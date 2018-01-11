

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_SW_JOURNAL.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_SW_JOURNAL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_SW_JOURNAL ("SWREF", "MT", "TRN", "IO_IND", "CURRENCY", "SENDER", "RECEIVER", "PAYER", "PAYEE", "AMOUNT", "ACCD", "ACCK", "DATE_IN", "DATE_OUT", "NLS_D", "NLS_K", "DATE_PAY", "DATE_REC", "VDATE", "ID", "PAGE", "TRANSIT", "SOS", "SW_OPER_REF", "SW_950_REF") AS 
  SELECT SW_JOURNAL.SWREF,   SW_JOURNAL.MT,      SW_JOURNAL.TRN ,
        SW_JOURNAL.IO_IND,  SW_JOURNAL.CURRENCY,SW_JOURNAL.SENDER,SW_JOURNAL.RECEIVER,
        SW_JOURNAL.PAYER,   SW_JOURNAL.PAYEE,   SW_JOURNAL.AMOUNT/100 AMOUNT,SW_JOURNAL.ACCD,SW_JOURNAL.ACCK,
        to_char(SW_JOURNAL.DATE_IN, 'dd.mm.yyyy HH24:MI:SS') DATE_IN, to_char(SW_JOURNAL.DATE_OUT, 'dd.mm.yyyy HH24:MI:SS') DATE_OUT,d.nls NLS_D,      k.nls NLS_K,
        SW_JOURNAL.DATE_PAY,SW_JOURNAL.DATE_REC,SW_JOURNAL.VDATE, SW_JOURNAL.ID,
        SW_JOURNAL.PAGE,    SW_JOURNAL.TRANSIT, SW_JOURNAL.SOS , (SELECT ref FROM sw_oper WHERE swref=SW_JOURNAL.SWREF) sw_oper_ref,
        (SELECT swref FROM sw_950 WHERE swref=SW_JOURNAL.SWREF and done=1) sw_950_ref
   FROM SW_JOURNAL, accounts d, accounts k
  WHERE SW_JOURNAL.accd=d.acc (+) and SW_JOURNAL.acck=k.acc (+) AND SW_JOURNAL.VDATE>=trunc(sysdate)-30
  ORDER BY SW_JOURNAL.swref desc;

PROMPT *** Create  grants  V_SW_JOURNAL ***
grant SELECT                                                                 on V_SW_JOURNAL    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_SW_JOURNAL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_SW_JOURNAL    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_SW_JOURNAL.sql =========*** End *** =
PROMPT ===================================================================================== 
