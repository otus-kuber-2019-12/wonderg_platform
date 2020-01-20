# Выполнено ДЗ №3

- [x] Основное ДЗ
- [x] Задание со \*

## В процессе сделано:

- настроил kind
- описал и применил ReplicaSet
- Руководствуясь материалами лекции опишите произошедшую ситуацию, почему обновление ReplicaSet не повлекло обновление запущенных pod?

ReplicaSet controller не рестартует поды и только следит за тем, чтобы объявленное количество подов было запущено в каждый момент времени. [How a ReplicationController Works](https://kubernetes.io/docs/concepts/workloads/controllers/replicationcontroller/#how-a-replicationcontroller-works)

- описал Deployment. Произвел обновление и роллбек версии приложения, используя Deployment
- протестировал возможность использования параметров maxSurge и maxUnavailable для Blue/Green & Reverse Rolling Update
- проверил работу readinessProbe & livenessProbe
- установил node-exporter на master & worker nodes используя DaemonSet

## Как запустить проект:

- kubectl apply -f \*.yaml //sequentially

## Как проверить работоспособность:

- kubectl port-forward node-exporter-\$sha 9100:9100

## PR checklist:

- [*] Выставлен label с номером домашнего задания
