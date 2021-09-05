# 5.2. Системы управления виртуализацией

#### 1.
* 100 виртуальных машин на базе Linux и Windows, общие задачи, нет особых требований
Преимущественно Windows based инфраструктура, требуется реализация программных балансировщиков нагрузки, репликации данных и автоматизированного механизма создания резервных копий 
  * Подойдет VmWare, т.к. четких требований по нагрузке у нас нет + планируется ставить разные ОС, если бы была только Windows, то скорее всего, предложил бы Hyper-V
    
* Требуется наиболее производительное бесплатное opensource решение для виртуализации небольшой (20 серверов) инфраструктуры Linux и Windows виртуальных машин
    * KVM - как более производительное решение для инфраструктуры из разных ОС, или XEN, но он менее производительный, хотя для 20 серверов, думаю, будет норм
    
* Необходимо бесплатное, максимально совместимое и производительное решение для виртуализации Windows инфраструктуры
    * Для решения инфраструктуры на Windows, неплохо было бы использовать Hyper-V, если виртуалок не очень много, то можно попробовать бесплатную версию Hyper-V.
      Если серверов будет +- много, можно попробовать KVM
      
* Необходимо рабочее окружение для тестирование программного продукта на нескольких дистрибутивах Linux
  * Для тестирования, разумно было бы использовать облачные решения - AWS|Openstack т.к. в этом случае, можно легко масштабировать инфраструктуру и управлять ресурсами
  
#### 2.
0. Устанавливаем на Hyper-V ВММ агент и библиотеку SCVMM
1. Выключаем машину
2. Копируем в библиотеку
3. Конвертируем VMDK диск в VHD
4. Создаем машину в Hyper-v (Параметры ВМ должны быть в точности такими же)

[Доклад по теме](https://channel9.msdn.com/Blogs/TechDays-Russia/-VMware-vSphere-Windows-Server-2012-Hyper-V-20121224090800)
#### 3.
Сложности: 
1. Необходимость наличию специалистов узкой направленности (или в обучении)
2. Затраты на покупку большего кол-ва лицензий
3. Проблемы с масштабируемостью (в том числе и ресурсов)
4. Если учитывать предыдущий вопрос, то , предположу что могут быть проблемы с быстрой миграцией, особенно для прода
   
Для оптимизации издержек, считаю, стоит выбрать один из типов ОС, что позволит исаользовать одну систему виртуализации, 
следовательно сократить расходы. 

Если же такой возможности нет, то , возможно, попытаться выбрать максимально подходящую для всех целей систему виртуализации, пусть даже она будет в каких то моментах хуже более узко направленных инструментов 