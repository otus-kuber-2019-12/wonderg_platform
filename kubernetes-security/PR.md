# Выполнено ДЗ №3

- [x] Основное ДЗ

## В процессе сделано:

- все три задания

## Как запустить проект:

- kubectl apply -f 0\{d}.\*.yaml //sequentially

## Как проверить работоспособность:

```
kubectl apply -f test-pod.yaml
```

В каждой директории с заданием есть test-pod.yaml, который нужно диплоить в проверяемый namespace и тогда можно легко проверять права ч/з `<kubectl exec -it curl-ken -c main curl localhost:8001/api/v1/namespaces/dev/pods>`

## PR checklist:

- [*] Выставлен label с номером домашнего задания
