CC1 := docker compose
CC2 := flutter
IMAGE := viewapp_master

.PHONY: all apk linux build up logs stop clean debug-chrome

all: build
apk: build-apk
linux: build-linux

build:
	@$(CC1) up --build -d

up:
	@$(CC1) up -d

logs:
	@$(CC1) logs --tail=100 -f

stop:
	@$(CC1) stop

clean:
	@$(CC1) down

build-apk:
	@$(CC2) build apk

build-linux:
	@$(CC2) build linux

debug-chrome:
	@$(CC2) run -d chrome