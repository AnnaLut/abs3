

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/VB_SNO.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view VB_SNO ***

  CREATE OR REPLACE FORCE VIEW BARS.VB_SNO ("OTM", "SPN", "ND", "KV", "ACC", "NLS", "ID", "DAT", "FDAT", "S", "SA", "OST1", "OST2") AS 
  SELECT t.otm
      ,t.spn
      ,t.nd
      ,t.kv
      ,t.acc
      ,t.nls
      ,t.id
      ,t.dat
      ,t.fdat
      ,t.s / 100 s
      ,t.sa / 100 sa
      ,(t.ostf - (SELECT nvl(SUM(s), 0)
                    FROM t2_sno
                   WHERE dat < t.dat
                     AND acc = t.acc)) / 100 ost1
      ,(t.ostf - (SELECT nvl(SUM(s), 0)
                    FROM t2_sno
                   WHERE dat <= t.dat
                     AND acc = t.acc)) / 100 ost2
  FROM t2_sno t
 WHERE acc = to_number(pul.get_mas_ini_val('ACC'));

PROMPT *** Create  grants  VB_SNO ***
grant SELECT                                                                 on VB_SNO          to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/VB_SNO.sql =========*** End *** =======
PROMPT ===================================================================================== 
