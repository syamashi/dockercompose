COMPOSE_FILE=./srcs/docker-compose.yml
VOLUME_WP = /home/user42/Desktop/data/wordpress
VOLUME_MYSQL = /home/user42/Desktop/data/mysql
all: run

run:
	@sudo mkdir -p $(VOLUME_WP)
	@sudo mkdir -p $(VOLUME_MYSQL)
	@docker-compose -f $(COMPOSE_FILE) up --build
	@echo "finished"
clean:
	@docker-compose -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	@sudo rm -rf $(VOLUME_WP)
	@sudo rm -rf $(VOLUME_MYSQL)
	@echo "clean finished"

.PHONY: run clean