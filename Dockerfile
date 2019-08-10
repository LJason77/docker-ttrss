FROM alpine:latest

LABEL maintainer "LJason <https://ljason.cn>"

ENV	SELF_URL_PATH=http://localhost:3000 \
	DB_TYPE=pgsql \
	DB_PORT=5432 \
	DB_NAME=ttrss \
	DB_USER=ttrss \
	DB_PASS=ttrss \
	AUTH_METHOD=internal

WORKDIR /var

COPY files .

RUN echo Asia/Chongqing > /etc/timezone && \
	apk add -qq --no-cache --no-progress postgresql postgresql-client supervisor git nginx php7-mbstring php7-fpm php7-cli php7-pdo_pgsql php7-curl php7-gd php7-json php-gettext php7-dom php7-intl php7-fileinfo php7-pgsql php7-ldap php7-pcntl php7-session php7-posix php7-mysqli php7-mcrypt && \
	mv ttrss.nginx.conf /etc/nginx/conf.d/ && \
	rm -rf /etc/nginx/conf.d/default.conf /var/www && \
	git clone --depth 1 https://gitlab.com/gothfox/tt-rss.git www && \
	mv af_newspapers www/plugins/ && \
	git clone --depth 1 https://github.com/hydrian/TTRSS-Auth-LDAP.git && \
	mv TTRSS-Auth-LDAP/plugins/auth_ldap www/plugins/ && \
	rm -rf TTRSS-Auth-LDAP && \
	git clone --depth 1 https://github.com/HenryQW/mercury_fulltext.git www/plugins/mercury_fulltext && \
	cp www/config.php-dist www/config.php && \
	mkdir -p /var/run/php && \
	mkdir -p /run/nginx && \
	mkdir -p /run/postgresql && \
	chown -R nginx:nginx /var/www && \
	chown -R postgres:postgres /run/postgresql && \
	chmod -R 777 /var/www/cache && \
	chmod -R 777 /var/www/feed-icons && \
	chmod -R 777 /var/www/lock && \
	apk del -qq --purge git && \
	rm -rf /var/cache/apk/*

VOLUME [ "/var/lib/postgresql/data" ]

EXPOSE 3000

CMD ["/var/entrypoint.sh"]