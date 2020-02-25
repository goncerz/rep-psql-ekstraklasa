CREATE TABLE IF NOT EXISTS trener (
    id character varying(3) NOT NULL PRIMARY KEY,
    imie character varying(40) NOT NULL,
    nazwisko character varying(80) NOT NULL,
    kraj_id character varying(3) NOT NULL
);

