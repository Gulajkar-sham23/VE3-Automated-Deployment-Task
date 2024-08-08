# Stage 1: Build Stage
# Use an official PHP runtime with Apache as the base image
FROM php:7.4-apache AS builder

# Set the working directory to /var/www/html
WORKDIR /var/www/html

# Install the PHP MySQL extension
RUN docker-php-ext-install mysqli

# Copy the application code into the container
COPY . /var/www/html

# Expose port 80 for Apache (only for the build stage)
EXPOSE 80

# Stage 2: Final Stage
# Use an official Nginx image as the base image for the final stage
FROM ubuntu:latest
RUN apt update
RUN apt install apache2 -y
COPY index.html /var/www/html/index.html
RUN chmod 777 /var/www/html
RUN chmod 666 /var/www/html/index.html
EXPOSE 80
CMD ["apache2ctl", "-D", "FOREGROUND"]
