
# Terraform Configuration for ha-validator Infrastructure

This directory contains Terraform configurations to set up the Google Cloud Platform (GCP) infrastructure for the ha-validator project.

## Prerequisites

Before you begin, ensure you have the following:

- [Google Cloud SDK (gcloud CLI)](https://cloud.google.com/sdk/docs/install) installed and configured
- [Terraform](https://www.terraform.io/downloads.html) (version 1.0.0 or later) installed
- A GCP project created and selected in your gcloud configuration
- A GCS bucket for Terraform state backend storage

## Getting Started

1. Set up your GCP authentication:
``` gcloud auth application-default login ```

2. Update the `backend.tf` file in the `environments/test` directory with your GCS bucket name:
```hcl
terraform {
  backend "gcs" {
    bucket  = "your-terraform-state-bucket"
    prefix  = "terraform/state"
  }
}
```
3. Update the `terraform.tfvars` file in the `environments/test` directory with your project details:
```
project_id  = "your-gcp-project-id"
region      = "your-preferred-region"
environment = "test"
```
## Installing 
To deploy the infrastructure: 
1. Initialize Terraform: 
	```
	cd environments/test  
	terraform init 
	``` 
2. Review the planned changes: 
`terraform plan` 
3. Apply the changes: 
`terraform apply`

## Upgrading 
To upgrade or modify the infrastructure: 
1. Make your changes to the Terraform files. 
2. Review the planned changes and apply: `terraform plan` then `terraform apply`

## Advanced 
### Module Structure 
The Terraform configuration is organized into the following modules: 
- `gcp_setup`: Enables necessary GCP APIs 
- `network`: Sets up VPC and subnets 
- `gke`: Creates and configures the GKE cluster 
- `iam`: Manages IAM roles and service accounts 

### Contribution Guide
Keep in mind the following guidelines when adding functionality to this codebase:
1. Maintain the modular structure and low coupling between modules.
2. Apply [DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself) principle. 