

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_ASYNC_ACTION_PARAM.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  view V_ASYNC_ACTION_PARAM ***

  CREATE OR REPLACE FORCE VIEW BARS.V_ASYNC_ACTION_PARAM ("PARAM_POS", "PARAM_NAME", "PARAM_TYPE", "DEFAULT_VALUE", "USER_PROMPT", "MIN", "MAX", "UI_TYPE", "DIRECTORY", "ACTION_CODE") AS 
  select asp.param_pos,
        ap.param_name,
        ap.param_type,
        ap.default_value,
        ap.user_prompt,
		ap.min,
		ap.max,
		ap.ui_type,
		ap.directory,
        aa.action_code
    from
        async_action aa
    join
        async_sql asq on asq.sql_id = aa.sql_id
    join
        async_sql_param asp on (asp.sql_id = asq.sql_id)
    join
        async_param ap on (ap.param_id = asp.param_id)
    order by
        aa.action_code,
        asp.param_pos;

PROMPT *** Create  grants  V_ASYNC_ACTION_PARAM ***
grant SELECT                                                                 on V_ASYNC_ACTION_PARAM to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_ASYNC_ACTION_PARAM.sql =========*** E
PROMPT ===================================================================================== 
