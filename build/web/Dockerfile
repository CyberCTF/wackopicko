# Upstream's Dockerfile (app/Dockerfile) builds FROM tutum/lamp, which Docker can no longer pull
# (a schema 1 manifest, unsupported since containerd 2.1). The first part below rebuilds that
# base the way tutum/lamp did (Ubuntu 14.04, Apache, PHP 5, MySQL 5.5 in one container under
# supervisord; its scripts are in lamp/). WackoPicko needs PHP 5 (mysql_connect) and reaches
# MySQL on localhost, so the database stays in this container as upstream has it. The second
# part is upstream's Dockerfile unchanged, except that the paths read app/ and the base's
# CMD is restated.
FROM ubuntu:14.04

# --- tutum/lamp ---
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
    apt-get -y install supervisor git apache2 libapache2-mod-php5 mysql-server php5-mysql pwgen php-apc php5-mcrypt && \
    echo "ServerName localhost" >> /etc/apache2/apache2.conf
COPY lamp/start-apache2.sh lamp/start-mysqld.sh lamp/run.sh /
COPY lamp/my.cnf /etc/mysql/conf.d/my.cnf
COPY lamp/supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
COPY lamp/supervisord-mysqld.conf /etc/supervisor/conf.d/supervisord-mysqld.conf
RUN rm -rf /var/lib/mysql/*
COPY lamp/apache_default /etc/apache2/sites-available/000-default.conf
RUN a2enmod rewrite
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ENV PHP_UPLOAD_MAX_FILESIZE=10M \
    PHP_POST_MAX_SIZE=10M

# --- upstream ---
RUN apt-get update && apt-get install -y libgd-dev php5-gd
RUN rm -fr /app
COPY app/website /app
RUN chmod 777 /app/upload

COPY app/current.sql .
ADD app/create_mysql_admin_user.sh /create_mysql_admin_user.sh
ADD app/php.ini /etc/php5/apache2/php.ini
ADD app/php.ini /etc/php5/cli/php.ini
RUN sed -i 's/150/250/g' /etc/apache2/mods-available/mpm_worker.conf
RUN sed -i 's/150/250/g' /etc/apache2/mods-available/mpm_prefork.conf
RUN chmod 755 /*.sh

EXPOSE 80
CMD ["/run.sh"]
