# MENGGUNAKAN BASE IMAGE LAMA DENGAN VULNERABILITIES
FROM node:14.15.0-alpine3.10

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --production

# Install additional vulnerable packages di OS level
RUN apk add --no-cache \
    curl=7.66.0-r0 \
    wget=1.20.3-r0 \
    openssl=1.1.1d-r3 \
    bash=5.0.0-r0

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Expose port
EXPOSE 3000

# Add vulnerable user (untuk testing)
RUN adduser -D -s /bin/bash vulnerable_user

# Start the application
CMD ["npm", "start"]