PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/View/V_NBU_FORM_601.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_NBU_FORM_601 ***

 CREATE OR REPLACE FORCE VIEW BARS.V_NBU_FORM_601 ("DATA_TYPE_CODE", "DATA_TYPE_NAME", "KF", "STATE_ID", "SYS_TIME", "TRACKING_MESSAGE", "REQUEST_ID") AS 
 select t.data_type_code,
 t.data_type_name,
 sys_context('bars_context','user_mfo') as kf,
 case when r.state_id = 1 then 'Запуск збору даних'
 when r.state_id = 2 then 'Очікування даних'
 when r.state_id = 3 then 'Збір даних'
 when r.state_id = 4 then 'Помилка при зборі даних'
 when r.state_id = 5 then 'Відправка даних'
 when r.state_id = 6 or t.id in (12,18,5,6,9) then 'Даних не отримано!'
 when r.state_id = 7 then 'Дані сформовано на відправку до ЦА'
 when r.state_id = 8 then 'Дані не отримані'
 when r.state_id = 9 then 'Дані успішно передані до ЦА'
 when r.state_id = 10 then 'Дані до ЦА не передані'
   end state_id,
 r.sys_time,
 decode(r.state_id,4,r.tracking_message,6,r.tracking_message,8,r.tracking_message,10,r.tracking_message,'') as tracking_message,
 r.request_id
 from nbu_data_type_601 t,
 (select r.kf, r.state_id, rt.sys_time, rt.tracking_message, r.data_type_id, rt.request_id
 from nbu_data_request_601 r, nbu_data_request_tracking_601 rt
 where r.kf = sys_context('bars_context','user_mfo')
 and r.report_instance_id = (select max(report_instance_id)
 from nbu_data_request_601
 where kf = r.kf
 and data_type_id = r.data_type_id)
 and r.id = rt.request_id
 and r.state_id = rt.state_id
 and (rt.sys_time) = (select max(sys_time)
 from nbu_data_request_tracking_601
 where request_id = rt.request_id
 and trunc(sys_time) >= trunc(sysdate,'mm'))) r
 where t.id = r.data_type_id(+) and t.data_type_code not in('NBU_W4_BPK','NBU_PROFIT_FO','NBU_FAMILY_FO')
 order by t.id;

PROMPT *** Create  grants  V_NBU_FORM_601 ***
grant FLASHBACK,SELECT                                                       on V_NBU_FORM_601  to WR_REFREAD;
grant SELECT                                  on V_NBU_FORM_601   to BARS_ACCESS_DEFROLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/View/V_NBU_FORM_601.sql =========*** End ***
PROMPT ===================================================================================== 
