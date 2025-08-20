# Automated Infrastructure & Configuration (Terraform + Ansible + Nginx)

## Project Overview
This project demonstrates **Infrastructure as Code (IaC)** and **Configuration Management** by deploying a **highly available web server setup** on AWS using Terraform and Ansible.  
It showcases:

- VPC, public subnets, and security groups
- Load-balanced EC2 Auto Scaling Group (ASG)  
- Nginx installation and configuration via Ansible  
- Dynamic AWS inventory for automatic configuration management  

---

## Architecture Diagram (ASCII)
```
  Internet
     |
     v
 +-------+
 |  ALB  |
 +-------+
   |  |
   v  v
+--------+ +--------+
| EC2 | | EC2 | <- Auto Scaling Group
| nginx | | nginx |
+--------+ +--------+
```

---

## Tech Stack

| Layer                  | Tool/Service         |
|------------------------|----------------------|
| IaC                    | Terraform            |
| Configuration Mgmt     | Ansible              |
| Load Balancer          | AWS ALB              |
| Compute                | AWS EC2 + ASG        |
| Web Server             | Nginx                |

---

## Prerequisites

- Terraform >= 1.5  
- Ansible >= 2.15  
- AWS CLI configured with proper credentials (`aws configure`)  
- SSH key pair (`.pub` + `.pem`)  
- Python installed for Ansible on local machine  

---

## Project Structure
```
project-automated-infra/
├─ terraform/
│ ├─ main.tf
│ ├─ variables.tf
│ ├─ outputs.tf
│ └─ modules/
│ ├─ vpc/
│ ├─ alb/
│ └─ asg/
└─ ansible/
├─ ansible.cfg
├─ inventory_aws_ec2.yaml
├─ site.yaml
└─ roles/
└─ nginx/
├─ tasks/main.yaml
├─ templates/nginx.conf.j2
└─ defaults/main.yaml
```

---

## Step 1 — Terraform Infrastructure

-  Navigate to Terraform folder:

```
cd terraform
```

-  Initialize Terraform:
```
terraform init
```

-  Check plan :
```
terraform plan
```

-  Apply infrastructure:
```
terraform apply
```

-  Outputs:
```
terraform output alb_dns_name
```

-  Use the ALB DNS to access Nginx web servers.

---

## Step 2 — Ansible Configuration

-  Install AWS collection for dynamic inventory:
```
ansible-galaxy collection install amazon.aws
```

-  Verify dynamic inventory:
```
ansible-inventory -i inventory.yaml --list
```

-  Run Nginx playbook:
```
ansible-playbook site.yaml
```

-  This installs and configures Nginx on all EC2 instances in the ASG.

-  Access your app through the ALB DNS.

---

## Step 3 — Testing

```
curl http://<alb-dns-name>
```

-  Expected response:

    *  Hello from ip-10-0-x-x.ec2.internal via Nginx!

    *  This confirms traffic is distributed to your EC2 instances.

Step 4 — Cleanup
```
terraform destroy -auto-approve
```
