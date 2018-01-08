

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_XOZREF_INV.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_XOZREF_INV ***

  CREATE OR REPLACE FORCE VIEW BARS.V_XOZREF_INV ("DATZ", "ACC", "KV", "NLS", "OB22", "BRANCH", "NMS", "OSTC", "REF1", "STMT1", "FDAT", "S", "MDATE", "S240", "S180", "NAZN", "MFOB", "NLSB", "NAM_B", "ID_B") AS 
  SELECT a.DATZ , a.ACC  , a.kv  , a.nls     , a.ob22, a.branch, a.nms,  a.OSTC,
       x.ref1, x.stmt1, x.fdat, x.s/100 S , x.mdate, (x.MDATE-a.DATZ ) s240,  (x.MDATE-x.fdat) s180,
       o.nazn, o.mfob, o.nlsb, o.nam_b, o.id_b
FROM xoz_ref x,   oper o,
  (select dd.DATZ, aa.acc, aa.kv, aa.nls, aa.ob22, aa.nbs, aa.nbs||aa.ob22 PROD, aa.branch, aa.nms, - OST_KORR(aa.acc, dd.DATZ-1 , null, aa.nbs) /100 OSTC
   from accounts aa, ( select NVL( to_date ( PUL.get('DATZ'), 'dd.mm.yyyy') , GL.BD) DATZ  from dual ) dd
   where aa.tip in ('XOZ','W4X')
   ) a
WHERE x.fdat < a.DATZ and x.s > 0  AND (x.DATZ is null or x.DATZ >= a.DATZ )   AND x.acc = a.acc AND x.ref1 = o.REF;

PROMPT *** Create  grants  V_XOZREF_INV ***
grant SELECT                                                                 on V_XOZREF_INV    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_XOZREF_INV    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_XOZREF_INV.sql =========*** End *** =
PROMPT ===================================================================================== 
