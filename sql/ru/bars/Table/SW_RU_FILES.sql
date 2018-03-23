prompt ... 


begin 
  BPA.ALTER_POLICY_INFO( 'SW_RU_FILES', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'SW_RU_FILES', 'FILIAL', 'M', 'M', 'M', 'M');
end;
/


prompt ... 


-- Create table
begin
    execute immediate 'create table SW_RU_FILES
(
  id        NUMBER not null,
  state     NUMBER(10) default 0 not null,
  message   VARCHAR2(4000),
  sign      RAW(128),
  ddate     DATE not null,
  kf        VARCHAR2(6) default sys_context(''bars_context'',''user_mfo''),
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
comment on table SW_RU_FILES
  is 'ϳ��������� ����� �� ��� �������� � ���';
-- Add comments to the columns 
comment on column SW_RU_FILES.state
  is '������ ������� �����';
comment on column SW_RU_FILES.message
  is '�����������';
comment on column SW_RU_FILES.sign
  is '������������� ����� ������';
comment on column SW_RU_FILES.ddate
  is '���� �����';
comment on column SW_RU_FILES.id
  is '������������� �����';
comment on column SW_RU_FILES.file_data
  is '���';
comment on column SW_RU_FILES.sdate
  is '���� ������ �����';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SW_RU_FILES
  add constraint PK_SW_RU_FILES primary key (ID)
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


begin
    execute immediate 'alter table SW_RU_FILES
  add constraint UK_SW_RU_FILES unique (KF, DDATE)
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
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update on SW_RU_FILES to BARS_ACCESS_DEFROLE;


 exec bpa.alter_policies('SW_RU_FILES');
