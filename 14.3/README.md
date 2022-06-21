## Домашнее задание к занятию "14.3 Карты конфигураций"
Задача 1: Работа с картами конфигураций через утилиту kubectl в установленном minikube
Выполните приведённые команды в консоли. Получите вывод команд. Сохраните задачу 1 как справочный материал.

### Как создать карту конфигураций?

#### kubectl create configmap nginx-config --from-file=nginx.conf

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl create configmap nginx-config --from-file=nginx.conf
    configmap/nginx-config created

#### kubectl create configmap domain --from-literal=name=netology.ru

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl create configmap domain --from-literal=name=netology.ru
    configmap/domain created
    

### Как просмотреть список карт конфигураций?
#### kubectl get configmaps

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmaps
    NAME               DATA   AGE
    domain             1      60s
    kube-root-ca.crt   1      45d
    nginx-config       1      74s


#### kubectl get configmap

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap
    NAME               DATA   AGE
    domain             1      115s
    kube-root-ca.crt   1      45d
    nginx-config       1      2m9s


### Как просмотреть карту конфигурации?
#### kubectl get configmap nginx-config

    padmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap nginx-config
    NAME           DATA   AGE
    nginx-config   1      5m

#### kubectl describe configmap domain

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl describe configmap domain
    Name:         domain
    Namespace:    default
    Labels:       <none>
    Annotations:  <none>

    Data
    ====
    name:
    ----
    netology.ru

    BinaryData
    ====

    Events:  <none>

### Как получить информацию в формате YAML и/или JSON?
#### kubectl get configmap nginx-config -o yaml
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap nginx-config -o yaml
    apiVersion: v1
    data:
    nginx.conf: "server {\r\n    listen 80;\r\n    server_name  netology.ru www.netology.ru;\r\n
        \   access_log  /var/log/nginx/domains/netology.ru-access.log  main;\r\n    error_log
        \  /var/log/nginx/domains/netology.ru-error.log info;\r\n    location / {\r\n
        \       include proxy_params;\r\n        proxy_pass http://10.10.10.10:8080/;\r\n
        \   }\r\n}\r\n"
    kind: ConfigMap
    metadata:
    creationTimestamp: "2022-05-23T06:08:51Z"
    name: nginx-config
    namespace: default
    resourceVersion: "137091"
    uid: b358a95a-3598-431e-a3f5-351bec703524
    
#### kubectl get configmap domain -o json
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap domain -o json
    {
        "apiVersion": "v1",
        "data": {
            "name": "netology.ru"
        },
        "kind": "ConfigMap",
        "metadata": {
            "creationTimestamp": "2022-05-23T06:09:05Z",
            "name": "domain",
            "namespace": "default",
            "resourceVersion": "137112",
            "uid": "2ab865fd-1c08-49ac-94f9-604db2775734"
        }
    }


