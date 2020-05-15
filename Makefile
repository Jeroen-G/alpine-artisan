.PHONY: all

info: intro show-commands

intro:
	@echo "     _    _       _                 _         _   _                 "
	@echo "    / \  | |_ __ (_)_ __   ___     / \   _ __| |_(_)___  __ _ _ __  "
	@echo "   / _ \ | | '_ \| | '_ \ / _ \   / _ \ | '__| __| / __|/ _' | '_ \ "
	@echo "  / ___ \| | |_) | | | | |  __/  / ___ \| |  | |_| \__ \ (_| | | | |"
	@echo " /_/   \_\_| .__/|_|_| |_|\___| /_/   \_\_|   \__|_|___/\__,_|_| |_|"
	@echo "           |_|                                                      "
	@echo ""

show-commands:
	@echo "=== Make commands ==="
	@echo "    make build"
	@echo "    make start"
	@echo "    make stop"
	@echo "    make clean"
	@echo "    make test"

# Variables
PWD := $(dir $(MAKEPATH))
PROJECTNAME=jeroen-g/alpine-artisan
TAG=UNDEF

build:
	if [ "$(TAG)" = "UNDEF" ]; then echo "Please provide a valid TAG" && exit 1; fi
	docker build -t $(PROJECTNAME):$(TAG) -f $(TAG).Dockerfile --pull .

start:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker run --privileged -d -p 8080:80 --name $(TAG)_instance $(PROJECTNAME):$(TAG)

stop:
	docker stop -t0 $(TAG)_instance
	docker rm $(TAG)_instance

clean:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker rmi $(PROJECTNAME):$(TAG)

test:
	if [ "$(TAG)" = "UNDEF" ]; then echo "please provide a valid TAG" && exit 1; fi
	docker ps | grep $(TAG)_instance | grep -q "(healthy)"
	wget -q localhost:8080 -O- | grep -q "PHP Version"
