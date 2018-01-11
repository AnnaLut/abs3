

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_GROUPS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCT_GROUPS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCT_GROUPS ("CODE", "NAME") AS 
  select code, name
  from w4_product_groups
 where code not in ('INSTANT', 'CORPORATE', 'INSTANT_MMSB') -- oa?ai 'LOCAL' ii  COBUSUPABS-4290 ---aiaaaeaiu 'CORPORATE','INSTANT_MMSB'  - ii COBUSUPABS-4580
 order by code
;

PROMPT *** Create  grants  V_W4_PRODUCT_GROUPS ***
grant SELECT                                                                 on V_W4_PRODUCT_GROUPS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PRODUCT_GROUPS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_GROUPS.sql =========*** En
PROMPT ===================================================================================== 
