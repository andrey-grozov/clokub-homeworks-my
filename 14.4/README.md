## Домашнее задание к занятию "14.4 Сервис-аккаунты"
### Задача 1: Работа с сервис-аккаунтами через утилиту kubectl в установленном minikube
Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.

#### Как создать сервис-аккаунт?
kubectl create serviceaccount netology

    spadmin@ubuntu:~$ kubectl create serviceaccount netology
    serviceaccount/netology created

#### Как просмотреть список сервис-акаунтов?
kubectl get serviceaccounts

    spadmin@ubuntu:~$ kubectl get serviceaccounts
    NAME                                SECRETS   AGE
    default                             1         46d
    netology                            1         35s
    nfs-server-nfs-server-provisioner   1         42d
kubectl get serviceaccount

    spadmin@ubuntu:~$ kubectl get serviceaccount 
    NAME                                SECRETS   AGE
    default                             1         46d
    netology                            1         71s
    nfs-server-nfs-server-provisioner   1         42d

#### Как получить информацию в формате YAML и/или JSON?
kubectl get serviceaccount netology -o yaml

    spadmin@ubuntu:~$ kubectl get serviceaccount netology -o yaml
    apiVersion: v1
    kind: ServiceAccount
    metadata:
    creationTimestamp: "2022-05-25T02:26:54Z"
    name: netology
    namespace: default
    resourceVersion: "151631"
    uid: dad16c3f-2689-4595-b718-3d693db21955
    secrets:
    - name: netology-token-zd7qf

kubectl get serviceaccount default -o json

    spadmin@ubuntu:~$ kubectl get serviceaccount default -o json
    {
        "apiVersion": "v1",
        "kind": "ServiceAccount",
        "metadata": {
            "creationTimestamp": "2022-04-08T05:09:00Z",
            "name": "default",
            "namespace": "default",
            "resourceVersion": "398",
            "uid": "42017ad3-a7a4-46a1-9aa5-308aac7aa60f"
        },
        "secrets": [
            {
                "name": "default-token-dplr7"
            }
        ]
    }

#### Как выгрузить сервис-акаунты и сохранить его в файл?
kubectl get serviceaccounts -o json > serviceaccounts.json

    spadmin@ubuntu:~$ kubectl get serviceaccounts -o json > serviceaccounts.json
    spadmin@ubuntu:~$ ls -lah *.json
    -rw-rw-r-- 1 spadmin spadmin 2.2K May 25 09:30 serviceaccounts.json

kubectl get serviceaccount netology -o yaml > netology.yml

    spadmin@ubuntu:~$ kubectl get serviceaccount netology -o yaml > netology.yml
    spadmin@ubuntu:~$ ls -lah *.yml 
    -rw-rw-r-- 1 spadmin spadmin 238 May 25 09:31 netology.yml

#### Как удалить сервис-акаунт?
kubectl delete serviceaccount netology

    spadmin@ubuntu:~$ kubectl delete serviceaccount netology
    serviceaccount "netology" deleted

#### Как загрузить сервис-акаунт из файла?
kubectl apply -f netology.yml

    spadmin@ubuntu:~$ kubectl apply -f netology.yml
    serviceaccount/netology created
    spadmin@ubuntu:~$ kubectl get serviceaccount netology
    NAME       SECRETS   AGE
    netology   2         26s
