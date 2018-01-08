

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_SWIFT_BANKS.sql ========
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_SWIFT_BANKS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_SWIFT_BANKS ("SWREF", "MT", "IO_IND", "SENDER", "B1_NAME", "RECEIVER", "B2_NAME") AS 
  select j.swref, j.mt, j.io_ind, j.sender, nvl(b1.name,'No data') as b1_name, j.receiver, nvl(b2.name,'No data') as b2_name
from sw_journal j, sw_banks b1, sw_banks b2
where b1.bic(+) = j.sender and b2.bic(+) = j.receiver;

PROMPT *** Create  grants  V_DOCUMENTVIEW_SWIFT_BANKS ***
grant SELECT                                                                 on V_DOCUMENTVIEW_SWIFT_BANKS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_SWIFT_BANKS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_SWIFT_BANKS.sql ========
PROMPT ===================================================================================== 
