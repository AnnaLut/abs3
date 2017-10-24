

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_SWIFT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_SWIFT ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_SWIFT ("SWREF", "MT", "IO_IND", "TRN", "SENDER", "RECEIVER", "VDATE", "DATE_IN") AS 
  SELECT
     swref,
     mt,
     io_ind,
     trn,
     sender,
     receiver,
     vdate,
     date_in
FROM v_sw300_header;

PROMPT *** Create  grants  V_FOREX_SWIFT ***
grant SELECT                                                                 on V_FOREX_SWIFT   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_SWIFT.sql =========*** End *** 
PROMPT ===================================================================================== 
