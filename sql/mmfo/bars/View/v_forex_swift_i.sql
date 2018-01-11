

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_SWIFT_I.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_SWIFT_I ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_SWIFT_I ("SWREF", "MT", "IO_IND", "TRN", "SENDER", "RECEIVER", "VDATE", "DATE_IN") AS 
  SELECT j.swref,
          j.mt,
          j.io_ind,
          j.trn,
          j.sender,
          j.receiver,
          j.vdate,
          j.date_in
     FROM sw_journal j,
          (SELECT io_ind, swref
             FROM sw_journal
            WHERE mt = 300
           MINUS
           SELECT io_ind, swref
             FROM (
                   SELECT 'I' io_ind, swo_ref swref
                     FROM fx_deal
                    WHERE swo_ref IS NOT NULL)) q
    WHERE     j.mt = '300'
          AND j.io_ind='I'
          AND j.swref = q.swref
          AND j.vdate BETWEEN bankdate_g - 7 AND bankdate_g + 7;

PROMPT *** Create  grants  V_FOREX_SWIFT_I ***
grant SELECT                                                                 on V_FOREX_SWIFT_I to BARSREADER_ROLE;
grant SELECT                                                                 on V_FOREX_SWIFT_I to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FOREX_SWIFT_I to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_SWIFT_I.sql =========*** End **
PROMPT ===================================================================================== 
