create or replace view v_tmp_dynamic_layout_detail as 
select 
  v.id, 
  v.nd,     
  v.kv,
  v.branch,
  v.branch_name,
  v.nls_a,
  v.nls_b,
  v.percent,
  v.summ_a/100 summ_a,
  v.summ_b/100 summ_b,
  v.nls_count,
  v.userid 
from bars.tmp_dynamic_layout_detail v 
where  v.userid = bars.user_id;

comment on table v_tmp_dynamic_layout_detail is '����� ������ ��������� ��������';
comment on column v_tmp_dynamic_layout_detail.id  is '�������������';
comment on column v_tmp_dynamic_layout_detail.nd  is '����� ���������(������ ��������)';
comment on column v_tmp_dynamic_layout_detail.kv is '��� ������';
comment on column v_tmp_dynamic_layout_detail.branch is '��� ������';
comment on column v_tmp_dynamic_layout_detail.branch_name is '����� ������';
comment on column v_tmp_dynamic_layout_detail.nls_a is '������� �';
comment on column v_tmp_dynamic_layout_detail.nls_b is '������� ������';
comment on column v_tmp_dynamic_layout_detail.percent is '������� �� �������� ����';
comment on column v_tmp_dynamic_layout_detail.summ_a is '���� �������� � ������� �';
comment on column v_tmp_dynamic_layout_detail.summ_b is '���� �������� � ����� �';
comment on column v_tmp_dynamic_layout_detail.nls_count is 'ʳ������ ������� �';
/
grant select on bars.v_tmp_dynamic_layout to bars_access_defrole;
/