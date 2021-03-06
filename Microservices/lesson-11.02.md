# 11.02 Микросервисы: принципы

#### 1. 
| Критерий  | Центральный шлюз	| Two-tier gateway	| Микрошлюз	| Шлюзы per-pod	| Sidecar, Service Mash |
|-----------|-------------------|-------------------|-----------|---------------|-----------------------|
| SSL/TLS termination|   +      |        +          |     +     |       +       |           +           |
| Authentication|        +      |        +          |     +     |       +       |           +           |
| Authorization |        +      |        +          |     -     |       -       |           +           |
| Request routing |      +      |        -          |     +     |       -       |           -           |
| Rate limiting |        +      |        -          |     +     |       +       |           -           |
| Request/response manipulation | + |    -          |     -     |       -       |           -           |
| Tracing injection |    -      |        +          |     -     |       -       |           +           |
| Centralized logging of connections and requests | - | + | -   |       -       |           +           |
| Load balancing |       -      |        +          |     +     |       -       |           +           |
| Service discovery |    -      |        +          |     +     |       -       |           +           |
| Tracing and metrics generation | - |   -          |     -     |       -       |           -           |

| Review                |  -   |
|-----------------------|------|
| Центральный шлюз      | Плохо подходит для микросервисной архитекуты, требующей частых изменений. Подходит при монолитной архитектуре |
| Two-tier gateway      | Лучше всего работает в ситуациях, требующих гибкости для рассредоточенных сервисов и независимого масштабирования. Не поддерживает распределенное управление, т.е. может вызвать проблемы при импользовании различных окружений и приложений |
| Микрошлюз             | Подходит для отдельных команд разработки, может управлять трафиком между службами. Сложно добиться согласованности и контроля. |
| Шлюзы per-pod         | Использует прокси-сервер. Конфигурация статична, не требует модификации при изменении приложения. |
| Sidecar, Service Mash | Сложность в управлении |

В результате, можно применить микрошлюз, т.к. он отвечает всем требованиям и лучше подходит для микросервисной архитектуры, чем Центральный шлюз.

#### 2.
| Критерий | [RabbitMQ](https://www.rabbitmq.com/) | [ActiveMQ](https://activemq.apache.org/) | [Qpid](https://qpid.apache.org/components/cpp-broker/index.html) | [SwiftMQ](https://www.swiftmq.com/)	
|----------|----------|----------|----------|-----------|
| Кластеризации | + | + | + | + |
| Хранение сообщений на диске в процессе доставки | + | + | + | + |
| Cкорость работы | + | - | - | - | 
| Поддержка различных форматов сообщений | + | - | - | - |
| Разделение прав доступа | + | + | + | + | 
| Простота эксплуатации | + | + | - | - |

Исходя из наддых таблицы, следует выбрать RabbitMQ, но следует учитывать, что при возрастании нагрузки на брокер, сильно возрастает потребление ресурсов, что может привести к увеличению затрат. 