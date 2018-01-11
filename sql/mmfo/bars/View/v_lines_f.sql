

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_LINES_F.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** Create  view V_LINES_F ***

  CREATE OR REPLACE FORCE VIEW BARS.V_LINES_F ("FN", "DAT", "N", "MFO", "OKPO", "RTYPE", "OTYPE", "ODATE", "NLS", "NLSM", "KV", "RESID", "NMKK", "C_REG", "NTAX", "ID_O", "SIGN", "ERR", "DAT_IN_DPA", "DAT_ACC_DPA", "ID_PR", "ID_DPA", "ID_DPS", "ID_REC", "FN_R", "DATE_R", "N_R", "KF", "ADR") AS 
  select "FN","DAT","N","MFO","OKPO","RTYPE","OTYPE","ODATE","NLS","NLSM","KV","RESID","NMKK","C_REG","NTAX","ID_O","SIGN","ERR","DAT_IN_DPA","DAT_ACC_DPA","ID_PR","ID_DPA","ID_DPS","ID_REC","FN_R","DATE_R","N_R","KF","ADR"
  from lines_f f
 where otype in (1,6)
   and dat = (select max(dat) from lines_f where nls=f.nls and kv=f.kv and otype in (1,6))
 union all
select "FN","DAT","N","MFO","OKPO","RTYPE","OTYPE","ODATE","NLS","NLSM","KV","RESID","NMKK","C_REG","NTAX","ID_O","SIGN","ERR","DAT_IN_DPA","DAT_ACC_DPA","ID_PR","ID_DPA","ID_DPS","ID_REC","FN_R","DATE_R","N_R","KF","ADR"
  from lines_f f
 where otype in (3,5)
   and dat = (select max(dat) from lines_f where nls=f.nls and kv=f.kv and otype in (3,5));

PROMPT *** Create  grants  V_LINES_F ***
grant SELECT                                                                 on V_LINES_F       to BARSREADER_ROLE;
grant SELECT                                                                 on V_LINES_F       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_LINES_F       to CC_DOC;
grant SELECT                                                                 on V_LINES_F       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on V_LINES_F       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_LINES_F.sql =========*** End *** ====
PROMPT ===================================================================================== 
