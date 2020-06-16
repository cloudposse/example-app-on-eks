FROM golang:alpine3.11 AS builder

# Copy source into builder
ADD . /src

# Build the app
RUN cd /src && \
    go build -o example-app

# Build the final image
FROM alpine:3.11 as final

# Install the cloudposse alpine repository
ADD https://apk.cloudposse.com/ops@cloudposse.com.rsa.pub /etc/apk/keys/
RUN echo "@cloudposse https://apk.cloudposse.com/3.11/vendor" >> /etc/apk/repositories

# Expose port of the app
EXPOSE 8080

# Set the runtime working directory
WORKDIR /app

# Copy the helmfile deployment configuration
COPY deploy/ /deploy/
COPY public/ /app/public/

# Install the app
COPY --from=builder /src/example-app /app/

# Define the entrypoint
ENTRYPOINT ["./example-app"]
