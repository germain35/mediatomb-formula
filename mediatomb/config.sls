{% from "mediatomb/map.jinja" import mediatomb with context %}

include:
  - mediatomb.install
  - mediatomb.service

mediatomb_default_config:
  file.replace:
    - name: {{mediatomb.default_config_file}}
    - pattern: '^MT_INTERFACE=.*$'
    - repl: 'MT_INTERFACE= "' + {{salt['pillar.get']('mediatomb:interface', 'lo')}} + '"'
    - append_if_not_found: True
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
      - file: mediatomb_default_config
    - watch_in:
       - service: mediatomb_service_reload
