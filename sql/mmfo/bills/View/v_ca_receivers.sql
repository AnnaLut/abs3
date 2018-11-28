
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_ca_receivers.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_CA_RECEIVERS ("KF", "EXP_ID", "NAME", "INN", "DOC_NO", "DOC_DATE", "DOC_WHO", "CL_TYPE", "CURRENCY", "LCV", "CUR_NAME", "CUR_RATE", "AMOUNT", "STATUS", "STATUS_NAME", "PHONE", "ADDRESS", "BRANCH", "ACCOUNT", "REQ_ID", "COMMENTS", "RNK", "EXTRACT_NUMBER_ID", "EXTRACT_DATE", "EXT_STATUS", "EXT_STATUS_NAME", "RES_ID", "RES_CODE", "RES_DATE", "COURTNAME") AS 
  select KF,
       EXP_ID,
       t.NAME,
       "INN",
       "DOC_NO",
       "DOC_DATE",
       "DOC_WHO",
       "CL_TYPE",
       "CURRENCY",
       tv.lcv,
       tv.NAME as cur_name,
       "CUR_RATE",
       cast(amount/100 as number(12, 2)) amount,
       t.status status,
       ds.name status_name,
       "PHONE",
       ADDRESS,
       "BRANCH",
       "ACCOUNT",
       "REQ_ID",
       "COMMENTS",
       "RNK",
	   t.EXTRACT_NUMBER_ID,
       e.extract_date,
       t.ext_status,
       dts.status_name ext_status_name,
       t.res_id,
       t.res_code,
       t.res_date,
       t.courtname
from CA_RECEIVERS t
left join (select * from dict_status where type = 'C') ds on t.status = ds.code
left join bars.tabval tv on t.currency = tv.kv
left join extracts e on t.extract_number_id = e.extract_number_id
left join dict_treasury_status dts on t.ext_status = dts.status_id
;
 show err;
 
PROMPT *** Create  grants  V_CA_RECEIVERS ***
grant SELECT                                                                 on V_CA_RECEIVERS  to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_ca_receivers.sql =========*** End **
 PROMPT ===================================================================================== 
 