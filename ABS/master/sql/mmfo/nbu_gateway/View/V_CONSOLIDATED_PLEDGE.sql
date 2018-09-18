
PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_PLEDGE.sql ===
PROMPT ===================================================================================== 


PROMPT *** Create  view V_CONSOLIDATED_PLEDGE ***

  CREATE OR REPLACE FORCE VIEW V_CONSOLIDATED_PLEDGE as 
	select s.report_id,
       (select min(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_creation_time,
       (select max(st.sys_time) from nbu_session_tracking st where st.session_id = s.id) session_activity_time,
       nvl((select distinct uu.nameur as name from core_person_uo uu where uu.rnk=pled.rnk),
       (select distinct f.lastname||''|| f.firstname||' '||f.middlename as name
       from core_person_fo f where f.rnk=pled.rnk and f.kf=pled.kf)) name ,pled."REQUEST_ID",pled."RNK",pled."ACC",pled."ORDERNUM",pled."NUMBERPLEDGE",pled."PLEDGEDAY",pled."S031",pled."R030",pled."SUMPLEDGE",pled."PRICEPLEDGE",pled."LASTPLEDGEDAY",pled."CODREALTY",pled."ZIPREALTY",pled."SQUAREREALTY",pled."REAL6INCOME",pled."NOREAL6INCOME",pled."FLAGINSURANCEPLEDGE",pled."NUMDOGDP",pled."DOGDAYDP",pled."R030DP",pled."SUMDP",pled."DEFAULT_PLEDGE_KF",pled."DEFAULT_PLEDGE_ID",pled."PLEDGE_OBJECT_ID",pled."STATUS",pled."STATUS_MESSAGE",pled."KF",pled."PLEDGE_CODE",pled."SUMBAIL",pled."SUMGUARANTEE",pled."ID",pled."CUSTOMER_OBJECT_ID",pled."ORDER_NUMBER",pled."PLEDGE_NUMBER",pled."PLEDGE_DATE",pled."PLEDGE_AMOUNT",pled."PLEDGE_CURRENCY_ID",pled."CORE_PLEDGE_KF",pled."CORE_PLEDGE_ID",pled."PLEDGE_TYPE"
     from   nbu_session s
            join  nbu_reported_object o on o.id = s.object_id
            join (select p.*,np.* from  nbu_reported_pledge np ,core_pledge_dep p
                         where p.status='ACCEPTED' and
                         p.request_id=(select max(pp.request_id) from core_pledge_dep pp where pp.default_pledge_id=np.core_pledge_id and pp.status='ACCEPTED' )
                         and np.core_pledge_id=p.default_pledge_id
                         and np.core_pledge_kf=p.default_pledge_kf)pled
     on pled.id = s.object_id
     where   o.object_type_id = 3 and s.state_id in (2);
     
     grant all privileges on V_CONSOLIDATED_PLEDGE to bars;
     grant all privileges on V_CONSOLIDATED_PLEDGE to bars_access_defrole;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/NBU_GATEWAY/View/V_CONSOLIDATED_PLEDGE.sql   ===
PROMPT ===================================================================================== 
