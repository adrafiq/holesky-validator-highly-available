# Cost Analysis for Ethereum Validator Setup on GCP

## Overview
This document provides an estimated monthly cost breakdown for running our Ethereum validator setup on Google Cloud Platform (GCP). The estimates are based on the infrastructure defined in our Terraform configuration.

## Cost Components

### 1. GKE Cluster Management
- Cost: $0.10 per hour
- Monthly cost: $0.10 * 730 hours = $73.00

### 2. Compute Engine (Node VMs)
- Machine type: e2-standard-4
- Cost per VM:$127.97046 per month
- Number of nodes: 1 (min) to 5 (max)
- Monthly cost range: 
  - Minimum (3 node): $127.97046 * 3 = $384
  - Maximum (5 nodes): $127.97046 * 5 = $640

### 3. Network Egress
- Cost: $0.12 per GB
- Estimated monthly egress: 100 GB (example)
- Monthly cost: $0.12 * 100 GB = $12.00

### 4. Cloud NAT
- Gateway cost: $0.044 per hour
- Monthly gateway cost: $0.044 * 730 = $32.12
- Data processing cost: $0.045 per GB
- Estimated monthly processed data: 50 GB (example)
- Monthly data processing cost: $0.045 * 50 GB = $2.25

### 5. Persistent Disk Storage
- Cost: $0.040 per GB per month
- Estimated storage: 500 GB (example)
- Monthly cost: $0.040 * 500 GB = $15.00

## Total Estimated Monthly Cost

### Minimum Configuration (3 node)
- GKE Cluster Management: $73.00
- Compute Engine (1 node): $384.91
- Network Egress: $12.00
- Cloud NAT: $34.37
- Storage: $15.00
- **Total: $518.37**

### Maximum Configuration (5 nodes)
- GKE Cluster Management: $73.00
- Compute Engine (5 nodes): $640.57
- Network Egress: $12.00
- Cloud NAT: $34.37
- Storage: $20.00
- **Total: $779.37.94**

## Notes
- All prices are in USD and based on us-central1 region pricing as of August 2024.
- Actual costs may vary based on usage, especially network egress and data processing.

## Cost Optimization Strategies
1. Use lightweight clients as beacon. For example, nimbus. 
2. Enable statepruning and caching for execution clients. Achieving that can result in reduced significant load on compute and storage. 
