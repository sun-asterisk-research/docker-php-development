# Viblo Docker for PHP Development

Docker containers for Viblo development.

## Requirement

- Docker version at least 18.06
- Docker compose version at least 1.22.0

## Getting started

```
# clone repo:
git clone git@github.com:sun-asterisk-research/docker-php-development.git docker

# init project:
./project init
```

There are 2 files that will be created: `.env` & `services`. They are copying files of `.env.example` and `services.example`. Therefore, please make them manually if the command `init` does not work.

## Setup development environment

### Environment variables


Notable things are:

- `PATH_PHP`, `PATH_WEB`: paths to your code directories. They will be mounted into the containers.
- `DOMAIN` and `PORT`: Domain and port to access the application.
- `DOMAIN_WEB`: defines public domain for your Node.js application.
- `COMPOSE_PROJECT_NAME`: used to isolate environments when you run multiple projects.

*Note:* To use the Node.js application & the PHP application in the same domain
```shell
cp docker-compose.override.yml.example docker-compose.override.yml
```

Not very important things:

- `PATH_DATA`: Path to the directory you want to persist data to (Database, uploads .etc)
- `PATH_LOGS`: Where to persist logs of some services.
- `DB_PORT`: Port published by database so you can connect with your DB management tool.
  Default value depends on which database you choose (`5432` for Postgres, `3306` for MySQL)
- `DOMAIN_SECONDARY`: Secondary domain to access some backend services (traefik, mailhog .etc). Default: `localhost`

*Note:* All directory paths can be relative to where you run `./project`.

### Services

Open **services** file. Specify which service to include. Example:

```plain
mysql
redis
php
```

Available services are in *compose* folder. For development, most likely you will only need the above ones.

## Start

```shell
./project up
```

## Shutdown

```shell
./project down
```

## Getting inside containers

To get inside a container you can use

```sh
./project sh <service>
```

e.g

```sh
./project sh php
```

If you are not inside this folder, you can use `docker exec` to enter containers. Most containers uses `alpine` image so you can get into them with `sh`

```sh
docker exec -it <container_name> sh
```

## Running commands in container

You can run commands like this

```sh
./project exec <service> <command>
```

Example

```sh
./project exec web yarn dev
```

## List all containers

Container names are prefixed with the `COMPOSE_PROJECT_NAME` environment variable (default: `php-project`). You can list them all with

```sh
./project ps
```

or use `docker ps`. e.g.

```sh
docker ps -f name=php-project_
```

## Overriding `docker-compose` file

You can override services or add new services by adding them to a `docker-compose.override.yml` file.
