## Overview

using nginx-proxy(jwilder/nginx-proxy) in frontend server and building a web application server in backend server.
Backend server inclues 4 docker containers contain nginx:1.19.4, php:7.4-fpm, mariadb:10.5.8, redis:6.0.9 and adminer:4.7.7

Dockerfile of php:7.4-fpm does the following.
 - installing compose.phar in /usr/local/bin/composer
 - adding user for container 
 - copying setup_laravel.shell in /tmp/setup_laravel.sh


## Development environment



## Directory structure



## Usage

--detail
