create or replace view v_compen_payments_reg_bur as
select cr.reg_id id,
       cr.date_val_reg,
       (select max(v.fio) from compen_portfolio v, compen_oper o where v.id = o.compen_id and o.reg_id = cr.reg_id and o.oper_type = 2/*TYPE_OPER_PAY_BUR*/) fio_compen,
       cc.fio fio_client, p.ser docserial, p.numdoc docnumber, cc.mfo, cc.nls, cr.amount / 100 amount, cr.regdate, cr.changedate, cr.branch_act branch, 
       cr.state_id, cst.state_name,
       cr.msg, cr.ref_oper, (select t.logname from staff$base t where t.id = cr.user_id) logname
    from compen_payments_registry cr,
         compen_registry_states cst,
         compen_clients cc,
         person p
    where cr.state_id = cst.state_id
      and p.rnk = cc.rnk
      and cc.rnk       = cr.rnk
      and cr.type_id = 2
      and cr.amount > 0
with read only;
comment on table V_COMPEN_PAYMENTS_REG_BUR is '������� ������������ ������ �� ������� �� ���������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.ID is '������������� �������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.DATE_VAL_REG is '���� �����������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.FIO_COMPEN is 'ϲ� ������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.FIO_CLIENT is 'ϲ� �������������� �볺���';
comment on column V_COMPEN_PAYMENTS_REG_BUR.DOCSERIAL is '���� ���������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.DOCNUMBER is '����� ���������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.MFO is '���';
comment on column V_COMPEN_PAYMENTS_REG_BUR.NLS is '������� �볺���';
comment on column V_COMPEN_PAYMENTS_REG_BUR.AMOUNT is '����������� ���� �� �������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.REGDATE is '���� ���������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.CHANGEDATE is '���� ������� ����';
comment on column V_COMPEN_PAYMENTS_REG_BUR.BRANCH is 'ϳ������ �� ��������� �볺��';
comment on column V_COMPEN_PAYMENTS_REG_BUR.STATE_ID is 'ID ������� ������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.STATE_NAME is '������ ������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.MSG is '����������';
comment on column V_COMPEN_PAYMENTS_REG_BUR.REF_OPER is '����� ��������� � ���';
comment on column V_COMPEN_PAYMENTS_REG_BUR.LOGNAME is '���������� ���� ������� ����� ������';
GRANT SELECT ON v_compen_payments_reg_bur TO BARS_ACCESS_DEFROLE;