# 🚀 Automated Infrastructure Project (Terraform + Ansible + Nginx)

## 📌 Project Overview
This project automates infrastructure deployment on **AWS** using **Terraform**, followed by **Ansible** configuration management and **Nginx** setup.

### Tech Stack
- **Terraform** → Infrastructure as Code (VPC, Subnets, EC2, Security Groups, Load Balancer, Auto Scaling Group).
- **Ansible** → Configuration management (installing packages, managing users, deploying apps).
- **Nginx** → Web server setup with load balancing and reverse proxy.

---

## 📂 Project Structure
project-automated-infra/
│── terraform/
│ ├── main.tf # Root Terraform file calling modules
│ ├── variables.tf # Input variables
│ ├── outputs.tf # Output values
│ ├── providers.tf # AWS provider
│ ├── modules/ # Reusable Terraform modules
│ │ ├── vpc/
│ │ ├── alb/
│ │ └── asg/
│ └── envs/
│ └── dev/ # Environment-specific configs
│── ansible/ # (will be added later)
│── nginx/ # (will be added later)
└── README.md


---

## ⚡ How to Use

### 1️⃣ Initialize Terraform
```bash
cd terraform
terraform init

2️⃣ Validate the Configuration
terraform validate

3️⃣ Preview the Infrastructure Changes
terraform plan

4️⃣ Apply the Infrastructure
terraform apply

5️⃣ Destroy Infrastructure (Cleanup)
terraform destroy

