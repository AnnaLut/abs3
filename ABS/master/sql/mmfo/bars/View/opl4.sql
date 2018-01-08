

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/OPL4.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view OPL4 ***

  CREATE OR REPLACE FORCE VIEW BARS.OPL4 ("REF", "KV", "NLS", "S", "SQ") AS 
  SELECT o.REF, a.KV, a.NLS, o.S/100, o.SQ/100
from opldok o, accounts a, sos0que s
where o.ref=s.ref and o.acc=a.acc and o.sos=4
 ;

PROMPT *** Create  grants  OPL4 ***
grant SELECT                                                                 on OPL4            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OPL4            to TECH005;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/OPL4.sql =========*** End *** =========
PROMPT ===================================================================================== 
