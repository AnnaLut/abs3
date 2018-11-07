create or replace view v_nbu_601_protocol as
select  distinct s.report_id,nvl (suc.date_report,unsuc.date_report) as date_report,suc.successful_object,unsuc.unsuccessful_object,all_obj.all_object
from nbu_gateway.v_nbu_session_history s
        left join(select report_id,count(*) successful_object ,trunc(max(s.SESSION_ACTIVITY_TIME),'dd') as date_report from nbu_gateway.v_nbu_session_history s
                        where  state_id=9 and SESSION_ACTIVITY_TIME>=TO_DATE(pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and  s.SESSION_ACTIVITY_TIME<=TO_DATE(pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy')
                        group by  report_id) suc on suc.report_id=s.report_id
        left join(select report_id,count(*) unsuccessful_object,trunc(max(s.SESSION_ACTIVITY_TIME),'dd') as date_report from nbu_gateway.v_nbu_session_history s
                        where  state_id=8 and SESSION_ACTIVITY_TIME>=TO_DATE(pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and  SESSION_ACTIVITY_TIME<=TO_DATE(pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy')
                        group by  report_id) unsuc on unsuc.report_id=s.report_id
        left join(select report_id,count(*) all_object,trunc(max(s.SESSION_ACTIVITY_TIME),'dd') as date_report from nbu_gateway.v_nbu_session_history s
                        where   state_id in (8,9) and SESSION_ACTIVITY_TIME>=TO_DATE(pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and  SESSION_ACTIVITY_TIME<=TO_DATE(pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy')
                        group by  report_id) all_obj on all_obj.report_id=s.report_id
       where all_obj.all_object is not null;
/
grant select on bars.v_nbu_601_protocol to bars_access_defrole; 
/
