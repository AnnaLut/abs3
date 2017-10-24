exec bpa.alter_policy_info('COMPEN_OPER_DBCODE', 'filial', null, null, null, null);
exec bpa.alter_policy_info('COMPEN_OPER_DBCODE', 'whole',  null,  null, null, null);

begin
    execute immediate 'create table COMPEN_OPER_DBCODE
(
  oper_id      NUMBER,
  dbcode       VARCHAR2(32),
  doctype      NUMBER,
  docserial    VARCHAR2(16),
  docnumber    VARCHAR2(32),
  docorg       VARCHAR2(256),
  docdate      DATE,
  state_compen NUMBER
)
tablespace BRSMDLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_OPER_DBCODE
  is '��������� ���������� �� �������� �� ��� ���������';
-- Add comments to the columns 
comment on column COMPEN_OPER_DBCODE.oper_id
  is '������������� ��������';
comment on column COMPEN_OPER_DBCODE.dbcode
  is '����� ��� �������������';
comment on column COMPEN_OPER_DBCODE.doctype
  is '��� ���������';
comment on column COMPEN_OPER_DBCODE.docserial
  is '���� ���������';
comment on column COMPEN_OPER_DBCODE.docnumber
  is '����� ���������';
comment on column COMPEN_OPER_DBCODE.docorg
  is '�����, �� ����� ��������';
comment on column COMPEN_OPER_DBCODE.docdate
  is '���� ������ ���������';
comment on column COMPEN_OPER_DBCODE.state_compen
  is '������ ������ ���� ������������ ����';

-- Create/Rebegin
begin
    execute immediate 'create index IDX_COMPEN_DBCODE_OPER_ID on COMPEN_OPER_DBCODE (OPER_ID)
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table COMPEN_OPER_DBCODE
  add constraint ��_COMPEN_OPER_DBCODE_ID_NN
  check ("OPER_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table COMPEN_OPER_DBCODE add type_person number(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_OPER_DBCODE.type_person is '��� ����� 0-��� 1-�� (��.��������)';

begin
    execute immediate 'alter table COMPEN_OPER_DBCODE add name_person varchar2(255)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_OPER_DBCODE.name_person is '����� ��.����� (��.��������)';

begin
    execute immediate 'alter table COMPEN_OPER_DBCODE add edrpo_person varchar2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_OPER_DBCODE.edrpo_person is '������ ��.����� (��.��������)';
