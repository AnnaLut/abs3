create or replace FORCE VIEW v_compen_choper_depend as
  select o.compen_bound, t.text, p.fio, p.nsc, p.ost / 100 ost
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_oper_dbcode d, passp s
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.oper_id = d.oper_id
    and d.doctype = s.passp
    and o.state = 0/*STATE_OPER_NEW*/
    and o.oper_type in (12,13)/*TYPE_OPER_CHANGE_DA, TYPE_OPER_CHANGE_DB*/
    and (o.mfo = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465');
comment on table v_compen_choper_depend is 'Операції зміни документа дочірні';    
GRANT SELECT ON v_compen_choper_depend TO BARS_ACCESS_DEFROLE;
