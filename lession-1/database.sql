-- ФИО студента: Тонкушин Дмитрий Алексеевич
-- Вариант: 4
-- Описание: Складская система хранения товаров (помещения, стеллажи, клиенты, товары)

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE room (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar NOT NULL UNIQUE,
    volume float NOT NULL,
    storage_temperature_range varchar NOT NULL,
    storage_humidity_range varchar NOT NULL
);

CREATE TABLE rack (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
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
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    company_name varchar NOT NULL,
    bank_details text NOT NULL,
    UNIQUE(company_name, bank_details)
);

CREATE TABLE product (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
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
