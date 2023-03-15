# Use golang 1.20 alpine image for building the Go app
FROM golang:1.20-alpine AS builder

# Set working directory for the builder
WORKDIR /build

# Copy all files in the current directory to the container
COPY . .

# Build the Go application
RUN go build -v -o app main.go

# Use Node.js 16 alpine image for building the frontend
FROM node:16-alpine AS node-builder

# Set working directory for the node builder
WORKDIR /build

# Copy all frontend files to the container
COPY frontend .

# Install dependencies, build and export the frontend application
RUN yarn && yarn build && yarn export

# Use alpine latest image for the runner
FROM alpine:latest AS runner

# Set working directory for the runner
WORKDIR /app

# Copy the built Go app from the builder to the runner
COPY --from=builder /build/app .

# Copy the built frontend files from the node-builder to the runner
COPY --from=node-builder /build/out ./static

# Expose the port for the application
EXPOSE 8090

# Create a directory for data storage
RUN mkdir /pb_data

# Set the command to run the app with arguments
CMD ["./app", "serve", "--http=0.0.0.0:8090", "--publicDir=./static", "--dir=/pb_data"]
