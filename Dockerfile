FROM wordpress:php7.3-apache

ARG INSTALL_DEPENDENCIES
RUN apt-get update -qq \
  && apt-get install -y --no-install-recommends ${INSTALL_DEPENDENCIES} \
      unzip \
  && curl -o /tmp/woocommerce.zip https://downloads.wordpress.org/plugin/woocommerce.3.6.4.zip \
  && unzip /tmp/woocommerce.zip -d /var \
  && rm /tmp/woocommerce.zip \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf \
      /var/lib/apt \
      /var/lib/dpkg \
      /var/lib/cache \
      /var/lib/log 

WORKDIR /var/www/html
COPY wp-custom-filters.php docker-entrypoint.sh ./

ENTRYPOINT ["/var/www/html/docker-entrypoint.sh"]
CMD ["apache2-foreground"]