

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_MKK.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PRODUCT_MKK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PRODUCT_MKK ("PRODUCT_CODE", "PRODUCT_NAME", "SUB_CODE", "SUB_NAME", "CARD_CODE") AS 
  select t.product_code, t.product_name, t.sub_code, t.sub_name, t.card_code
  from v_w4_product t
 where t.grp_code = 'INSTANT_MMSB' and t.kv = 980 and t.nbs = '2605';

PROMPT *** Create  grants  V_W4_PRODUCT_MKK ***
grant SELECT                                                                 on V_W4_PRODUCT_MKK to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_PRODUCT_MKK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PRODUCT_MKK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PRODUCT_MKK.sql =========*** End *
PROMPT ===================================================================================== 
