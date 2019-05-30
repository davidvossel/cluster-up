# Getting Started with a multi-node Kubernetes Provider

Download cluster-up repo
```
git clone https://github.com/davidvossel/cluster-up.git
cd cluster-up
```

Start multi node k8s cluster
```
export KUBEVIRT_PROVIDER=k8s-1.13.3 KUBEVIRT_NUM_NODES=2
make cluster-up
```

Stop k8s cluster
```
make cluster-down
```

Use provider's kubectl client with kubectl.sh wrapper script
```
cluster/kubectl.sh get nodes
cluster/kubectl.sh get pods --all-namespaces
```

Use your own kubectl client by defining the KUBECONFIG environment variable 
```
export KUBECONFIG=$(cluster/kubeconfig.sh)

kubectl get nodes
kubect apply -f <some file>
```

SSH into a node
```
cluster/ssh.sh node01
```

# Getting Started with multi-node OKD Provider

Download cluster-up repo
```
git clone https://github.com/davidvossel/cluster-up.git
cd cluster-up
```

Start okd cluster (pre-configured with a master and worker node)
```
export KUBEVIRT_PROVIDER=okd-4.1.0
make cluster-up
```

Stop okd cluster
```
make cluster-down
```

Use provider's OC client with oc.sh wrapper script
```
cluster/oc.sh get nodes
cluster/oc.sh get pods --all-namespaces
```

Use your own OC client by defining the KUBECONFIG environment variable 
```
export KUBECONFIG=$(cluster/kubeconfig.sh)

oc get nodes
oc apply -f <some file>
```

SSH into master
```
cluster/ssh.sh master-0
```

SSH into worker
```
cluster/ssh.sh worker-0
```

Accessing OKD UI
```
TODO - in the process of working out the details here. 
```
