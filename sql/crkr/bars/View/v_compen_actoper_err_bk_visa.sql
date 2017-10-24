create or replace view v_compen_actoper_err_bk_visa as
select o.oper_id, t.text, o.msg, p.fio, p.nsc, p.ost / 100 ost, c.fio fio_act, o.amount / 100 amount, o.regdate, p.id, o.rnk, (select t.logname from staff$base t where t.id = o.user_id) user_login
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_clients c
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.rnk = c.rnk
    and o.state = 40/*STATE_OPER_ERROR*/
    and o.oper_type in (5/*TYPE_OPER_ACT_DEP*/, 6/*TYPE_OPER_ACT_BUR*/)
  with read only;
comment on table v_compen_actoper_err_bk_visa is '�������� ����������� � ���� ��������� ������ �������(��� ���-�����)';
comment on column v_compen_actoper_err_bk_visa.OPER_ID is '������������� ��������';
comment on column v_compen_actoper_err_bk_visa.TEXT is '����� ��������';
comment on column v_compen_actoper_err_bk_visa.MSG is '����������';
comment on column v_compen_actoper_err_bk_visa.FIO is '������� �� �����';
comment on column v_compen_actoper_err_bk_visa.NSC is '����� ������';
comment on column v_compen_actoper_err_bk_visa.OST is '������� �� �����';
comment on column v_compen_actoper_err_bk_visa.FIO_ACT is '������� �������������� �볺���';
comment on column v_compen_actoper_err_bk_visa.AMOUNT is '���� ��������';
comment on column v_compen_actoper_err_bk_visa.REGDATE is '���� ���������';
comment on column v_compen_actoper_err_bk_visa.ID is '�� ������';
comment on column v_compen_actoper_err_bk_visa.RNK is '�� �������������� �볺���';

GRANT SELECT ON v_compen_actoper_err_bk_visa TO BARS_ACCESS_DEFROLE;