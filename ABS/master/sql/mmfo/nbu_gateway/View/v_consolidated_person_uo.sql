

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_PERSON_UO.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CONSOLIDATED_PERSON_UO ***

  CREATE OR REPLACE FORCE VIEW V_CONSOLIDATED_PERSON_UO as 
  select s.report_id,
      (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
      (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       f."REQUEST_ID",f."RNK",f."NAMEUR",f."ISREZ",f."CODEDRPOU",f."REGISTRYDAY",f."NUMBERREGISTRY",f."K110",f."EC_YEAR",f."COUNTRYCODNEREZ",f."ISMEMBER",f."ISCONTROLLER",f."ISPARTNER",f."ISAUDIT",f."K060",f."COMPANY_CODE",f."DEFAULT_COMPANY_KF",f."DEFAULT_COMPANY_ID",f."COMPANY_OBJECT_ID",f."STATUS",f."STATUS_MESSAGE",f."KF",f."K020",f."CODDOCUM",f."ISKR",f."CORE_CUSTOMER_KF",f."CORE_CUSTOMER_ID",f."ID"
       from nbu_session s
            join  nbu_reported_object o on o.id = s.object_id
            join (select uo.*, c.core_customer_kf,c.core_customer_id,c.id
                   from nbu_reported_customer c,core_person_uo uo 
                   where uo.request_id=(select max(request_id) from core_person_uo u where c.core_customer_id=u.rnk and u.status='ACCEPTED' )
                   and uo.default_company_id=c.core_customer_id and uo.status='ACCEPTED')f
                   on f.id = s.object_id
       where o.object_type_id = 2 --and s.report_id=(select max(report_id) from nbu_session)
        and s.state_id in (2);
        grant all privileges on V_CONSOLIDATED_PERSON_UO to bars;
        grant all privileges on V_CONSOLIDATED_PERSON_UO to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_PERSON_UO.sql ===
PROMPT ===================================================================================== 
