.PHONY: deploy

# Check if the required gems are installed, install any that are missing, then build and deploy the project.
deploy:
	@echo "Checking for bundle dependencies..."
	@bundle check || bundle install
	@echo "Building the project with Middleman..."
	@middleman build
	@echo "Deploying with Wrangler..."
	@npx wrangler deploy

