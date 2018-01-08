

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SPECPARAM_CP_V.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view SPECPARAM_CP_V ***

  CREATE OR REPLACE FORCE VIEW BARS.SPECPARAM_CP_V ("NLS", "KV", "DAOS", "DAZS", "ACC", "MARKET", "INITIATOR", "NMS") AS 
  select a.nls,a.kv,a.daos,a.dazs,s.acc, s.MARKET, s.INITIATOR,a.nms 
from accounts a, SPECPARAM_CP_OB s where a.acc=s.acc;

PROMPT *** Create  grants  SPECPARAM_CP_V ***
grant SELECT                                                                 on SPECPARAM_CP_V  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPECPARAM_CP_V  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM_CP_V  to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPECPARAM_CP_V  to START1;
grant SELECT                                                                 on SPECPARAM_CP_V  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPECPARAM_CP_V  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SPECPARAM_CP_V  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SPECPARAM_CP_V.sql =========*** End ***
PROMPT ===================================================================================== 
