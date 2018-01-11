

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_FDZ_REFS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_FDZ_REFS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_FDZ_REFS ("CP_REF", "OPER_REF", "TT", "PDAT", "NLSA", "NLSB", "S", "NAZN") AS 
  SELECT DISTINCT e.REF,
                   o.REF,
                   o.tt,
                   o.pdat,
                   o.nlsa,
                   o.nlsb,
                   o.s,
                   o.nazn
     FROM cp_kod k,
          cp_deal e,
          accounts a,
          accounts a0,
          cp_accounts cpa,
          cp_ryn cr,
          oper o
    WHERE     o.REF = e.REF
          AND k.ID = e.ID
          AND a.acc = e.acc
          AND a0.acc = a.accc
          AND e.REF = cpa.cp_ref
          AND e.ryn = cr.ryn
          AND e.REF IN (  SELECT cp_ref
                            FROM cp_accounts
                        GROUP BY cp_ref
                          HAVING COUNT (cp_ref) > 1)
          AND CR.QUALITY = -1;

PROMPT *** Create  grants  V_CP_FDZ_REFS ***
grant SELECT                                                                 on V_CP_FDZ_REFS   to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_FDZ_REFS   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_FDZ_REFS   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_FDZ_REFS.sql =========*** End *** 
PROMPT ===================================================================================== 
