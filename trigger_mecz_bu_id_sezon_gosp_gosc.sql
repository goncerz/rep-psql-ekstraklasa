CREATE OR REPLACE TRIGGER mecz_bu_id_sezon_gosp_gosc 
BEFORE UPDATE OF id, sezon_id, gosp_id, gosc_id 
ON mecz 
FOR EACH ROW 
EXECUTE PROCEDURE mecz_bu_id_sezon_gosp_gosc() 
; 

