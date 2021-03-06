{% from "mediatomb/map.jinja" import mediatomb with context %}

{% set interface = salt['pillar.get']('mediatomb:interface', 'lo') %}

include:
  - mediatomb.install
  - mediatomb.service

mediatomb_default_config_interface:
  file.replace:
    - name: {{mediatomb.default_config_file}}
    - pattern: 'INTERFACE=.*$'
    - repl: 'INTERFACE="{{interface}}"'
    - append_if_not_found: False
    - bufsize: file

mediatomb_config:
  file.managed:
    - name: {{mediatomb.config_file}}
    - source: salt://mediatomb/templates/config.xml.jinja
    - template: jinja
    - mode: 644
    - user: mediatomb
    - group: mediatomb
    - require:
      - sls: mediatomb.install
      - file: mediatomb_default_config_interface
    - watch_in:
       - service: mediatomb_service_restart
