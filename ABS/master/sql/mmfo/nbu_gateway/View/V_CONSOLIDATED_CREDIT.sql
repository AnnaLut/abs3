

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_CREDIT.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CONSOLIDATED_CREDIT ***

  CREATE OR REPLACE FORCE VIEW V_CONSOLIDATED_CREDIT as 
  select s.report_id,
       (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
       (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       nvl((select distinct NAMEUR from core_person_uo uo where uo.rnk=f.rnk ),
             (select  distinct lastname||' '|| FIRSTNAME ||' '||MIDDLENAME from core_person_fo fo where fo.rnk=f.rnk and fo.kf=f.kf )) NMK,
             f."REQUEST_ID",f."RNK",f."ND",f."ORDERNUM",f."FLAGOSOBA",f."TYPECREDIT",f."NUMDOG",f."DOGDAY",f."ENDDAY",f."SUMZAGAL",f."R030",f."PROCCREDIT",f."SUMPAY",f."PERIODBASE",f."PERIODPROC",f."SUMARREARS",f."ARREARBASE",f."ARREARPROC",f."DAYBASE",f."DAYPROC",f."FACTENDDAY",f."FLAGZ",f."KLASS",f."RISK",f."FLAGINSURANCE",f."DEFAULT_LOAN_KF",f."DEFAULT_LOAN_ID",f."LOAN_OBJECT_ID",f."STATUS",f."STATUS_MESSAGE",f."KF",f."LOAN_CODE",f.kf as "CORE_CUSTOMER_KF",f.kf as "CORE_CUSTOMER_ID",f."ID"
             from   nbu_session s
                    join  nbu_reported_object o on o.id = s.object_id
                    join ( select cr.*,-- c.core_customer_kf,c.core_customer_id,
                    l.id
                    from
                         nbu_reported_loan l,core_credit cr
                        -- ,nbu_reported_customer c
                         where cr.request_id=(select max(request_id) from core_credit u where cr.rnk=u.rnk and u.status='ACCEPTED')
                         --and l.customer_object_id=c.id
                        -- and c.core_customer_id=cr.rnk
                         and cr.loan_object_id=l.id
                          and cr.status='ACCEPTED'
                          )f on f.id = s.object_id
             where o.object_type_id = 4  and s.state_id=2;
             grant all privileges on v_consolidated_credit to bars;
             grant all privileges on v_consolidated_credit to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_CREDIT.sql   ===
PROMPT ===================================================================================== 
