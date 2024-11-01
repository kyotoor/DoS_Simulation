FROM nginx:stable-perl

RUN apt update
RUN apt -y upgrade
RUN apt -y install tcpdump
RUN apt -y install procps #　For top command
RUN apt -y install htop

COPY ./html /usr/share/nginx/html

EXPOSE 80
