CREATE OR REPLACE FUNCTION mecze(k1 character varying, k2 character varying) 
RETURNS TABLE(gosp character varying, ggosp integer, ggosc integer, gosc character varying, sezon character varying) 
LANGUAGE plpgsql 
AS 
$$ 
begin 
    return query ( 
        select gosp_id, gole_gosp, gole_gosc, gosc_id, sezon_id 
        from mecz 
        where (gosp_id = k1 and gosc_id = k2) 
        or (gosp_id = k2 and gosc_id = k1) 
    ); 
end; 
$$; 

