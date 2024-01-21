USERNAME :=$(shell whoami)

all: 
	sudo mkdir -p /home/$(USERNAME)/data/mariadb
	sudo mkdir -p /home/$(USERNAME)/data/wordpress
	sudo docker-compose -f ./src/docker-compose.yml build;
	sudo docker-compose -f ./src/docker-compose.yml up -d

logs:
	sudo docker logs wordpress
	sudo docker logs mariadb
	sudo docker logs nginx

clean:
	sudo docker container stop mariadb
	sudo docker container stop wordpress
	sudo docker container stop nginx
	sudo docker network rm inception

fclean: clean
	sudo rm -rf /home/$(USERNAME)/data/mariadb/*
	sudo rm -rf /home/$(USERNAME)/data/wordpress/*
	sudo docker system prune -af

re: fclean all

.Phony: all logs clean fclean