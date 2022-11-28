include docker/.env

project_name := $(PROJECT_NAME)
compose_file := $(COMPOSE_FILE)

init:
	docker compose -f $(compose_file) -p $(project_name) build --no-cache
	-@docker compose -f $(compose_file) -p $(project_name) down --volumes
	docker compose -f $(compose_file) -p $(project_name) up -d
	@sh ./docker/wait-for-db.sh
	@sh ./docker/make-for-env.sh
	docker compose -f $(compose_file) -p $(project_name) exec php php artisan key:generate
	docker compose -f $(compose_file) -p $(project_name) exec php php artisan key:generate --env=testing
	docker compose -f $(compose_file) -p $(project_name) exec php php artisan migrate:fresh --seed

build:
	@docker compose -f $(compose_file) -p $(project_name) build --no-cache

up:
	@docker compose -f $(compose_file) -p $(project_name) up -d

down:
	@docker compose -f $(compose_file) -p $(project_name) down --volumes

exec:
	@docker compose -f $(compose_file) -p $(project_name) exec $(args)

ps:
	@docker compose -f $(compose_file) -p $(project_name) ps

composer-install:
	@docker compose -f $(compose_file) -p $(project_name) exec php composer install --ignore-platform-reqs --no-interaction --no-plugins --no-scripts --prefer-dist
	@echo "copy vendor files from container"
	@docker compose -f $(compose_file) -p $(project_name) cp php:/app/vendor ./

fresh:
	@docker compose -f $(compose_file) -p $(project_name) exec php php artisan migrate:fresh --seed

test:
	@docker compose -f $(compose_file) -p $(project_name) exec php php artisan test

phpcs:
	@docker compose -f $(compose_file) -p $(project_name) exec php ./vendor/bin/phpcs --standard=phpcs.xml ./

phpstan:
	@docker compose -f $(compose_file) -p $(project_name) exec php ./vendor/bin/phpstan analyse
