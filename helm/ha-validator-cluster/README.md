# Ethereum Validator Cluster Helm Chart

This chart sets up a highly available Ethereum validator cluster on the Holesky Testnet, including:
- Geth execution client
- Lighthouse consensus client
- Charon distributed validator client
- Lighthouse and Nimbus validators

## Installing and updating

To install the chart:
```
helm install ha-validator-cluster . -f values.yaml -n NAMESPACE
```

To upgrade an existing installation:
```
helm upgrade ha-validator-cluster . -f values.yaml
```

## Working Principle

1. **Clients as StatefulSets**: Each client (Geth, Lighthouse, validators) is deployed as a Kubernetes StatefulSet for stable network identity and persistent storage.
2. **Distributed Validator Technology**: Uses Obol Network's Charon client for distributed validator functionality.
3. **High Availability**: Implements multiple validator nodes (Lighthouse and Nimbus) for redundancy.
4. **Secrets Management**: Sensitive data (keys, JWT) are stored in Kubernetes Secrets.
5. **Monitoring**: Includes Prometheus and Grafana for monitoring the validator cluster.

## Configuration

The following table lists the configurable parameters of the Ethereum validator cluster chart and their default values.

| Parameter | Description | Default |
|-----------|-------------|---------|
| `global.network` | Ethereum network to use | `holesky` |
| `global.charonVersion` | Charon version | `v1.0.0` |
| `global.lighthouseVersion` | Lighthouse version | `v5.3.0` |
| `global.tekuVersion` | Teku version | `24.2.0` |
| `global.gethVersion` | Geth version | `v1.14.8` |
| `geth.enabled` | Enable Geth | `true` |
| `geth.replicaCount` | Number of Geth replicas | `1` |
| `geth.storage.size` | Geth storage size | `1Ti` |
| `geth.storage.storageClass` | Geth storage class | `standard` |
| `geth.resources.requests.cpu` | CPU request for Geth | `1` |
| `geth.resources.requests.memory` | Memory request for Geth | `4Gi` |
| `geth.resources.limits.cpu` | CPU limit for Geth | `2` |
| `geth.resources.limits.memory` | Memory limit for Geth | `8Gi` |
| `lighthouse.enabled` | Enable Lighthouse | `true` |
| `lighthouse.replicaCount` | Number of Lighthouse replicas | `1` |
| `lighthouse.checkpointSyncUrl` | Checkpoint sync URL | `https://checkpoint-sync.holesky.ethpandaops.ios` |
| `lighthouse.storage.size` | Lighthouse storage size | `100Gi` |
| `lighthouse.storage.storageClass` | Lighthouse storage class | `standard` |
| `lighthouse.resources.requests.cpu` | CPU request for Lighthouse | `1` |
| `lighthouse.resources.requests.memory` | Memory request for Lighthouse | `4Gi` |
| `lighthouse.resources.limits.cpu` | CPU limit for Lighthouse | `2` |
| `lighthouse.resources.limits.memory` | Memory limit for Lighthouse | `8Gi` |
| `charonRelay.enabled` | Enable Charon Relay | `true` |
| `charonRelay.replicaCount` | Number of Charon Relay replicas | `1` |
| `charonRelay.storage.size` | Charon Relay storage size | `10Gi` |
| `charonRelay.storage.storageClass` | Charon Relay storage class | `standard` |
| `validators.replicaCount` | Number of validator replicas | `2` |
| `validators.resources.requests.cpu` | CPU request for validators | `500m` |
| `validators.resources.requests.memory` | Memory request for validators | `1Gi` |
| `validators.resources.limits.cpu` | CPU limit for validators | `1` |
| `validators.resources.limits.memory` | Memory limit for validators | `2Gi` |
| `validators.storage.size` | Validators storage size | `100Gi` |
| `validators.storage.storageClass` | Validators storage class | `standard` |
| `monitoring.prometheus.enabled` | Enable Prometheus | `true` |
| `monitoring.prometheus.version` | Prometheus version | `v2.50.1` |
| `monitoring.grafana.enabled` | Enable Grafana | `true` |
| `monitoring.grafana.version` | Grafana version | `10.3.3` |
| `monitoring.nodeExporter.enabled` | Enable Node Exporter | `true` |
| `monitoring.nodeExporter.version` | Node Exporter version | `v1.7.0` |
| `monitoring.jaeger.enabled` | Enable Jaeger | `true` |
| `monitoring.jaeger.version` | Jaeger version | `1.55.0` |

## Notes

- Ensure that you have the necessary validator keys and secrets before deploying this chart.
- Resource limits and requests can be adjusted based on your cluster's capacity and performance requirements.

