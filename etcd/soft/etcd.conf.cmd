[program:etcd-0]
command=/opt/etcd/etcd-v3.3.12/etcd -name etcd-0 -data-dir /data/etcd/etcd-0/data -listen-client-urls http://etcd:2379 -advertise-client-urls http://etcd:2379 -listen-peer-urls http://etcd:2380 -initial-advertise-peer-urls http://etcd:2380 -initial-cluster etcd-0=http://etcd:2380,etcd-1=http://etcd:2381,etcd-2=http://etcd:2382 -initial-cluster-token etcd-cluster-token -initial-cluster-state new
directory=/opt/etcd/etcd-v3.3.12
priority=700
user=work

[program:etcd-1]
command=/opt/etcd/etcd-v3.3.12/etcd -name etcd-1 -data-dir /data/etcd/etcd-1/data -listen-client-urls http://etcd:2389 -advertise-client-urls http://etcd:2389 -listen-peer-urls http://etcd:2381 -initial-advertise-peer-urls http://etcd:2381 -initial-cluster etcd-0=http://etcd:2380,etcd-1=http://etcd:2381,etcd-2=http://etcd:2382 -initial-cluster-token etcd-cluster-token -initial-cluster-state new
directory=/opt/etcd/etcd-v3.3.12
priority=700
user=work

[program:etcd-2]
command=/opt/etcd/etcd-v3.3.12/etcd -name etcd-2 -data-dir /data/etcd/etcd-2/data -listen-client-urls http://etcd:2399 -advertise-client-urls http://etcd:2399 -listen-peer-urls http://etcd:2382 -initial-advertise-peer-urls http://etcd:2382 -initial-cluster etcd-0=http://etcd:2380,etcd-1=http://etcd:2381,etcd-2=http://etcd:2382 -initial-cluster-token etcd-cluster-token -initial-cluster-state new
directory=/opt/etcd/etcd-v3.3.12
priority=700
user=work
