CREATE OR REPLACE FORCE VIEW BARS.V_OB_CORP_REP_NBS
(
   REP_ID,
   NBS,
   CORP_ID
)
AS
SELECT rep_id, nbs, corp_id
     FROM OB_CORP_REP_NBS n
    WHERE userid = user_id
   UNION ALL
   SELECT rep_id, nbs, to_number(RC.EXTERNAL_ID)
     FROM ob_corp_dict_rep r, ob_corp_dict_nbs d, v_root_corporation rc
    WHERE NOT EXISTS
             (SELECT 1
                FROM OB_CORP_REP_NBS n
               WHERE userid = user_id AND r.rep_id = n.rep_id and n.corp_id = to_number(RC.EXTERNAL_ID));
