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
FROM nginx:alpine

# Set the working directory to /usr/share/nginx/html
WORKDIR /usr/share/nginx/html

# Copy the built application from the previous stage
COPY --from=builder /var/www/html /usr/share/nginx/html

# Copy Nginx configuration file (if you have a custom one)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
