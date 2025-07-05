1. Secure 3-tier network architecture
Tier 1: Frontend subnet – e.g., hosts a web app (public or limited access)

Tier 2: Backend subnet – e.g., hosts APIs or application services (internal)

Tier 3: Database subnet – e.g., Postgres/MySQL/SQL Server (private)

Each tier is isolated using:

Separate subnets

NSGs (Network Security Groups)

Routing control (e.g., no internet in DB tier)

✅ Terraform modules should be used for each component (vnet, subnet, NSG, VM, etc.)

2. Lock down frontend access to specific IPs
Allow access to the frontend VM or service (e.g., Nginx, web app) only from specific public IPs.

Use NSG rules to allow only whitelisted IPs.

💡 Example: Only allow access from x.x.x.x/32 to port 80/443 on frontend subnet.

3. Secure the application
This is general, but may include:

NSGs limiting access across subnets

No public access to backend/DB

Enabling VM disk encryption, disabling password login (SSH key only)

Use Azure Key Vault to store secrets

Use Ansible to install and harden the app/OS (e.g., disable root login, set up firewall)