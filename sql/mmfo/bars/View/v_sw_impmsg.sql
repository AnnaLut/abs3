

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_IMPMSG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_IMPMSG ***

CREATE OR REPLACE FORCE VIEW BARS.V_SW_IMPMSG
(
   SWREF,
   MT,
   TRN,
   SENDER,
   SENDER_NAME,
   RECEIVER,
   RECEIVER_NAME,
   PAYER,
   PAYEE,
   CURRENCY,
   KV,
   DIG,
   AMOUNT,
   ACCD,
   ACCK,
   IO_IND,
   DATE_IN,
   DATE_OUT,
   DATE_REC,
   DATE_PAY,
   VDATE,
   ID,
   FIO,
   TRANSIT,
   TAG20,
   is_pde
)
AS
   SELECT /*+ FIRST_ROWS(100)*/
         j.swref,
          j.mt,
          j.trn,
          j.sender,
          sb1.name sender_name,
          j.receiver,
          sb2.name receiver_name,
          j.payer,
          j.payee,
          j.currency,
          t.kv,
          t.dig,
          j.amount,
          j.accd,
          j.acck,
          j.io_ind,
          j.date_in,
          j.date_out,
          j.date_rec,
          j.date_pay,
          j.vdate,
          j.id,
          i.fio,
          j.transit,
          (SELECT SUBSTR (VALUE, 1, 150)
             FROM sw_operw
            WHERE tag = '21' AND swref = j.swref)
             tag20,
          (select 1 from sw_messages swm
            where  swm.swref= j.swref and  regexp_like (BODY,  '{5:.*?{PDE:') )  as is_pde
 
     FROM sw_journal j,
          tabval t,
          staff i,
          sw_banks sb1,
          sw_banks sb2
    WHERE     DECODE (j.date_pay, NULL, 1, NULL) = 1
          AND j.id = i.id(+)
          AND j.sender = sb1.bic
          AND j.receiver = sb2.bic
          AND j.mt NOT IN (SELECT mt FROM sw_stmt)
          AND J.MT !=199
          AND t.lcv(+) = j.currency
   WITH READ ONLY;

PROMPT *** Create  grants  V_SW_IMPMSG ***
grant SELECT                                                                 on V_SW_IMPMSG     to BARS013;
grant SELECT                                                                 on V_SW_IMPMSG     to BARSREADER_ROLE;
grant SELECT                                                                 on V_SW_IMPMSG     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_IMPMSG     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_SW_IMPMSG     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_IMPMSG.sql =========*** End *** ==
PROMPT ===================================================================================== 
