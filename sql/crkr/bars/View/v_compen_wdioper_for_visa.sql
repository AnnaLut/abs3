create or replace view v_compen_wdioper_for_visa as
select o.oper_id, t.text, o.msg, p.fio, p.ost / 100 ost, c.fio fio_act, o.amount / 100 amount, o.regdate, p.id, o.rnk, (select t.logname from staff$base t where t.id = o.user_id) user_login
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_clients c
  where o.compen_bound = p.id
    and o.oper_type = t.type_id
    and o.rnk = c.rnk
    and o.state = 10/*STATE_OPER_WAIT_CONFIRM*/
    and o.oper_type = 3/*TYPE_OPER_WDI*/
    and (o.mfo = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465')
  with read only;

  GRANT SELECT ON V_COMPEN_WDIOPER_FOR_VISA TO BARS_ACCESS_DEFROLE;