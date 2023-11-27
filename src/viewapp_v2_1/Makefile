CC1:=docker compose
CC2:=flutter
IMAGE:=viewapp_v2_1

.PHONY: build up logs stop clean apk linux

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
