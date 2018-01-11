

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_VAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_VAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_VAL ("FDAT", "NBS", "KV", "NAME", "DOS", "KOS", "ISD", "ISK", "DIG") AS 
  SELECT s.FDAT, s.nbs, s.KV, t.name, DOS, KOS, ISD, ISK , t.dig
from tabval t,
  (select fdat, nbs, KV, SUM(dos) dos, SUM(kos) kos,
          SUM(decode(zn,1,OST,0)) ISD, SUM(decode(zn,1,0,-OST)) ISK
   FROM (select a.KV,a.nbs,d.caldt_DATE fdat,b.dos,b.kos,sign(b.OST) ZN, b.OST
         FROM accm_calendar d, accm_snap_balances b, accounts a
         where b.acc=a.acc  and d.caldt_ID=b.caldt_ID and a.nbs not like '8%'
           and a.BRANCH LIKE SYS_CONTEXT('bars_context','user_branch_mask')
           and (b.ost<>0 or b.dos <>0 or b.kos<>0)
         )
   GROUP BY FDAT, nbs, KV
   ) s
where s.kv = t.kv
 ;

PROMPT *** Create  grants  V_BALANS_VAL ***
grant SELECT                                                                 on V_BALANS_VAL    to BARSREADER_ROLE;
grant SELECT                                                                 on V_BALANS_VAL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_VAL    to UPLD;
grant SELECT                                                                 on V_BALANS_VAL    to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_VAL    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_VAL.sql =========*** End *** =
PROMPT ===================================================================================== 
