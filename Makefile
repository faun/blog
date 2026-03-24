.DEFAULT_GOAL := default

default: build

.PHONY: deploy

deploy: build
	@echo "Deploying with Wrangler..."
	@npx wrangler deploy

.PHONY: serve

serve:
	@echo "Starting the development server..."
	@hugo server

.PHONY: build

build:
	@echo "Building the project with Hugo..."
	@hugo

.PHONY: test

test: build
	@echo "Running tests..."
	@bundle check || bundle install
	@bundle exec rspec spec/site_spec.rb
