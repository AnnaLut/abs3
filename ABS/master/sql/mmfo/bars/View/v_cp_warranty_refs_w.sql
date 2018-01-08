

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY_REFS_W.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_WARRANTY_REFS_W ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_WARRANTY_REFS_W ("CP_REF", "PAWN", "OPER_REF", "TT", "PDAT", "NLSA", "ACCA", "NLSB", "ACCB", "S", "NAZN") AS 
  SELECT DISTINCT cw.REF,
                   cw.pawn,
                   o.REF,
                   o.tt,
                   o.pdat,
                   o.nlsa,
                   (select acc from accounts where nls = o.nlsa and kv = o.kv) acca,
                   o.nlsb,
                   (select acc from accounts where nls = o.nlsb and kv = o.kv2) accb,
                   o.s,
                   o.nazn
     FROM V_CP_WARRANTY cw,
          accounts a,
          cp_accounts ca,
          cp_payments cp,
          oper o
    WHERE     CW.NLS = a.nls
          AND cw.kv = a.kv
          AND ca.cp_acc = a.acc
          AND ca.cp_ref = cp.cp_ref
          AND cp.cp_ref = cw.REF
          AND cp.op_ref = o.REF
          AND CW.NLS = o.nlsb;

PROMPT *** Create  grants  V_CP_WARRANTY_REFS_W ***
grant SELECT                                                                 on V_CP_WARRANTY_REFS_W to BARSREADER_ROLE;
grant SELECT                                                                 on V_CP_WARRANTY_REFS_W to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CP_WARRANTY_REFS_W to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY_REFS_W.sql =========*** E
PROMPT ===================================================================================== 
