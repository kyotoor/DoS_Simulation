# Stop the containers
docker stop victim-server
docker stop attack-server
docker stop observe-server

# Remove the containers
docker rm victim-server
docker rm attack-server
docker rm observe-server

# Remove the built images
# docker rmi nginx-dos
# docker rmi ubuntu-dos
# docker rmi kali-dos

# Remove the network
docker network rm dos_network
