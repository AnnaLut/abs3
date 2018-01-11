

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_W4_PROECT_SAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_W4_PROECT_SAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_W4_PROECT_SAL ("ID", "NAME", "OKPO", "PRODUCT_CODE", "PRODUCT_NAME", "GRP_CODE") AS 
  select b.id, b.name, b.okpo, p.code, p.name, p.grp_code
  from bpk_proect b, w4_product p
 where b.product_code = p.code
   and p.grp_code in ('SALARY', 'PENSION')
   and nvl(b.used_w4,0) = 1;

PROMPT *** Create  grants  V_W4_PROECT_SAL ***
grant SELECT                                                                 on V_W4_PROECT_SAL to BARSREADER_ROLE;
grant SELECT                                                                 on V_W4_PROECT_SAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_W4_PROECT_SAL to OW;
grant SELECT                                                                 on V_W4_PROECT_SAL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_W4_PROECT_SAL.sql =========*** End **
PROMPT ===================================================================================== 
