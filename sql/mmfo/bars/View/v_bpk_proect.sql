

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_BPK_PROECT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_BPK_PROECT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_BPK_PROECT ("ID", "NAME", "OKPO", "PRODUCT_CODE", "PRODUCT_NAME", "GRP_CODE") AS 
  select -1, '*Власна картка', null, null, null, g.code
  from w4_product_groups g
 where code <> 'SALARY'
 union all
select b.id, b.name, b.okpo, p.code, p.name, p.grp_code
  from bpk_proect b, w4_product p
 where b.product_code = p.code
   and p.grp_code = 'SALARY'
   and nvl(b.used_w4,0) = 1;
grant select on BARS.V_BPK_PROECT to BARSREADER_ROLE;
PROMPT *** Create  grants  V_BPK_PROECT ***
grant SELECT                                                                 on V_BPK_PROECT    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_BPK_PROECT.sql =========*** End *** =
PROMPT ===================================================================================== 
