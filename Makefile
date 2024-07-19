all: build up

build:
	docker compose -f srcs/docker-compose.yaml build

up:
	docker compose -f srcs/docker-compose.yaml up

upd:
	docker compose -f srcs/docker-compose.yaml up -d

down:
	docker compose -f srcs/docker-compose.yaml down

clean: down
	docker compose -f srcs/docker-compose.yaml rm -f

# fclean: clean
# 	docker system prune -af

.PHONY: all build up down clean fclean