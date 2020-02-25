CREATE TABLE IF NOT EXISTS sezon (
    id character varying(9) NOT NULL PRIMARY KEY,
    rozp numeric(4,0) NOT NULL,
    zak numeric(4,0) NOT NULL,
    CHECK (zak - rozp = 1),
    CHECK (rozp >= 1840),
    CHECK (zak >= 1840)
);

