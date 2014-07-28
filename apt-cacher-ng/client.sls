{% set url = "http://apt.create.wrd.nu:23142" %}

/etc/apt/apt.conf:
  file.managed:
    - mode: 0644
    - user: root
    - group: root
    - content: |
        Acquire::http::Proxy "{{ url }}";
