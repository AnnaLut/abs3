create or replace view v_nbug_601_protocol as
select  distinct s.report_id,trunc(max(s.session_activity_time),'dd') as date_report, suc.successful_object,unsuc.unsuccessful_object,all_obj.all_object 
from v_nbu_session_history s 
        left join(select report_id,count(*) successful_object from v_nbu_session_history s
                        where  state_id=9
                        group by  report_id) suc on suc.report_id=s.report_id              
        left join(select report_id,count(*) unsuccessful_object from v_nbu_session_history s
                        where  state_id=8
                        group by  report_id) unsuc on unsuc.report_id=s.report_id                        
        left join(select report_id,count(*) all_object from v_nbu_session_history s
                        where   state_id in (8,9)
                        group by  report_id) all_obj on all_obj.report_id=s.report_id                                                                                                                 
group by  s.report_id, suc.successful_object,unsuc.unsuccessful_object,all_obj.all_object;
/
grant all on v_nbug_601_protocol to bars;
grant all on v_nbug_601_protocol to bars_access_defrole; 
/
