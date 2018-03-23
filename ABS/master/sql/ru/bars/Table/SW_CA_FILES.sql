prompt ... 

begin 
  BPA.ALTER_POLICY_INFO( 'SW_CA_FILES', 'WHOLE' ,  null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_CA_FILES', 'FILIAL', 'M', 'M', 'M', 'M');
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table SW_CA_FILES
(
  id        NUMBER not null,
  kf        VARCHAR2(6) not null,
  state     NUMBER(10) default 0 not null,
  message   VARCHAR2(4000),
  sign      RAW(128),
  ddate     DATE not null,
  file_data CLOB,
  sdate     DATE
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table SW_CA_FILES
  is '����� ������� ����, ������ �� ��';
-- Add comments to the columns 
comment on column SW_CA_FILES.id
  is '������������� �����';
comment on column SW_CA_FILES.state
  is '������ ������� ����� (
0 - ���� ��� ������ � SW_CA_FILES, 
1 - ������� ������ ������ ������, 
2 - �������� � ��������, 
3 - �������, 
4 - ���� ��� ��������, 
5 - �������������� ����������,
10 - ������������ ������ � recive_data,
-99 - ������ �� ����������)';
comment on column SW_CA_FILES.message
  is '�����������';
comment on column SW_CA_FILES.sign
  is '������������� ����� ������';
comment on column SW_CA_FILES.ddate
  is '���� �����';
comment on column SW_CA_FILES.file_data
  is '���';
comment on column SW_CA_FILES.sdate
  is '���� ������ �����';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_CA_FILES
  add constraint PK_SW_CA_FILES primary key (KF, ID)
  using index 
  tablespace BRSDYNI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update on SW_CA_FILES to BARS_ACCESS_DEFROLE;



PROMPT *** ALTER_POLICIES to PAYTT_NO ***
 exec bpa.alter_policies('SW_CA_FILES');
