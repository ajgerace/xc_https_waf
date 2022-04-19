# xc_https_waf
terraform module to deploy a http load balancer with an app firewall

## Instructions
1. Create 3x env variables, for example:
````bash
export VOLT_API_URL='https://<your-tenant-name>.ves.volterra.io/api'
export VOLT_API_P12_FILE='/home/ubuntu/myp12file.p12'
export VES_P12_PASSWORD='password'
````

2. Run terraform. If you have not updated the variables.tf file with your xcTenant and demoNameSpace, define those variables at the cmd line:
````bash
terraform init
terraform plan -var custName=customer -var originFQDN=www.customer.com -var xcTenant=<your-tenant-name> -var demoNameSpace=<your-namespace>
terraform apply -var custName=customer -var originFQDN=www.customer.com -var xcTenant=<your-tenant-name> -var demoNameSpace=<your-namespace>
````