

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CIM_KL_R030.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CIM_KL_R030 ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CIM_KL_R030 ("KV", "NAME") AS 
  select lpad(kv,3,'0') kv, lcv||' '||name name from tabval where d_close is null;

PROMPT *** Create  grants  V_CIM_KL_R030 ***
grant SELECT                                                                 on V_CIM_KL_R030   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CIM_KL_R030.sql =========*** End *** 
PROMPT ===================================================================================== 
