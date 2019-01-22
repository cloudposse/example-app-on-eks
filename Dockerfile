FROM golang:alpine3.8 AS builder

# Copy source into builder
ADD . /src

# Build the app
RUN cd /src && \
    go build -o example-app

# Build the final image
FROM alpine:3.8 as final

# Expose port of the app
EXPOSE 8080

# Set the runtime working directory
WORKDIR /app

# Copy the helmfile deployment configuration
COPY deploy/ /deploy/
COPY *.html /app/

# Install the app
COPY --from=builder /src/example-app /app/

# Define the entrypoint
ENTRYPOINT ["./example-app"]