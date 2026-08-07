# Build stage: Flutter + web build
FROM ubuntu:22.04 AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    git curl unzip xz-utils zip libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter SDK
WORKDIR /app
RUN git clone --depth 1 https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Pre-cache Flutter web platform
RUN flutter config --enable-web

WORKDIR /app
COPY pubspec.yaml ./
# Regenerate pubspec.lock in container to avoid version conflicts with repo's cached lock file
RUN flutter pub get --verbose

COPY . .
RUN flutter build web --release

# Runtime stage: Nginx
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
