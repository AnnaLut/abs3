prompt ... 

begin
BARS.BPA.ALTER_POLICY_INFO( 'BARS',  'ADR_RU_FILES', 'WHOLE' , NULL, NULL, NULL, NULL );
BARS.BPA.ALTER_POLICY_INFO( 'BARS',  'ADR_RU_FILES', 'FILIAL', null, null, null, null );
end;

/


-- Create table
begin
    execute immediate 'create table ADR_RU_FILES
(
  id        NUMBER not null,
  file_data CLOB not null,
  state     NUMBER(10) default 0 not null,
  message   VARCHAR2(4000),
  sign      RAW(128),
  ddate     DATE not null
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
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table ADR_RU_FILES
  is '����� �� ��������� ���� ������';
-- Add comments to the columns 
comment on column ADR_RU_FILES.id
  is '������������� ����� � ��';
comment on column ADR_RU_FILES.file_data
  is '�����';
comment on column ADR_RU_FILES.state
  is '������ ������� �����';
comment on column ADR_RU_FILES.message
  is '�����������';
comment on column ADR_RU_FILES.sign
  is '������������� ����� ������';
comment on column ADR_RU_FILES.ddate
  is '���� ���������';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table ADR_RU_FILES
  add constraint PK_ADR_RU_FILES primary key (ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update on ADR_RU_FILES to BARS_ACCESS_DEFROLE;

/ 

-- Grant/Revoke object privileges 
grant select on ADR_AREAS to BARSUPL;
grant select on ADR_AREAS to START1;
grant select on ADR_AREAS to UPLD;

/