

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_MBK_BV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_MBK_BV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_MBK_BV ("ND", "KV", "BV") AS 
  select n.nd,  min(a.kv) KV, -SUM (s.ostf-s.dos+s.kos)/100 BV
FROM nd_acc n, accounts a, saldoa s
WHERE (a.nbs > '1500' AND a.nbs < '1600' or a.nbs in ('1600','1607','1608') )
  AND n.acc  = a.acc  AND a.acc  = s.acc  AND s.fdat =
   (SELECT MAX (fdat) FROM saldoa WHERE acc=a.acc AND fdat < TO_DATE (pul.get_mas_ini_val('sFdat1'),'dd.mm.yyyy') )
group by n.nd having SUM (s.ostf-s.dos+s.kos) <0 ;

PROMPT *** Create  grants  V_MBK_BV ***
grant SELECT                                                                 on V_MBK_BV        to BARSREADER_ROLE;
grant SELECT                                                                 on V_MBK_BV        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_MBK_BV.sql =========*** End *** =====
PROMPT ===================================================================================== 
