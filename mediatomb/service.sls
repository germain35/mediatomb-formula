{% from "mediatomb/map.jinja" import mediatomb with context %}

include:
  - mediatomb.install
  - mediatomb.config

mediatomb_service:
  service.running:
      - name: mediatomb

# The following states are inert by default and can be used by other states to
# trigger a restart or reload as needed.
mediatomb_service_reload:
  module.wait:
    - name: service.reload
    - m_name: mediatomb

mediatomb_service_restart:
  module.wait:
    - name: service.restart
    - m_name: mediatomb
