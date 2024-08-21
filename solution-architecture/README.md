# 2. Implementation

## 2.1 System Architecture

### Context and Challenges

Running a highly available Ethereum validator setup presents unique challenges. Traditional high availability strategies often involve running multiple replicas of a service. However, for Ethereum validators, this approach can lead to severe penalties due to slashing rules.

### Charon: Distributed Validator Solution

To address this challenge, we're using Charon, a distributed validator middleware developed by Obol Network. Charon allows multiple validator clients to operate as a single logical validator, enhancing fault tolerance without risking slashing penalties. It acts a middleware between validator and consensys clients, ensuring they act as a single logical validator. It implements distributed key generation and threshold signing, allowing the validator to continue operating even if some components fail.

This approach allows us to achieve high availability while mitigating the risk of slashing.

### System Architecture Diagram
![!\[Architecture Diagram\]()](architecture-diagram.svg)

Key components:
1. **Execution Client**: Handles transaction execution and state management.
2. **Consensus Client**: Manages the proof-of-stake protocol and block proposals.
3. **Charon Middleware**: Coordinates actions between multiple validator clients.
4. **Validator Clients**: Manage keys and signing operations, working together as a distributed validator.

In this setup:
- The execution and consensus clients operate as in a standard Ethereum node.
- Charon acts as a middleware, presenting itself as a standard beacon node to the validator clients.
- Validator clients connect to Charon instead of directly to the consensus client.
- Charon manages the distribution of duties and coordination of signatures across the validator clients.

This architecture allows us to run multiple validator clients for the same validator without risking slashing, providing high availability and fault tolerance.

## 2.2 Client Selection

Our Ethereum validator setup on the Holesky Testnet prioritizes resource efficiency and cost optimization:

1. **Execution Client: Geth (Go Ethereum)**
   - Efficient resource utilization and wide adoption
   - Offers snap sync for faster initial synchronization

2. **Consensus Client: Nimbus**
   - Designed for resource-constrained environments
   - Low memory and CPU footprint

3. **Validator Clients:**
   - **Nimbus (integrated)**: Seamless integration with Nimbus consensus client
   - **Teku**: Known for reliability and performance, offers good balance with Nimbus

This combination provides a balance of efficiency, reliability, and flexibility, allowing for cost-effective operation on modest hardware or smaller cloud instances.

## 2.3 Tools and Infrastructure Enviornment

For our Ethereum cluster, we have chosen to leverage Kubernetes on Google Cloud Platform (GCP) to create a highly available and stable infrastructure. This setup allows us to optimize for reliability, scalability, and ease of management. Below are the key components of our environment:

### Infrastructure Components:
1. **Kubernetes Cluster**: Deployed on Google Cloud Platform
2. **Region**: Single region deployment
3. **Availability Zones**: Utilizing 2 Availability Zones (AZs) within the chosen region
4. **Node Pool**: One node pool spread across the 2 AZs, with one node per AZ

### Ethereum Node Components:
1. **Validator and Charon**:
   - Deployed as a StatefulSet
   - Charon runs as a sidecar container alongside the validator
   - Validators are spread across different AZs for high availability

2. Charon Relay, Execution Client, Consensus Client deployed as stateful set each.

### Benefits of This Setup:
1. **High Availability**: By spreading validators and other components across multiple AZs, we ensure that the cluster remains operational even if one AZ experiences issues.

2. **Stability**: StatefulSets provide stable, unique network identifiers and persistent storage, which is crucial for maintaining the state of Ethereum nodes.

This infrastructure design creates a robust and reliable foundation for our Ethereum cluster, balancing performance, availability, and manageability.

