#!/bin/bash

INSTALL_DIR=/var/www/html

rm -rf $INSTALL_DIR/* && \
/usr/local/bin/composer create-project laravel/laravel $INSTALL_DIR && \
chmod -R 777 $INSTALL_DIR/storage/logs
