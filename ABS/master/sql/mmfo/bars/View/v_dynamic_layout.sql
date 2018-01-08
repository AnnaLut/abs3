

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DYNAMIC_LAYOUT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DYNAMIC_LAYOUT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DYNAMIC_LAYOUT ("ID", "DK", "NAME", "NLS", "BS", "OB", "NAZN", "DATP", "ALG", "GRP") AS 
  select id,
  nvl(dk,1) dk,
  name,
  nls,
  bs1 bs,
  ob1 ob,
  nazn1 nazn,
  datp,
  alg,
  grp
from ope_lot
where  ob22 = '~~' ;

PROMPT *** Create  grants  V_DYNAMIC_LAYOUT ***
grant SELECT                                                                 on V_DYNAMIC_LAYOUT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DYNAMIC_LAYOUT.sql =========*** End *
PROMPT ===================================================================================== 
