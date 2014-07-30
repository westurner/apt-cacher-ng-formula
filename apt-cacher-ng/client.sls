{% set apt = pillar.get('apt', {}) %}

/etc/apt/apt.conf:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - source: salt://apt-cacher-ng/files/apt.conf.jinja
    - template: jinja
