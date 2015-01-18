#! yaml . jinja
{% set apt = pillar.get('apt', {}) %}

apt-proxy-conf:
  file.managed:
    - name: /etc/apt/apt.conf.d/00proxy.conf
    - mode: 0644
    - user: root
    - group: root
    - source: salt://apt-cacher-ng/files/apt.conf.jinja
    - template: jinja
    - context:
      apt: {{ apt }}
