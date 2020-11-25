# README.ja.md

## 概要

nginx-proxy(jwilder/nginx-proxy:latest)をリバースプロキシとして活用し、バックエンドサーバーにLarvel8を配置する構成です。
docker-composeで各コンテナをセットアップします。大まか流れは下記の通り。
- composerのインストール
- 一般ユーザーを追加
- Docker起動後にsetup_laravel.shシェルスクリプトでLaravelをインストール


## 開発環境
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

## コンテナ
<details><summary>ディレクトリ構成</summary>
<div>

```
/docker
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
|       +-- /src // laravel install dir
|       +-- .env
|       +-- docker-compose.yml
```

</div>
</details>

## 使い方
<details><summary>事前準備</summary>
<div>
 
 ```
0 DNSにIPアドレスとドメインを設定します
1 .envに必要な環境変数を記述します
2 nginx-proxy を起動します
  $cd proxy/
  $docker-compose --build -d
3 laravel.example.comの起動をします
  $cd example.com/laravel
  $docker-compose --build -d
 4 appコンテナにログインして、Laraelをインストールする
  $docker exec -it sv-laravel-app bash
  $/tmp/setup_laravel.sh
 
 ```
 
</div>
</details>

## 動作確認
<details><summary>PHPインストール済みモジュールの確認</summary>
<div>
 
```
/src/public/index.php

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
 
</div>
</details>

<details><summary>adminer起動の確認</summary>
<div>
 ブラウザから　http://admr.laravel.example.com　にアクセスする
 
 </div>
 </details>
 
 <details><summary>redisサーバ起動の確認</summary>
 <div>
 ```
  $ docker exec -it sv-laravel-redis bash
  # redis-server -v
Redis server v=6.0.9 sha=00000000:0 malloc=jemalloc-5.1.0 bits=64 build=12c354e6793cb936
 ```
</div>
</details>
