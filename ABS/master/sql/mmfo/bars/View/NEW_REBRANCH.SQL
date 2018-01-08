

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/NEW_REBRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view NEW_REBRANCH ***

  CREATE OR REPLACE FORCE VIEW BARS.NEW_REBRANCH ("BR_OLD", "NLSO", "NMSO", "S", "BR_NEW", "NLSN", "NAZN", "KV", "OB22") AS 
  select branch BR_OLD,
       nls    NLSO,
       nms    NMSO,
       ostc/100 S,
       Substr(PUL.get('BRN'), 1, 15) BR_NEW,
       nbs_ob22_bra (nbs,ob22, Substr(PUL.get('BRN'), 1, 15)  ) NLSN ,
       substr( PUL.get('NZN'),1,160) NAZN, KV, ob22
from accounts
where dazs is null and branch = PUL.get('BRO') and substr(nbs,1,1) in ('6','7') ;

PROMPT *** Create  grants  NEW_REBRANCH ***
grant SELECT                                                                 on NEW_REBRANCH    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on NEW_REBRANCH    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/NEW_REBRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
