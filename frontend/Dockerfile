# Frontend Dockerfile

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

# Build the app for production
RUN npm run build

# Start the app
CMD ["npm", "start"]

# Expose the port your app runs on
EXPOSE 3000

