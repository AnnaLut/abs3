

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_BUHMODEL.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCUMENTVIEW_BUHMODEL ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCUMENTVIEW_BUHMODEL ("REF", "SOS", "FDAT", "TT", "NLS", "KV", "DOS", "KOS", "NMS", "TXT", "BRANCH") AS 
  select o.ref, o.sos, o.fdat, o.tt, a.nls, a.kv,
       decode(o.dk, 0, o.s, null)/power(10, t.dig) as dos,
       decode(o.dk, 1, o.S, null)/power(10, t.dig) as kos,
       a.nms, o.txt, '' as branch
from opldok o, accounts a, tabval t
where o.acc = a.acc and a.kv = t.kv
order by o.fdat, a.kv, o.stmt, o.tt, o.dk;

PROMPT *** Create  grants  V_DOCUMENTVIEW_BUHMODEL ***
grant SELECT                                                                 on V_DOCUMENTVIEW_BUHMODEL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_DOCUMENTVIEW_BUHMODEL to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCUMENTVIEW_BUHMODEL.sql =========**
PROMPT ===================================================================================== 
