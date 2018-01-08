

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_DOCS_SALDO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  view V_DOCS_SALDO ***

  CREATE OR REPLACE FORCE VIEW BARS.V_DOCS_SALDO ("REF", "TT", "USERID", "ND", "NLSA", "S", "S_", "LCV", "KV", "VDAT", "PDAT", "S2", "S2_", "LCV2", "KV2", "MFOB", "NLSB", "DK", "SK", "DATD", "NAZN", "TOBO", "SOS") AS 
  SELECT
	unique(op.REF), op.TT, op.USERID, op.ND, op.NLSA, op.S, op.S/power(10,t1.DIG), t1.LCV, op.KV, op.VDAT,
	op.PDAT, op.S2, op.S2/power(10,t2.DIG), t2.LCV, op.KV2, op.MFOB, op.NLSB, op.DK, op.SK, op.DATD,
	op.NAZN, op.TOBO, op.SOS
FROM OPLDOK o, OPER op, SALDO s, TABVAL t1, TABVAL t2
WHERE s.ACC = o.ACC and o.REF = op.REF and t1.KV = op.KV and t2.KV = op.KV2
 ;

PROMPT *** Create  grants  V_DOCS_SALDO ***
grant SELECT                                                                 on V_DOCS_SALDO    to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_DOCS_SALDO    to WR_ALL_RIGHTS;
grant SELECT                                                                 on V_DOCS_SALDO    to WR_DOCLIST_SALDO;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_DOCS_SALDO.sql =========*** End *** =
PROMPT ===================================================================================== 
