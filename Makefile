MAKEFLAGS  	+= --silent
SHELL      	 = /bin/bash

export TERRAFORM_FOLDER
export TF_VAR_cloudflare_zone_name

ifndef TERRAFORM_FOLDER
	TERRAFORM_FOLDER := "test"
endif

TF_VAR_cloudflare_zone_name := ${CLOUDFLARE_ZONE_NAME}

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help

help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

terraform-tfsec: ## Execute tfsec in terraform files
	echo "STEP: terraform-tfsec"
	cd ./${TERRAFORM_FOLDER}/ && \
	tfsec . --no-color

terraform-validate: ## Execute terraform validate in terraform files
	echo "STEP: terraform-validate"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform validate

terraform-clean: ## Remove terraform files untracked in git.
	echo "STEP: terraform-clean"
	cd ./${TERRAFORM_FOLDER}/ && \
	rm -rf .terraform/ && \
	rm -rf .terraform.* && \
	rm -rf backend.tf && \
	rm -rf terraform.tfstate.d && \
	rm -rf .terraform.lock.hcl && \
	rm -rf tf.plan

terraform-fmt: ## Execute terraform fmt in terraform files
	echo "STEP: terraform-fmt"
	terraform fmt -recursive

terraform-init: ## Execute terraform init in terraform files
	echo "STEP: terraform-init"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform init

terraform-plan: terraform-validate terraform-tfsec ## Execute terraform validate, tfsec and plan in terraform files 
	echo "STEP: terraform-plan"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform plan -var-file=env.tfvars -out tf.plan

terraform-apply: ## Execute terraform apply in terraform files
	echo "STEP: terraform-apply"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform apply -auto-approve tf.plan
	
terraform-destroy: ## Execute terraform destroy in terraform files
	echo "STEP: terraform-destroy"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform destroy -auto-approve -var-file=env.tfvars

fmt: terraform-fmt ## alias for terraform fmt
plan: fmt terraform-init terraform-plan ## Execute terraform fmt, init, plan in terraform files
apply: terraform-apply ## alias for terraform apply
destroy: terraform-destroy ## alias for terraform destroy
clean: terraform-clean ## alias for terraform clean
test: plan terraform-apply terraform-destroy ## Execute terraform plan, apply, destroy in terraform files
