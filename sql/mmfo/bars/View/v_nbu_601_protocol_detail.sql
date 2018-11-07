create or replace view v_nbu_601_protocol_detail as
select distinct nvl (suc.date_report,unsuc.date_report) as date_report,s.report_id,s.object_type_name,suc.successful_object,unsuc.unsuccessful_object,all_obj.all_object
from nbu_gateway.v_nbu_session_history s
        left join(select s.object_type_name,count(*) successful_object,trunc(max(s.SESSION_ACTIVITY_TIME),'dd') as date_report,report_id from nbu_gateway.v_nbu_session_history s
                        where  state_id=9 and SESSION_ACTIVITY_TIME>=TO_DATE(pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and  SESSION_ACTIVITY_TIME<=TO_DATE(pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy')
                        group by  s.object_type_name,report_id) suc on suc.object_type_name=s.object_type_name and  suc.report_id=s.report_id
        left join(select s.object_type_name,count(*) unsuccessful_object,trunc(max(s.SESSION_ACTIVITY_TIME),'dd') as date_report,report_id from nbu_gateway.v_nbu_session_history s
                        where  state_id=8 and SESSION_ACTIVITY_TIME>=TO_DATE(pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and  SESSION_ACTIVITY_TIME<=TO_DATE(pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy')
                        group by  s.object_type_name,report_id) unsuc on unsuc.object_type_name=s.object_type_name and  unsuc.report_id=s.report_id
        left join(select s.object_type_name,count(*) all_object,report_id from nbu_gateway.v_nbu_session_history s
                        where   state_id in (8,9) and SESSION_ACTIVITY_TIME>=TO_DATE(pul.get_mas_ini_val ('sFdat1'), 'dd.mm.yyyy') and  SESSION_ACTIVITY_TIME<=TO_DATE(pul.get_mas_ini_val ('sFdat2'),'dd.mm.yyyy')
                        group by s.object_type_name,report_id) all_obj on all_obj.object_type_name=s.object_type_name and  all_obj.report_id=s.report_id
         where all_obj.all_object is not null;
/
grant select on v_nbu_601_protocol_detail to bars_access_defrole; 
/
		 
