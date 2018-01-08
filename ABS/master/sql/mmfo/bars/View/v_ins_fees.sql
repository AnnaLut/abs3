

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_INS_FEES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_INS_FEES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_INS_FEES ("FEE_ID", "NAME", "MIN_VALUE", "PERC_VALUE", "MAX_VALUE", "PER_CNT") AS 
  select f.id as fee_id,
       f.name,
       f.min_value,
       f.perc_value,
       f.max_value,
       (select count(*) from ins_fee_periods fp where fp.fee_id = f.id) as per_cnt
  from ins_fees f
 order by f.id;

PROMPT *** Create  grants  V_INS_FEES ***
grant SELECT                                                                 on V_INS_FEES      to BARSREADER_ROLE;
grant SELECT                                                                 on V_INS_FEES      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_INS_FEES      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_INS_FEES.sql =========*** End *** ===
PROMPT ===================================================================================== 
