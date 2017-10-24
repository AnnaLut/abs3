create or replace view v_e_deal_acc26
as
   (select case when d.acc26 = a.acc then 1 else 0 end as opt,
           d.nd,
           a.rnk,
           a.acc,
           a.nls || '(' || a.kv || ')' as nls_kv
      from accounts a, e_deal$base d
     where     a.rnk = d.rnk
           and a.nbs in (select nbs from e_nbs)
           and a.tip in ('ODB', 'BDB', 'SS')
           and a.dazs is null
           and d.nd = to_number (pul.get('DEAL_ND')));

show errors;

grant select on bars.v_e_deal_acc26 to bars_access_defrole;
