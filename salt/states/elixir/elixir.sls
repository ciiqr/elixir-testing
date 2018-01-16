{% set elixir_version = '1.5.2' %}
{% set elixir_programs = ['iex', 'mix', 'elixir', 'elixirc'] %}

erlang:
  pkgrepo.managed:
    - humanname: deb-erlang
    - name: deb http://packages.erlang-solutions.com/ubuntu {{ grains['oscodename'] }} contrib
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

# install hex
elixir.hex:
  cmd.run:
    - name: mix local.hex --force
    - unless: mix hex.info
    - runas: vagrant
    - require:
      - file: elixir.mix

# install rebar
elixir.rebar:
  cmd.run:
    - name: mix local.rebar --force
    - creates: /home/vagrant/.mix/rebar3 # TODO: this is annoying having to hard code the path, should add a helper for expanduser
    - runas: vagrant
    - require:
      - file: elixir.mix

# allow running on port 80
erlang.setcap:
  cmd.run:
    - name: setcap 'cap_net_bind_service=+ep' /usr/lib/erlang/erts-*/bin/beam.smp
    - unless: getcap /usr/lib/erlang/erts-*/bin/beam.smp | grep -q 'cap_net_bind_service+ep'
