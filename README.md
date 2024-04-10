# Домашнее задание к занятию «Основы Terraform. Yandex Cloud» - Илларионов Дмитрий

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.  Убедитесь что ваша версия **Terraform** =1.5.Х (версия 1.6.Х может вызывать проблемы с Яндекс провайдером) 

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).

_создал аккаунт_

![alt text](image-1.png)

_создал ключ_
https://yandex.cloud/ru/docs/iam/operations/authorized-key/create#cli_1

_на ububntu поставил yc:_

```
curl -sSL https://storage.yandexcloud.net/yandexcloud-yc/install.sh | bash
yc init
```
_вводил там токен_
```
yc iam key create --service-account-name test-srv -o my-key.json
```
![alt text](image-2.png)

![alt text](image-3.png)

4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.

![alt text](image-4.png)

Исправил на standard-v1 и количество ядер и памяти исправил.

Создание прошло:
![alt text](image-5.png)

6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.

Посмотрел IP:

![alt text](image-6.png)

подключился:
![alt text](image-7.png)

![alt text](image-8.png)

Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;

8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

_что бы сделать ВМ прерываемой, и что бы использовать не полную мощь ядер, а только часть, чтобы экономить затраты_

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

![alt text](image-9.png)

Еще что бы не забивать каждый раз начальные значения переменных в интерактиве, я создал файл src\personal.auto.tfvars и там прописал значения:

![alt text](image-10.png)

### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 

Все сделал:

![alt text](image-12.png)

![alt text](image-13.png)

![alt text](image-11.png)

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

Сначала попробовал без изменения расположения ВМ:

![alt text](image-14.png)

![alt text](image-15.png)

![alt text](image-16.png)

Потом попробовал поменять расположение ВМ, для этого:
пытаюсь создать подсеть в другой зоне для той же сети:


![alt text](image-18.png)

т.е. должна создаться сеть и две подсети в разных локациях:

![alt text](image-19.png)

Далее создаю ВМ:

![alt text](image-24.png)

### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

![alt text](image-25.png)


### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

Сделал так:

![alt text](image-26.png)

![alt text](image-27.png)

![alt text](image-28.png)

### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map.  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=
       memory=
       core_fraction=
       ...
     },
     db= {
       cores=
       memory=
       core_fraction=
       ...
     }
   }
   ```
Сделал так:

![alt text](image-29.png)

![alt text](image-30.png)

![alt text](image-31.png)


3. Создайте и используйте отдельную map переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  

  Сделал так

  ![alt text](image-32.png)

  в блоке ресурсов при создании ВМ:

  ![alt text](image-33.png)
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.

Выполнил

![alt text](image-34.png)

![alt text](image-35.png)

![alt text](image-36.png)



6. Проверьте terraform plan. Изменений быть не должно.

изменений нет:

![alt text](image-37.png)

------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.

![alt text](image-38.png)

2. Найдите длину списка test_list с помощью функции length(<имя переменной>).

![alt text](image-39.png)

3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.

![alt text](image-40.png)

4. Напишите interpolation-выражение, результатом которого будет: 
"John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks"

, используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

```
"${local.test_map.admin} is ${keys(local.test_map)[0]} for ${local.test_list[2]} server based on OS ${local.servers.stage.image} with ${local.servers.stage.cpu}  vcpu, ${local.servers.stage.ram}  ram and ${length(local.servers.stage.disks)} virtual disks"
```

![alt text](image-42.png)



**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```

```
variable test {
  type = list(map(list(string)))
  default = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
}
```

![alt text](image-44.png)

2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"

```
var.test[0].dev1[0]
```

![alt text](image-43.png)
------

------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

смотрел тут https://yandex.cloud/ru/docs/vpc/operations/create-nat-gateway#tf_1 

пароль поставил на ubuntu.

создал нат

![alt text](image-46.png)

![alt text](image-45.png)

Отключил nat

![alt text](image-47.png)

![alt text](image-48.png)

У ВМ пропал внешний IP

![alt text](image-49.png)

удалось войти в серийную консоль

![alt text](image-50.png)

Но, пинг не идет:

![alt text](image-51.png)

Настройки IP

![alt text](image-52.png)

Что я сделал не так?
Может внутри ВМ еще нужно прописать основной шлюз? Но, какой?



### Правила приёма работыДля подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu
В качестве результата прикрепите ссылку на MD файл с описанием выполненой работы в вашем репозитории. Так же в репозитории должен присутсвовать ваш финальный код проекта.

**Важно. Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 

