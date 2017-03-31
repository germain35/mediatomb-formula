{% from "mediatomb/map.jinja" import mediatomb with context %}

mediatomb_packages:
  pkg.installed:
    - pkgs: {{mediatomb.packages}}
