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
   IS_PDE
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
          (SELECT 1
             FROM sw_messages swm
            WHERE swm.swref = j.swref AND REGEXP_LIKE (BODY, '{5:.*?{PDE:'))
             AS is_pde
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
          AND J.MT not in ('199','299')
          AND t.lcv(+) = j.currency
   WITH READ ONLY;


--
-- V_SW_IMPMSG  (Synonym) 
--
CREATE OR REPLACE PUBLIC SYNONYM V_SW_IMPMSG FOR BARS.V_SW_IMPMSG;


GRANT SELECT ON BARS.V_SW_IMPMSG TO BARS_ACCESS_DEFROLE;