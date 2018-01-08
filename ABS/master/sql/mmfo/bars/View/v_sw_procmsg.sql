

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_PROCMSG.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_PROCMSG ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_PROCMSG ("SWREF", "MT", "TRN", "SENDER_BIC", "SENDER_NAME", "RECEIVER_BIC", "RECEIVER_NAME", "CURRENCY", "AMOUNT", "DATE_REC", "DATE_PAY", "VDATE", "EXPSTATUS") AS 
  SELECT j.swref,
          j.mt,
          j.trn,
          j.sender sender_bic,
          sb1.name sender_name,
          j.receiver receiver_bic,
          sb2.name receiver_name,
          j.currency,
          ABS (j.amount) amount,
          j.date_rec,
          j.date_pay,
          j.vdate,
          bars_swift.msgchk_getexpstatus (j.swref)
     FROM sw_journal j, sw_banks sb1, sw_banks sb2
    WHERE     j.flags IS NOT NULL
          AND j.flags = 'L'
          AND j.sender = sb1.bic
          AND j.receiver = sb2.bic
;

PROMPT *** Create  grants  V_SW_PROCMSG ***
grant SELECT                                                                 on V_SW_PROCMSG    to BARS013;
grant SELECT                                                                 on V_SW_PROCMSG    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_PROCMSG    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_PROCMSG.sql =========*** End *** =
PROMPT ===================================================================================== 
