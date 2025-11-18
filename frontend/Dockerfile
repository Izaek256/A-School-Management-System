# Stage 1: Build the Flutter web app
FROM debian:latest AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    clang \
    cmake \
    ninja-build \
    pkg-config \
    libgtk-3-dev \
    liblzma-dev \
    libstdc++-12-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter config --enable-web
RUN flutter precache

# Set working directory
WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Get dependencies
RUN flutter pub get

# Copy source code
COPY . .

# Build the web app
RUN flutter build web --release

# Stage 2: Serve the web app using Nginx
FROM nginx:alpine

# Copy the built app to nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]