# Build the docker network
docker network create --subnet 192.168.0.0/24 dos_network


# Pull docker images
# docker pull ubuntu:latest
# docker pull kalilinux/kali-rolling:latest
# docker pull nginx:stable-perl

# Build the docker images
# docker build -t nginx-dos:victim ./victim/.
# docker build -t kali-dos:attack ./attack/.
# docker build -t ubuntu-dos:observe ./observe/.

# Build the docker containers
docker create -it --name victim-server --cpus=".1" --network dos_network --ip 192.168.0.10 -p 8080:80 nginx-dos:victim
docker create -it --name attack-server --network dos_network --ip 192.168.0.11 kali-dos:attack
docker create -it --name observe-server --network dos_network --ip 192.168.0.12 ubuntu-dos:observe 

# Run the docker containers
docker start victim-server
docker start attack-server
docker start observe-server