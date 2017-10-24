begin 
  execute immediate 'drop table tmp_dynamic_layout_detail';
  exception when others then null;
end;
/
begin 
  execute immediate '
create table tmp_dynamic_layout_detail
(
  id 			number(38), 
  dk 		    number(1), 
  nd 			varchar2(10),     
  kv 			number(3),
  branch 		varchar2(30),
  branch_name 	varchar2(70),
  nls_a 		varchar2(15),
  nama			varchar2(256),
  okpoa 		varchar2(14),
  mfob 			varchar2(12),
  mfob_name 	varchar2(256),
  nls_b 		varchar2(15),
  namb          varchar2(38),
  okpob 		varchar2(14),
  percent 		number(5,2),
  summ_a 		number(38),
  summ_b 		number(38),
  delta 		number(38),
  tt			varchar2(3),
  vob			number,
  nazn 			varchar2(256),
  ref 			varchar2(64),
  nls_count 	number(38),
  userid 		number
)
SEGMENT CREATION IMMEDIATE 
 NOCOMPRESS LOGGING
TABLESPACE BRSSMLD';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
comment on table tmp_dynamic_layout_detail is '����� ������ ��������� ��������';
comment on column tmp_dynamic_layout_detail.id  is '�������������';
comment on column tmp_dynamic_layout_detail.dk  is '������ 1 �����, 2 - ������';
comment on column tmp_dynamic_layout_detail.nd  is '����� ���������(������ ��������)';
comment on column tmp_dynamic_layout_detail.kv is '��� ������';
comment on column tmp_dynamic_layout_detail.branch is '��� ������';
comment on column tmp_dynamic_layout_detail.branch_name is '����� ������';
comment on column tmp_dynamic_layout_detail.nls_a is '������� �';
comment on column tmp_dynamic_layout_detail.nama is '������������ �������� �';
comment on column tmp_dynamic_layout_detail.okpoa is '���� �';
comment on column tmp_dynamic_layout_detail.namb is '��� �';
comment on column tmp_dynamic_layout_detail.okpob is '���� �';
comment on column tmp_dynamic_layout_detail.nls_b is '������� ������';
comment on column tmp_dynamic_layout_detail.percent is '������� �� �������� ����';
comment on column tmp_dynamic_layout_detail.summ_a is '���� �������� � ������� �';
comment on column tmp_dynamic_layout_detail.summ_b is '���� �������� � ����� �';
comment on column tmp_dynamic_layout_detail.delta is '+ ��� - ��������� � �����';
comment on column tmp_dynamic_layout_detail.tt is '��� ��������';
comment on column tmp_dynamic_layout_detail.vob is '��� ��';
comment on column tmp_dynamic_layout_detail.nls_count is 'ʳ������ ������� �';
/
grant select, insert, update, delete on tmp_dynamic_layout_detail to bars_access_defrole;
/