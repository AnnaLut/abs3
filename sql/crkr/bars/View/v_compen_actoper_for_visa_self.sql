create or replace view v_compen_actoper_for_visa_self as
select o.oper_id, t.text, o.oper_type, o.msg, p.fio, p.nsc, p.ost / 100 ost, c.fio fio_act, o.amount / 100 amount, o.regdate, p.id, o.rnk, (select t.logname from staff$base t where t.id = o.user_id) user_login,
  decode(o.changedate, null, 0, 1) as is_change_state  
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_clients c
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.rnk = c.rnk
    and o.state = 0/*STATE_OPER_NEW*/
    and o.oper_type in (5/*TYPE_OPER_ACT_DEP*/, 6/*TYPE_OPER_ACT_BUR*/, 17 /*TYPE_OPER_ACT_HER*/)
    and o.branch like SYS_CONTEXT('bars_context', 'user_branch_mask')
    and o.user_id = user_id()
  with read only;
comment on table V_COMPEN_ACTOPER_FOR_VISA_self is 'Операції актуалізацій на візування';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.OPER_ID is 'Ідентифиікатор операції';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.TEXT is 'Назва операції';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.MSG is 'Інформація';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.FIO is 'Прізвище на вкладі';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.NSC is 'Номер книжки';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.OST is 'Залишок на вкладі';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.FIO_ACT is 'Прізвище актуалізованого клієнта';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.AMOUNT is 'Сума операції';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.REGDATE is 'Дата реєстрації';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.ID is 'ІД Вкладу';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.RNK is 'ІД Актуалізованого клієнта';
comment on column V_COMPEN_ACTOPER_FOR_VISA_self.IS_CHANGE_STATE is '1- була зміна статусу';

GRANT SELECT ON v_compen_actoper_for_visa_self TO BARS_ACCESS_DEFROLE;