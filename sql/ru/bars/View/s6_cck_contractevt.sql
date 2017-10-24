

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S6_CCK_CONTRACTEVT.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view S6_CCK_CONTRACTEVT ***

  CREATE OR REPLACE FORCE VIEW BARS.S6_CCK_CONTRACTEVT ("ID", "IDVID_CALE", "BIC", "IDCONTRACT", "D_OPEN", "D_PLAN", "D_FACT", "SUMMA", "DA_OD", "ID_OPER", "ID_DOCUM", "IDDOC", "IDMETHOD", "ISP_MODIFY", "D_MODIFY", "DESCRIPTIO", "I_VA", "ISP_EXEC", "ISP_OWNER", "ISP_VERIFY") AS 
  SELECT "ID","IDVID_CALE","BIC","IDCONTRACT","D_OPEN","D_PLAN","D_FACT","SUMMA","DA_OD","ID_OPER","ID_DOCUM","IDDOC","IDMETHOD","ISP_MODIFY","D_MODIFY","DESCRIPTIO","I_VA","ISP_EXEC","ISP_OWNER","ISP_VERIFY"
     FROM S6_S6_ContractEVT ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S6_CCK_CONTRACTEVT.sql =========*** End
PROMPT ===================================================================================== 
