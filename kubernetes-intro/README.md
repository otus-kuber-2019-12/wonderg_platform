# Задание 2.1

Разберитесь почему все pod в namespace kube-system восстановились после удаления. Укажите причину в описании PR Hint: core-dns и, например, kube-apiserver, имеют различия в механизме запуска и восстанавливаются по разным причинам

# Ответ

- core-dns описан в диплойменте, который можно увидеть ч/з
  kubectl describe deployments coredns

```
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
```

kube-controller-manager -> Deployment controller контролирует жизненный цикл диплоймента, следит за тем, чтобы декларативное описание диплоймента соответствовало том, что сейчас задиплоено в k8s.

- kube-apiserver и другие системные описаны как [static pods](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/). Их запуск контролирует kubelet, описание тут - > [Observe static pod behavior](https://kubernetes.io/docs/tasks/configure-pod-container/static-pod/#behavior-of-static-pods)

```
minikube ssh
ps aux | grep pod-manifest
root      2456  3.4  4.6 1337324 91728 ?       Ssl  12:12   0:39 /var/lib/minikube/binaries/v1.17.0/kubelet --authorization-mode=Webhook --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --cgroup-driver=cgroupfs --client-ca-file=/var/lib/minikube/certs/ca.crt --cluster-dns=10.96.0.10 --cluster-domain=cluster.local --config=/var/lib/kubelet/config.yaml --container-runtime=docker --fail-swap-on=false --hostname-override=minikube --kubeconfig=/etc/kubernetes/kubelet.conf --node-ip=192.168.64.2 --pod-manifest-path=/etc/kubernetes/manifests
```

--pod-manifest-path=/etc/kubernetes/manifests - путь где лежат манифесты статик подов

```
$ ls -lht /etc/kubernetes/manifests/
total 20K
-rw------- 1 root root 1.8K Dec 15 12:12 etcd.yaml
-rw------- 1 root root 1.1K Dec 15 12:12 kube-scheduler.yaml
-rw------- 1 root root 2.5K Dec 15 12:12 kube-controller-manager.yaml
-rw------- 1 root root 2.9K Dec 15 12:12 kube-apiserver.yaml
-rw-r----- 1 root root 1.5K Jan  1  0001 addon-manager.yaml.tmpl
```

# Задание 2.2

- в Dockerfile описан nginx запускающийся на порту 8000 от UID 1001. Запущен с autoindex on для /app/\* директории
- image отправлен в [negleb/otus-k8s](https://hub.docker.com/repository/docker/negleb/otus-k8s)
- описал запуск pod'a с контейнером в web-pod.yaml, где также описан initContainers для выгрузки index.html страницы в /app/

# Задание 2.3

frontend валится с ошибкой

```
kubectl get pods
NAME       READY   STATUS    RESTARTS   AGE
frontend   0/1     Error     0          11s
web        1/1     Running   1          21m
```

смотрим логи
kubectl -n default logs -f frontend
и находим, что не выставлена необходимая переменная

```
panic: environment variable "PRODUCT_CATALOG_SERVICE_ADDR" not set

goroutine 1 [running]:
main.mustMapEnv(0xc0000340b0, 0xb03c4a, 0x1c)
	/go/src/github.com/GoogleCloudPlatform/microservices-demo/src/frontend/main.go:248 +0x10e
main.main()
	/go/src/github.com/GoogleCloudPlatform/microservices-demo/src/frontend/main.go:106 +0x3e9
```

Помог поиск по репозиторию, где значение этой и других переменных можно найти в манифесте от гугла [frontend.yaml](https://github.com/GoogleCloudPlatform/microservices-demo/blob/master/kubernetes-manifests/frontend.yaml)

Добавляем значения переменных и создаем новый под

