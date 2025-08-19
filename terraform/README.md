# 🚀 Automated Infrastructure with Terraform

## 📌 Project Overview
This project provisions a complete AWS infrastructure using **Terraform**.  
The setup follows a **modular structure** and supports multi-environment deployments.

### 🔧 Components Deployed
- **VPC Module**
  - Custom VPC with DNS support
  - Public subnets
- **Auto Scaling Group (ASG) Module**
  - EC2 launch template with user data
  - Auto Scaling configuration
  - Key pair for SSH access
  - Integration with Application Load Balancer (ALB)
- **Application Load Balancer (ALB) Module**
  - Target group
  - Listener
  - Attachment to ASG

---

## 📂 Project Structure
```
project-automated-infra/
│── terraform/
    ├── main.tf 
    ├── variables.tf  
    ├── outputs.tf 
    ├── providers.tf
    ├── .gitignore
    ├── .terraform.lock.hcl
    ├── README.md
    └── modules/ 
        ├── vpc/
        │   ├── main.tf 
        │   ├── variables.tf  
        │   └── outputs.tf  
        ├── alb/
        │   ├── main.tf 
        │   ├── variables.tf  
        │   └── outputs.tf 
        └── asg/
            ├── main.tf 
            ├── variables.tf  
            └── outputs.tf 
      
```

---

## ⚡ How to Use

### 1️⃣ Initialize Terraform
```
cd terraform
terraform init
```
2️⃣ Validate the Configuration
```
terraform validate
```
3️⃣ Preview the Infrastructure Changes
```
terraform plan
```
4️⃣ Apply the Infrastructure
```
terraform apply
```
5️⃣ Destroy Infrastructure (Cleanup)
```
terraform destroy
```
