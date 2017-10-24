create or replace force view bars.v_notportfolio_int_reckoning as
select t.account_id, t.interest_kind, a.kv currency_id, a.kf mfo,
       c.nmk partner_name, a.nls account_number,
       nvl(t.account_rest / 100, 0) account_rest, t.interest_rate,
       t.interest_amount / 100 interest_amount, t.date_from, t.date_to,
       t.purpose, nvl(i.tt, '%%1') operation_type,
       ia.nls interest_account_number, inc.nls income_account, t.message,
       t.state_id, t.id, t.reckoning_id, t.oper_ref
  from int_reckoning t
  join accounts a
    on a.acc = t.account_id
  join notportfolio_nbs n
    on a.nbs = n.nbs
  join int_accn i
    on i.acc = a.acc and i.id = a.pap - 1
  join customer c
    on c.rnk = a.rnk
  left join accounts ia
    on ia.acc = i.acra
  left join accounts inc
    on inc.acc = i.acrb
 where t.reckoning_id = sys_context('bars_pul', 'reckoning_id') and
       t.interest_amount > 0 and not exists
 (select 1 from nd_acc na where na.acc = t.account_id);
grant select on BARS.v_notportfolio_int_reckoning to BARS_ACCESS_DEFROLE;
 

