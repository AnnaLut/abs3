

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZREF_ADD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZREF_ADD ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZREF_ADD ("NLS", "ACC", "REF", "STMT", "TT", "FDAT", "S", "NAZN") AS 
  select pul.get('XOZ_NLS') NLS,   s.acc, o.ref, o.stmt, o.tt, o.fdat, o.s/100 s, (select nazn from oper where ref = o.ref) nazn
from opldok o,
     (select * from saldoa where acc = pul.get('XOZ_ACC') and dos > 0) s
where o.dk = 0 and o.sos = 5 and o.acc = s.acc and o.fdat = s.fdat
  and not exists ( select 1 from xoz_ref where ref1= o.ref and stmt1 = o.stmt and acc = s.acc) ;

PROMPT *** Create  grants  V_XOZREF_ADD ***
grant SELECT                                                                 on V_XOZREF_ADD    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZREF_ADD    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZREF_ADD.sql =========*** End *** =
PROMPT ===================================================================================== 
