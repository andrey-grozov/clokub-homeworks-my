## Домашнее задание к занятию "14.1 Создание и использование секретов"

### Задача 1: Работа с секретами через утилиту kubectl в установленном minikube

Выполните приведённые ниже команды в консоли, получите вывод команд. Сохраните задачу 1 как справочный материал.

#### Как создать секрет?
openssl genrsa -out ./certs/cert.key 4096

    yc-user@cp1:~$ openssl genrsa -out ./certs/cert.key 4096
    Generating RSA private key, 4096 bit long modulus (2 primes)
    ...................................................++++
    ................................................................................................................................++++
    e is 65537 (0x010001)

openssl req -x509 -new -key ./certs/cert.key -days 3650 -out ./certs/cert.crt \
-subj '/C=RU/ST=Moscow/L=Moscow/CN=server.local'

    yc-user@cp1:~/certs$ ls -la
    total 16
    drwxrwxr-x 2 yc-user yc-user 4096 May 16 03:42 .
    drwxr-xr-x 9 yc-user yc-user 4096 May 16 03:43 ..
    -rw-rw-r-- 1 yc-user yc-user 1944 May 16 03:42 cert.crt
    -rw------- 1 yc-user yc-user 3247 May 16 03:41 cert.key

kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key

    yc-user@cp1:~$ sudo kubectl create secret tls domain-cert --cert=certs/cert.crt --key=certs/cert.key
    secret/domain-cert created

#### Как просмотреть список секретов?

kubectl get secrets

    root@cp1:/home/yc-user/certs# kubectl get secrets
    NAME                                            TYPE                                  DATA   AGE
    default-token-dplr7                             kubernetes.io/service-account-token   3      37d
    domain-cert                                     kubernetes.io/tls                     2      2m
    nfs-server-nfs-server-provisioner-token-nfzpc   kubernetes.io/service-account-token   3      34d
    sh.helm.release.v1.nfs-server.v1                helm.sh/release.v1                    1      34d

kubectl get secret

    root@cp1:/home/yc-user/certs# kubectl get secret
    NAME                                            TYPE                                  DATA   AGE
    default-token-dplr7                             kubernetes.io/service-account-token   3      37d
    domain-cert                                     kubernetes.io/tls                     2      2m30s
    nfs-server-nfs-server-provisioner-token-nfzpc   kubernetes.io/service-account-token   3      34d
    sh.helm.release.v1.nfs-server.v1                helm.sh/release.v1                    1      34d

#### Как просмотреть секрет?
kubectl get secret domain-cert

    root@cp1:/home/yc-user/certs# kubectl get secret domain-cert
    NAME          TYPE                DATA   AGE
    domain-cert   kubernetes.io/tls   2      2m44s

kubectl describe secret domain-cert

    root@cp1:/home/yc-user/certs# kubectl describe secret domain-cert
    Name:         domain-cert
    Namespace:    default
    Labels:       <none>
    Annotations:  <none>

    Type:  kubernetes.io/tls

    Data
    ====
    tls.key:  3247 bytes
    tls.crt:  1944 bytes

#### Как получить информацию в формате YAML и/или JSON?
kubectl get secret domain-cert -o yaml

    root@cp1:/home/yc-user/certs# kubectl get secret domain-cert -o yaml
    apiVersion: v1
    data:
    tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVSmozREQvT3M5TTAybXBDczl6emZDdGhvRUVFd0RRWUpLb1pJaHZjTkFRRUwKQlFBd1JqRUxNQWtHQTFVRUJoTUNVbFV4RHpBTkJnTlZCQWdNQm
    .......
    h4dStVR1k1QnJZR3EzbkRJZnRGZW5ZNzl2RDVjVnY4NXUwam1hWHdBR2dRdy9OcGtLU0Vwd3B5ZitlbWxCYwpLN2FydFNWY0VBSW9HRWdjSXBVY1E1dWNsTGJTSDM4L1k2NVdiL1MwMTRQNDlXeWo5blo4dzFFME8rS2phUT09Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg==
    kind: Secret
    metadata:
    creationTimestamp: "2022-05-16T04:26:10Z"
    name: domain-cert
    namespace: default
    resourceVersion: "101300"
    uid: 84079ffb-9d5c-44e0-9b16-65d95c6bf48f
    type: kubernetes.io/tls

kubectl get secret domain-cert -o json

    root@cp1:/home/yc-user/certs# kubectl get secret domain-cert -o json
    {
        "apiVersion": "v1",
        "data": {
            "tls.crt": "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUZiVENDQTFXZ0F3SUJBZ0lVSmozREQvT3M5TTAybXBDczl6emZDdGhvRUVFd0RRWUp
            .......
            rWHZLU2kwTW1DKzZ5dHAyanpOQ2t5WEFLckxIdk9lZlkwWi9mOEI1RWdEclBsZkR5ZwowUT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K",
            "tls.key": "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlKS2dJQkFBS0NBZ0VBeUpaR0VxN05GdFdRNy94Q1hyQVkrVGsveUdRYTg0STZ.......WY0VBSW9HRWdjSXBVY1E1dWNsTGJTSDM4L1k2NVdiL1MwMTRQNDlXeWo5blo4dzFFME8rS2phUT09Ci0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0tCg=="
        },
        "kind": "Secret",
        "metadata": {
            "creationTimestamp": "2022-05-16T04:26:10Z",
            "name": "domain-cert",
            "namespace": "default",
            "resourceVersion": "101300",
            "uid": "84079ffb-9d5c-44e0-9b16-65d95c6bf48f"
        },
        "type": "kubernetes.io/tls"
    }

#### Как выгрузить секрет и сохранить его в файл?
kubectl get secrets -o json > secrets.json

kubectl get secret domain-cert -o yaml > domain-cert.yml


        root@cp1:/home/yc-user/certs# ls -lah
        total 60K
        drwxrwxr-x 2 yc-user yc-user 4.0K May 16 04:36 .
        drwxr-xr-x 9 yc-user yc-user 4.0K May 16 03:43 ..
        -rw-rw-r-- 1 yc-user yc-user 1.9K May 16 03:42 cert.crt
        -rw------- 1 yc-user yc-user 3.2K May 16 03:41 cert.key
        -rw-r--r-- 1 root    root    7.1K May 16 04:36 domain-cert.yml
        -rw-r--r-- 1 root    root     36K May 16 04:35 secrets.json


#### Как удалить секрет?
kubectl delete secret domain-cert

        root@cp1:/home/yc-user/certs# kubectl delete secret domain-cert
        secret "domain-cert" deleted

        root@cp1:/home/yc-user/certs# kubectl get secret domain-cert
        Error from server (NotFound): secrets "domain-cert" not found

#### Как загрузить секрет из файла?
kubectl apply -f domain-cert.yml

    root@cp1:/home/yc-user/certs# kubectl apply -f domain-cert.yml
    secret/domain-cert created

    root@cp1:/home/yc-user/certs# kubectl get secret domain-cert
    NAME          TYPE                DATA   AGE
    domain-cert   kubernetes.io/tls   2      18s