#!/bin/bash

__getenv() {
    grep -m1 ^$1= .env | cut -d'=' -f2
}

__get_compose_files() {
    files=( 'docker-compose.yml' )

    while read -r module; do
        files+=( "compose/$module.yml" )
    done < services

    if [ -f "docker-compose.override.yml" ]; then
        files+=( 'docker-compose.override.yml' )
    fi

    files_argument=''

    for file in "${files[@]}"
    do
        files_argument+="-f $file "
    done

    echo $files_argument
}

up() {
    docker-compose $(__get_compose_files) up -d $@
}

up-undetached() {
    docker-compose $(__get_compose_files) up $@
}

down() {
    docker-compose $(__get_compose_files) down $@
}

ps() {
    docker ps -f name=$(__getenv COMPOSE_PROJECT_NAME)_
}

sh() {
    docker exec -it $(__getenv COMPOSE_PROJECT_NAME)_$1_1 sh
}

bash() {
    docker exec -it $(__getenv COMPOSE_PROJECT_NAME)_$1_1 bash
}

exec() {
    docker exec -it $(__getenv COMPOSE_PROJECT_NAME)_$1_1 ${@:2}
}

logs() {
    docker logs $(__getenv COMPOSE_PROJECT_NAME)_$1_1 ${@:2}
}

inspect() {
    docker inspect $(__getenv COMPOSE_PROJECT_NAME)_$1_1 ${@:2}
}
