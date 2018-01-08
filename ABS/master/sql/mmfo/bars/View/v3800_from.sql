

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V3800_FROM.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V3800_FROM ***

  CREATE OR REPLACE FORCE VIEW BARS.V3800_FROM ("BRANCH", "OB22", "NLS", "NMS", "PLAN", "FAKT", "ACC", "RATE_K", "RATE_P", "KV", "RATE_O", "N", "K", "Q", "FF", "FT", "REFF", "REFT") AS 
  SELECT a.Branch, a.ob22, a.nls, a.nms, a.ostb / 100 PLAN, a.ostc / 100 FAKT, a.acc, p.rate_k, p.rate_p,   a.kv KV,
          (gl.p_icurval(a.kv, 1000000, gl.bd) / 1000000)  RATE_O ,
          TO_NUMBER (DECODE (a.acc, PUL.get ('ACCF'), PUL.get ('N'), '0')) N,
          TO_NUMBER (DECODE (a.acc, PUL.get ('ACCF'), PUL.get ('K'), '0')) K,
          TO_NUMBER (DECODE (a.acc, PUL.get ('ACCF'), PUL.get ('Q'), '0')) Q,
          DECODE (a.acc, PUL.get ('ACCF'), 1, 0) FF,
          DECODE (a.acc, PUL.get ('ACCT'), 1, 0) FT,
          TO_NUMBER (PUL.get ('REFF')) REFF,
          TO_NUMBER (PUL.get ('REFT')) REFT
     FROM accounts a, (SELECT acc, rate_k, rate_p from spot p1 WHERE p1.vdate = (SELECT MAX (vdate) FROM spot    WHERE acc = p1.acc)) p
    WHERE a.kv = PUL.get ('KV')   AND a.acc = p.acc(+)  AND EXISTS   (SELECT 1  FROM vp_list WHERE acc3800 = a.acc)  AND a.dazs IS NULL;

PROMPT *** Create  grants  V3800_FROM ***
grant SELECT                                                                 on V3800_FROM      to BARSREADER_ROLE;
grant SELECT                                                                 on V3800_FROM      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V3800_FROM      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V3800_FROM.sql =========*** End *** ===
PROMPT ===================================================================================== 
