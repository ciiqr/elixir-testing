# elixir-testing

## dependencies
```
vagrant
vagrant-hostmanager
vagrant-notify-forwarder
```

## basic example
* `cd ~/src/basic` Go to the basic app (in vagrant)
* `mix deps.get` Install dependencies
* `mix ecto.create && mix ecto.migrate` Create and migrate your database
* `cd assets && npm install` Install Node.js dependencies
* `mix phx.server` Start Phoenix endpoint
* [`elixir.local`](http://elixir.local) Now you can visit your site in your browser
