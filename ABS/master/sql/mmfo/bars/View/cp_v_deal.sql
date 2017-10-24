

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_V_DEAL.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_V_DEAL ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_V_DEAL ("SOS", "ND", "DATD", "SUMB", "DAZS", "TIP", "REF", "ID", "CP_ID", "MDATE", "IR", "ERAT", "RYN", "VIDD", "ACCR", "OSTR", "OSTR_F", "OSTAF", "EMI", "DOX", "RNK", "PF", "PFNAME", "DAPP", "DATP") AS 
  SELECT o.sos, o.nd, o.datd, o.s / 100, a.dazs, k.tip, e.REF, k.ID, k.cp_id,
          k.datp, k.ir, e.erat,                    --ROUND (e.erat*100*365,4),
                               e.ryn, v.vidd,           -- a.kv, a.acc, d.acc,
                                             --       p.acc,
                                             r.acc,                 -- r2.acc,
                                                   --     s.acc, NVL (a.ostc, 0) / 100,
                                                   --     NVL (d.ostc, 0) / 100, NVL (p.ostc, 0) / 100,
                                                   NVL (r.ostc, 0) / 100,
          NVL (r.ostf, 0) / 100,
                                 --       NVL (r2.ostc, 0) / 100, NVL (s.ostc, 0) / 100, NVL (a.ostb, 0) / 100,
                                 NVL (a.ostb + a.ostf, 0) / 100, k.emi, k.dox,
          k.rnk, v.pf, cp.NAME, NVL (a.dapp, a.daos), o.datp
     FROM cp_kod k,
          cp_deal e,
          accounts a,
          accounts d,
          accounts p,
          accounts r,
          accounts r2,
          accounts s,
          cp_vidd v,
          cp_pf cp,
          oper o
    WHERE v.vidd IN (SUBSTR (a.nls, 1, 4), NVL (SUBSTR (p.nls, 1, 4), ''))
      AND o.REF = e.REF
   --   AND o.sos > 0
      AND k.ID = e.ID
      AND a.acc = e.acc
      AND d.acc(+) = e.accd
      AND p.acc(+) = e.accp
      AND r.acc(+) = e.accr
      AND r2.acc(+) = e.accr2
      AND s.acc(+) = e.accs
      AND v.pf = cp.pf
      AND v.emi = k.emi;

PROMPT *** Create  grants  CP_V_DEAL ***
grant SELECT,UPDATE                                                          on CP_V_DEAL       to BARS_ACCESS_DEFROLE;
grant SELECT,UPDATE                                                          on CP_V_DEAL       to CP_ROLE;
grant SELECT                                                                 on CP_V_DEAL       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_V_DEAL.sql =========*** End *** ====
PROMPT ===================================================================================== 
