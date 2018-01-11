

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LINES_P.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LINES_P ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LINES_P ("FN", "DAT", "N", "MFO", "BANK_OKPO", "NB", "OKPO", "RTYPE", "OTYPE", "ODATE", "NLS", "RESID", "NMKK", "C_REG", "NTAX", "ADR", "ERR", "DAT_IN_DPA", "DAT_ACC_DPA", "ID_PR", "ID_DPA", "ID_DPS", "ID_REC", "FN_R", "DATE_R", "N_R", "KF", "ID") AS 
  select "FN","DAT","N","MFO","BANK_OKPO","NB","OKPO","RTYPE","OTYPE","ODATE","NLS","RESID","NMKK","C_REG","NTAX","ADR","ERR","DAT_IN_DPA","DAT_ACC_DPA","ID_PR","ID_DPA","ID_DPS","ID_REC","FN_R","DATE_R","N_R","KF","ID" from lines_p p
where dat=(select max(dat) from lines_p where nls=p.nls and otype=p.otype);

PROMPT *** Create  grants  V_LINES_P ***
grant SELECT                                                                 on V_LINES_P       to BARSREADER_ROLE;
grant SELECT                                                                 on V_LINES_P       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_LINES_P       to CC_DOC;
grant SELECT                                                                 on V_LINES_P       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LINES_P.sql =========*** End *** ====
PROMPT ===================================================================================== 
