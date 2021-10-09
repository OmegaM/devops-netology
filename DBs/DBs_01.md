# 6.1. Типы и структура СУБД

#### 1.
* Электронные чеки в json виде
  * Документо-ориентированная - чек - документ.
* Склады и автомобильные дороги для логистической компании
  * Думаю, лучше внедрять графовую СУБД, т.к. алгоритм Дейкстры (если я правильно помню, лучший вариант, для решения логистических задач), основан на графах.
* Генеалогические деревья
  * Иерархические - один корень, много потомков.
* Кэш идентификаторов клиентов с ограниченным временем жизни для движка аутенфикации
  * Ключ-значение, где ключ - параметры запроса, значение - ответ
* Отношения клиент-покупка для интернет-магазина
    * Реляционная СУБД - проще составлять зависимость покупки от клиента, по средством FK.

#### 2. 
* Данные записываются на все узлы с задержкой до часа (асинхронная запись)
  * CA, EL-PC
* При сетевых сбоях, система может разделиться на 2 раздельных кластера
  * AP, PA-EL
* Система может не прислать корректный ответ или сбросить соединение
    * CP, PA-EC
#### 3.
Принципы BASE и ACID сочетаться не могут из-за противоречия в согласованности данных. ACID - обеспечивает согласованность данных, а BASE - нет. 
#### 4.
СУБД подходящее под описание - Redis.
Минусы : 
* Redis хранит данные в памяти.
    * Это позволяет ему увеличивать скорость работы, но делает чуствительным к нехватке той самой памяти + размер БД ограничен доступной памятью
    
* Нет сегментации на пользователей или группы пользователей. Отсутствует контроль доступа
    * доступ по общему паролю
    