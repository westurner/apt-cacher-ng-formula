{% set apt = pillar.get('apt', {}) %}

/etc/apt/apt.conf:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - content: |
        Acquire::http::Proxy "{{ apt.proxy_url }}";
