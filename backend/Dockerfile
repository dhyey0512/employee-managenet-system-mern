# Backend Dockerfile

# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of your application code
COPY . .

# Start the app
CMD ["npx","nodemon", "index.js"]

# Expose the port your app runs on
EXPOSE 8000
