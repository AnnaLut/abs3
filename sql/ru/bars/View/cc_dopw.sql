create or replace view cc_W_EPS as 
SELECT (m.fdat - x.dat1 + 1) npp
      ,m.fdat
      ,m.ss1
      ,m.sdp
      ,m.ss2
      ,m.sn2
      ,(m.ss1 + m.sn2 + m.sdp + m.ss2) s
  FROM (SELECT *
          FROM cc_many
         WHERE nd = to_number(pul.get_mas_ini_val('ND'))) m
      ,(SELECT nd, MIN(fdat) dat1
          FROM cc_many
         WHERE nd = to_number(pul.get_mas_ini_val('ND'))
         GROUP BY nd) x
 WHERE m.nd = x.nd;
