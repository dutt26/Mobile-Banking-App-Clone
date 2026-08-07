# Build stage: Flutter + web build
FROM ubuntu:22.04 AS build

# Install dependencies
RUN apt-get update && apt-get install -y \
    git curl unzip xz-utils zip libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Install specific stable Flutter version (not master branch)
WORKDIR /app
RUN git clone --branch 3.24.0 --depth 1 https://github.com/flutter/flutter.git /flutter || \
    git clone --branch stable --depth 1 https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Verify Flutter installation
RUN flutter --version && dart --version

# Enable web platform
RUN flutter config --enable-web

# Copy and install dependencies
WORKDIR /app
COPY pubspec.yaml ./

# If pubspec.lock exists in repo, remove it to force regeneration
RUN rm -f pubspec.lock && flutter pub get 2>&1 || { \
    echo "=== PUB GET FAILED ==="; \
    flutter doctor -v; \
    exit 1; \
}

# Copy remaining app code
COPY . .
RUN flutter build web --release

# Runtime stage: Nginx
FROM nginx:1.27-alpine
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
