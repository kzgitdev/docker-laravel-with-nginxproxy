## Overview

using nginx-proxy(jwilder/nginx-proxy) in frontend server and building web application server(Laravel8) in backend server.

Backend server inclues 4 docker containers contain nginx:1.19.4, php:7.4-fpm, mariadb:10.5.8, redis:6.0.9 and adminer:4.7.7 .

Dockerfile of php:7.4-fpm does the following.
 - installing compose.phar in /usr/local/bin/composer
 - adding user for container 
 - copying setup_laravel.shell in /tmp/setup_laravel.sh


## Development environment

<details><summary>System info</summary>
<div>

```
$ cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04.1 LTS"
$ arch
x86_64

$ docker version
Client:
 Version:           19.03.8
 API version:       1.40
 Go version:        go1.13.8
 Git commit:        afacb8b7f0
 Built:             Wed Oct 14 19:43:43 2020
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.8
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.13.8
  Git commit:       afacb8b7f0
  Built:            Wed Oct 14 16:41:21 2020
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.3.3-0ubuntu2
  GitCommit:
 runc:
  Version:          spec: 1.0.1-dev
  GitCommit:
 docker-init:
  Version:          0.18.0
  GitCommit:

$ docker-compose version
docker-compose version 1.27.4, build 40524192
docker-py version: 4.3.1
CPython version: 3.7.7
OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019
```

</div>
</details>

## Directory structure
<details><summary>click below to the detail</summary>
<div>

```

+-- /proxy
|   +-- /log
|       +-- /nginx
|           +-- access.log
|           +-- error.log
|   +-- docker-compose.yml
+-- /example.com
|   +-- /laravel <= subdomain: laravel.example.com
|       +-- /build
|           +-- /nginx
|               +-- default.conf
|           +-- /php
|               +-- Dockerfile
|               +-- php.ini
|               +-- setup_laravel.sh
|       +-- /db <= mount point: /var/lib/mysql
|       +-- /src <= laravel install dir mount in /var/www/html
|       +-- .env
|       +-- docker-compose.yml
```

</div>
</details>

## Usage

```
0. Register your domain with DNS(Domain Name System) Server.

1. Config .env file.
  see and edit parameters.

2. run nginx-proxy.
  $cd proxy/
  $docker-compose --build -d

3. Start up laravel.example.com .
  $cd example.com/laravel
  $docker-compose --build -d

4. login app container and install Laravel8 using shell script.
  $docker exec -it sv-laravel-app bash
  $/tmp/setup_laravel.sh

````
## Check containers operation

<details><summary>Check installed modules in PHP:7.4-FPM</summary>
<div>

```
/src/public/index.php
add php code

/*
|--------------------------------------------------------------------------
| Run The Application
|--------------------------------------------------------------------------
|
| Once we have the application, we can handle the incoming request using
| the application's HTTP kernel. Then, we will send the response back
| to this client's browser, allowing them to enjoy our application.
|
*/
// add here
phpinfo();

```
access http://laravel.example.com with web browser.

</div>
</details>

<details><summary>Check mariadb server operation</summary>
<div>

```
$ docker exec -it sv-laravel-db bash
# mysql -V
mysql  Ver 15.1 Distrib 10.5.8-MariaDB, for debian-linux-gnu (x86_64) using readline 5.2
```

</div>
</details>


<details><summary>Check adminer </summary>
<div>
access http://admr.laravel.example.com with web browser.

</div>
</details>


<details><summary>Check redis server operation</summary>
<div>
login redis server and check version.

```
$ docker exec -it sv-laravel-redis bash
# redis-server -v
Redis server v=6.0.9 sha=00000000:0 malloc=jemalloc-5.1.0 bits=64 build=12c354e6793cb936
```

</div>
</details>
