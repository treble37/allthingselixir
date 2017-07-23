# source: https://github.com/rbeene/phoenix-with-docker/blob/master/Dockerfile
# Set the Docker image you want to base your image off.
# Elixir 1.4.5: https://hub.docker.com/_/elixir/
FROM elixir:1.4.5
ENV DEBIAN_FRONTEND=noninteractive

# Install hex
RUN MIX_ENV=prod mix local.hex --force

# Install rebar
RUN MIX_ENV=prod mix local.rebar --force

# Install the Phoenix framework itself
RUN mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez --force


# Install NodeJS 6.x and the NPM
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y -q nodejs

# Set /app as workdir
RUN mkdir /app
ADD . /app
WORKDIR /app

# Install Node Deps
ADD package.json ./
RUN npm install

# Install app
ADD . .

# Install Elixir deps
RUN MIX_ENV=prod mix deps.get
RUN MIX_ENV=prod mix compile

# Compile assets
RUN NODE_ENV=production node_modules/brunch/bin/brunch build --production
RUN MIX_ENV=prod mix phoenix.digest

# Exposes this port from the docker container to the host machine
EXPOSE 4000

# The command to run when this image starts up
CMD MIX_ENV=prod mix ecto.migrate && MIX_ENV=prod mix phoenix.server

COPY ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
