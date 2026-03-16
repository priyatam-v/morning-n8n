## Launch n8n with Docker Compose

### Launch docker compose
To start the containers in the background, just run:
```commandline
sudo docker compose up -d
```
This command tells Docker to launch everything based on your docker-compose.yml file, including n8n and Traefik.

### Stop docker compose
To stop n8n, use the following command:
```commandline
sudo docker compose stop
```
