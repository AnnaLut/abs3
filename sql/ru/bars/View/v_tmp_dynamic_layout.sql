create or replace view v_tmp_dynamic_layout as 
select 
  v.nd,
  v.datd,
  v.dk,
  v.summ/100 summ,       
  v.kv_a,
  v.nls_a,
  v.ostc/100 ostc,
  v.nms,
  v.nazn,
  v.date_from,
  v.date_to,
  v.dates_to_nazn,
  v.correction,
  v.ref,
  v.typed_percent,
  v.typed_summ/100 typed_summ,
  v.branch_count,
  v.userid
from bars.tmp_dynamic_layout v 
where  v.userid = bars.user_id;

comment on table v_tmp_dynamic_layout is '����� ��������� �������� (���������)';
comment on column v_tmp_dynamic_layout.nd is '����� ���������(�������������)';
comment on column v_tmp_dynamic_layout.datd is '���� ���������(�������������)';
comment on column v_tmp_dynamic_layout.dk is '1 - �����, 0 - ������';
comment on column v_tmp_dynamic_layout.summ is '�������� ���� ��� ���������';
comment on column v_tmp_dynamic_layout.kv_a is '��� ������ ������� �';
comment on column v_tmp_dynamic_layout.nls_a is '����� ������� �';
comment on column v_tmp_dynamic_layout.ostc is '������� ������� �';
comment on column v_tmp_dynamic_layout.nms is ' ������������ ������� �';
comment on column v_tmp_dynamic_layout.nazn is '����������� �������';
comment on column v_tmp_dynamic_layout.date_from is '���� �';
comment on column v_tmp_dynamic_layout.date_to is '���� ��';
comment on column v_tmp_dynamic_layout.dates_to_nazn is '������ ��������� ���� � �� ���� �� �� ����������� �������(0 - �, 1 - ���)';
comment on column v_tmp_dynamic_layout.correction is '������ ��������� ������� �������������� ���������';
comment on column v_tmp_dynamic_layout.ref is '���';
comment on column v_tmp_dynamic_layout.typed_percent is '������� %';
comment on column v_tmp_dynamic_layout.typed_summ is ' ������� ����';
comment on column v_tmp_dynamic_layout.branch_count is '������� �������';

grant select on bars.v_tmp_dynamic_layout to bars_access_defrole;
