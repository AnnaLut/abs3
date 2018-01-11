

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DPT_NO_INHERITORS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DPT_NO_INHERITORS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DPT_NO_INHERITORS ("DPT_ID", "DPT_NUM", "DPT_DAT", "VIDD_CODE", "VIDD_NAME", "RATE", "DAT_BEGIN", "DAT_END", "DPT_SALDO", "DPT_CURCODE", "INT_SALDO", "INT_CURCODE", "OWNER_ID", "OWNER_NAME") AS 
  select d.dpt_id, d.dpt_num, d.dpt_dat, d.vidd_code, d.vidd_name, d.rate, d.dat_begin, d.dat_end,
       d.dpt_saldo, d.dpt_curcode, d.int_saldo, d.int_curcode, d.cust_id, d.cust_name
  from v_dpt_portfolio_active d
 where not exists (select h.dpt_id from dpt_inheritors h where h.dpt_id = d.dpt_id)
 ;

PROMPT *** Create  grants  V_DPT_NO_INHERITORS ***
grant SELECT                                                                 on V_DPT_NO_INHERITORS to BARSREADER_ROLE;
grant SELECT                                                                 on V_DPT_NO_INHERITORS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DPT_NO_INHERITORS to DPT_ROLE;
grant SELECT                                                                 on V_DPT_NO_INHERITORS to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DPT_NO_INHERITORS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DPT_NO_INHERITORS.sql =========*** En
PROMPT ===================================================================================== 
