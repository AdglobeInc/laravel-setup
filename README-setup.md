# Project.Setup.Code

このリポジトリは、Laravelの初期セットアッププログラムです。  
これを元に新規PJを作成してください。

## Requirements

- [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)
  - あるいは他のDocker実行環境

## 概要

これでセットアップされる雛形は、Laravel単体プロジェクトとなっています。  
  
SPA構成など、複数のプログラムで構成されるプロジェクトは、1リポジトリで複数システムを管理するモノレポ構成で構築する必要があります。  
モノレポ構成を前提とした初期セットアッププログラムは、今のところ用意する予定はありません。  
※要望が多ければ検討しますので、Slackの`php部`チャンネルで意思表明ください。

## 初回セットアップ方法
以下の作業は、プロジェクト用のgitリポジトリに初回コミットを行う方のみが行う操作です。  
開発メンバーはこの作業は不要です。

### セットアッププログラムを Git clone する

```console
git clone -b main git@github.com:AdglobeInc/laravel-setup.git
git clone -b main https://github.com/AdglobeInc/laravel-setup.git

cd laravel-setup
```

### プロジェクト名を更新する
以下ファイルの `PROJECT_NAME=` を、正しいプロジェクト名に更新してください。
```console
vim docker/.env

PROJECT_NAME="project-null"
```

### 初期セットアップコマンドを実行する

```console
make init
```

以下ページが表示されることを確認してください。
- http://localhost (Laravel)
- http://localhost:8085 (phpMyAdmin)
- http://localhost:8025 (mailhog)

### gitリポジトリをプロジェクト用のリポジトリに変更してpushする
gitリポジトリの向き先をプロジェクト用のリポジトリに変更します。
```console
git remote set-url origin git@github.com:AdglobeInc/new-project.git
git remote set-url origin https://github.com/AdglobeInc/new-project.git

git push -u origin main
```

## Makefileコマンド
開発中によく利用するコマンドを `Makefile` にまとめています。

### Docker環境初回セットアップ用コマンド
以下のコマンドは、はじめてプロジェクト開発環境を構築する場合のみ実行します。
```console
make init
```

### 起動用コマンド
`docker-compose up` 相当のコマンドです。
```console
make up
```

### 終了用コマンド
`docker-compose down` 相当のコマンドです。
```console
make down
```

### exec実行コマンド
`docker compose exec` 相当のコマンドです。
```console
make exec args="php php -v"
```

### psコマンド
`docker-compose ps` 相当のコマンドです。
```console
make ps
```

### データベースリフレッシュコマンド
`php artisan migrate:fresh --seed` 相当のコマンドです。
```console
make fresh
```

### ユニットテストコマンド
`php artisan test` 相当のコマンドです。
```console
make test
```

### phpcsチェックコマンド
`./vendor/bin/phpcs --standard=phpcs.xml ./` 相当のコマンドです。
```console
make phpcs
```

### phpstanチェックコマンド
`./vendor/bin/phpstan analyse` 相当のコマンドです。
```console
make phpstan
```
