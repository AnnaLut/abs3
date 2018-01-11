

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/SPECPARAM_CP_OPER.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  view SPECPARAM_CP_OPER ***

  CREATE OR REPLACE FORCE VIEW BARS.SPECPARAM_CP_OPER ("REF", "USERID", "DATD", "NLSA", "NLSB", "S", "NAZN", "CP_IN", "CP_MR") AS 
  with cprefs as ( select op_ref from cp_payments)
SELECT o1.REF,
          o1.userid,
          o1.datd,
          o1.nlsa,
          o1.nlsb,
          o1.s,
          o1.nazn,
          (SELECT VALUE
             FROM operw
            WHERE ref = o1.ref
              and tag = 'CP_IN') as cp_in,
          (SELECT VALUE
             FROM operw
            WHERE ref = o1.ref
              and tag = 'CP_MR') as cp_mr
     FROM oper o1, cprefs,
          (SELECT a.nls
             FROM accounts a, cp_accounts ca, specparam_cp_ob sp
            WHERE sp.acc = ca.cp_acc
              AND a.acc = ca.cp_acc
              and a.acc = sp.acc
             /* AND a.nbs between '6000' and '6999'*/)
          a1
    WHERE cprefs.op_ref = o1.ref
          AND o1.sos = 5
          AND (o1.nlsa = a1.nls OR o1.nlsb = a1.nls);

PROMPT *** Create  grants  SPECPARAM_CP_OPER ***
grant SELECT                                                                 on SPECPARAM_CP_OPER to BARSREADER_ROLE;
grant FLASHBACK,SELECT                                                       on SPECPARAM_CP_OPER to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPECPARAM_CP_OPER to UPLD;
grant FLASHBACK,SELECT                                                       on SPECPARAM_CP_OPER to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/SPECPARAM_CP_OPER.sql =========*** End 
PROMPT ===================================================================================== 
