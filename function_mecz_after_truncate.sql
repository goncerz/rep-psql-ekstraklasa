CREATE OR REPLACE FUNCTION mecz_after_truncate() RETURNS trigger 
LANGUAGE plpgsql 
AS 
$$ 
begin 
    truncate stats; 
    alter sequence mecz_id_seq restart with 1; 

    return null; 
end; 
$$; 
