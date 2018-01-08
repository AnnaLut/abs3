

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_DECREPITNOTES.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_AGREEMENTS_DECREPITNOTES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_AGREEMENTS_DECREPITNOTES ("AGR_ID", "DPT_ID", "DPT_NUM", "DPT_DAT", "DPT_AMOUNT", "DPT_CURCODE", "DPT_CURGENDER", "DECREPIT_AMOUNT", "DECREPIT_PERCENT", "DECREPIT_PENALTY") AS 
  select a.agrmnt_id, d.deposit_id, d.nd, d.datz, d.limit, v.kv, nvl(v.gender,'M'),
       a.denom_amount, round((a.denom_amount/d.limit)*100, 2), denom_count
  from dpt_agreements a, dpt_deposit d, tabval v
 where a.agrmnt_type = 14
   and a.dpt_id = d.deposit_id
   and d.kv = v.kv
 ;

PROMPT *** Create  grants  V_DPT_AGREEMENTS_DECREPITNOTES ***
grant SELECT                                                                 on V_DPT_AGREEMENTS_DECREPITNOTES to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_DECREPITNOTES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_DECREPITNOTES to DPT_ROLE;
grant SELECT                                                                 on V_DPT_AGREEMENTS_DECREPITNOTES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_AGREEMENTS_DECREPITNOTES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_AGREEMENTS_DECREPITNOTES.sql ====
PROMPT ===================================================================================== 
