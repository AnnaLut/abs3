

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SALB_GL.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view SALB_GL ***

  CREATE OR REPLACE FORCE VIEW BARS.SALB_GL ("ACCC", "ACC", "NLS", "KV", "NMS", "FDAT", "DOS", "KOS", "OST", "NBS", "ISP", "NLSALT", "DAZS", "DAPP", "TIP", "TOBO") AS 
  select a.accc, a.acc, a.nls, a.kv, a.nms, b.fdat,
          decode (s.fdat, b.fdat, s.dos, 0),
          decode (s.fdat, b.fdat, s.kos, 0), s.ostf - s.dos + s.kos, a.nbs,
          a.isp, a.nlsalt, a.dazs, s.fdat, a.tip, a.tobo
     from v_gl a, saldob s, fdat b
    where a.kv <> 980
      and a.acc = s.acc
      and (a.acc, s.fdat) = (select   c.acc, max (c.fdat)
                                 from saldob c
                                where a.acc = c.acc and c.fdat <= b.fdat
                             group by c.acc)
 ;

PROMPT *** Create  grants  SALB_GL ***
grant SELECT                                                                 on SALB_GL         to BARSREADER_ROLE;
grant SELECT                                                                 on SALB_GL         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SALB_GL         to RPBN001;
grant SELECT                                                                 on SALB_GL         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SALB_GL         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SALB_GL.sql =========*** End *** ======
PROMPT ===================================================================================== 
