.PHONY: all plan apply destroy remote_state
    SHELL := $(SHELL) -e

all: plan apply

remote_state:
	terraform remote config -backend=s3 -backend-config="bucket=tah-ruk" -backend-config="key=terraform/vpc-10_110.tfstate" -backend-config="region=us-east-1"

plan:
	terraform get -update
	terraform plan -var-file terraform.tfvars -out terraform.tfplan

apply: remote_state
	terraform apply -var-file terraform.tfvars

clean:
	rm -f terraform.tfplan
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup

test:
	./scripts/testPlan
