

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_TECH_ACCOUNTS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  view V_TECH_ACCOUNTS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_TECH_ACCOUNTS ("NLS", "NAM", "REC", "REF", "MFOA", "NLSA", "MFOB", "NLSB", "DK", "S", "VOB", "ND", "KV", "DATD", "DATP", "NAM_A", "NAM_B", "NAZN", "NAZNK", "NAZNS", "ID_A", "ID_B", "ID_O", "REF_A", "BIS", "SIGN", "FN_A", "DAT_A", "REC_A", "FN_B", "DAT_B", "REC_B", "D_REC", "BLK", "SOS", "PRTY", "FA_NAME", "FA_LN", "FA_T_ARM3", "FA_T_ARM2", "FC_NAME", "FC_LN", "FC_T1_ARM2", "FC_T2_ARM2", "FB_NAME", "FB_LN", "FB_T_ARM2", "FB_T_ARM3", "FB_D_ARM3", "KF") AS 
  select '' nls, '' nam, a."REC",a."REF",a."MFOA",a."NLSA",a."MFOB",a."NLSB",a."DK",a."S",a."VOB",a."ND",a."KV",a."DATD",a."DATP",a."NAM_A",a."NAM_B",a."NAZN",a."NAZNK",a."NAZNS",a."ID_A",a."ID_B",a."ID_O",a."REF_A",a."BIS",a."SIGN",a."FN_A",a."DAT_A",a."REC_A",a."FN_B",a."DAT_B",a."REC_B",a."D_REC",a."BLK",a."SOS",a."PRTY",a."FA_NAME",a."FA_LN",a."FA_T_ARM3",a."FA_T_ARM2",a."FC_NAME",a."FC_LN",a."FC_T1_ARM2",a."FC_T2_ARM2",a."FB_NAME",a."FB_LN",a."FB_T_ARM2",a."FB_T_ARM3",a."FB_D_ARM3",a."KF" from arc_rrp a where 1=0;

PROMPT *** Create  grants  V_TECH_ACCOUNTS ***
grant SELECT                                                                 on V_TECH_ACCOUNTS to BARSREADER_ROLE;
grant SELECT                                                                 on V_TECH_ACCOUNTS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_TECH_ACCOUNTS.sql =========*** End **
PROMPT ===================================================================================== 