### Как выгрузить карту конфигурации и сохранить его в файл?
#### kubectl get configmaps -o json > configmaps.json

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmaps -o json > configmaps.json
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ ll
    total 14
    drwxrwxrwx 1 spadmin root 4096 May 23 13:17 ./
    drwxrwxrwx 1 spadmin root 4096 May 16 10:08 ../
    -rwxrwxrwx 1 spadmin root 3238 May 23 13:17 configmaps.json*
    -rwxrwxrwx 1 spadmin root  387 May 16 10:08 generator.py*
    -rwxrwxrwx 1 spadmin root  604 May 16 10:08 myapp-pod.yml*
    -rwxrwxrwx 1 spadmin root  316 May 16 10:08 nginx.conf*
    drwxrwxrwx 1 spadmin root    0 May 16 10:08 templates/
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ cat configmaps.json 
    {
        "apiVersion": "v1",
        "items": [
            {
                "apiVersion": "v1",
                "data": {
                    "name": "netology.ru"
                },
                "kind": "ConfigMap",
                "metadata": {
                    "creationTimestamp": "2022-05-23T06:09:05Z",
                    "name": "domain",
                    "namespace": "default",
                    "resourceVersion": "137112",
                    "uid": "2ab865fd-1c08-49ac-94f9-604db2775734"
                }
            },
            {
                "apiVersion": "v1",
                "data": {
                    "ca.crt": "-----BEGIN CERTIFICATE-----\nMIIC/jCCAeagAwIBAgIBADANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDEwprdWJl\ncm5ldGVzMB4XDTIyMDQwODA1MDgyNloXDTMyMDQwNTA1MDgyNlowFTETMBEGA1UE\nAxMKa3ViZXJuZXRlczCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANN2\nBi3UcS3/8A34vUx6wpnVJkXDB85T3nbc/jy9ImS2pt6m/JyemV35+Uoqg/rLx+3H\nJ/SwRmcLNdCiS9bFJFLg1nKZ5cntorrz95mqeKcJEhvzJReUBQJLeora+k+RETw4\nDet2NtpJWus7FvZjgpiDqTKOwo/5PCR1PDeuFugrud+okLnA7r7Vdarqvk1eV7q7\nX/Km4cOcXc0tTCqo8bx0yqwH4OZvxe9zuH+aXud45k70/rDja4dxvc/zc8Ilx7Fw\nFyeuthjvH1DDnIR+kUN9dxmTCe2IbdsEuxEayBdQhh021egUhVwYr4XbFRpJZd8b\neZUnI/G63JbpadYFMMECAwEAAaNZMFcwDgYDVR0PAQH/BAQDAgKkMA8GA1UdEwEB\n/wQFMAMBAf8wHQYDVR0OBBYEFIOQ51aelMxmXtfWGrc6Jza0819vMBUGA1UdEQQO\nMAyCCmt1YmVybmV0ZXMwDQYJKoZIhvcNAQELBQADggEBAIXQ74oIYqLJZrUBIE98\na/mCw70KyetmDLilHXT3ChD/acmvoe8Is1nS7ZM1tcBw66KNpKDcPecZCgGFv5CI\nt72unI1XLj2jpmr8JqCd7Y+FbGhsF9tPw/gaTM67ZBUytrJFBBt/7XwXnAhY09pm\nlqGkHyqNxCF/haNciGrsq6CAbBVTX78dqClM37qCqRnhkOcGCXbvu8ajmMTOpsfe\nXnPyKK8OZe2r8gRYqqRCbCQXoCJ4Dp87JoIsHDTdWxJaprVADMlrnl6sn5qZvuzm\nB7gUCHDy4c4FQZY2L6HhBp4TtNk8jKYfA8btdO0w/+SopHjhf78y571Vp7GUMzui\nbP4=\n-----END CERTIFICATE-----\n"
                },
                "kind": "ConfigMap",
                "metadata": {
                    "annotations": {
                        "kubernetes.io/description": "Contains a CA bundle that can be used to verify the kube-apiserver when using internal endpoints such as the internal service IP or kubernetes.default.svc. No other usage is guaranteed across distributions of Kubernetes clusters."
                    },
                    "creationTimestamp": "2022-04-08T05:09:00Z",
                    "name": "kube-root-ca.crt",
                    "namespace": "default",
                    "resourceVersion": "404",
                    "uid": "4ac33afa-b9b2-4c24-a67e-7e5367522d27"
                }
            },
            {
                "apiVersion": "v1",
                "data": {
                    "nginx.conf": "server {\r\n    listen 80;\r\n    server_name  netology.ru www.netology.ru;\r\n    access_log  /var/log/nginx/domains/netology.ru-access.log  main;\r\n    error_log   /var/log/nginx/domains/netology.ru-error.log info;\r\n    location / {\r\n        include proxy_params;\r\n        proxy_pass http://10.10.10.10:8080/;\r\n    }\r\n}\r\n"
                },
                "kind": "ConfigMap",
                "metadata": {
                    "creationTimestamp": "2022-05-23T06:08:51Z",
                    "name": "nginx-config",
                    "namespace": "default",
                    "resourceVersion": "137091",
                    "uid": "b358a95a-3598-431e-a3f5-351bec703524"
                }
            }
        ],
        "kind": "List",
        "metadata": {
            "resourceVersion": ""
        }
    }

    
#### kubectl get configmap nginx-config -o yaml > nginx-config.yml

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap nginx-config -o yaml > nginx-config.yml
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ ll
    total 15
    drwxrwxrwx 1 spadmin root 4096 May 23 13:18 ./
    drwxrwxrwx 1 spadmin root 4096 May 16 10:08 ../
    -rwxrwxrwx 1 spadmin root 3238 May 23 13:17 configmaps.json*
    -rwxrwxrwx 1 spadmin root  387 May 16 10:08 generator.py*
    -rwxrwxrwx 1 spadmin root  604 May 16 10:08 myapp-pod.yml*
    -rwxrwxrwx 1 spadmin root  578 May 23 13:18 nginx-config.yml*
    -rwxrwxrwx 1 spadmin root  316 May 16 10:08 nginx.conf*
    drwxrwxrwx 1 spadmin root    0 May 16 10:08 templates/
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ cat nginx-config.yml 
    apiVersion: v1
    data:
    nginx.conf: "server {\r\n    listen 80;\r\n    server_name  netology.ru www.netology.ru;\r\n
        \   access_log  /var/log/nginx/domains/netology.ru-access.log  main;\r\n    error_log
        \  /var/log/nginx/domains/netology.ru-error.log info;\r\n    location / {\r\n
        \       include proxy_params;\r\n        proxy_pass http://10.10.10.10:8080/;\r\n
        \   }\r\n}\r\n"
    kind: ConfigMap
    metadata:
    creationTimestamp: "2022-05-23T06:08:51Z"
    name: nginx-config
    namespace: default
    resourceVersion: "137091"
    uid: b358a95a-3598-431e-a3f5-351bec703524

### Как удалить карту конфигурации?
#### kubectl delete configmap nginx-config

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl delete configmap nginx-config
    configmap "nginx-config" deleted
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap nginx-config
    Error from server (NotFound): configmaps "nginx-config" not found

### Как загрузить карту конфигурации из файла?
#### kubectl apply -f nginx-config.yml

    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl apply -f nginx-config.yml
    configmap/nginx-config created
    spadmin@ubuntu:~/gitwork/clokub-homeworks/14.3$ kubectl get configmap nginx-config
    NAME           DATA   AGE
    nginx-config   1      4s
