
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/view/v_teller_users.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BARS.V_TELLER_USERS ("USER_ID", "USER_NAME", "BRANCH", "VALID_FROM", "VALID_TO", "SESSION_ID", "ID", "BOSS_LIST", "TOX_FLAG") AS 
  select u."USER_ID",u."USER_NAME",u."BRANCH",u."VALID_FROM",u."VALID_TO",u."SESSION_ID",u."ID", v.userlist as boss_list, u.tox_flag
  from teller_users u,
       v_teller_boss_list v
  where u.user_id = v.user_id
;
 show err;
 
PROMPT *** Create  grants  V_TELLER_USERS ***
grant FLASHBACK,SELECT                                                       on V_TELLER_USERS  to WR_REFREAD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/view/v_teller_users.sql =========*** End ***
 PROMPT ===================================================================================== 
 