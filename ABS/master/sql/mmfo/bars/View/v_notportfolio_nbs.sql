

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOTPORTFOLIO_NBS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOTPORTFOLIO_NBS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOTPORTFOLIO_NBS ("NBS", "XAR", "PAP", "NAME", "CLASS", "CHKNBS", "AUTO_STOP", "D_CLOSE", "SB") AS 
  select p.nbs, p.xar, p.pap, p.name, p.class, p.chknbs, p.auto_stop, p.d_close, p.sb
from   ps p
join   notportfolio_nbs n on p.nbs = n.nbs
where  n.userid = sys_context('bars_global', 'user_id') or
       n.userid is null;

PROMPT *** Create  grants  V_NOTPORTFOLIO_NBS ***
grant SELECT                                                                 on V_NOTPORTFOLIO_NBS to BARSREADER_ROLE;
grant SELECT                                                                 on V_NOTPORTFOLIO_NBS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOTPORTFOLIO_NBS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOTPORTFOLIO_NBS.sql =========*** End
PROMPT ===================================================================================== 
