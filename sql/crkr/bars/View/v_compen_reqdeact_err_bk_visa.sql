create or replace view v_compen_dea_err_bk_visa as
select o.oper_id, t.text, o.msg, p.fio, p.nsc, p.ost / 100 ost, c.fio fio_act, o.amount / 100 amount, o.regdate, p.id, o.rnk, (select t.logname from staff$base t where t.id = o.user_id) user_login,
  case when (select count(*) from compen_oper co where co.compen_id = p.id and co.oper_type = 1 /*TYPE_OPER_PAY_DEP*/ and co.state = 20 /*STATE_OPER_COMPLETED*/) > 0 then 1 else 0 end as is_pay_dep_done
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_clients c
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.rnk = c.rnk
    and o.state = 40/*STATE_OPER_ERROR*/
    and o.oper_type in (9/*TYPE_OPER_DEACT_DEP*/, 10/*TYPE_OPER_DEACT_BUR*/)
  with read only;
comment on table v_compen_dea_err_bk_visa is 'Операції запитів актуалізацій (для Бєк-офісу)';
comment on column v_compen_dea_err_bk_visa.OPER_ID is 'Ідентифиікатор операції';
comment on column v_compen_dea_err_bk_visa.TEXT is 'Назва операції';
comment on column v_compen_dea_err_bk_visa.MSG is 'Інформація';
comment on column v_compen_dea_err_bk_visa.FIO is 'Прізвище на вкладі';
comment on column v_compen_dea_err_bk_visa.NSC is 'Номер книжки';
comment on column v_compen_dea_err_bk_visa.OST is 'Залишок на вкладі';
comment on column v_compen_dea_err_bk_visa.FIO_ACT is 'Прізвище актуалізованого клієнта';
comment on column v_compen_dea_err_bk_visa.AMOUNT is 'Сума операції';
comment on column v_compen_dea_err_bk_visa.REGDATE is 'Дата реєстрації';
comment on column v_compen_dea_err_bk_visa.ID is 'ІД Вкладу';
comment on column v_compen_dea_err_bk_visa.RNK is 'ІД Актуалізованого клієнта';
comment on column v_compen_dea_err_bk_visa.IS_PAY_DEP_DONE is '1 якщо була виплата по вкладу';

GRANT SELECT ON v_compen_dea_err_bk_visa TO BARS_ACCESS_DEFROLE;