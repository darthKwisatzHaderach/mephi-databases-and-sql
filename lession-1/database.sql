CREATE TABLE room (
    id uuid PRIMARY KEY NOT NULL,
    name varchar NOT NULL UNIQUE,
    volume float NOT NULL,
    room_conditions text NOT NULL
);

CREATE TABLE rack (
    id uuid PRIMARY KEY NOT NULL,
    positions integer NOT NULL,
    room_id uuid NOT NULL REFERENCES room(id),
    positions_count integer NOT NULL,
    position_height float NOT NULL,
    position_width float NOT NULL,
    position_length float NOT NULL,
    total_weight float NOT NULL
);

CREATE TABLE client (
    id uuid PRIMARY KEY NOT NULL,
    company_name varchar NOT NULL,
    bank_details text NOT NULL,
    UNIQUE(company_name, bank_details)
);

CREATE TABLE product (
    id uuid PRIMARY KEY NOT NULL,
    height float NOT NULL,
    width float NOT NULL,
    length float NOT NULL,
    weight float NOT NULL,
    receipt_date date,
    contract_number varchar NOT NULL,
    instructions text,
    client_id uuid NOT NULL REFERENCES client(id),
    contract_end_date date NOT NULL,
    storage_conditions text NOT NULL,
    rack_id uuid NOT NULL REFERENCES rack(id),
    rack_position integer NOT NULL,
    UNIQUE(rack_id, rack_position)
);
