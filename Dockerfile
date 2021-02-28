FROM alpine:latest

LABEL maintainer "LJason <https://ljason.cn>"

WORKDIR /var

ENV SCRIPT_ROOT=/opt/tt-rss
ENV TTRSS_DB_HOST=postgres
ENV TTRSS_DB_NAME=ttrss
ENV TTRSS_DB_USER=ttrss
ENV TTRSS_DB_PASS=ttrss
ENV HTTP_PORT=3000

COPY files .

RUN apk add -qq --no-cache --no-progress --virtual .build-deps tzdata git && \
	apk add -qq --no-cache --no-progress nginx supervisor php8 php8-fpm php8-mbstring php8-pdo_pgsql php8-curl php8-dom php8-intl php8-iconv php8-posix php8-gd php8-fileinfo php8-pgsql php8-pcntl php8-session php8-json php8-pdo php8-xml php8-zip php8-openssl php8-pecl-xdebug postgresql-client && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	mv ttrss.nginx.conf /etc/nginx/conf.d/ && \
	rm -rf /etc/nginx/conf.d/default.conf /var/www && \
	git clone --depth=1 https://git.tt-rss.org/fox/tt-rss.git && \
	mv config.php tt-rss/config.php && \
	chmod 644 tt-rss/config.php && \
	sed -i 's/user = nobody/user = nginx/' /etc/php8/php-fpm.d/www.conf && \
	mkdir -p /run/nginx && \
	chown -R nginx /var/tt-rss && \
	rm -rf /var/cache/apk/*
