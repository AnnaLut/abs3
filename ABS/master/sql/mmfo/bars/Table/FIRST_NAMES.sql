begin
  BPA.ALTER_POLICY_INFO( 'FIRST_NAMES', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'FIRST_NAMES', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table FIRST_NAMES
(
  firstid    NUMBER(10) not null,
  firstru    VARCHAR2(50),
  firstua    VARCHAR2(50),
  sexid      CHAR(1),
  middleuam  VARCHAR2(50),
  middleuaf  VARCHAR2(50),
  middlerum  VARCHAR2(50),
  middleruf  VARCHAR2(50),
  firstuaof  VARCHAR2(50),
  firstuarod VARCHAR2(50),
  firstuadat VARCHAR2(50),
  firstuavin VARCHAR2(50),
  firstuatvo VARCHAR2(50),
  firstuapre VARCHAR2(50),
  firstrurod VARCHAR2(50),
  firstrudat VARCHAR2(50),
  firstruvin VARCHAR2(50),
  firstrutvo VARCHAR2(50),
  firstrupre VARCHAR2(50)
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
comment on table BARS.FIRST_NAMES
  is '������� ����';
-- Add comments to the columns 
comment on column BARS.FIRST_NAMES.firstid
  is 'ID';
comment on column BARS.FIRST_NAMES.firstru
  is '��''� (���) ';
comment on column BARS.FIRST_NAMES.firstua
  is '��''� (���)';
comment on column BARS.FIRST_NAMES.sexid
  is '�����';
comment on column BARS.FIRST_NAMES.middleuam
  is '�� ������� ���. (���)';
comment on column BARS.FIRST_NAMES.middleuaf
  is '�� ������� ��. (���)';
comment on column BARS.FIRST_NAMES.middlerum
  is '�� ������� ���. (���)';
comment on column BARS.FIRST_NAMES.middleruf
  is '�� ������� ��. (���)';
comment on column BARS.FIRST_NAMES.firstuaof
  is '��������� (���)';
comment on column BARS.FIRST_NAMES.firstuarod
  is '������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstuadat
  is '��������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstuavin
  is '��������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstuatvo
  is '������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstuapre
  is '̳������ ������ (���)';
comment on column BARS.FIRST_NAMES.firstrurod
  is '������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstrudat
  is '��������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstruvin
  is '��������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstrutvo
  is '������� ������ (���)';
comment on column BARS.FIRST_NAMES.firstrupre
  is '̳������ ������ (���)';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table FIRST_NAMES
  add constraint PK_FIRSTNAMES primary key (FIRSTID)
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
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table FIRST_NAMES
  add constraint FK_FIRSTNAMES_SEX foreign key (SEXID)
  references BARS.SEX (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

