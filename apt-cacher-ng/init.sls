
{% from "apt-cacher-ng/map.jinja" import acng with context %}

apt-cacher-ng:
  pkg:
    - installed
    - name: {{ acng.pkg }}
  service:
    - running
    - name: {{ acng.service }}
    - enable: True
    - require:
      - pkg: apt-cacher-ng
      - file: apt-cacher-ng-config


apt-cacher-ng-config:
  file.managed:
    - name: {{ acng.config }}
    - source: salt://apt-cacher-ng/files/acng.conf.jinja
    - template: jinja
    - mode: 0644
    - user: root
    - group: root
    - watch_in:
      - service: apt-cacher-ng


apt-cacher-ng-mirror_dir:
  file.directory:
    - name: {{ acng.cachedir }}
    - user: root
    - group: apt-cacher-ng
    - dir_mode: 0775
    - makedirs: True
    - require_in:
      - service: apt-cacher-ng


{% if grains['os'] == 'Ubuntu'
  and grains['osrelease'].split('.')[0] < 14 -%}
# Patch /usr/sbin/apt-cacher-ng in from Trusty
# TODO: dpkg-divert
apt-cacher-ng_patch:
  cmd.script:
    - unless: test -f /usr/sbin/apt-cacher-ng.bkp
    - source: salt://apt-cacher-ng/files/acng_latest.sh
    - template: jinja
    - defaults:
      - version: "0.7.26-1"
    - require:
      - pkg: apt-cacher-ng
    - watch:
      - pkg: apt-cacher-ng
    - watch_in:
      - service: apt-cacher-ng
{% endif -%}
