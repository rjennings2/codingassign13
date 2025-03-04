# Use the official Node.js image
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Production image
FROM nginx:alpine

# Copy the build files to nginx's html folder
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 8018
EXPOSE 8018

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]