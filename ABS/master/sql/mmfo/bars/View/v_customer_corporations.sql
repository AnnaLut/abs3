

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CORPORATIONS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CUSTOMER_CORPORATIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_CUSTOMER_CORPORATIONS ("RNK", "NMK", "EXTERNAL_ID", "CORPORATION_NAME", "ORG_ID", "ORG_NAME") AS 
  select c.RNK,
       c.NMK,
       --cwp.VALUE parent_id,
       vr.EXTERNAL_ID,
       vr.CORPORATION_NAME,
       --vo.base_corp_name,
       --cwc.VALUE child_id,
       vo.EXTERNAL_ID org_id,
       vo.CORPORATION_NAME org_name
from      customer  c
join      customerw cwp on c.RNK = cwp.RNK and cwp.TAG = 'OBPCP'
left join customerw cwc on c.RNK = cwc.RNK and cwc.TAG = 'OBCRP'
left join V_ROOT_CORPORATION vr on vr.EXTERNAL_ID = cwp.VALUE
left join V_ORG_CORPORATIONS vo  on vo.EXTERNAL_ID = cwc.VALUE and vo.base_extid = vr.EXTERNAL_ID
;

PROMPT *** Create  grants  V_CUSTOMER_CORPORATIONS ***
grant SELECT                                                                 on V_CUSTOMER_CORPORATIONS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on V_CUSTOMER_CORPORATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_CUSTOMER_CORPORATIONS to CORP_CLIENT;
grant SELECT                                                                 on V_CUSTOMER_CORPORATIONS to UPLD;
grant FLASHBACK,SELECT                                                       on V_CUSTOMER_CORPORATIONS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_CUSTOMER_CORPORATIONS.sql =========**
PROMPT ===================================================================================== 
