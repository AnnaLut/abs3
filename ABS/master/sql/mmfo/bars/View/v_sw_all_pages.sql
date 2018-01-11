

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_ALL_PAGES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_ALL_PAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_ALL_PAGES ("N", "SEQ", "TAG", "OPT", "VALUE", "TRN") AS 
  select w.n, w.seq, w.tag, w.opt, w.value, j.trn
             from sw_operw w, sw_journal j
            where w.swref = j.swref
                          order by j.page, w.n;

PROMPT *** Create  grants  V_SW_ALL_PAGES ***
grant SELECT                                                                 on V_SW_ALL_PAGES  to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_ALL_PAGES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_ALL_PAGES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_ALL_PAGES.sql =========*** End ***
PROMPT ===================================================================================== 
