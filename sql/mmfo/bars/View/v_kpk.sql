

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_KPK.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_KPK ***

  CREATE OR REPLACE FORCE VIEW BARS.V_KPK ("KV", "LCV", "NAME", "TOBO", "NAMET", "VDATE", "BSUM", "RATE_B", "RATE_S", "RATE_O", "VDATEO") AS 
  SELECT c.kv,
            t.lcv,
            t.name,
            b.branch,
            b.name namet,
            c.vdate,
            c.bsum,
            c.rate_b,
            c.rate_s,
            ROUND (c.RATE_O, 4) RATE_O,
            c.vdate VDATEO
       FROM bars.tabval t, bars.cur_rates$base c, bars.branch b
      WHERE t.kv = c.kv AND c.vdate >= bars.bankdate () AND c.branch = b.branch
      and b.branch like sys_context('bars_context','user_branch_mask')
   ORDER BY 6, 1,4;

PROMPT *** Create  grants  V_KPK ***
grant SELECT                                                                 on V_KPK           to BARSREADER_ROLE;
grant SELECT                                                                 on V_KPK           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_KPK           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_KPK.sql =========*** End *** ========
PROMPT ===================================================================================== 
