{% from "mediatomb/map.jinja" import mediatomb with context %}

include:
  - mediatomb.install
  - mediatomb.service

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
    - watch_in:
       - service: mediatomb_service_reload
