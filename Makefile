up :
	@docker-compose -f ./srcs/docker-compose.yml up -d --build
rm :
	@docker rm -f $(docker ps -aq)

