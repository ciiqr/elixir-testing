{% set major_version = '9' %}

apt-transport-https:
  pkg.installed:
    - name: apt-transport-https

build-essential:
  pkg.installed:
    - name: build-essential

nodejs:
  pkgrepo.managed:
    - humanname: NodeSource Node.js Repository
    - name: deb https://deb.nodesource.com/node_{{ major_version }}.x {{ grains['oscodename'] }} main
    - dist: {{ grains['oscodename'] }}
    - file: /etc/apt/sources.list.d/nodesource.list
    - keyid: "68576280"
    - key_url: https://deb.nodesource.com/gpgkey/nodesource.gpg.key
    - keyserver: keyserver.ubuntu.com
    - require:
      - pkg: apt-transport-https
  pkg.installed:
    - name: nodejs
    - reload_modules: true
