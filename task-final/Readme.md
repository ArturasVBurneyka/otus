Kubernetes cluster information:
| VM's Name | Internal IPv4 | Role |
| --- | --- | --- |
| kubernetes-master-1st | 10.128.0.21 | Master |
| kubernetes-master-2nd | 10.128.0.13 | Master |
| kubernetes-master-3rd | 10.128.0.6 | Master |
| kubernetes-worker-1st | 10.128.0.36 | Worker |
| kubernetes-worker-2nd | 10.128.0.33 | Worker |
| kubernetes-worker-3rd | 10.128.0.9 | Worker |

Install k3s and init cluster on 1st master:
```shell
sudo curl -sfL https://get.k3s.io | sh -s - server \
--token "c5c77161-d5a6-4c77-87bd-2a5ca9e2706e" \
--write-kubeconfig-mode 644 \
--cluster-init
```

Detail information in case of successfull installation:
```shell
[INFO]  Finding release for channel stable
[INFO]  Using v1.29.4+k3s1 as release
[INFO]  Downloading hash https://github.com/k3s-io/k3s/releases/download/v1.29.4+k3s1/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/k3s-io/k3s/releases/download/v1.29.4+k3s1/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Skipping installation of SELinux RPM
[INFO]  Creating /usr/local/bin/kubectl symlink to k3s
[INFO]  Creating /usr/local/bin/crictl symlink to k3s
[INFO]  Creating /usr/local/bin/ctr symlink to k3s
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s
```

Install k3s and join 2nd and 3rd masters to 1st master:
```shell
sudo curl -sfL https://get.k3s.io | sh -s server \
--server https://10.128.0.21:6443 \
--token "c5c77161-d5a6-4c77-87bd-2a5ca9e2706e" \
--write-kubeconfig-mode 644
```

File with secret token to join worker nodes:
```shell
/var/lib/rancher/k3s/server/token
```

Example of secret token:
```shell
K104546e6a4b56a4230014b313d7da5e46f652efd0e1e00cc3637d1c08846192a59::server:c5c77161-d5a6-4c77-87bd-2a5ca9e2706e
```

Install k3s agent and join it to 1st master:
```shell
sudo curl -sfL https://get.k3s.io | sh -s - agent \
--server https://10.128.0.21:6443 \
--token "K104546e6a4b56a4230014b313d7da5e46f652efd0e1e00cc3637d1c08846192a59::server:c5c77161-d5a6-4c77-87bd-2a5ca9e2706e"
```

Tag image with Mera.OpcUa.Service:
```shell
sudo docker tag \
mera.opcua.client:latest \
arturasvburneyka/opcua-service:latest
```

Sign in to Docker Hub:
```shell
sudo docker login \
--username arturasvburneyka \
--password <...> \
docker.io
```

Push image with Mera.OpcUa.Service to Docker Hub:
```shell
sudo docker push arturasvburneyka/opcua-service:latest
```

Sign out from Docker Hub:
```shell
sudo docker logout
```
