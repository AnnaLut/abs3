

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_FOREX_NETTING.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_FOREX_NETTING ***

  CREATE OR REPLACE FORCE VIEW BARS.V_FOREX_NETTING ("NTIK", "DAT", "RNK", "NMK", "DEAL_TAG", "DETALI", "REF", "REFA", "DAT_A", "ACCA", "KVA", "NLSA", "NETA", "SA", "REFB", "DAT_B", "ACCB", "KVB", "NLSB", "NETB", "SB") AS 
  SELECT a.ntik,
          a.DAT,
          a.rnk,
          a.nmk,
          a.DEAL_TAG,
          a.detali,
          b.REF,
          a.refa,
          a.dat_a,
          a.acc ACCA,
          a.KVA,
          a.nlsA,
          a.neta,
          a.Sa / 100 SA,
          b.refb,
          b.dat_b,
          b.acc ACCB,
          b.KVB,
          b.nlsB,
          b.netb,
          b.Sb / 100 SB
     FROM (  SELECT x.ntik,
                    x.DAT,
                    x.rnk,
                    c.nmk,
                    x.DEAL_TAG,
                    x.refa,
                    x.dat_a,
                    aa.acc,
                    aa.kv KVA,
                    aa.nls NLSA,
                    aa.nlsalt,
                    x.neta,
                    x.detali,
                    -SUM (DECODE (o.dk, 0, -1, +1) * o.s) Sa
               FROM opldok o,
                    FX_DEAL_REF r,
                    (SELECT *
                       FROM accounts
                      WHERE nls = '18199') aa,
                    (SELECT *
                       FROM fx_deal
                      WHERE     dat_a >= gl.bd
                            AND NVL (kodb, '*') NOT LIKE 'COSB%'
                            AND NVL (kodb, '*') <> '300465') x,
                     CUSTOMER c
              WHERE     aa.acc = o.acc
                    AND o.fdat = x.dat_a
                    AND o.REF = r.REF
                    AND r.DEAL_TAG = x.DEAL_TAG
                    AND aa.kv = x.kva
                    AND o.tt <> 'FXK'
                    AND (   o.REF NOT IN (NVL (x.refa, 0), NVL (x.refb, 0))
                         OR o.sos >= 4)
                    AND c.rnk=x.rnk
           GROUP BY x.ntik,
                    x.DAT,
                    x.rnk,
                    c.nmk,
                    x.DEAL_TAG,
                    x.refa,
                    x.dat_a,
                    aa.acc,
                    aa.kv,
                    aa.nls,
                    aa.nlsalt,
                    x.neta,
                    x.detali) A,
          (  SELECT x.REF,
                    c.nmk,
                    x.DEAL_TAG,
                    x.refb,
                    x.dat_b,
                    ab.acc,
                    ab.kv KVB,
                    ab.nls NLSB,
                    x.netb,
                    SUM (DECODE (o.dk, 0, -1, +1) * o.s) Sb
               FROM opldok o,
                    FX_DEAL_REF r,
                    (SELECT *
                       FROM accounts
                      WHERE nls = '19198') ab,
                    (SELECT *
                       FROM fx_deal
                      WHERE     dat_b >= gl.bd
                            AND NVL (kodb, '*') NOT LIKE 'COSB%'
                            AND NVL (kodb, '*') <> '300465') x,
                     CUSTOMER c
              WHERE     ab.acc = o.acc
                    AND o.fdat = x.dat_b
                    AND o.REF = r.REF
                    AND r.DEAL_TAG = x.DEAL_TAG
                    AND ab.kv = x.kvB
                    AND o.tt <> 'FXK'
                    AND (   o.REF NOT IN (NVL (x.refa, 0), NVL (x.refb, 0))
                         OR o.sos >= 4)
                    and c.rnk=x.rnk
           GROUP BY x.REF,
                    c.nmk,
                    x.DEAL_TAG,
                    x.refb,
                    x.dat_b,
                    ab.acc,
                    ab.kv,
                    ab.nls,
                    x.netb) B
    WHERE a.DEAL_TAG = b.DEAL_TAG AND (A.SA <> 0 OR B.SB <> 0);

PROMPT *** Create  grants  V_FOREX_NETTING ***
grant SELECT                                                                 on V_FOREX_NETTING to BARSREADER_ROLE;
grant SELECT,UPDATE                                                          on V_FOREX_NETTING to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on V_FOREX_NETTING to FOREX;
grant SELECT,UPDATE                                                          on V_FOREX_NETTING to START1;
grant SELECT                                                                 on V_FOREX_NETTING to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_FOREX_NETTING.sql =========*** End **
PROMPT ===================================================================================== 
