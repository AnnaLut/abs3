
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BILLS/view/v_rec_bills_local.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FORCE VIEW BILLS.V_REC_BILLS_LOCAL ("EXP_ID", "BILL_NO", "DT_ISSUE", "DT_PAYMENT", "AMOUNT", "STATUS", "STATUS_NAME", "LAST_DT", "LAST_USER", "NAME", "INN", "DOC_NO", "DOC_DATE", "DOC_WHO", "CL_TYPE", "CURRENCY", "CUR_RATE", "EXPECTED_AMOUNT", "PHONE", "ACCOUNT", "REQ_ID", "BRANCH", "COMMENTS", "RNK", "HANDOUT_DATE") AS 
  select c.exp_id,
       b.bill_no,
       b.dt_issue,
       b.dt_payment,
       b.amount,
       b.status,
       ds.name status_name,
       b.last_dt,
       b.last_user,
       c.name,
       c.inn,
       c.doc_no,
       c.doc_date,
       c.doc_who,
       c.cl_type,
       c.currency,
       c.cur_rate,
       c.amount expected_amount,
       c.phone,
       c.account,
       c.req_id,
       c.branch,
       c.comments,
       c.rnk,
       b.handout_date
from rec_bills b
join receivers c on b.rec_id = c.exp_id
join dict_status ds on b.status = ds.code and ds.type = 'B'
where b.status in ('SR', 'RR', 'OK')
  and c.branch = bill_abs_integration.f_user_branch
;
 show err;
 
PROMPT *** Create  grants  V_REC_BILLS_LOCAL ***
grant SELECT                                                                 on V_REC_BILLS_LOCAL to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BILLS/view/v_rec_bills_local.sql =========*** End
 PROMPT ===================================================================================== 
 
