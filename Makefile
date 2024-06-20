.DEFAULT_GOAL := default

default: build

.PHONY: deploy

deploy: build
	@echo "Deploying with Wrangler..."
	@npx wrangler deploy

.PHONY: serve

serve:
	@echo "Starting the development server..."
	@middleman server

.PHONY: build

# Check if the required gems are installed, install any that are missing, then build and deploy the project.
build:
	@echo "Checking for bundle dependencies..."
	@bundle check || bundle install
	@echo "Building the project with Middleman..."
	@middleman build
