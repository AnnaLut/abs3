CREATE OR REPLACE FORCE VIEW "BARS"."V_ORG_CORPORATIONS" ("BASE_EXTID", "BASE_CORP_NAME", "ID", "EXTERNAL_ID", "CORPORATION_NAME", "PARENT_ID", "STATE_ID", "CORPORATION_CODE") AS 
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
/
  GRANT SELECT ON "BARS"."V_ORG_CORPORATIONS" TO "CORP_CLIENT";
  GRANT SELECT ON "BARS"."V_ORG_CORPORATIONS" TO "BARS_ACCESS_DEFROLE";
/