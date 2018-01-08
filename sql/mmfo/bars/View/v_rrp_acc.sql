

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_RRP_ACC.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_RRP_ACC ***

  CREATE OR REPLACE FORCE VIEW BARS.V_RRP_ACC ("ORD", "TIP", "OST") AS 
  SELECT 1, 'MAX', ostf-lim FROM lkl_rrp
                  WHERE lkl_rrp.mfo=(select val from params where par='MFOP') AND lkl_rrp.kv  = 980
        UNION ALL SELECT 2, 'L00', ostf FROM lkl_rrp
                  WHERE lkl_rrp.mfo=(select val from params where par='MFOP') AND lkl_rrp.kv  = 980
        UNION ALL SELECT 3, 'LIM', lim FROM lkl_rrp
                  WHERE lkl_rrp.mfo=(select val from params where par='MFOP') AND lkl_rrp.kv  = 980;

PROMPT *** Create  grants  V_RRP_ACC ***
grant SELECT                                                                 on V_RRP_ACC       to BARSREADER_ROLE;
grant SELECT                                                                 on V_RRP_ACC       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_RRP_ACC       to START1;
grant SELECT                                                                 on V_RRP_ACC       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_RRP_ACC.sql =========*** End *** ====
PROMPT ===================================================================================== 
