

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_PROECT_KK.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_PROECT_KK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_PROECT_KK ("ID", "NAME", "OKPO", "PRODUCT_CODE", "PRODUCT_NAME", "GRP_CODE") AS 
  select b.id, b.name, b.okpo, p.code, p.name, p.grp_code
  from bpk_proect b, v_w4_product_kk p
 where b.product_code = p.code
   and p.grp_code = 'SALARY'
   and nvl(b.used_w4,0) = 1;

PROMPT *** Create  grants  V_BPK_PROECT_KK ***
grant SELECT                                                                 on V_BPK_PROECT_KK to BARSREADER_ROLE;
grant SELECT                                                                 on V_BPK_PROECT_KK to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_BPK_PROECT_KK to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_PROECT_KK.sql =========*** End **
PROMPT ===================================================================================== 
