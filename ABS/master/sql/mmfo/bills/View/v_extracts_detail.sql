prompt v_extracts_detail
create or replace force view v_extracts_detail
as 
select c.kf,
       c.exp_id,
       c.name,
       c.inn,
       c.doc_no,
       c.doc_date,
       c.doc_who,
       c.cl_type,
       c.currency,
       c.cur_rate,
       c.amount,
       c.phone,
       c.account,
       c.req_id,
       c.branch,
       c.comments,
       c.status,
       c.rnk,
       c.signer,
       c.signature,
       c.sign_date,
       c.res_code,
       c.res_date,
       c.res_id,
       c.courtname,
       c.address,
       ed.extract_id,
       e.extract_date,
       ed.ext_status,
       dts.status_name as ext_status_name
from ca_receivers c
join extracts_detail ed on c.exp_id = ed.exp_id
join extracts e on ed.extract_id = e.extract_number_id
left join dict_treasury_status dts on ed.ext_status = dts.status_id;

grant select on v_extracts_detail to bars_access_defrole;
