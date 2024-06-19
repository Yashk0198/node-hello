# We will use a multi-stage build for smaller final image size

# First stage: Installing dependencies and build the application
FROM node:alpine AS build

# Setting the working directory in the container
WORKDIR /src/app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the application code
COPY . .

# Second stage: Creating a smaller image without unnecessary dependencies
FROM node:alpine

# Setting the working directory in the container
WORKDIR /src/app

# Copying only necessary files from the previous stage
COPY --from=build /src/app/package.json .
COPY --from=build /src/app .

# Installing the dependencies
RUN npm install

# Exposing the port
EXPOSE 3000

# Command to start the application
CMD ["node", "index.js"]