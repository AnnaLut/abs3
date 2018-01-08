

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_SEARCHMSG.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_SEARCHMSG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_SEARCHMSG ("SWREF", "IO_IND", "MT", "TRN", "SENDER", "RECEIVER", "CURRENCY", "AMOUNT", "DATE_REC", "DATE_PAY", "VDATE", "REF") AS 
  select j.swref, j.io_ind, j.mt, j.trn, j.sender, j.receiver,
       j.currency, j.amount, j.date_rec, j.date_pay,
	   j.vdate, o.ref
 from sw_journal j, sw_oper o
where j.swref = o.swref(+)
with read only
 ;

PROMPT *** Create  grants  V_SW_SEARCHMSG ***
grant SELECT                                                                 on V_SW_SEARCHMSG  to BARS013;
grant SELECT                                                                 on V_SW_SEARCHMSG  to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_SEARCHMSG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_SEARCHMSG  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_SEARCHMSG  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_SEARCHMSG.sql =========*** End ***
PROMPT ===================================================================================== 
