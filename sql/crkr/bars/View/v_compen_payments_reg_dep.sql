create or replace view v_compen_payments_reg_dep as
select cr.reg_id id,
       cr.date_val_reg,
       (select max(v.fio) from compen_portfolio v, compen_oper o where v.id = o.compen_id and o.reg_id = cr.reg_id and o.oper_type = 1/*TYPE_OPER_PAY_DEP*/) fio_compen,
       cc.fio fio_client, p.ser docserial, p.numdoc docnumber, cc.mfo, cc.nls, cr.amount /100 amount, cr.regdate, cr.changedate, cr.branch_act branch, 
       cr.state_id, cst.state_name,
       cr.msg, cr.ref_oper,  (select t.logname from staff$base t where t.id = cr.user_id) logname
    from compen_payments_registry cr,
         compen_registry_states cst,
         compen_clients cc,
         person p
    where cr.state_id = cst.state_id
      and p.rnk = cc.rnk
      and cc.rnk       = cr.rnk
      and cr.type_id = 1
      and cr.amount > 0
with read only;
comment on table V_COMPEN_PAYMENTS_REG_DEP is 'Створені компенсаційні платежі на виплату (без виплат на поховання)';
comment on column V_COMPEN_PAYMENTS_REG_DEP.ID is 'Ідентифікатор платежу';
comment on column V_COMPEN_PAYMENTS_REG_DEP.DATE_VAL_REG is 'Дата валютування';
comment on column V_COMPEN_PAYMENTS_REG_DEP.FIO_COMPEN is 'ПІБ вкладу';
comment on column V_COMPEN_PAYMENTS_REG_DEP.FIO_CLIENT is 'ПІБ актуалізованого клієнта';
comment on column V_COMPEN_PAYMENTS_REG_DEP.DOCSERIAL is 'Серія документа';
comment on column V_COMPEN_PAYMENTS_REG_DEP.DOCNUMBER is 'Номер документа';
comment on column V_COMPEN_PAYMENTS_REG_DEP.MFO is 'МФО';
comment on column V_COMPEN_PAYMENTS_REG_DEP.NLS is 'Рахунок клієнта';
comment on column V_COMPEN_PAYMENTS_REG_DEP.AMOUNT is 'Розрахована сума на виплату';
comment on column V_COMPEN_PAYMENTS_REG_DEP.REGDATE is 'Дата створення';
comment on column V_COMPEN_PAYMENTS_REG_DEP.CHANGEDATE is 'Дата останьої зміни';
comment on column V_COMPEN_PAYMENTS_REG_DEP.BRANCH is 'Підрозділ в якому заведений клієнт';
comment on column V_COMPEN_PAYMENTS_REG_DEP.STATE_ID is 'ID статусу запису';
comment on column V_COMPEN_PAYMENTS_REG_DEP.STATE_NAME is 'Статус запису';
comment on column V_COMPEN_PAYMENTS_REG_DEP.MSG is 'Інформація';
comment on column V_COMPEN_PAYMENTS_REG_DEP.REF_OPER is 'Номер документу в АБС';
comment on column V_COMPEN_PAYMENTS_REG_DEP.LOGNAME is 'Користувач який створив запис реєстру';

GRANT SELECT ON v_compen_payments_reg_dep TO BARS_ACCESS_DEFROLE;