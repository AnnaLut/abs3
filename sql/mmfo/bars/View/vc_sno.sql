

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VC_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view VC_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.VC_SNO ("ND", "ACC", "KV", "NLS", "DAT31", "S", "REF", "FDAT") AS 
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

PROMPT *** Create  grants  VC_SNO ***
grant SELECT                                                                 on VC_SNO          to BARSREADER_ROLE;
grant SELECT                                                                 on VC_SNO          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on VC_SNO          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VC_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
