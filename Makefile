MAKEFLAGS  	+= --silent
SHELL      	 = /bin/bash

export TERRAFORM_FOLDER
export TF_VAR_cloudflare_zone_name

ifndef TERRAFORM_FOLDER
	TERRAFORM_FOLDER := "test"
endif

TF_VAR_cloudflare_zone_name := ${CLOUDFLARE_ZONE_NAME}

terraform-tfsec:
	echo "STEP: terraform-tfsec"
	cd ./${TERRAFORM_FOLDER}/ && \
	tfsec . --no-color

terraform-validate:
	echo "STEP: terraform-validate"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform validate

terraform-clean:
	echo "STEP: terraform-clean"
	cd ./${TERRAFORM_FOLDER}/ && \
	rm -rf .terraform/ && \
	rm -rf .terraform.* && \
	rm -rf backend.tf && \
	rm -rf terraform.tfstate.d && \
	rm -rf .terraform.lock.hcl && \
	rm -rf tf.plan

terraform-fmt:
	echo "STEP: terraform-fmt"
	terraform fmt -recursive

terraform-init:
	echo "STEP: terraform-init"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform init

terraform-plan: terraform-validate terraform-tfsec
	echo "STEP: terraform-plan"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform plan -var-file=env.tfvars -out tf.plan

terraform-apply:
	echo "STEP: terraform-apply"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform apply -auto-approve tf.plan
	
terraform-destroy:
	echo "STEP: terraform-destroy"
	cd ./${TERRAFORM_FOLDER}/ && \
	terraform destroy -auto-approve -var-file=env.tfvars

fmt: terraform-fmt
plan: fmt terraform-init terraform-plan
apply: terraform-apply
destroy: terraform-destroy
clean: terraform-clean
test: plan terraform-apply terraform-destroy
