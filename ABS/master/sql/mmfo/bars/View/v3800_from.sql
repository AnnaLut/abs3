CREATE OR REPLACE FORCE VIEW BARS.V3800_FROM AS
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
    

GRANT SELECT ON BARS.V3800_FROM TO BARS_ACCESS_DEFROLE;
