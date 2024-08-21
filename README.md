# Project Name

## Description
This project aims to comprehensive and cost-effective way to run one or more highly available validator. Included in this project are monitoring, lifecycle management and costing.

Below is an index of the main sections, each linking to its own detailed documentation.

## Table of Contents
1. [Project Scope](project-scope/README.md)
2. [Solution Architecture](solution-architecture/README.md)
3. [Implementation]
   If you have read throughly the solution architecture, it proposes creating kubernetes infrastructure and then installing the cluster upon it.
   - [Setting up infrastructure](/infrastructure/terraform/README.md)
   - [Installing the cluster helm chart](/helm/ha-validator-cluster/README.md)
   
   Alternatively, included in this repo is the local enviornment which was used to test and validate approach.
   - [Running the local enviornment](/local/charon-distributed-validator-cluster/README.md)
4. [Results and Screenshots](/results/README.md)
5. [Costing](/costing/README.md)

