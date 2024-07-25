ROOT = /home/ychalant/data

all: build up

build:
	bash srcs/setup.sh
	mkdir -p $(ROOT)
	mkdir -p $(ROOT)/mariadb
	mkdir -p $(ROOT)/wordpress
	docker compose -f srcs/docker-compose.yaml build

up:
	docker compose -f srcs/docker-compose.yaml up

upd:
	docker compose -f srcs/docker-compose.yaml up -d

down:
	docker compose -f srcs/docker-compose.yaml down

clean:
	docker compose -f srcs/docker-compose.yaml down
	docker compose -f srcs/docker-compose.yaml rm -f
	rm -rf $(ROOT)

fclean: clean
	docker system prune -af

.PHONY: all build up down clean fclean