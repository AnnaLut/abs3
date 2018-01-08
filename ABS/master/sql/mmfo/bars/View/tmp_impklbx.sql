

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/TMP_IMPKLBX.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  view TMP_IMPKLBX ***

  CREATE OR REPLACE FORCE VIEW BARS.TMP_IMPKLBX ("FN", "N", "ND", "ERRCODE", "ERRMSG", "KV", "NLSA", "NLSB", "S", "SK", "NAZN", "ID") AS 
  select "FN","N","ND","ERRCODE","ERRMSG","KV","NLSA","NLSB","S","SK","NAZN","ID" from tmp_impklbx_tbl where id  = user_id 
 ;

PROMPT *** Create  grants  TMP_IMPKLBX ***
grant SELECT                                                                 on TMP_IMPKLBX     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IMPKLBX     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IMPKLBX     to OPER000;
grant SELECT                                                                 on TMP_IMPKLBX     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_IMPKLBX     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/TMP_IMPKLBX.sql =========*** End *** ==
PROMPT ===================================================================================== 
