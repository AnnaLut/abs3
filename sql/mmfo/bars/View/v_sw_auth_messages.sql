

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_AUTH_MESSAGES.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_AUTH_MESSAGES ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_AUTH_MESSAGES ("LAU_ACT", "SWREF", "MT", "IO_IND", "TRN", "CURRENCY", "SENDER", "RECEIVER", "AMOUNT", "DATE_IN") AS 
  select
       lau_act, swref, mt, io_ind, trn,
       currency, sender, receiver, amount, date_in
  from sw_journal
 where lau_act = 0
   and imported = 'Y'
with read only
 ;

PROMPT *** Create  grants  V_SW_AUTH_MESSAGES ***
grant SELECT                                                                 on V_SW_AUTH_MESSAGES to BARS013;
grant SELECT                                                                 on V_SW_AUTH_MESSAGES to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_AUTH_MESSAGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_AUTH_MESSAGES to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_AUTH_MESSAGES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_AUTH_MESSAGES.sql =========*** End
PROMPT ===================================================================================== 
