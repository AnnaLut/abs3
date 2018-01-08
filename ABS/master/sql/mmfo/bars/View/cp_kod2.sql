

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/CP_KOD2.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** Create  view CP_KOD2 ***

  CREATE OR REPLACE FORCE VIEW BARS.CP_KOD2 ("ID", "EMI", "DOX", "CP_ID", "KV", "NAME", "COUNTRY", "DATP", "IR", "TIP", "DAT_EM", "AMORT", "DCP", "CENA", "BASEY", "CENA_KUP", "KY", "DOK", "DNK", "RNK", "PERIOD_KUP", "IDT", "DAT_RR", "PR1_KUP", "PR_AMR", "FIN23", "KAT23", "K23", "VNCRR", "PR_AKT", "METR", "GS", "CENA_KUP0", "CENA_START", "QUOT_SIGN", "DATZR", "DATVK", "IO", "RIVEN", "IN_BR", "EXPIRY", "VNCRP", "ZAL_CP", "PAWN", "HIERARCHY_ID", "FIN_351", "PD") AS 
  select "ID","EMI","DOX","CP_ID","KV","NAME","COUNTRY","DATP","IR","TIP","DAT_EM","AMORT","DCP","CENA","BASEY","CENA_KUP","KY","DOK","DNK","RNK","PERIOD_KUP","IDT","DAT_RR","PR1_KUP","PR_AMR","FIN23","KAT23","K23","VNCRR","PR_AKT","METR","GS","CENA_KUP0","CENA_START","QUOT_SIGN","DATZR","DATVK","IO","RIVEN","IN_BR","EXPIRY","VNCRP","ZAL_CP","PAWN","HIERARCHY_ID","FIN_351","PD" from cp_kod where  CP_KOD.TIP = 2 and CP_KOD.ID > 0;

PROMPT *** Create  grants  CP_KOD2 ***
grant SELECT                                                                 on CP_KOD2         to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/CP_KOD2.sql =========*** End *** ======
PROMPT ===================================================================================== 
