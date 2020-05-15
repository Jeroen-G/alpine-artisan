# 🏔️ *Artisanal Docker images with Alpine Linux*
A set of lightweight Docker images created with Laravel in mind, but work just as fine for other applications.
At the basis lies Alpine Linux and [Docker-Webstack](https://github.com/eXistenZNL/Docker-Webstack) which keeps the images that you pull in very small but usable.

## Targets
Every Docker image comes with a difference between development and production. To build the right image you have to provide either a `dev` or `prod` target.

## Docker-compose
```yaml
services:
  app:
    image: jeroen-g/alpine-artisan:web7.4
    build:
    target: dev
    args:
    USERID: ${USERID:-1000}
    GROUPID: ${GROUPID:-1000}
```

## Docker images

### Web
Sets you up with Alpine Linux, PHP-FPM, Nginx. The aim is to support the latest two PHP version, right now that's 7.3 and 7.4.

To use PHP 7.3 use:
```
FROM jeroen-g/alpine-artisan:web7.3
```

For PHP 7.4:
```
FROM jeroen-g/alpine-artisan:web7.4
```

### Horizon
Laravel Horizon requires a slightly different container than your web application. Again, the aim is to support the latest two PHP versions.

To use PHP 7.3 use:
```
FROM jeroen-g/alpine-artisan:horizon7.3
```

For PHP 7.4:
```
FROM jeroen-g/alpine-artisan:horizon7.4
```

## Contributing
Clone this repository and run `make` to see which commands are there to help you. every command requires a `TAG=` parameter, which is the Docker image you want to build, for example: `make build TAG=web7.4`.