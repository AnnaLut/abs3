create or replace view v_mbdk_int_reckoning as
select t.id,
       d.cc_id deal_number,
       dd.kv currency_id,
       cb.bic partner_bic,
       c.nmk partner_name,
       a.nls account_number,
       ia.nls interest_account,
       pea.nls income_account,
       t.date_from,
       t.date_to,
       currency_utl.from_fractional_units(t.account_rest, a.kv) account_rest,
       t.interest_rate,
       currency_utl.from_fractional_units(t.interest_amount, a.kv) interest_amount,
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

grant select on v_mbdk_int_reckoning to bars_access_defrole;
