# Инструкция по запуску БД и работе со скриптами

## 1. Запуск PostgreSQL в Docker

### Создание и запуск контейнера

Выполните в терминале:

```bash
docker run --name mephi-postgres \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_PASSWORD=postgres \
  -e POSTGRES_DB=mephi_warehouse \
  -p 5432:5432 \
  -d postgres:16
```

Параметры:
- `--name mephi-postgres` - имя контейнера
- `-e POSTGRES_USER=postgres` - пользователь БД
- `-e POSTGRES_PASSWORD=postgres` - пароль БД
- `-e POSTGRES_DB=mephi_warehouse` - имя базы данных
- `-p 5432:5432` - проброс порта (локальный:контейнер)
- `-d` - запуск в фоновом режиме
- `postgres:16` - образ PostgreSQL версии 16

### Проверка работы контейнера

```bash
docker ps
```

Контейнер должен быть в статусе "Up".

### Остановка контейнера

```bash
docker stop mephi-postgres
```

### Запуск существующего контейнера

```bash
docker start mephi-postgres
```

### Удаление контейнера (если нужно начать заново)

```bash
docker stop mephi-postgres
docker rm mephi-postgres
```

## 2. Подключение через DBViewer

1. Откройте DBViewer
2. Нажмите кнопку "New Connection" или "+"
3. Выберите тип БД: **PostgreSQL**
4. Заполните параметры подключения:
   - **Host**: `localhost` или `127.0.0.1`
   - **Port**: `5432`
   - **Database**: `mephi_warehouse`
   - **Username**: `postgres`
   - **Password**: `postgres`
5. Нажмите "Test Connection" для проверки
6. Нажмите "Save" и "Connect"

## 3. Выполнение скриптов

### Вариант 1: Через DBViewer

1. Подключитесь к БД (см. раздел 2)
2. Откройте вкладку "Query" или "SQL Editor"
3. Откройте файл `database.sql` в любом текстовом редакторе
4. Скопируйте весь содержимое файла
5. Вставьте в SQL редактор DBViewer
6. Нажмите "Execute" или `Cmd+Enter`
7. Повторите шаги 3-6 для файла `insert_data.sql`

### Вариант 2: Через Docker (psql)

#### Выполнение скрипта создания структуры:

```bash
docker exec -i mephi-postgres psql -U postgres -d mephi_warehouse < homework-2/database.sql
```

#### Выполнение скрипта заполнения данными:

```bash
docker exec -i mephi-postgres psql -U postgres -d mephi_warehouse < homework-2/insert_data.sql
```

#### Или выполнение через интерактивный psql:

```bash
docker exec -it mephi-postgres psql -U postgres -d mephi_warehouse
```

Затем в консоли psql можно выполнять SQL команды или загрузить файл:

```sql
\i /path/to/database.sql
```

(Но для этого нужно сначала скопировать файлы в контейнер)

### Вариант 3: Через терминал с копированием файлов

```bash
# Копируем файлы в контейнер
docker cp homework-2/database.sql mephi-postgres:/tmp/database.sql
docker cp homework-2/insert_data.sql mephi-postgres:/tmp/insert_data.sql

# Выполняем скрипты
docker exec -it mephi-postgres psql -U postgres -d mephi_warehouse -f /tmp/database.sql
docker exec -it mephi-postgres psql -U postgres -d mephi_warehouse -f /tmp/insert_data.sql
```

## 4. Проверка данных

После выполнения скриптов можно проверить данные через DBViewer:

```sql
-- Проверка количества записей
SELECT COUNT(*) FROM room;
SELECT COUNT(*) FROM rack;
SELECT COUNT(*) FROM client;
SELECT COUNT(*) FROM product;

-- Просмотр данных
SELECT * FROM room;
SELECT * FROM rack;
SELECT * FROM client;
SELECT * FROM product;
```

## 5. Полезные команды Docker

```bash
# Просмотр логов контейнера
docker logs mephi-postgres

# Просмотр логов в реальном времени
docker logs -f mephi-postgres

# Вход в контейнер
docker exec -it mephi-postgres bash

# Остановка и удаление контейнера с данными
docker stop mephi-postgres
docker rm mephi-postgres
```

## Примечания

- Данные в контейнере сохраняются до удаления контейнера
- Для постоянного хранения данных можно использовать Docker volumes (опционально)
- Порт 5432 должен быть свободен на вашем Mac
- Если порт занят, измените первый номер порта в команде `-p` (например, `-p 5433:5432`)

