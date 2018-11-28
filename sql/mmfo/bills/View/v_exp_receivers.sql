
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_exp_receivers.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_EXP_RECEIVERS ("EXP_ID", "RESOLUTION_ID", "RECEIVER_NAME", "RECEIVER_CODE", "RECEIVER_DOC_NO", "CURRENCY_ID", "AMOUNT", "STATE", "RES_CODE", "RES_DATE", "COURTNAME", "RES_ID") AS 
  select exp_id,
       resolution_id,
       receiver_name,
       receiver_code,
       receiver_doc_no,
       currency_id,
       cast(amount/100 as number(12, 2)) as amount,
       state,
       r.res_code,
       r.res_date,
       r.courtname,
       r.res_id
  from expected_receivers er,
       resolutions r
  where er.resolution_id = r.res_id
;
 show err;
 
PROMPT *** Create  grants  V_EXP_RECEIVERS ***
grant SELECT                                                                 on V_EXP_RECEIVERS to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_exp_receivers.sql =========*** End *
 PROMPT ===================================================================================== 
 