

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_PERSON_FO.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CONSOLIDATED_PERSON_FO ***

  CREATE OR REPLACE FORCE VIEW NBU_GATEWAY.V_CONSOLIDATED_PERSON_FO ("REPORT_ID", "SESSION_CREATION_TIME", "SESSION_ACTIVITY_TIME", "REQUEST_ID", "RNK", "LASTNAME", "FIRSTNAME", "MIDDLENAME", "ISREZ", "INN", "BIRTHDAY", "COUNTRYCODNEREZ", "K060", "PERSON_CODE", "STATUS", "STATUS_MESSAGE", "KF", "K020", "CODDOCUM", "ISKR", "CODREGION", "AREA", "ZIP", "CITY", "STREETADDRESS", "HOUSENO", "ADRKORP", "FLATNO") AS 
  select s.report_id,
       (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
       (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       f.request_id,f.rnk,f.lastname,f.firstname,f.middlename,f.isrez,f.inn,f.birthday,f.countrycodnerez,f.k060,f.person_code,f.status,f.status_message,f.kf,f.k020,f.coddocum,f.iskr
       ,f.codregion,f.area,f.zip,f.city,f.streetaddress,f.houseno,f.adrkorp,f.flatno
       from nbu_session s
            join  nbu_reported_object o on o.id = s.object_id
            join (select fo.*, c.core_customer_kf,c.core_customer_id,c.id,a.codregion,a.area,a.zip,a.city,a.streetaddress,a.houseno,a.adrkorp,a.flatno
                  from nbu_reported_customer c,
                      core_person_fo fo,core_address_fo a
                        where fo.request_id=(select max(request_id) from core_person_fo f where c.core_customer_id=f.rnk and f.status='ACCEPTED')
                        and a.request_id=(select max(request_id) from core_address_fo a where a.rnk=c.core_customer_id)
                        and fo.default_person_id=c.core_customer_id and fo.status='ACCEPTED'
                        and a.rnk=fo.default_person_id)f on f.id = s.object_id
       where o.object_type_id = 1 --and s.report_id=(select max(report_id) from nbu_session)
             and s.state_id=2;

grant all privileges on v_consolidated_person_fo to bars;
grant all privileges on v_consolidated_person_fo to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_PERSON_FO.sql ===
PROMPT ===================================================================================== 
