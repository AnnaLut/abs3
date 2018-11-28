
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_receivers.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_RECEIVERS ("EXP_ID", "RESOLUTION_ID", "NAME", "EXPECTEDNAME", "INN", "DOC_NO", "DOC_DATE", "DOC_WHO", "CL_TYPE", "CURRENCY", "LCV", "CUR_NAME", "CUR_RATE", "AMOUNT", "EXPECTED_AMOUNT", "STATUS", "STATUS_NAME", "PHONE", "ADDRESS", "BRANCH", "ACCOUNT", "REQ_ID", "COMMENTS", "RNK", "APPLREADY", "SNDDOC", "USER_BRANCH", "IMPORTANT_FLAG", "IMPORTANT_TXT", "LAST_DT", "LAST_USER", "EXT_STATUS", "EXT_STATUS_NAME") AS 
  with mfo as (select bsm.f_ourmfo x from dual)
select t.EXP_ID as exp_id,
       t.RESOLUTION_ID,
       t.NAME,
       er.receiver_name as ExpectedName,
       "INN",
       "DOC_NO",
       "DOC_DATE",
       "DOC_WHO",
       "CL_TYPE",
       "CURRENCY",
       tv.lcv,
       tv.NAME as cur_name,
       "CUR_RATE",
       t.AMOUNT ,
       cast(er.amount/100 as number(12, 2)) expected_amount,
       t.status status,
       ds.name status_name,
       "PHONE",
       ADDRESS,
       "BRANCH",
       "ACCOUNT",
       "REQ_ID",
       "COMMENTS",
       "RNK",
       (select count(1) from documents d, dict_doc_types dt
          where d.rec_id = t.exp_id
            and d.doc_type = dt.id
            and dt.code = 'Application') ApplReady,
       (select count(1) from documents d, dict_doc_types dt
          where d.rec_id = t.exp_id
            and d.doc_type = dt.id
            and dt.code != 'Application'
            and d.status = 'IN') SndDoc,
     cast(bill_service_mgr.f_user_branch() as varchar2(40)) as user_branch,
     case
       when t.status = 'RJ' then 1
       else 0
     end as important_flag,
     case
       when t.status = 'RJ' then 'Запис відбракований, необхідне доопрацювання'
       else null
     end as important_txt,
     t.last_dt,
     t.last_user,
     t.ext_status,
     dts.status_name ext_status_name
from RECEIVERS t
left join (select * from dict_status where type = 'R') ds on t.status = ds.code
left join bars.tabval tv on t.currency = tv.kv
left join dict_treasury_status dts on t.ext_status = dts.status_id
join expected_receivers er on t.exp_id = er.exp_id
join mfo on substr(t.branch, 2, 6) = mfo.x
;
 show err;
 
PROMPT *** Create  grants  V_RECEIVERS ***
grant SELECT                                                                 on V_RECEIVERS     to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_receivers.sql =========*** End *** =
 PROMPT ===================================================================================== 
 