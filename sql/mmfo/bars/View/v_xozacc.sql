CREATE OR REPLACE FORCE VIEW BARS.V_XOZACC  AS
SELECT a.RNK,  a.ob22,  a.ACC, a.KV, a.NLS, a.NMS, a.ISP, a.BRANCH, c.nmk, c.custtype TYPE, null s180, a.OSTC, NVL(x.KC,0) KOL, NVL(x.SC,0) S,
     (-a.ostc+NVL(x.SC,0)) DEL, a.OSTB, NVL(x.KB,0) KOLB,  NVL(x.SB,0) SB, (-a.ostB+NVL(x.SB,0)) DELB,  'Àðõiâ' ARC,  a.NBS||a.ob22 prod,
     ( SELECT MAX (fdat)  FROM saldoa  WHERE acc = a.acc AND ostf >= 0 AND ostf-dos+kos <= 0 ) DAT0
FROM customer c,
     (SELECT RNK, ob22, ACC, KV, NLS, NMS, ISP, tobo BRANCH, -ostc/100 OSTC, -(ostb+ostf)/100 OSTB, nbs  
      FROM accounts   WHERE tip IN ('XOZ', 'W4X') ) a,
     (SELECT acc, SUM(kc) kc, SUM(kb) kb, SUM(sc)/100 sc, SUM(sb)/100 sb FROM (SELECT r.acc, 1 KC, 1 KB, r.s SC, r.s SB FROM xoz_ref r WHERE r.s > 0 AND r.ref2 IS NULL)  GROUP BY acc) x
 WHERE a.rnk = c.rnk   AND a.acc = x.acc(+)   AND (a.ostc <> 0 OR NVL (x.SC, 0) <> 0 OR a.ostb <> 0);
/


GRANT SELECT ON BARS.V_XOZACC TO BARS_ACCESS_DEFROLE;
/