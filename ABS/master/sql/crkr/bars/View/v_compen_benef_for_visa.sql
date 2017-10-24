create or replace force view v_compen_benef_for_visa as
select o.oper_id, t.text, o.oper_type, o.msg, p.fio, p.nsc, p.ost / 100 ost, b.fiob fio_benef, b.idb, o.regdate, p.id, 
       case when o.oper_type = 32 then crkr_compen_web.analiz_change_benef(o.compen_id, o.benef_idb) else null end as change_info,
       (select t.logname from staff$base t where t.id = o.user_id) user_login,
  decode(o.changedate, null, 0, 1) as is_change_state  
  from compen_oper o, compen_portfolio p, compen_oper_types t, compen_benef b
  where o.compen_id = p.id
    and o.oper_type = t.type_id
    and o.benef_idb = b.idb and o.compen_id = b.id_compen
    and o.state = 10/**/
    and o.oper_type in (31/**/, 32/**/, 33 /**/)
    and (o.mfo = sys_context('bars_context','user_mfo') or sys_context('bars_context','user_mfo') = '300465')
  with read only;
comment on table v_compen_benef_for_visa is '�������� ���������� � ������������ �� �������� ����������';
comment on column v_compen_benef_for_visa.OPER_ID is '������������� ��������';
comment on column v_compen_benef_for_visa.TEXT is '����� ��������';
comment on column v_compen_benef_for_visa.MSG is '����������';
comment on column v_compen_benef_for_visa.FIO is '������� �� �����';
comment on column v_compen_benef_for_visa.NSC is '����� ������';
comment on column v_compen_benef_for_visa.OST is '������� �� �����';
comment on column v_compen_benef_for_visa.fio_benef is '������� ����������';
comment on column v_compen_benef_for_visa.REGDATE is '���� ���������';
comment on column v_compen_benef_for_visa.ID is '�� ������';
comment on column v_compen_benef_for_visa.idb is '�� ����������';
comment on column v_compen_benef_for_visa.change_info is '���������� �� ����������';
comment on column v_compen_benef_for_visa.IS_CHANGE_STATE is '1- ���� ���� �������';

GRANT SELECT ON v_compen_benef_for_visa TO BARS_ACCESS_DEFROLE;