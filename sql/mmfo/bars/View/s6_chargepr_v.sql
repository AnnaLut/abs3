

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/S6_CHARGEPR_V.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  view S6_CHARGEPR_V ***

  CREATE OR REPLACE FORCE VIEW BARS.S6_CHARGEPR_V ("NLS", "I_VA", "PercenRate", "DA", "SERV_DB_S", "SERV_KR_S", "SERV_I_VA") AS 
  select NLS,I_VA,"PercenRate",DA,serv_db_s,serv_kr_s,serv_i_va
from "S6_ChargePr" where (NLS,I_VA,DA) in (     
select NLS,I_VA,max(DA) from "S6_ChargePr" group by NLS,I_VA) 
 ;

PROMPT *** Create  grants  S6_CHARGEPR_V ***
grant SELECT                                                                 on S6_CHARGEPR_V   to BARSREADER_ROLE;
grant SELECT                                                                 on S6_CHARGEPR_V   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S6_CHARGEPR_V   to START1;
grant SELECT                                                                 on S6_CHARGEPR_V   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/S6_CHARGEPR_V.sql =========*** End *** 
PROMPT ===================================================================================== 
