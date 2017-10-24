create or replace force view v_w4_not_confirm_acc as
select t.acc, t.rnk, c.nmk, c.okpo, a.nls, w.card_code
  from w4_acc_instant t
  join customer c
    on t.rnk = c.rnk
  join accounts a
    on a.acc = t.acc
  join w4_acc w on w.acc_pk = t.acc
 where t.state = 1;
grant select on V_W4_NOT_CONFIRM_ACC to BARS_ACCESS_DEFROLE;