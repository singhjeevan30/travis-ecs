FROM ubuntu:latest
RUN apt update
RUN apt install -y nginx
Expose 8080
CMD ["echo", "Hello nginxx!"]
