create or replace view vc_sno as
SELECT x.nd
      ,a.acc
      ,a.kv
      ,a.nls
      ,x.dat31
      ,x.sump1 / 100 s
      ,r.ref
      ,x.fdat fdat
  FROM accounts a
      ,(SELECT *
          FROM sno_gpp
         WHERE acc = to_number(pul.get_mas_ini_val('ACC'))) x
      ,sno_ref r
 WHERE x.acc = a.acc
   AND r.acc = a.acc;
