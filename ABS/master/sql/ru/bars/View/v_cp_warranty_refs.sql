

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY_REFS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CP_WARRANTY_REFS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CP_WARRANTY_REFS ("CP_REF", "PAWN", "OPER_REF", "TT", "PDAT", "NLSA", "NLSB", "S", "NAZN") AS 
  SELECT DISTINCT cw.REF,
                cw.pawn,
                o.ref,
                o.tt,
                o.pdat,
                o.nlsa,
                o.nlsb,
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
       and CW.NLS = o.nlsb;

PROMPT *** Create  grants  V_CP_WARRANTY_REFS ***
grant SELECT                                                                 on V_CP_WARRANTY_REFS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CP_WARRANTY_REFS.sql =========*** End
PROMPT ===================================================================================== 
