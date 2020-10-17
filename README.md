# ValeriyTyutyunnik_infra
ValeriyTyutyunnik Infra repository

[![Build Status](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_infra.svg?branch=master)](https://travis-ci.com/Otus-DevOps-2020-08/ValeriyTyutyunnik_infra)

## Задание к Лекции 5 (ДЗ №3)

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

## Задание к лекции 6 (ДЗ №4)
testapp_IP = 130.193.50.51
testapp_port = 9292

### Доп.задание - создание ВМ, используя скрипт с метаданными

Примечание: ВМ создается прерываемая (ключ --preemptible).

```
yc compute instance create \
  --name reddit-app \
  --hostname reddit-app \
  --memory=4 \
  --create-boot-disk image-folder-id=standard-images,image-family=ubuntu-1604-lts,size=10GB \
  --network-interface subnet-name=default-ru-central1-a,nat-ip-version=ipv4 \
  --metadata serial-port-enable=1 \
  --preemptible \
  --metadata-from-file user-data=./reddit_app_metadata.yaml
```

[doc: cloud config examples](https://cloudinit.readthedocs.io/en/latest/topics/examples.html)

## Задание к лекции 7 (ДЗ №5)

1. Сделаны packer скрипты для создания Fry и Bake образов для приложения reddit
2. Проверено создание ВМ из созданных образов
```
packer build -var-file=variables.json ./ubuntu16.json
packer build -var-file=variables.json ./immutable.json
```
3. Скрипт создание ВМ из Bake-образа через YC CLI /config-scripts/create-reddit-vm.sh

## terraform-1 (ДЗ №6)
Создана и проверена конфигурация terraform с развертыванием 2-ух инстансов приложения и балансером

[doc: terraform configuration](https://www.terraform.io/docs/configuration/resources.html)
[doc: terraform yandex provider](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs)

## teraform-2 (ДЗ №7)

1. Созданы packer образы db и app
2. Созданы terraform модули app, db, vpc. Модули app и db создаются на основе новых образов packer
3. Созданы конфигурации stage и prod
4. В модули db и app добавлены провиженеры для развертывания готового приложения.
5. Модулем app может быть создано несколько инстансов, которые будут коннетится к одной БД. Проверено - работает)
6. Создан бакет в облаке и ключ доступа к нему для хранения state файла

## ansible-1 (ДЗ №8)

1. Установлен ansible
2. Выполнены задания по списку
3. При выполнении плейбука после удаления папки на сервере вернулось ok=2 changed=1. То есть было применено изменение так как не было сконированного репозитория.
4. Написан python скрипт inventory-gen.py для генерации динамического инвентори. Скрипт берет данные из tfstate
5. Перечитал описание и понял, что сделал нет тот скрипт. Написал dynamic-inventory.py. Проверил запуском ansible %group% -m ping, где group = all/app/db/reddit-db/reddit-app-[i]. Работает

## ansible-2 (ДЗ №9)

1. Выполнено задание по практике
2. Создан один плейбук, который после был разбит на несколько
3. Провижинеры терраформ теперь запускаются по переменной через null-провиженеры, в dynamic-invertory исправлен маленький баг
4. ansible/app.yml получает ip DB через dynamic-inventory
5. Создана ansible конфигурация для образов packer. Собрана и проверена инфраструктура из новых образов

## ansible-3 (ДЗ №10)

1. Работа по плану домашки. Перенос ролей из прошлого задания в роли app/db
2. Описаны окружения stage/prod
3. Создана роль users. Пароли зашифрованы через vault. Проверено, что после накатки роли пользователи есть и пароль подходит

задания со звездочкой:


1. Инвентори работате для stage и prod окружений ansible
2. Муки с [докой тревиса](https://docs.travis-ci.com/user/job-lifecycle/#the-job-lifecycle) и синтаксическими мелочами bash все же привели к результату:
- Для всех плейбуков ansible запускается линтер
- Для всех образов packer запускается packer/validate (запуск из корня репозитория)
- Для stage и prod конфигураций terraform запускается validate и tflint


```
# ansible stage command
ansible-playbook playbooks/site.yml --check
ansible-playbook playbooks/site.yml

# ansible prod command
ansible-playbook -i environments/prod/dynamic-inventory.py playbooks/site.yml --check
ansible-playbook -i environments/prod/dynamic-inventory.py playbooks/site.yml
```

## ansible-4 (ДЗ №11)
1. Установлен Vagrant. Классная вещь!
2. Настроен для ролей app и db. Плейбук base.yml в site.yml не включал, т.к. питон итак установлен.
3. Потестил молекулой роль db. Странно, что от версии к версии разный список поддерживаемых провижинеров, пришлось сначала откатывать 3.х версию и устанавливать 2.22
4. Настроил использование ролей в пакере. После добавления переменной deploy_user сломался плейбук deploy.yml если катать не через Vagrant. Отправил его в роль app, чтобы не дублировать переменные в окружении и плейбуке с ролью.

Роль db в отдельный не стал выносить. Сделать и подключить просто, а вот с настройкой автозапуска тестов в облаке возится совсем нет желания. В описании задания тем более стоит GCP, и не факт что есть модуль молекулы для yc

Подключить роль из репозитория:
```
- src: https://<repo>.git
  version: <branch>
  name: <name>
```
