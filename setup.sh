#!/bin/bash
set -eu

PWD=`cd $(dirname ${0}) && pwd`

docker run --rm --interactive --tty \
    --volume ${PWD}:/app composer \
    composer create-project laravel/laravel laravel

docker run --rm --interactive --tty \
    --volume ${PWD}/laravel:/app composer \
    composer require nunomaduro/larastan --dev

docker run --rm --interactive --tty \
    --volume ${PWD}/laravel:/app composer \
    composer require squizlabs/php_codesniffer --dev

mv laravel/* laravel/.e* laravel/.g* . && rm -rf laravel .env

sed -i "" "s/DB_HOST=127.0.0.1/DB_HOST=db/g" .env.example
sed -i "" "s/DB_USERNAME=root/DB_USERNAME=phper/g" .env.example
sed -i "" "s/DB_PASSWORD=/DB_PASSWORD=secret/g" .env.example
