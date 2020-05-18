# 🏔️ *Artisanal Docker images with Alpine Linux*
A set of lightweight Docker images created with Laravel in mind, but work just as fine for other applications.
At the basis lies Alpine Linux and [Docker-Webstack](https://github.com/eXistenZNL/Docker-Webstack) which keeps the images that you pull in very small but usable.

## Installation
In the folder of your application create two files: `docker-compose.yml` and `Dockerfile` (note that the latter has no extension).

### Docker-compose.yml
```yaml
services:
  app:
    build: .
    ports:
      - 80:80
```

### Dockerfile
```Dockerfile
FROM jeroen-g/alpine-artisan:web7.3
```

## Docker images

### Web
Sets you up with Alpine Linux, PHP-FPM, Nginx. The aim is to support the latest two PHP version, right now that's 7.3 and 7.4.

To use PHP 7.3 use:
```
FROM jeroeng/alpine-artisan:web7.3
```

For PHP 7.4:
```
FROM jeroeng/alpine-artisan:web7.4
```

## Contributing
Clone this repository and run `make` to see which commands are there to help you. every command requires a `TAG=` parameter, which is the Docker image you want to build, for example: `make build TAG=web7.4`.