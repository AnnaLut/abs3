

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_SWIFT_O.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_SWIFT_O ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_SWIFT_O ("SWREF", "MT", "IO_IND", "TRN", "SENDER", "RECEIVER", "VDATE", "DATE_IN", "AMOUNT") AS 
  SELECT j.swref,
          j.mt,
          j.io_ind,
          j.trn,
          j.sender,
          j.receiver,
          j.vdate,
          j.date_in,
          j.amount/100 amount
        FROM sw_journal j,
          (SELECT io_ind, swref
             FROM sw_journal
            WHERE mt = 300
           MINUS
           SELECT io_ind, swref
             FROM (SELECT 'O' io_ind, swi_ref swref
                     FROM fx_deal
                    WHERE swi_ref IS NOT NULL)
                   ) q
    WHERE     j.mt = '300'
          AND j.io_ind='O'
          AND j.swref = q.swref
          AND j.vdate BETWEEN bankdate_g - 7 AND bankdate_g + 7;

PROMPT *** Create  grants  V_FOREX_SWIFT_O ***
grant SELECT                                                                 on V_FOREX_SWIFT_O to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_SWIFT_O.sql =========*** End **
PROMPT ===================================================================================== 
