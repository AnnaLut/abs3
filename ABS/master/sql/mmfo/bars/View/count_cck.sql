

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/COUNT_CCK.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view COUNT_CCK ***

  CREATE OR REPLACE FORCE VIEW BARS.COUNT_CCK ("GRAA", "GRA", "GRB", "GR1", "GR2", "GR3", "GR4", "GR5", "GR51", "DAT1", "DAT2") AS 
  select  NLSALT GRAA,
        pr||'.'|| decode (prs, null, null, prs||'.') ||  decode (kv , null, null, kv ) GRA,
        name GRB , n1 GR1, n2 GR2, n3 GR3, n4 GR4, uv GR5,  n5 GR51 ,
        to_date( pul.Get_Mas_Ini_Val('sFdat1'),'dd.mm.yyyy') dat1,
        to_date( pul.Get_Mas_Ini_Val('sFdat2'),'dd.mm.yyyy') dat2
from CCK_AN_TMP
order by pr, prs, kv;

PROMPT *** Create  grants  COUNT_CCK ***
grant SELECT                                                                 on COUNT_CCK       to BARSREADER_ROLE;
grant SELECT                                                                 on COUNT_CCK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on COUNT_CCK       to START1;
grant SELECT                                                                 on COUNT_CCK       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/COUNT_CCK.sql =========*** End *** ====
PROMPT ===================================================================================== 
