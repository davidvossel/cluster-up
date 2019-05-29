# cluster-up
Local on demand multi-node k8s, ocp, okd clusters using pre-built immutable qemu images.




# Getting Started OKD

Download repo
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

Using oc tool
```
./oc.sh get nodes
```

SSH into master
```
./ssh master-0
```

SSH into worker
```
./ssh worker-0
```

Accessing OKD UI
```
TODO - in the process of working out the details here. 
```
