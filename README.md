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

Using oc tool
```
./oc.sh get nodes
```

Accessing OKD UI
```
#Add the following entry to etc/hosts
sudo echo "127.0.0.1 console-openshift-console.apps.test-1.tt.testing" >> /etc/hosts
sudo echo "127.0.0.1 oauth-openshift.apps.test-1.tt.testing" >> /etc/hosts
sudo -E ./kubectl.sh port-forward -n openshift-console svc/console 443:443 
```

SSH into master
```
./ssh master-0
```

SSH into worker
```
./ssh worker-0
```
