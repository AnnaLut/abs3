CREATE OR REPLACE FORCE VIEW BARS.V_XOZREF_INV AS
SELECT a.DATZ, a.ACC , a.kv  , a.nls  , a.ob22, a.branch, a.nms, a.OSTC, x.ref1, x.stmt1, x.fdat, x.s0/100 S, x.mdate, (x.MDATE-a.DATZ) s240, (x.MDATE-x.fdat) s180,
       o.nazn, o.mfob, o.nlsb, o.nam_b, o.id_b, a.rnk, c.nmk, 
       decode ( a.kv,980, x.s0, gl.p_icurval(a.kv, x.s0, a.datZ) ) /100 SQ
FROM xoz_ref x,   oper o, customer c,
    (SELECT dd.DATZ,   aa.acc, aa.rnk, aa.kv, aa.nls, aa.ob22, aa.nbs, aa.nbs||aa.ob22 PROD, aa.branch, aa.nms,  -OST_KORR(aa.acc,(dd.DATZ-1), NULL,aa.nbs)/100  OSTC
     FROM accounts aa,      (SELECT NVL (TO_DATE (PUL.get ('DATZ'), 'dd.mm.yyyy'), GL.BD)  DATZ  FROM DUAL) dd
     WHERE aa.tip IN ('XOZ', 'W4X')
    ) a
WHERE a.rnk = c.rnk and x.fdat < a.DATZ  AND x.s > 0  AND (x.DATZ IS NULL OR x.DATZ >= a.DATZ)     
  AND x.acc = a.acc   AND x.ref1 = o.REF;


GRANT SELECT ON BARS.V_XOZREF_INV TO BARS_ACCESS_DEFROLE;
GRANT SELECT ON BARS.V_XOZREF_INV TO UPLD;

