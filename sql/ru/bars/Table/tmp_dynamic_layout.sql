begin 
  execute immediate '
create table bars.tmp_dynamic_layout
(
  nd varchar2(10),
  datd date,
  dk number (1),
  summ number(38),       
  kv_a number(3),
  nls_a varchar2(15),
  ostc number(38),
  nms varchar2(70),
  nazn varchar2(256),
  date_from date,
  date_to date,
  dates_to_nazn number(1),
  correction number(1),
  ref number(38),
  typed_percent number (5,2),
  typed_summ number (38),
  branch_count number(38),
  userid number(38)
)
SEGMENT CREATION IMMEDIATE 
 NOCOMPRESS LOGGING
TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table tmp_dynamic_layout is '����� ��������� �������� (���������)';
comment on column tmp_dynamic_layout.nd is '����� ���������(�������������)';
comment on column tmp_dynamic_layout.datd is '���� ���������(�������������)';
comment on column tmp_dynamic_layout.dk is '1 - �����, 0 - ������';
comment on column tmp_dynamic_layout.summ is '�������� ���� ��� ���������';
comment on column tmp_dynamic_layout.kv_a is '��� ������ ������� �';
comment on column tmp_dynamic_layout.nls_a is '����� ������� �';
comment on column tmp_dynamic_layout.ostc is '������� ������� �';
comment on column tmp_dynamic_layout.nms is ' ������������ ������� �';
comment on column tmp_dynamic_layout.nazn is '����������� �������';
comment on column tmp_dynamic_layout.date_from is '���� �';
comment on column tmp_dynamic_layout.date_to is '���� ��';
comment on column tmp_dynamic_layout.dates_to_nazn is '������ ��������� ���� � �� ���� �� �� ����������� �������(0 - �, 1 - ���)';
comment on column tmp_dynamic_layout.correction is '������ ��������� ������� �������������� ���������';
comment on column tmp_dynamic_layout.ref is '���';
comment on column tmp_dynamic_layout.typed_percent is '������� %';
comment on column tmp_dynamic_layout.typed_summ is ' ������� ����';
comment on column tmp_dynamic_layout.branch_count is '������� �������';
/
grant select, insert, update, delete on tmp_dynamic_layout to bars_access_defrole;
/


