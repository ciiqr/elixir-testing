{% set elixir_version = '1.5.2' %}
{% set elixir_programs = ['iex', 'mix', 'elixir', 'elixirc'] %}

erlang:
  pkgrepo.managed:
    - humanname: deb-erlang
    - name: deb http://packages.erlang-solutions.com/ubuntu {{ salt['grains.get']('lsb_distrib_codename', '') }} contrib
    - file: /etc/apt/sources.list.d/deb-erlang.list
    - key_url: http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
  pkg.installed:
    - name: erlang

elixir:
  archive.extracted:
    - name: /usr/local/src/elixir-{{ elixir_version }}
    - source: https://github.com/elixir-lang/elixir/releases/download/v{{ elixir_version }}/Precompiled.zip
    # - source_hash: TODO
    - skip_verify: true
    - enforce_toplevel: false

# TODO: it's totally unclear if anything in the lib directory matters...
{% for prog in elixir_programs %}
elixir.{{ prog }}:
  file.symlink:
    - name: /usr/local/bin/{{ prog }}
    - target: /usr/local/src/elixir-{{ elixir_version }}/bin/{{ prog }}
{% endfor %}
