
# install phoenix
elixir.phoenix:
  cmd.run:
    - name: mix archive.install https://github.com/phoenixframework/archives/raw/master/phx_new.ez --force
    - unless: mix local | grep -q '^mix phx.new\s\+#'

# install inotify tools
elixir.phoenix.inotify-tools:
  pkg.installed:
    - name: inotify-tools

# install nodejs
include:
  - nodejs
