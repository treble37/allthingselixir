#!/bin/bash
set -e

#uncomment this if you use ecto
mix do ecto.drop, ecto.create, ecto.migrate

elixir -pa _build/prod/consilidated -S mix phoenix.server

exec $@
