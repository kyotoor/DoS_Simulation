# DoS Environment Simulation
In this repository, I will introduce the most simple DoS simulation using VM(Virtual Machine). For the victim server, we use nginx server. I will attack it by using the other containes

IPv4 network

## Environmnet 
Chip : Apple M2 <br>
OS : macOS 14.6.1（23G93）<br>
VM : Docker Desktop 27.1.1, build 6312585 <br>


## Setup for web page 
We need make the directory first, and prepare the html file which will be displaed on the web server.

```bash
mkdir html
echo "<h1>Hello World</h1>" > html/index.html
```

## Setup for the docker network
Docker network allow us to create the virtual network environment. In this project, I will use idepended network. It makes possible to set the IP address of the containers. I will make the network structure on 192.163.0.0/24. 

```bash
docker network create --subnet 192.163.0.0/24 dos_network
docker network ls | grep dos_network
```

## Setup for the docker containers
### Setup for the docker image
Docker containers need base docker image to identify the environmnet. In this project we use nginx for the victim web server. To begin with, we need to create the Dockerfile which has information of the environmnet. The Dockerfile's line is as follows.

```bash
FROM nginx:stable-perl
COPY ./html /usr/share/nginx/html
EXPOSE 80
```

After creating the Dockerfile, we will make the new docker image based on the Dockerfile. We create the victim server first.

```bash
docker pull nginx:stable-perl
docker build -t nginx-dos:victim ./victim/.
```

Next, we will prepare the attack server.
```bash
docker pull kalilinux/kali-rolling:latest
docker build -t kali-dos:attack ./attack/.
```
We need to check the victim server's status from 3rd party. Therefore, we need to create the container which allows us to observe. In this project, we will use the ubuntu container.
```bash
docker pull ubuntu:latest
docker build -t ubuntu-dos:observe ./observe/.
```

### Setup for the docker container
For each container (Attack, Victim and Observe), we need to create by using image. Here's the way to create the docker container.

```bash
docker create -it --name web-server --network dos_network --ip 192.163.0.10 -p 8080:80 nginx-dos:victim
docker start web-server

docker create -it --name attack-server --network dos_network --ip 192.163.0.11 kalilinux/kali-rolling:latest
docker start attack-server

docker create -it --name observe-server --network dos_network --ip 192.163.0.12 ubuntu 
docker start observe-server
```

### DoS Attack
For the attack simulation, we will use SYN Flood, UDP Flood, HTTP Flood. For 

```bash
apt install hping3
```

### Close the docker containers
```bash
docker stop
docker stop
```




