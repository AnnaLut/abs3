prompt create view v_rec_bills
create or replace force view v_rec_bills as
select c.exp_id,
       b.bill_no,
       b.dt_issue,
       b.dt_payment,
       b.amount,
       b.status,
       ds.name status_name,
       b.last_dt,
       b.last_user,
       c.kf,
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
       c.extract_number_id,
       b.handout_date
from rec_bills b
join ca_receivers c on b.rec_id = c.exp_id
join dict_status ds on b.status = ds.code and ds.type = 'B'
--where b.status = 'SN'
;
grant select on v_rec_bills to bars_access_defrole;