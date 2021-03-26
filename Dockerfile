FROM ubuntu:latest
RUN apt-get install update
RUN apt-get install -y nginx
RUN cat "Tesing Dockerfile"
Expose 8080
CMD ["echo", "Hello nginxx!"]
