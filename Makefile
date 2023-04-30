include ./srcs/.env
all: run

run:
	@sudo mkdir -p $(VOLUME_WEB)
	@sudo mkdir -p $(VOLUME_DB)
	@docker-compose -f $(COMPOSE_FILE) up --build
	@echo "finished"
clean:
#	@docker-compose -f $(COMPOSE_FILE) down
	@-docker stop `docker ps -qa`
	@-docker rm `docker ps -qa`
	@-docker rmi -f `docker images -qa`
	@-docker volume rm `docker volume ls -q`
	@-docker network rm `docker network ls -q`
	@sudo rm -rf /home/syamashi
	@echo "clean finished"

.PHONY: run clean