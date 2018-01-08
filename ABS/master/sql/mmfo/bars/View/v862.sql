

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V862.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** Create  view V862 ***

  CREATE OR REPLACE FORCE VIEW BARS.V862 ("ACC8", "ACC6", "ACC2", "NLS8", "NLS6", "NLS2", "OST8", "OST6", "OST2", "KV", "NMS", "OST", "DAZS8", "DAZS6", "DAZS2", "PR8", "PR6", "PR2", "PRE") AS 
  select a8.acc, a6.acc, a2.acc, a8.nls, a6.nls, a2.nls, a8.ostc, a6.ostc,
          a2.ostc, a6.kv, a6.nms, a6.ostc + a8.ostc, a8.dazs, a6.dazs,
          a2.dazs, acrn.fproc (a8.acc), acrn.fproc (a6.acc),
          acrn.fproc (a2.acc), 0
-- прежде чем делить необходимо проверить на 0
--     round((acrn.fproc(a8.acc)*a8.ostc-acrn.fproc(a2.acc)*a2.ostc-
--     acrn.fproc(a6.acc)*a6.ostc)/(a8.ostc-a2.ostc-a6.ostc),2)
   from   accounts a2, accounts a8, accounts a6
    where a2.nbs = 2000
      and a8.nbs = 8000
      and a6.nbs = 2600
      and a2.kv = a6.kv
      and a6.kv = a8.kv
      and SUBSTR (a2.nls, 6, 9) = SUBSTR (a8.nls, 6, 9)
      and SUBSTR (a6.nls, 6, 9) = SUBSTR (a8.nls, 6, 9)
 ;

PROMPT *** Create  grants  V862 ***
grant SELECT                                                                 on V862            to BARSREADER_ROLE;
grant SELECT                                                                 on V862            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V862            to OPERKKK;
grant SELECT                                                                 on V862            to START1;
grant SELECT                                                                 on V862            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V862            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V862.sql =========*** End *** =========
PROMPT ===================================================================================== 
