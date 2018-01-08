

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BALANS_TOBO_VAL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BALANS_TOBO_VAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BALANS_TOBO_VAL ("TOBO", "FDAT", "NBS", "KV", "NAME", "DOS", "KOS", "ISD", "ISK", "DIG") AS 
  select a.tobo, a.fdat fdat, a.nbs nbs, a.kv kv, t.name name,
       sum(dos) dos, sum(kos) kos,
       sum(decode(sign(ost),-1,-ost,0)) isd,
       sum(decode(sign(ost), 1, ost,0)) isk, t.dig dig
from sal_branch a, tabval t
where t.kv=a.kv
group by a.tobo, a.fdat, a.nbs, a.kv, t.name, t.dig

 ;

PROMPT *** Create  grants  V_BALANS_TOBO_VAL ***
grant SELECT                                                                 on V_BALANS_TOBO_VAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BALANS_TOBO_VAL to WEB_BALANS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_BALANS_TOBO_VAL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BALANS_TOBO_VAL.sql =========*** End 
PROMPT ===================================================================================== 
