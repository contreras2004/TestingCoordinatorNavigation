SHELL := /bin/bash

mock:
	node index mock

mock-proxy:
	node index mock-proxy

mock-docker:
	docker-compose -f docker-compose-local.yml up --build

nvm:
	[ -s "$$HOME/.nvm/nvm.sh" ] && . "$$HOME/.nvm/nvm.sh" && \
	nvm install $$(cat .nvmrc) && \
	nvm use

install:
	npm install --production
