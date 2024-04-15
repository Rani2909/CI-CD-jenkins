# Use an existing Docker image as a base
FROM nginx:alpine

# Copy the index.html file from the local filesystem into the container
COPY index.html /usr/share/nginx/html

# Expose port 80 to allow external access to the web server
EXPOSE 80
