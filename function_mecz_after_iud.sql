CREATE OR REPLACE FUNCTION mecz_after_iud() RETURNS trigger 
LANGUAGE plpgsql 
AS 
$$ 
declare 
    stats_gosp stats%rowtype; 
    stats_gosc stats%rowtype; 

    new_sezon_id stats.sezon_id%type; 
    new_gosp_id stats.klub_id%type; 
    new_gosc_id stats.klub_id%type; 

    new_mecze_dom int     := 0; 
    new_zwy_dom int       := 0; 
    new_rem_dom int       := 0; 
    new_por_dom int       := 0; 
    new_gole_zdob_dom int := 0; 
    new_gole_stra_dom int := 0; 

    new_mecze_wyj int     := 0; 
    new_zwy_wyj int       := 0; 
    new_rem_wyj int       := 0; 
    new_por_wyj int       := 0; 
    new_gole_zdob_wyj int := 0; 
    new_gole_stra_wyj int := 0; 


begin 
    if TG_OP = 'UPDATE' then 
        if old.id <> new.id or old.sezon_id <> new.sezon_id or old.gosp_id <> new.gosp_id or old.gosc_id <> new.gosc_id then 
            raise exception 'Modification not allowed'; 
        end if; 
    end if; 


    if TG_OP = 'INSERT' then 
        select * into stats_gosp from stats where sezon_id = new.sezon_id and klub_id = new.gosp_id; 
        if not found then 
            insert into stats(sezon_id, klub_id) values (new.sezon_id, new.gosp_id); 
            select * into stats_gosp from stats where sezon_id = new.sezon_id and klub_id = new.gosp_id; 
        end if; 

        select * into stats_gosc from stats where sezon_id = new.sezon_id and klub_id = new.gosc_id; 
        if not found then 
            insert into stats(sezon_id, klub_id) values (new.sezon_id, new.gosc_id); 
            select * into stats_gosc from stats where sezon_id = new.sezon_id and klub_id = new.gosc_id; 
        end if; 

    else 
        select * into stats_gosp from stats where sezon_id = old.sezon_id and klub_id = old.gosp_id; 
        select * into stats_gosc from stats where sezon_id = old.sezon_id and klub_id = old.gosc_id; 
    end if; 


    new_sezon_id = stats_gosp.sezon_id; 
    new_gosp_id  = stats_gosp.klub_id; 
    new_gosc_id  = stats_gosc.klub_id; 

    new_mecze_dom     = stats_gosp.mecze_dom; 
    new_zwy_dom       = stats_gosp.zwy_dom; 
    new_rem_dom       = stats_gosp.rem_dom; 
    new_por_dom       = stats_gosp.por_dom; 
    new_gole_zdob_dom = stats_gosp.gole_zdob_dom; 
    new_gole_stra_dom = stats_gosp.gole_stra_dom; 

    new_mecze_wyj     = stats_gosp.mecze_wyj; 
    new_zwy_wyj       = stats_gosc.zwy_wyj; 
    new_rem_wyj       = stats_gosc.rem_wyj; 
    new_por_wyj       = stats_gosc.por_wyj; 
    new_gole_zdob_wyj = stats_gosc.gole_zdob_wyj; 
    new_gole_stra_wyj = stats_gosc.gole_stra_wyj; 


    if TG_OP = 'INSERT' then 
        new_gole_zdob_dom = new_gole_zdob_dom + new.gole_gosp; 
        new_gole_stra_dom = new_gole_stra_dom + new.gole_gosc; 
        new_gole_zdob_wyj = new_gole_zdob_wyj + new.gole_gosc; 
        new_gole_stra_wyj = new_gole_stra_wyj + new.gole_gosp; 

        if new.gole_gosp > new.gole_gosc then 
            new_zwy_dom = new_zwy_dom + 1; 
            new_por_wyj = new_por_wyj + 1; 

        elsif new.gole_gosp < new.gole_gosc then 
            new_por_dom = new_por_dom + 1; 
            new_zwy_wyj = new_zwy_wyj + 1; 

        else 
            new_rem_dom = new_rem_dom + 1; 
            new_rem_wyj = new_rem_wyj + 1; 
        end if; 


    elsif TG_OP = 'DELETE' then 
        new_gole_zdob_dom = new_gole_zdob_dom - old.gole_gosp; 
        new_gole_stra_dom = new_gole_stra_dom - old.gole_gosc; 
        new_gole_zdob_wyj = new_gole_zdob_wyj - old.gole_gosc; 
        new_gole_stra_wyj = new_gole_stra_wyj - old.gole_gosp; 

        if old.gole_gosp > old.gole_gosc then 
            new_zwy_dom = new_zwy_dom - 1; 
            new_por_wyj = new_por_wyj - 1; 

        elsif old.gole_gosp < old.gole_gosc then 
            new_por_dom = new_por_dom - 1; 
            new_zwy_wyj = new_zwy_wyj - 1; 

        else 
            new_rem_dom = new_rem_dom - 1; 
            new_rem_wyj = new_rem_wyj - 1; 
        end if; 


    else 
        new_gole_zdob_dom = new_gole_zdob_dom - old.gole_gosp + new.gole_gosp; 
        new_gole_stra_dom = new_gole_stra_dom - old.gole_gosc + new.gole_gosc; 
        new_gole_zdob_wyj = new_gole_zdob_wyj - old.gole_gosc + new.gole_gosc; 
        new_gole_stra_wyj = new_gole_stra_wyj - old.gole_gosp + new.gole_gosp; 

        if old.gole_gosp > old.gole_gosc then 
            if new.gole_gosp < new.gole_gosc then 
                new_zwy_dom = new_zwy_dom - 1; 
                new_por_wyj = new_por_wyj - 1; 
                new_por_dom = new_por_dom + 1; 
                new_zwy_wyj = new_zwy_wyj + 1; 

            elsif new.gole_gosp = new.gole_gosc then 
                new_zwy_dom = new_zwy_dom - 1; 
                new_por_wyj = new_por_wyj - 1; 
                new_rem_dom = new_rem_dom + 1; 
                new_rem_wyj = new_rem_wyj + 1; 
            end if; 

        elsif old.gole_gosp < old.gole_gosc then 
            if new.gole_gosp > new.gole_gosc then 
                new_por_dom = new_por_dom - 1; 
                new_zwy_wyj = new_zwy_wyj - 1; 
                new_zwy_dom = new_zwy_dom + 1; 
                new_por_wyj = new_por_wyj + 1; 

            elsif new.gole_gosp = new.gole_gosc then 
                new_por_dom = new_por_dom - 1; 
                new_zwy_wyj = new_zwy_wyj - 1; 
                new_rem_dom = new_rem_dom + 1; 
                new_rem_wyj = new_rem_wyj + 1; 
            end if; 

        else  -- old.gole_gosp = old.gole_gosc 
            if new.gole_gosp > new.gole_gosc then 
                new_rem_dom = new_rem_dom - 1; 
                new_rem_wyj = new_rem_wyj - 1; 
                new_zwy_dom = new_zwy_dom + 1; 
                new_por_wyj = new_por_wyj + 1; 

            elsif new.gole_gosp < new.gole_gosc then 
                new_rem_dom = new_rem_dom - 1; 
                new_rem_wyj = new_rem_wyj - 1; 
                new_por_dom = new_por_dom + 1; 
                new_zwy_wyj = new_zwy_wyj + 1; 
            end if; 

        end if; 
    end if; 


    new_mecze_dom = new_zwy_dom + new_rem_dom + new_por_dom; 
    new_mecze_wyj = new_zwy_wyj + new_rem_wyj + new_por_wyj; 


    update stats set 
    mecze_dom = new_mecze_dom, 
    zwy_dom = new_zwy_dom, 
    rem_dom = new_rem_dom, 
    por_dom = new_por_dom, 
    gole_zdob_dom = new_gole_zdob_dom, 
    gole_stra_dom = new_gole_stra_dom 
    where 
    sezon_id = new_sezon_id and klub_id = new_gosp_id; 


    update stats set 
    mecze_wyj = new_mecze_wyj, 
    zwy_wyj = new_zwy_wyj, 
    rem_wyj = new_rem_wyj, 
    por_wyj = new_por_wyj, 
    gole_zdob_wyj = new_gole_zdob_wyj, 
    gole_stra_wyj = new_gole_stra_wyj 
    where 
    sezon_id = new_sezon_id and klub_id = new_gosc_id; 


    return null; 
end; 
$$;


