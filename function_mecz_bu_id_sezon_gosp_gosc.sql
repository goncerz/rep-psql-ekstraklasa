CREATE OR REPLACE FUNCTION mecz_bu_id_sezon_gosp_gosc() RETURNS trigger 
LANGUAGE plpgsql 
AS 
$$ 
begin 
    raise exception 'Modification not allowed'; 
end; 
$$; 

