# ValeriyTyutyunnik_infra
ValeriyTyutyunnik Infra repository

## Задание к Лекции 5

bastion_IP = 84.201.159.70
someinternalhost_IP = 10.130.0.12

### Подключение к someinternalhost с локальной машины в одну команду

#### Вариант 1. Проброс команды

```
ssh -i ~/.ssh/appuser -A appuser@<bastion ip> "ssh <someinternalhost ip>"
```

#### Вариант 2 (более правильный). Проброс хоста

```
ssh -i ~/.ssh/appuser -AJ appuser@<bastion ip> appuser@<someinternalhost ip>
```

### Настройка подключения по команде ssh someinternalhost

Добавить в ~/.ssh/config:

```
Host bastion
  HostName <bastion ip>
  User appuser
  ForwardAgent yes
  IdentityFile ~/.ssh/appuser
  Port 22

Host someinternalhost
  HostName <someinternalhost ip>
  User appuser
  ForwardAgent yes
  IdentityFile ~/.ssh/appuser
  Port 22
  ProxyJump bastion
```
