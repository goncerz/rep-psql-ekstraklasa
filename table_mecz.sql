CREATE TABLE IF NOT EXISTS mecz (
    id serial NOT NULL PRIMARY KEY,
    sezon_id character varying(9) NOT NULL,
    gosp_id character varying(3) NOT NULL,
    gosc_id character varying(3) NOT NULL,
    gole_gosp integer NOT NULL,
    gole_gosc integer NOT NULL,
    CHECK (gosp_id <> gosc_id),
    CHECK (gole_gosc >= 0),
    CHECK (gole_gosp >= 0),
    UNIQUE (sezon_id, gosp_id, gosc_id)
);

