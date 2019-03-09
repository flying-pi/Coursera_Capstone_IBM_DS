WORKDIR := $(shell pwd)

help: ## Display help message
	@echo "Please use \`make <target>' where <target> is one of"
	@perl -nle'print $& if m{^[\.a-zA-Z_-]+:.*?## .*$$}' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m  %-25s\033[0m %s\n", $$1, $$2}'


run_notebook: .build/notebook ## Run notebook
	export WORKDIR=$(WORKDIR); docker-compose up notebook

.build:
	mkdir .build

.build/notebook: .build requirements.txt Docker-notebook
	docker build -t capstone_notebook:latest -f Docker-notebook .
	touch $@

