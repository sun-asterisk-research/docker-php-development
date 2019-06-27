#!/bin/bash

up() {
    docker-compose up -d $@
}

up-undetached() {
    docker-compose up $@
}

down() {
    docker-compose down $@
}

ps() {
    docker-compose ps
}

sh() {
    docker-compose exec $1 sh
}

bash() {
    docker-compose exec $1 bash
}

exec() {
    docker-compose exec $1 ${@:2}
}

logs() {
    docker-compose logs $@
}

logs-tailf() {
    docker-compose logs -f $@
}

inspect() {
    docker inspect $(docker-compose ps -q $1) ${@:2}
}
