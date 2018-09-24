# Viblo Docker for PHP Development

Docker containers for Viblo development.

## Requirement

- Docker version at least 18.06
- Docker compose version at least 1.22.0

## Setup development environment

### Environment variables

Make a **.env** file

```shell
cp .env.example .env
```

Notable things are:

- **PATH_API**, **PATH_WEB**: paths to your code directories. They will be mounted into the container at */srv*.
- **DOMAIN** and **PORT**: Domain and port to access the application.

Not very important things:

- **PATH_DATA**: Path to the directory you want to persist data to (Postgres, uploads .etc)
- **PATH_LOGS**: Where to persist logs of some services.
- **DB_PORT** and **DB_TEST_PORT**: Ports published by Postgres databases so you can connect to Postgres with your DB management tool.
- **PORT_TRAEFIK**: Port to access traefik on localhost.
- **DOMAIN_BACKEND**: The domain to access some backend services (traefik, mailhog .etc).

*Note:* All directory paths can be relative to where you run `up.sh`.

### Modules

Make a **modules** file

```shell
cp modules.example modules
```

Specify which module to include. Example:

```plain
db
api
web
```

Available modules are in *compose* folder. For development, most likely you will only need the above ones.

## Start

```shell
bash viblo up
```

## Shutdown

```shell
bash viblo down
```

## Getting inside containers

To get inside a container you can use

```sh
bash viblo sh <service>
```

e.g

```sh
bash viblo sh web
```

If you are not inside this folder, you can use `docker exec` to enter containers. Most containers uses `alpine` image so you can get into them with `sh`

```sh
docker exec -it <container_name> sh
```

## Running commands in container

You can run commands like this

```sh
bash viblo exec <service> <command>
```

Example

```sh
bash viblo exec web yarn dev
```

## List all containers

Container names are prefixed with the `COMPOSE_PROJECT_NAME` environment variable (default: `viblo`). You can list them all with

```sh
bash viblo ps
```

or use `docker ps`. e.g.

```sh
docker ps -f name=viblo_
```

## Overriding `docker-compose` file

You can override services or add new services by adding them to a `docker-compose.override.yml` file.
