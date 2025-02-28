CC1 := docker compose
CC2 := flutter
HAS_CC1 := $(shell command -v docker >/dev/null 2>&1 && echo 1 || echo 0)
HAS_CC2 := $(shell command -v flutter >/dev/null 2>&1 && echo 1 || echo 0)
IMAGE := viewapp_user

.PHONY: all apk linux web docker clean up-docker logs-docker stop-docker check-env

# 預設選項
all: check-env
clean: clean-docker clean-build
debug: install-lib debug-chrome

# 建置目標平台
docker: stop-docker clean-docker build-docker
apk: install-lib build-apk
linux: install-lib build-linux
web: install-lib build-web

# 各平台的target
check-env:
ifeq ($(HAS_CC1),1)
ifeq ($(HAS_CC2),1)
	@echo "Environment OK: Docker and Flutter found."
	@$(MAKE) docker
else
	@echo "Error: Flutter not found!"
	@exit 1
endif
else
	@echo "Error: Docker not found!"
	@exit 1
endif

install-lib:
	@if ! command -v $(CC2) >/dev/null 2>&1; then \
    		echo "Error: Flutter not found!"; exit 1; \
    fi
	@$(CC2) pub get

build-apk:
	@$(CC2) build apk

build-linux:
	@$(CC2) build linux

build-docker:
	@$(CC1) up --build -d

build-web:
	@$(CC2) build web

up-docker:
	@$(CC1) up -d

logs-docker:
	@$(CC1) logs --tail=100 -f

stop-docker:
	@$(CC1) stop

clean-docker:
	@$(CC1) down

clean-build:
	@$(CC2) clean

debug-chrome:
	@$(CC2) run -d chrome