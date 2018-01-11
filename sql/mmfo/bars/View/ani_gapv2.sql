

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/ANI_GAPV2.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view ANI_GAPV2 ***

  CREATE OR REPLACE FORCE VIEW BARS.ANI_GAPV2 ("FDAT", "PAP", "KV", "NAMEV", "BRANCH", "NAMEB", "G00") AS 
  select a.FDAT, a.pap, a.kv, v.name, a.branch, b.name, a.G00
from ani_gap a, (select kv, name from tabval union all
                 select 0,   'Консолiдовано' from dual) v,
                (select tobo, name from tobo union all
                 select '*', 'Консолiдовано' from dual) b
where a.kv=v.kv and a.branch=b.tobo;

PROMPT *** Create  grants  ANI_GAPV2 ***
grant SELECT                                                                 on ANI_GAPV2       to BARSREADER_ROLE;
grant SELECT                                                                 on ANI_GAPV2       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_GAPV2       to SALGL;
grant SELECT                                                                 on ANI_GAPV2       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/ANI_GAPV2.sql =========*** End *** ====
PROMPT ===================================================================================== 
