-- ФИО студента: Тонкушин Дмитрий Алексеевич
-- Вариант: 4
-- Описание предметной области:
-- Описание хранящихся на складе товаров. Включает в себя: описание помещений, описание стеллажей, описание клиентов, описание товаров, хранящихся на стеллажах.
-- Описание помещения состоит из: названия, полезного объёма, температурных и влажностных условий. 
-- Описание стеллажа состоит из: номера, указания помещения, в котором стеллаж находится, количества мест для хранения в стеллаже, высоты, ширины и длины одного места, максимальной суммарной нагрузки.
-- Описание клиента состоит из: названия юридического лица и банковских реквизитов в виде большого текста.
-- Описание товара, хранящегося на стеллажах, состоит из: высоты, ширины, длины, веса, даты поступления, номера договора, указания, от какого клиента поступил, даты окончания договора, температурных и влажностных условий хранения, указания стеллажа, и позиции размещения на нём, представляемой в виде целого номера.
-- На одном стеллаже могут храниться товары разных клиентов.

CREATE TABLE room (
    id uuid PRIMARY KEY,
    name varchar NOT NULL UNIQUE,
    volume float NOT NULL,
    storage_temperature_range varchar NOT NULL,
    storage_humidity_range varchar NOT NULL
);

CREATE TABLE rack (
    id uuid PRIMARY KEY,
    rack_number varchar NOT NULL,
    room_id uuid NOT NULL REFERENCES room(id),
    positions_count integer NOT NULL,
    position_height float NOT NULL,
    position_width float NOT NULL,
    position_length float NOT NULL,
    max_total_weight float NOT NULL,
    UNIQUE (room_id, rack_number)
);

CREATE TABLE client (
    id uuid PRIMARY KEY,
    company_name varchar NOT NULL,
    bank_details text NOT NULL,
    UNIQUE(company_name, bank_details)
);

CREATE TABLE product (
    id uuid PRIMARY KEY,
    height float NOT NULL,
    width float NOT NULL,
    length float NOT NULL,
    weight float NOT NULL,
    receipt_date date NOT NULL,
    contract_number varchar NOT NULL,
    client_id uuid NOT NULL REFERENCES client(id),
    contract_end_date date NOT NULL,
    storage_temperature_range varchar NOT NULL,
    storage_humidity_range varchar NOT NULL,
    rack_id uuid NOT NULL REFERENCES rack(id),
    rack_position integer NOT NULL,
    UNIQUE(rack_id, rack_position)
);
