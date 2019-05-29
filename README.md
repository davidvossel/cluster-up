# Getting Started with OKD Provider

Download cluster-up repo
```
git clone https://github.com/davidvossel/cluster-up.git
cd cluster-up
```

Start okd cluster
```
export KUBEVIRT_PROVIDER=okd-4.1.0
make cluster-up
```

Stop okd cluster
```
make cluster-down
```

## Exploring OKD Cluster

Use provider's OC client with oc.sh wrapper script
```
tools/oc.sh get nodes
tools/oc.sh get pods --all-namespaces
```

Use your own OC client by defining the KUBECONFIG environment variable 
```
export KUBECONFIG=$(tools/kubeconfig.sh)

oc get nodes
oc apply -f <some file>
```

SSH into master
```
tools/ssh.sh master-0
```

SSH into worker
```
tools/ssh.sh worker-0
```

Accessing OKD UI
```
TODO - in the process of working out the details here. 
```
