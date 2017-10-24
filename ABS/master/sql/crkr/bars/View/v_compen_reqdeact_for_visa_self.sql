create or replace view v_compen_reqdea_for_visa_self as
select o.oper_id, t.text, o.msg, p.fio, p.nsc, p.ost / 100 ost, c.fio fio_act, o.amount / 100 amount, o.regdate, p.id, o.rnk, (select t.logname from staff$base t where t.id = o.user_id) user_login,
  decode(o.changedate, null, 0, 1) as is_change_state
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_clients c
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.rnk = c.rnk
    and o.state = 0/*STATE_OPER_NEW*/
    and o.oper_type in(9/*TYPE_OPER_REQ_DEACT_DEP*/ , 10 /*TYPE_OPER_REQ_DEACT_BUR*/)
    and o.mfo = sys_context('bars_context','user_mfo')
    and o.user_id = user_id()
  with read only;
comment on table v_compen_reqdea_for_visa_self is '�������� ������ �� ����� ����������� �� ��������';
comment on column v_compen_reqdea_for_visa_self.OPER_ID is '������������� ��������';
comment on column v_compen_reqdea_for_visa_self.TEXT is '����� ��������';
comment on column v_compen_reqdea_for_visa_self.MSG is '����������';
comment on column v_compen_reqdea_for_visa_self.FIO is '������� �� �����';
comment on column v_compen_reqdea_for_visa_self.NSC is '����� ������';
comment on column v_compen_reqdea_for_visa_self.OST is '������� �� �����';
comment on column v_compen_reqdea_for_visa_self.FIO_ACT is '������� �������������� �볺���';
comment on column v_compen_reqdea_for_visa_self.AMOUNT is '���� ��������';
comment on column v_compen_reqdea_for_visa_self.REGDATE is '���� ���������';
comment on column v_compen_reqdea_for_visa_self.ID is '�� ������';
comment on column v_compen_reqdea_for_visa_self.RNK is '�� �������������� �볺���';
comment on column v_compen_reqdea_for_visa_self.IS_CHANGE_STATE is '1 - ���� ���� �������';

GRANT SELECT ON v_compen_reqdea_for_visa_self TO BARS_ACCESS_DEFROLE;