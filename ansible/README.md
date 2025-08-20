# Ansible Playbook for Nginx on EC2 Instances 

This Ansible setup installs and configures **Nginx** on EC2 instances tagged with `Name=vm-lt-1` in AWS. It uses a **dynamic inventory** to automatically detect instances and deploys a custom Nginx configuration.

---

## **Directory Structure**
```
ansible/
├── roles/
│ └── nginx/
│ ├── defaults/
│ │ └── main.yaml
│ ├── tasks/
│ │ └── main.yaml
│ └── templates/
│ └── nginx.conf.j2
├── group_vars/
│ └── all.yaml
├── ansible.cfg
├── site.yaml
├── README.md
└── inventory.yaml
```

- `roles/nginx/` → Contains the Nginx role.
- `site.yaml` → Main playbook.
- `inventory.yaml` → Dynamic inventory configuration for AWS EC2.

---

## **Prerequisites**

- Python 3.x
- Ansible 2.10+
- `boto3` and `botocore` Python libraries:

```
pip install boto3 botocore
```

-  AWS CLI configured with access to the target region.

-  SSH key pair corresponding to your EC2 instances.

---

### Dynamic Inventory Configuration (inventory.yaml)
```
plugin: aws_ec2
regions:
  - us-east-1           # Replace with your AWS region
filters:
  "tag:Name": "vm-lt-1"
keyed_groups:
  - key: tags.Name
    prefix: tag_Name_
hostnames:
  - public-ip-address    # Connect from your laptop
```

-  Filters only EC2 instances tagged vm-lt-1.

-  Creates a group tag_Name_vm_lt_1 used in the playbook.

-  Uses public IPs to connect from outside the VPC.

###  Playbook (site.yaml)
```
- name: Configure Nginx on web servers
  hosts: tag_Name_vm_lt_1
  become: yes
  roles:
    - nginx
```
-  Targets all EC2 instances in group tag_Name_vm_lt_1.

-  Uses become: yes for privilege escalation.

-  Applies the nginx role.

---

### Running the Playbook
```
ansible-playbook -i aws_ec2.yaml site.yaml \
  --private-key ~/path/to/my-key.pem \
  -u ec2-user
```

-  --private-key → Path to the SSH private key for EC2 instances.

-  -u ec2-user → Default user for Amazon Linux 2.

---

### Nginx Role Tasks

-  Enable Nginx via Amazon Linux Extras.

-  Install Nginx.

-  Start and enable the Nginx service.

-  Deploy custom nginx.conf template.

-  Restart Nginx to apply configuration.

-  Template nginx.conf.j2 outputs:

-  Hello from {{ inventory_hostname }} via Nginx!

