

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/A_S180.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** Create  view A_S180 ***

  CREATE OR REPLACE FORCE VIEW BARS.A_S180 ("BRANCH", "RNK", "VIDD", "ND", "CC_ID", "SDATE", "WDATE", "R180", "O180", "S180", "KV", "NLS", "NAME", "KVP", "NLSP") AS 
  select
   tobo,rnk,vidd, s,cc_id,SDATE,WDATE,substr(nbs,1,1),substr(nbs,2,1),substr(nbs,3,1),
   kv, nls, name, ratn, to_char(ROW_NUM)
from CCK_AN_TMP_UPB;

PROMPT *** Create  grants  A_S180 ***
grant SELECT                                                                 on A_S180          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on A_S180          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on A_S180          to SALGL;
grant SELECT                                                                 on A_S180          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/A_S180.sql =========*** End *** =======
PROMPT ===================================================================================== 
