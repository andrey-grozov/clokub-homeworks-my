## Домашнее задание к занятию "14.2 Синхронизация секретов с внешними сервисами. Vault"

### Задача 1: Работа с модулем Vault

#### Запустить модуль Vault конфигураций через утилиту kubectl в установленном minikube

kubectl apply -f 14.2/vault-pod.yml

    root@cp1:/home/yc-user/14.2# kubectl apply -f vault-prod.yml
    pod/14.2-netology-vault created


Получить значение внутреннего IP пода

kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
Примечание: jq - утилита для работы с JSON в командной строке

    root@cp1:/home/yc-user/14.2# kubectl get pod 14.2-netology-vault -o json | jq -c '.status.podIPs'
    [{"ip":"10.233.90.21"}]

Запустить второй модуль для использования в качестве клиента

kubectl run -i --tty fedora --image=fedora --restart=Never -- sh

Установить дополнительные пакеты

dnf -y install pip

pip install hvac

Запустить интепретатор Python и выполнить следующий код, предварительно поменяв IP и токен

    import hvac
    client = hvac.Client(
        url='http://10.10.133.71:8200',
        token='aiphohTaa0eeHei'
    )
    client.is_authenticated()

    # Пишем секрет
    client.secrets.kv.v2.create_or_update_secret(
        path='hvac',
        secret=dict(netology='Big secret!!!'),
    )

    # Читаем секрет
    client.secrets.kv.v2.read_secret_version(
        path='hvac',
    )

#### Результат

    sh-5.1# python3
    Python 3.10.4 (main, Mar 25 2022, 00:00:00) [GCC 12.0.1 20220308 (Red Hat 12.0.1-0)] on linux
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import hvac
    >>> client = hvac.Client(
    ...     url='http://10.233.90.21:8200',
    ...     token='aiphohTaa0eeHei'
    ... )
    >>> client.is_authenticated()
    True
    >>> 
    >>> # Пишем секрет
    >>> client.secrets.kv.v2.create_or_update_secret(
    ...     path='hvac',
    ...     secret=dict(netology='Big secret!!!'),
    ... )
    {'request_id': 'a2035c4a-2df7-c617-19db-b72486ed3a26', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'created_time': '2022-05-23T02:50:22.790046399Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}, 'wrap_info': None, 'warnings': None, 'auth': None}
    >>> 
    >>> # Читаем секрет
    >>> client.secrets.kv.v2.read_secret_version(
    ...     path='hvac',
    ... )
    {'request_id': 'dfbeb96f-503b-3d5e-c101-fc404f9945e6', 'lease_id': '', 'renewable': False, 'lease_duration': 0, 'data': {'data': {'netology': 'Big secret!!!'}, 'metadata': {'created_time': '2022-05-23T02:50:22.790046399Z', 'custom_metadata': None, 'deletion_time': '', 'destroyed': False, 'version': 1}}, 'wrap_info': None, 'warnings': None, 'auth': None}
    >>> 
