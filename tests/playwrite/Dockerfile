# Use the specific Node.js base image
FROM node:20-bookworm

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install app dependencies including Playwright
# Note: It's better to lock Playwright version in package.json, not in Dockerfile
RUN npm install

# Install Playwright browsers with all dependencies
RUN npx playwright install --with-deps

# Copy the rest of the application source code
COPY . .

