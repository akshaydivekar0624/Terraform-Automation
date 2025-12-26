# Terraform-Automation
This repo is for Terraform-Automation

## Using your SSH key (Option A) 🔐

This repository supports importing a public SSH key into AWS via Terraform so you can use your existing private key locally (for example `AD_Linux_Server_Key.pem`). Follow these steps:

1. Generate the public key from your private key (run on your workstation or Jenkins agent):

   - Linux / macOS / Jenkins agent:
     - `ssh-keygen -y -f AD_Linux_Server_Key.pem > AD_Linux_Server_Key.pub`

   - Windows (PowerShell with OpenSSH):
     - `ssh-keygen -y -f .\AD_Linux_Server_Key.pem > .\AD_Linux_Server_Key.pub`

2. Create a `terraform.tfvars` file (DO NOT commit this file) and set the variables:

```
# terraform.tfvars
key_name = "AD_Linux_Server_Key"
public_key = "<paste the contents of AD_Linux_Server_Key.pub here>"
create_key_pair = true
```

3. The repository already contains `terraform.tfvars.example` — copy it to `terraform.tfvars` and fill in the `public_key` value.

4. Run Terraform:

```
terraform init
terraform apply -var-file="terraform.tfvars"
```

Security notes:
- **Never** commit your private key `.pem` file or `terraform.tfvars` containing secrets to the repository.
- This repo's `.gitignore` now includes `*.pem` and `terraform.tfvars` to help prevent accidental commits.

If you'd like, I can also update the `Jenkinsfile` to securely retrieve the private key from Jenkins credentials and export the public key into `terraform.tfvars` at build time — tell me if you want that automated.
