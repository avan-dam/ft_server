FROM debian:buster
#make sure correct version
RUN apt-get update
RUN apt-get -y install wget
RUN mkdir -p /var/www/html/phpmyadmin

#install nginx
RUN apt-get -y install nginx
COPY ./srcs/nginx.conf etc/nginx/sites-available/amber
RUN ln -s /etc/nginx/sites-available/amber /etc/nginx/sites-enabled/amber

# copy in certificates
COPY ./srcs/localhost.crt etc/ssl/certs/
COPY ./srcs/localhost.key etc/ssl/certs/

#install mariadb the current default MySQL compatible database server and create database
RUN apt-get -y install mariadb-server 

#php set up wordpress database in phpmyadmin SQL  
RUN service mysql start && \
    echo "CREATE DATABASE wordpress;" | mysql -u root && \
    echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'username'@'localhost' IDENTIFIED BY 'password';" | mysql -u root && \
    echo "GRANT SELECT, INSERT, DELETE, UPDATE ON phpmyadmin.* TO 'root'@'localhost';" | mysql -u root && \
    echo "FLUSH PRIVILEGES" | mysql -u root && \
    echo "update mysql.user set plugin = 'mysql_native_password' where user='root';" | mysql -u root

# download PHPmyAdmin and config file for it 
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip sendmail
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-english.tar.gz
RUN tar xf phpMyAdmin-5.0.1-english.tar.gz && rm phpMyAdmin-5.0.1-english.tar.gz
RUN mv phpMyAdmin-5.0.1-english/* /var/www/html/phpmyadmin/
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin
RUN service mysql start && mysql -u root mysql < /var/www/html/phpmyadmin/sql/create_tables.sql

# download wordpress and config with database
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN service mysql start && \
    wp core download --allow-root && \
    wp config create --dbhost=localhost --dbname=wordpress --dbuser=username --dbpass=password --allow-root && \
    wp core install --url=https://localhost --title="Amber's Amazing website!" --admin_name=username --admin_password=password --admin_email=ambervandam97@gmail.com --allow-root && \
    wp plugin install https://downloads.wordpress.org/plugin/classic-editor.1.5.zip --allow-root && \
    wp plugin activate classic-editor --allow-root
RUN mv *.php /var/www/html
RUN mv wp-* /var/www/html
RUN mv readme.html /var/www/html
RUN mv license.txt /var/www/html
RUN rm -rf phpMyAdmin-5.0.1-english


#send mail
# RUN echo "127.0.0.1 localhost localhost.localdomain" >> /etc/hosts

# increase limits
RUN cd /etc/php/7.3/fpm && sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 10M/g' php.ini && \
    sed -i 's/post_max_size = 8M/post_max_size = 20M/g' php.ini

# ownership rights and then permissions
RUN chown -R www-data:www-data /var/www/html
RUN chmod 775 -R var/www/html
RUN chmod 775 -R var/www/html/phpmyadmin

EXPOSE 80 443 110

# start it all
CMD service nginx start && service mysql start && service php7.3-fpm start && service sendmail start && bash
