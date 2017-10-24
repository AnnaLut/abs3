create or replace view v_mbdk_deal_int_reckoning as
select t.id,
       ia.nls interst_account,
       pea.nls income_account,
       t.date_from,
       t.date_to,
       t.account_rest / 100 account_rest,
       t.interest_rate,
       t.interest_amount / 100 interest_amount,
       i.tt operation_type,
       t.purpose,
       t.message,
       t.state_id
from   int_reckoning t
join   cc_deal d on d.nd = t.deal_id
join   cc_add dd on dd.nd = d.nd and dd.adds = 0
join   customer c on c.rnk = d.rnk
join   custbank cb on cb.rnk = d.rnk
join   accounts a on a.acc = dd.accs
join   int_accn i on i.acc = a.acc and i.id = a.pap - 1
join   accounts ia on ia.acc = i.acra
join   accounts pea on pea.acc = i.acrb
where  t.reckoning_id = sys_context('bars_pul', 'reckoning_id');

grant select on v_mbdk_deal_int_reckoning to bars_access_defrole;
