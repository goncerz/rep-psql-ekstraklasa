ALTER TABLE trener ADD FOREIGN KEY (kraj_id) REFERENCES kraj(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE klub ADD FOREIGN KEY (kraj_id) REFERENCES kraj(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE klub ADD FOREIGN KEY (trener_id) REFERENCES trener(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE stats ADD FOREIGN KEY (klub_id) REFERENCES klub(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE stats ADD FOREIGN KEY (sezon_id) REFERENCES sezon(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE mecz ADD FOREIGN KEY (gosc_id) REFERENCES klub(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE mecz ADD FOREIGN KEY (gosp_id) REFERENCES klub(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

ALTER TABLE mecz ADD FOREIGN KEY (sezon_id) REFERENCES sezon(id) ON UPDATE RESTRICT ON DELETE RESTRICT;

