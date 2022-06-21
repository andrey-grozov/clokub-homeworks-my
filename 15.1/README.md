## Домашнее задание к занятию "15.1. Организация сети"

### Задание 1. Яндекс.Облако (обязательное к выполнению)
Создать VPC.
Создать пустую VPC. Выбрать зону.
Публичная подсеть.
Создать в vpc subnet с названием public, сетью 192.168.10.0/24.
Создать в этой подсети NAT-инстанс, присвоив ему адрес 192.168.10.254. В качестве image_id использовать fd80mrhj8fl2oe87o4e1
Создать в этой публичной подсети виртуалку с публичным IP и подключиться к ней, убедиться что есть доступ к интернету.
Приватная подсеть.
Создать в vpc subnet с названием private, сетью 192.168.20.0/24.
Создать route table. Добавить статический маршрут, направляющий весь исходящий трафик private сети в NAT-инстанс
Создать в этой приватной подсети виртуалку с внутренним IP, подключиться к ней через виртуалку, созданную ранее и убедиться что есть доступ к интернету

[Файлы терраформа](./yctf/)

#### Разворачиваем инфраструктуру

    ...
    Apply complete! Resources: 7 added, 0 changed, 0 destroyed.

    Outputs:

    public_nat_ip = "51.250.83.24"
    test_private_ip = "192.168.20.19"
    test_public_ip = "51.250.84.43"


Проверяем доступ на public хост

    spadmin@ubuntu:~/gitwork/clokub-homeworks-my/15.1/yctf$ ssh ubuntu@51.250.84.43
    Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-120-generic x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage
    Last login: Tue Jun 21 04:16:03 2022 from 212.17.24.111
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

    ubuntu@test-public:~$ curl 2ip.ru
    51.250.84.43


Заходим на виртуалку в приватной подсети, убеждаемся что есть выход в интернет, проверяем внешний IP

    ubuntu@test-public:~$ ssh 192.168.20.19
    Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-120-generic x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage
    Last login: Tue Jun 21 04:20:22 2022 from 192.168.10.19
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

    ubuntu@test-private:~$ curl 2ip.ru
    51.250.83.24

Подключаемся к нату

    spadmin@ubuntu:~/gitwork/clokub-homeworks-my/15.1/yctf$ ssh ubuntu@51.250.83.24
    Welcome to Ubuntu 18.04.1 LTS (GNU/Linux 4.15.0-29-generic x86_64)

    * Documentation:  https://help.ubuntu.com
    * Management:     https://landscape.canonical.com
    * Support:        https://ubuntu.com/advantage

    New release '20.04.4 LTS' available.
    Run 'do-release-upgrade' to upgrade to it.



    #################################################################
    This instance runs Yandex.Cloud Marketplace product
    Please wait while we configure your product...

    Documentation for Yandex Cloud Marketplace images available at https://cloud.yandex.ru/docs

    #################################################################

    Last login: Tue Jun 21 04:23:56 2022 from 212.17.24.111
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.

    ubuntu@nat-instance:~$ 




