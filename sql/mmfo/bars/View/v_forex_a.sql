

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_A ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_A ("NTIK", "DAT", "RNK", "DEAL_TAG", "REFA", "DAT_A", "ACCA", "KVA", "NLSA", "NETA", "SA", "DETALI", "REFB", "DAT_B", "ACCB", "KVB", "NLSB", "NETB", "SB") AS 
  SELECT   a.ntik, a.DAT, a.rnk, a.DEAL_TAG, a.refa, a.dat_a, a.acc ACCA, a.KVA, a.nlsA, a.neta, a.Sa/100 SA, a.detali,
          b.refb, b.dat_b, b.acc ACCB, b.KVB, b.nlsB, b.netb, b.Sb/100 SB
 FROM (SELECT x.ntik, x.DAT, x.rnk, x.DEAL_TAG, x.refa, x.dat_a, aa.acc, aa.kv KVA, aa.nls NLSA, aa.nlsalt, x.neta,
              x.detali,   -SUM (DECODE (o.dk, 0, -1, +1) * o.s) Sa
       FROM opldok o, accounts aa,  FX_DEAL_REF r,
            (SELECT * FROM fx_deal WHERE  dat_a >= gl.bd AND dat_b >= gl.bd) x,
            (select nvl(substr(val,1,4),'') val from params where par='BICCODE') s
       WHERE substr(x.kodb,1,4)<>s.val  AND x.kodb <> gl.kf
         AND aa.nbs  = '3540'
         AND aa.acc  = o.acc
         AND o.fdat >= x.dat
         AND o.REF   = r.REF
         AND r.DEAL_TAG = x.DEAL_TAG
         AND aa.kv   = x.kva
         AND o.sos   > 0 and o.tt<>'FXK'
         and ( o.ref not in ( nvl(x.refa,0), nvl(x.refb,0), nvl(x.refb,0) ) or o.sos>=4)
       GROUP BY x.ntik,x.DAT,x.rnk, x.DEAL_TAG, x.refa, x.dat_a, aa.acc, aa.kv, aa.nls, aa.nlsalt, x.neta, x.detali
      ) a,
      (SELECT                       x.DEAL_TAG, x.refb, x.dat_b, ab.acc, ab.kv KVB, ab.nls NLSB,  x.netb,  SUM (DECODE (o.dk, 0, -1, +1) * o.s) Sb
       FROM opldok o, accounts ab,  FX_DEAL_REF r,
            (SELECT * FROM fx_deal WHERE  dat_a >= gl.bd AND dat_b >= gl.bd) x,
            (select nvl(substr(val,1,4),'') val from params where par='BICCODE') s
       WHERE substr(x.kodb,1,4)<>s.val  AND x.kodb <> gl.kf
         AND ab.nbs  = '3640'
         AND ab.acc  = o.acc
         AND o.fdat >= x.dat
         AND o.REF   = r.REF
         AND r.DEAL_TAG = x.DEAL_TAG
         AND ab.kv   = x.kvB
         AND o.sos   > 0 and o.tt<>'FXK'
         and ( o.ref not in ( nvl(x.refa,0), nvl(x.refb,0),  nvl(x.refb2,0) )  or o.sos>=4)
       GROUP BY                     x.DEAL_TAG, x.refb, x.dat_b, ab.acc, ab.kv, ab.nls,  x.netb
       ) b
 WHERE a.DEAL_TAG = b.DEAL_TAG
;

PROMPT *** Create  grants  V_FOREX_A ***
grant SELECT                                                                 on V_FOREX_A       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_FOREX_A       to FOREX;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_A.sql =========*** End *** ====
PROMPT ===================================================================================== 
