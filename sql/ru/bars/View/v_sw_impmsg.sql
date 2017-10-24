

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_IMPMSG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_IMPMSG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_IMPMSG ("SWREF", "MT", "TRN", "SENDER", "SENDER_NAME", "RECEIVER", "RECEIVER_NAME", "PAYER", "PAYEE", "CURRENCY", "KV", "DIG", "AMOUNT", "ACCD", "ACCK", "IO_IND", "DATE_IN", "DATE_OUT", "DATE_REC", "DATE_PAY", "VDATE", "ID", "FIO", "TRANSIT") AS 
  select /*+ FIRST_ROWS(100)*/
       j.swref, j.mt, j.trn, j.sender, sb1.name sender_name,
       j.receiver, sb2.name receiver_name, j.payer, j.payee,
       j.currency, t.kv, t.dig, j.amount, j.accd, j.acck,
       j.io_ind, j.date_in, j.date_out, j.date_rec,
       j.date_pay, j.vdate, j.id, i.fio, j.transit
  from sw_journal j, tabval t, staff i, sw_banks sb1, sw_banks sb2
 where decode(j.date_pay, null, 1, null) = 1
   and j.id = i.id(+)
   and j.sender   = sb1.bic
   and j.receiver = sb2.bic
   and j.mt not in (select mt from sw_stmt)
   and t.lcv(+)   = j.currency
with read only;

PROMPT *** Create  grants  V_SW_IMPMSG ***
grant SELECT                                                                 on V_SW_IMPMSG     to BARS013;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_IMPMSG     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_IMPMSG.sql =========*** End *** ==
PROMPT ===================================================================================== 
