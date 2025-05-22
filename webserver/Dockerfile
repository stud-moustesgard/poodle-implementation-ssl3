# Use a specific older Alpine version known to have OpenSSL 1.0.x
# Alpine 3.8 is a good candidate as it still provides OpenSSL 1.0.x
FROM alpine:3.8

# Install build tools and Nginx dependencies for Alpine
# Ensure openssl and openssl-dev (for compilation) are installed.
RUN apk add --no-cache \
    build-base \
    wget \
    tar \
    zlib-dev \
    pcre-dev \
    libxml2-dev \
    libxslt-dev \
    gd-dev \
    perl-dev \
    openssl \
    openssl-dev \
    ca-certificates

# Build and install older nginx manually
# Nginx 1.14.2 is a stable version from the same era as Alpine 3.8,
# which should link correctly with OpenSSL 1.0.x from Alpine 3.8.
ENV NGINX_VERSION 1.14.2
RUN wget http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz -O /tmp/nginx-${NGINX_VERSION}.tar.gz && \
    tar zxvf /tmp/nginx-${NGINX_VERSION}.tar.gz -C /tmp/ && \
    cd /tmp/nginx-${NGINX_VERSION} && \
    ./configure \
        --prefix=/usr/local/nginx \
        --with-http_ssl_module \
        --with-http_realip_module \
        --with-http_addition_module \
        --with-http_sub_module \
        --with-http_dav_module \
        --with-http_flv_module \
        --with-http_mp4_module \
        --with-http_gunzip_module \
        --with-http_gzip_static_module \
        --with-http_auth_request_module \
        --with-http_random_index_module \
        --with-http_secure_link_module \
        --with-http_stub_status_module \
        --with-http_v2_module \
        --with-mail \
        --with-mail_ssl_module \
        --with-stream \
        --with-stream_ssl_module \
        --with-cc-opt="-O2" \
        --with-ld-opt="-Wl,-rpath,/usr/local/lib" && \
    make && \
    make install && \
    rm -rf /tmp/nginx-${NGINX_VERSION} /tmp/nginx-${NGINX_VERSION}.tar.gz && \
    # Clean up build dependencies to reduce image size
    apk del build-base wget tar libxml2-dev libxslt-dev gd-dev perl-dev openssl-dev

# Create directories for certificates and private keys
# Ensure these directories exist before openssl tries to write to them.
# The `openssl` binary in Alpine 3.8 is /usr/bin/openssl
RUN mkdir -p /usr/local/nginx/certs && \
    mkdir -p /usr/local/nginx/private && \
    chmod 700 /usr/local/nginx/private

# Generate self-signed certificate using the OpenSSL provided by Alpine 3.8
# This OpenSSL version should support SSLv3.
RUN /usr/bin/openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
       -keyout /usr/local/nginx/private/server.key \
       -out  /usr/local/nginx/certs/server.crt \
       -subj "/C=XX/ST=X/L=X/O=Lab/CN=vulnerable.local"

# Copy nginx config to the correct location for your manually compiled Nginx
COPY nginx.conf /usr/local/nginx/conf/nginx.conf

# Create the directory for Nginx's web content
RUN mkdir -p /usr/local/nginx/html

# Copy the simple HTML page into the web root
COPY index.html /usr/local/nginx/html/index.html

# Copy the poodle.js file into the web root
COPY poodle.js /usr/local/nginx/html/poodle.js

EXPOSE 443

# Point CMD to the newly installed Nginx binary
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
