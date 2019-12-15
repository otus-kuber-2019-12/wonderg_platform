# Задание 2

Разберитесь почему все pod в namespace kube-system восстановились после удаления. Укажите причину в описании PR Hint: core-dns и, например, kube-apiserver, имеют различия в механизме запуска и восстанавливаются по разным причинам

core-dns описан в диплойменте, который можно увидеть ч/з
kubectl describe deployments coredns

```
Replicas:               2 desired | 2 updated | 2 total | 2 available | 0 unavailable
```

В свою очередь kube-controller-manager -> Deployment controller контролирует жизненный цикл диплоймента, следит за тем, чтобы декларативное описание диплоймента соответствовало том, что сейчас задиплоено в k8s.

kubectl delete pod --all -n kube-system
