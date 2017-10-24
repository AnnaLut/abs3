create or replace view v_compen_actoper_for_visa as
select o.oper_id, t.text, o.oper_type, o.msg, p.fio, p.nsc, p.ost / 100 ost, c.fio fio_act, o.amount / 100 amount, o.regdate, p.id, o.rnk, (select t.logname from staff$base t where t.id = o.user_id) user_login
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_clients c
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.rnk = c.rnk
    and o.state = 10/*STATE_OPER_WAIT_CONFIRM*/
    and o.oper_type in (5/*TYPE_OPER_ACT_DEP*/, 6/*TYPE_OPER_ACT_BUR*/, 17 /*TYPE_OPER_ACT_HER*/)
    and (o.branch like SYS_CONTEXT('bars_context', 'user_branch_mask') or sys_context('bars_context','user_mfo') = '300465')
  with read only;
comment on table V_COMPEN_ACTOPER_FOR_VISA is '�������� ����������� �� ��������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.OPER_ID is '������������� ��������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.TEXT is '����� ��������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.MSG is '����������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.FIO is '������� �� �����';
comment on column V_COMPEN_ACTOPER_FOR_VISA.NSC is '����� ������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.OST is '������� �� �����';
comment on column V_COMPEN_ACTOPER_FOR_VISA.FIO_ACT is '������� �������������� �볺���';
comment on column V_COMPEN_ACTOPER_FOR_VISA.AMOUNT is '���� ��������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.REGDATE is '���� ���������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.ID is '�� ������';
comment on column V_COMPEN_ACTOPER_FOR_VISA.RNK is '�� �������������� �볺���';

GRANT SELECT ON V_COMPEN_ACTOPER_FOR_VISA TO BARS_ACCESS_DEFROLE;