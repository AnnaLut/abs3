

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NOT_PAID_DOCS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NOT_PAID_DOCS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_NOT_PAID_DOCS ("DOC_ID", "DOC_CODE", "DOC_NUM", "DOC_DT", "DOC_AMNT", "DOC_DESC", "BNK_CODE_A", "ACC_NUM_A", "CCY_ID_A", "BNK_CODE_B", "ACC_NUM_B", "CCY_ID_B") AS 
  select d.REF, d.TT, d.ND, d.DATD, d.S, d.NAZN
     , d.MFOA, d.NLSA, d.KV
     , d.MFOB, d.NLSB, d.KV2
  from OPLDOK t
  join OPER   d
    on ( d.KF = t.KF and d.REF = t.REF )
 where t.FDAT between DAT_NEXT_U(GL.GBD(),-6) and DAT_NEXT_U(GL.GBD(),-1)
   and t.SOS < 5;

PROMPT *** Create  grants  V_NOT_PAID_DOCS ***
grant SELECT                                                                 on V_NOT_PAID_DOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_NOT_PAID_DOCS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NOT_PAID_DOCS.sql =========*** End **
PROMPT ===================================================================================== 
