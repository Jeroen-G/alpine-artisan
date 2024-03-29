# 🏔️ *Artisanal Docker images with Alpine Linux*

[![Docker Pulls][ico-pulls]][link-docker-hub]
[![Docker Image Size (latest by date)][ico-size]][link-docker-hub]

A set of lightweight Docker images created with Laravel in mind, but work just as fine for other applications.
At the basis lies Alpine Linux and the amazing [Docker-Webstack](https://github.com/eXistenZNL/Docker-Webstack) which keeps the images that you pull in very small but usable.

The image sets you up with Alpine Linux, PHP-FPM, Nginx. Currently there is an image for different PHP versions available.

## Installation
In the folder of your application create two files: `docker-compose.yml` and `Dockerfile` (note that the latter has no extension). On the command line, run `docker compose up -d --build` and view your containerized application at `localhost:80`.

The docker image contains a healthcheck. You can run the command `docker-compose ps` to see if the build was succesful, the state should mention "Up (healthy)" for the app container.

### Docker-compose.yml
```yaml
services:
  app:
    build: .
    ports:
      - 80:80
    volumes:
      - .:/www:delegated
```

### Dockerfile
```Dockerfile
FROM jeroeng/alpine-artisan:web8.3
```

## Configuration
In the end, the best Docker setup is one you create yourself. That being said, this is how you could quickly build upon the Docker image from this repository.

### Using a database
[Percona](https://hub.docker.com/_/percona) is an (optimized) version of MySQL and very useful as your database server. Add the following to your docker-compose.yml file:

```yaml
services:
  # app container definition

  db:
    image: percona:5.7
      environment:
        MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD:-secret}
        MYSQL_DATABASE: my_database
        MYSQL_USER: jeroen
        MYSQL_PASSWORD: ${MYSQL_ROOT_PASSWORD:-secret}
      volumes:
        - mysql-data:/var/lib/mysql:rw
      ports:
        - 3306:3306
volumes:
  mysql-data: # nothing necessary here, let Docker manage the storage
```

Your application's .env should contain the following environment variables, after that run `docker compose up -d --build` again to have a database container running next to your app.

```.env
DB_CONNECTION=mysql
DB_HOST=database
DB_PORT=3306
DB_DATABASE=my_database
DB_USERNAME=jeroen
DB_PASSWORD=secret
```

### Using Redis
A typical use of redis is for queues (possibly in combination with Laravel Horizon). To have a redis container, add to the docker-compose.yml file:

```yaml
services:
  # app container definition

  queue:
      image: redis:5-alpine
      ports:
        - 6379:6379
```

Adapt your .env file as well, and after another `docker compose up -d --build` you will have a redis container running for your application (yes, there is no password in this case). If you want to use Horizon, you would still need to install it in your application.

```.env
QUEUE_CONNECTION=redis
REDIS_HOST=queue
REDIS_PASSWORD=
REDIS_PORT=6379
```

### Standalone Laravel Horizon
Laravel Horizon requires a daemon in order to work. If you want to have Laravel Horizon running continuously you may start a new container based on the app one. The image name, `test_app` is unique for your application, `test` is the name of the folder, `app` is the name of the app container. After a `docker-compose build` this image name should be listed when you run `docker images`.

```yaml
services:
  horizon:
    image: test_app
    command: php artisan horizon
```

Note: this only runs horizon locally using docker-compose. As soon as you want to host horizon in a container in the cloud, e.g. using kubernetes, you will have to build a separate image.

## Contributing
Clone this repository and run `make` to see which commands are there to help you. every command requires a `TAG=` parameter, which is the Docker image you want to build, for example: `make build TAG=web8.0`.

[link-docker-hub]: https://hub.docker.com/r/jeroeng/alpine-artisan
[ico-pulls]: https://img.shields.io/docker/pulls/jeroeng/alpine-artisan?style=flat-square
[ico-size]: https://img.shields.io/docker/image-size/jeroeng/alpine-artisan?style=flat-square
