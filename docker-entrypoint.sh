#!/usr/bin/env bash

set -e

# Call WordPress docker-entrypoint.sh to copy over WordPress files
# https://github.com/docker-library/wordpress/blob/641f8442947e07d2e2398e7f5fe516a5fb3f48b1/php7.3/apache/Dockerfile#L82
nohup /usr/local/bin/docker-entrypoint.sh apache2-foreground >/tmp/apache.log &

while ! [ -f /var/www/html/wp-includes/functions.php ]; do
  sleep 1
  echo "Waiting for WordPress files..."
done

# Add custom WP filter to allow unsafe (local) URLs and non-standard ports
cat wp-custom-filters.php >> /var/www/html/wp-includes/functions.php

# Copy WooCommerce after WordPress files are copied over
mv /var/woocommerce /var/www/html/wp-content/plugins/

exec "$@"
