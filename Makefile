ifndef CONFIG_DIR
override CONFIG_DIR = configs
endif

ifndef COMMON_CONFIG_DIR
override COMMON_CONFIG_DIR = common-configs/$(AWS_ACCOUNT_NAME)
endif

tf-clean:
	rm -f terraform.tfplan terraform.tfstate && rm -fR .terraform/

validate:
	# Validate the infrastructure.
	terraform init -backend-config="$(COMMON_CONFIG_DIR)/backend.hcl" && terraform get && terraform validate -var-file="$(COMMON_CONFIG_DIR)/common_vars.json" -var-file="configs/config-$(ENV_NAME).json"

plan:validate
	terraform init -backend-config="$(COMMON_CONFIG_DIR)/backend.hcl" && terraform get -update && terraform plan -var-file="$(COMMON_CONFIG_DIR)/common_vars.json" -var-file="configs/config-$(ENV_NAME).json" -out="configs/terraform.tfplan"

# Creates the network infrastructure.
create:
	# Get the modules, create the infrastructure.
	terraform init -backend-config="$(COMMON_CONFIG_DIR)/backend.hcl" && terraform get && terraform apply -auto-approve -var-file="$(COMMON_CONFIG_DIR)/common_vars.json" -var-file="configs/config-$(ENV_NAME).json" && terraform output -json > infra_info_$(ENV_NAME).json

# Destroy the network infrastructure.
destroy:
	terraform init -backend-config="$(COMMON_CONFIG_DIR)/backend.hcl" && terraform get && terraform destroy -auto-approve -var-file="$(COMMON_CONFIG_DIR)/common_vars.json" -var-file="configs/config-$(ENV_NAME).json"

# Lint the terraform files. Don't forget to provide the 'region' var, as it is
# not provided by default. Error on issues, suitable for CI.
tf-lint:
	terraform get
	TF_VAR_region="ap-southeast-1" tflint --error-with-issues
