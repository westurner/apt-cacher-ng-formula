apt-cacher-ng:
  pkg:
    - installed
  service:
    - running
    - enable: True
    - require:
      - pkg: apt-cacher-ng
      - cmd: patch_apt-cacher-ng
      - file: /srv/repos/apt
    - watch:
      - file: /etc/apt-cacher-ng/acng.conf

/etc/apt-cacher-ng/acng.conf:
  file.managed:
    - source: salt://apt-cacher-ng/files/acng.conf.jinja
    - template: jinja
    - mode: 0644
    - user: root
    - group: root
    - watch_in:
      - service: apt-cacher-ng

/srv/repos/apt:
  file.directory:
    - makedirs: True
    - user: root
    - group: apt-cacher-ng
    - mode: 0775
    - dir_mode: 0775

{% if grains['os'] == 'Ubuntu' and grains['osrelease'].split('.')[0] < 14 %}
# Patch /usr/sbin/apt-cacher-ng in from Trusty
# TODO: dpkg-divert
patch_apt-cacher-ng:
  cmd.script:
    - unless: test -f /usr/sbin/apt-cacher-ng.bkp
    - source: salt://apt-cacher-ng/files/acng_latest.sh
    - template: jinja
    - defaults:
      - version: "0.7.26-1"
  require:
    - pkg: apt-cacher-ng
    - watch:
      - pkg: apt-cacher-ng
    - watch_in:
      - service: apt-cacher-ng
{% else %}
patch_apt-cacher-ng:
  cmd.run:
    - unless: true
    - cmd: true
{% endif %}

