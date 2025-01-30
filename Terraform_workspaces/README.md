# Terraform Workspace

### what is terraform workspace?

Terraform workspaces enable us to manage multiple deployments of the same configuration.When we create cloud resource using the terraform, the resources are created in the default workspace. Using terraform workspaces we can create multiple workspaces (i.e dev, stage, uat, prod) which are having isolated state files.
Each workspace has its own state file, so we can manage multiple environments with the same terraform configuration.

With a single config terraform file we can deploy same resources with different requirements of the resources depending upon the enviroment for which we are deploying.

for example: we have to deploy an EC2 Instance and S3 bucket for dev enviroment with instance_type  varies with the enviroment requirements.
    Let say for dev instance_type = t2.micro
    for stage instance_type = t2.medium
    and for prod instance_type = t2.xlarge

we can change the variables.tfvars file and deploy for specified enviroment.