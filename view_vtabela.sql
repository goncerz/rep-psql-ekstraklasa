CREATE OR REPLACE VIEW vtabela 
AS 
SELECT 
    rank() OVER (ORDER BY (((s.zwy_dom + s.zwy_wyj) * 3) + s.rem_dom + s.rem_wyj) DESC, (s.gole_zdob_dom + s.gole_zdob_wyj - (s.gole_stra_dom + s.gole_stra_wyj)) DESC, (s.gole_zdob_dom + s.gole_zdob_wyj) DESC) AS "LP", 
    k.nazwa_klubu AS "KLUB", 
    (s.mecze_dom + s.mecze_wyj) AS "M", 
    (((s.zwy_dom + s.zwy_wyj) * 3) + s.rem_dom + s.rem_wyj) AS "PKT", 
    (s.zwy_dom + s.zwy_wyj) AS "Z_ALL", 
    (s.rem_dom + s.rem_wyj) AS "R_ALL", 
    (s.por_dom + s.por_wyj) AS "P_ALL", 
    (s.gole_zdob_dom + s.gole_zdob_wyj) AS "BZ_ALL", 
    (s.gole_stra_dom + s.gole_stra_wyj) AS "BS_ALL", 
    s.zwy_dom AS "Z_DOM", 
    s.rem_dom AS "R_DOM", 
    s.por_dom AS "P_DOM", 
    s.gole_zdob_dom AS "BZ_DOM", 
    s.gole_stra_dom AS "BS_DOM", 
    s.zwy_wyj AS "Z_WYJ", 
    s.rem_wyj AS "R_WYJ", 
    s.por_wyj AS "P_WYJ", 
    s.gole_zdob_wyj AS "BZ_WYJ", 
    s.gole_stra_wyj AS "BS_WYJ" 
FROM 
stats s JOIN klub k 
ON 
(s.klub_id = k.id) 
; 

