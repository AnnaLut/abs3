create or replace view v_nbug_601_protocol_detail as 
select  distinct trunc(max(s.session_activity_time),'dd') as date_report,s.report_id,s.object_type_name,suc.successful_object,unsuc.unsuccessful_object,all_obj.all_object 
from v_nbu_session_history s 
        left join(select s.object_type_name,count(*) successful_object from v_nbu_session_history s
                        where  state_id=9
                        group by  s.object_type_name) suc on suc.object_type_name=s.object_type_name                  
        left join(select s.object_type_name,count(*) unsuccessful_object from v_nbu_session_history s
                        where  state_id=8
                        group by  s.object_type_name) unsuc on unsuc.object_type_name=s.object_type_name                        
        left join(select s.object_type_name,count(*) all_object from v_nbu_session_history s
                        where   state_id in (8,9)
                        group by s.object_type_name) all_obj on all_obj.object_type_name=s.object_type_name                                                                                                            
group by s.object_type_name,suc.successful_object,unsuc.unsuccessful_object,all_obj.all_object,s.report_id;   
/
grant all on v_nbug_601_protocol_detail to bars;
grant all on v_nbug_601_protocol_detail to bars_access_defrole; 
/
