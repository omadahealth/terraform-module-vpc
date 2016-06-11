.PHONY: all plan apply test destroy

all: test

plan: .terraform
	terraform plan

apply: .terraform
	terraform apply

destroy: .terraform
	terraform destroy
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup

test: apply destroy

clean: destroy
	rm -rf .terraform

.terraform:
	terraform get
