

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S6_CCK_CONTRACT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view S6_CCK_CONTRACT ***

  CREATE OR REPLACE FORCE VIEW BARS.S6_CCK_CONTRACT ("BIC", "IDCONTRACT", "VIDCONTRAC", "TARGET", "CONTRPAREN", "STRPERCEN", "D_OPEN", "D_CLOSE", "D_BEGIN", "D_DIST", "D_RETURN", "D_CANCEL", "D_MODIFY", "SUMMA", "I_VA", "IDCLIENT", "VID_KRED", "V_MAIN", "N_PROLONG", "C_RISK", "EMITENT", "EMIS", "PAPER", "QUOT", "TERM", "T_KR", "PROLONG", "SOURCE", "PERREP", "N_APPL", "D_APPL", "N_DCC", "D_DCC", "DESCRIPTIO", "ISP_OWNER", "GROUP_C", "STATUS", "ISP_MODIFY", "DOC_MODIFY", "JURIDNUMBE", "METHODCI", "PERIODPR", "EFFECTPRC", "ETALONPRC") AS 
  select "BIC","IDCONTRACT","VIDCONTRAC","TARGET","CONTRPAREN","STRPERCEN","D_OPEN","D_CLOSE","D_BEGIN","D_DIST","D_RETURN","D_CANCEL","D_MODIFY","SUMMA","I_VA","IDCLIENT","VID_KRED","V_MAIN","N_PROLONG","C_RISK","EMITENT","EMIS","PAPER","QUOT","TERM","T_KR","PROLONG","SOURCE","PERREP","N_APPL","D_APPL","N_DCC","D_DCC","DESCRIPTIO","ISP_OWNER","GROUP_C","STATUS","ISP_MODIFY","DOC_MODIFY","JURIDNUMBE","METHODCI","PERIODPR","EFFECTPRC","ETALONPRC"  FROM S6_S6_Contract ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S6_CCK_CONTRACT.sql =========*** End **
PROMPT ===================================================================================== 
