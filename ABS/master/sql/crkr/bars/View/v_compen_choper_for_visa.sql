create or replace view v_compen_choper_for_visa as
select o.oper_id, t.text, o.msg, p.fio, p.ost / 100 ost, o.regdate, p.id, s.name, d.docserial, d.docnumber, d.docorg, d.docdate, (select t.logname from staff$base t where t.id = o.user_id) user_login
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_oper_dbcode d, passp s
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.oper_id = d.oper_id
    and d.doctype = s.passp
    and o.state = 10/*STATE_OPER_WAIT_CONFIRM*/
    and o.oper_type = 11/*TYPE_OPER_CHANGE_D*/
    and (o.mfo = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465')
  with read only;

  GRANT SELECT ON v_compen_choper_for_visa TO BARS_ACCESS_DEFROLE;