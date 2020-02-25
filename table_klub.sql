CREATE TABLE IF NOT EXISTS klub (
    id character varying(3) NOT NULL PRIMARY KEY,
    nazwa_klubu character varying(120) NOT NULL,
    nazwa_spolki character varying(120) NOT NULL,
    kraj_id character varying(3) NOT NULL,
    trener_id character varying(3) NOT NULL,
    rok_powst numeric(4,0) NOT NULL,
    barwy character varying(80) NOT NULL
);

