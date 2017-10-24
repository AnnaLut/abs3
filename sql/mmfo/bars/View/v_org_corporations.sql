

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ORG_CORPORATIONS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ORG_CORPORATIONS ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ORG_CORPORATIONS ("BASE_EXTID", "BASE_CORP_NAME", "ID", "EXTERNAL_ID", "CORPORATION_NAME", "PARENT_ID", "STATE_ID", "CORPORATION_CODE") AS 
  select --connect_by_root ID as base_id,
       connect_by_root EXTERNAL_ID as base_extid,
       connect_by_root CORPORATION_NAME as base_corp_name,
       t.ID,
       t.EXTERNAL_ID,
       t.CORPORATION_NAME,
       t.PARENT_ID,
       t.state_id,
       t.corporation_code
  from OB_CORPORATION t
start with t.PARENT_ID is null
connect by prior id = parent_id
;

PROMPT *** Create  grants  V_ORG_CORPORATIONS ***
grant SELECT                                                                 on V_ORG_CORPORATIONS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on V_ORG_CORPORATIONS to CORP_CLIENT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ORG_CORPORATIONS.sql =========*** End
PROMPT ===================================================================================== 
