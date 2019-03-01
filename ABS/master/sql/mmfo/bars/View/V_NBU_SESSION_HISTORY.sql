

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_SESSION_HISTORY.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_SESSION_HISTORY ***

create or replace view v_nbu_session_history as
select "ID","REPORT_ID","OBJECT_ID","OBJECT_TYPE_ID","OBJECT_TYPE_NAME","OBJECT_KF","OBJECT_CODE","OBJECT_NAME","SESSION_CREATION_TIME","SESSION_ACTIVITY_TIME","SESSION_TYPE_ID","SESSION_TYPE_NAME","STATE_ID","SESSION_STATE","SESSION_DETAILS","LAST_ACTIVITY_AT","OBJ","OBJECT_LINK" from nbu_gateway.v_nbu_session_history
where LAST_ACTIVITY_AT>=TO_DATE (pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy')
order by last_activity_at desc, id desc;


PROMPT *** Create  grants  V_NBU_SESSION_HISTORY ***
grant FLASHBACK,SELECT                                                       on V_NBU_SESSION_HISTORY to WR_REFREAD;

grant SELECT                                  on V_NBU_SESSION_HISTORY   to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_SESSION_HISTORY.sql =========*** 
PROMPT ===================================================================================== 
