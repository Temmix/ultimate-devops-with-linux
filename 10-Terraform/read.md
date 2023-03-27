TERRAFORM

Some command

Initialize terraform
    terraform init 

Apply changes
    terraform apply

Destroy changes
    terraform destroy aws_vpc.default

Destroy all the resource
    terraform destroy

Check the difference between the current state and the desire state
    terraform plan

Apply changes without confirming
    terraform apply -auto-approve

Best Practise , you should use terraform apply, as the code should represent the actual state of the code.
Delete resource on the source code and call terraform apply.

Check state of resources on the command line
    terraform state list (This will show all the resource available)
    terraform state show aws_vpc.development (This will show all the information about this specific resource)

If you want terraform to show some information about the resource create
    use the output

When you have different variable files, normally terraform will be looking for terraform.tfvars files, 
in the absent of that, you have specify the variable file when executing terraform apply command
    terraform apply -var-file terraform-dev.tfvars