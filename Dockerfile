FROM ubuntu:latest
RUN apt update
RUN apt install -y nginx
RUN cat "Tesing Dockerfile"
Expose 8080
CMD ["echo", "Hello nginxx!"]
