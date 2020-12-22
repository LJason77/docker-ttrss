FROM alpine:latest

LABEL maintainer "LJason <https://ljason.cn>"

WORKDIR /var

COPY files .

RUN apk add -qq --no-cache --no-progress tzdata supervisor git nginx php7-mbstring php7-fpm php7-cli php7-pdo_pgsql php7-curl php7-gd php7-json php-gettext php7-dom php7-intl php7-fileinfo php7-pgsql php7-ldap php7-pcntl php7-session php7-posix php7-mysqli php7-mcrypt php7-iconv && \
	cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
	mv ttrss.nginx.conf /etc/nginx/conf.d/ && \
	rm -rf /etc/nginx/conf.d/default.conf /var/www && \
	git clone --depth 1 https://git.tt-rss.org/fox/tt-rss.git && \
	mv af_newspapers tt-rss/plugins/ && \
	sed -i 's/user = nobody/user = nginx/' /etc/php7/php-fpm.d/www.conf && \
	mkdir -p /run/nginx && \
	chown -R nginx /var/tt-rss && \
	rm -rf /var/cache/apk/*
