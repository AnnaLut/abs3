begin
bpa.alter_policy_info(p_table_name    => 'SUBSIDY_DATA',
                      p_policy_group  => 'WHOLE',
                      p_select_policy => null,
                      p_insert_policy => null,
                      p_update_policy => null,
                      p_delete_policy => null);
end;
/
-- Create table
prompt ... 


-- Create table
begin
    execute immediate 'create table SUBSIDY_DATA
(
  extreqid          VARCHAR2(300) not null,
  receiveraccnum    VARCHAR2(15),
  receivername      VARCHAR2(38),
  receiveridentcode VARCHAR2(14),
  receiverbankcode  VARCHAR2(12),
  amount            NUMBER,
  purpose           VARCHAR2(160),
  signature         VARCHAR2(64),
  extrowid          NUMBER not null,
  ref               NUMBER,
  feerate           NUMBER(38),
  receiverrnk       NUMBER(38),
  payeraccnum 	    VARCHAR2(29),
  payerbankcode     VARCHAR2(12),
  err               varchar2(1000)
)
tablespace BRSDYND';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column SUBSIDY_DATA.extreqid
  is '������������� ������ � �������� �������';
comment on column SUBSIDY_DATA.receiveraccnum
  is '����� ������� ����������';
comment on column SUBSIDY_DATA.receivername
  is '����� ����������';
comment on column SUBSIDY_DATA.receiveridentcode
  is '������/��� ����������  ';
comment on column SUBSIDY_DATA.receiverbankcode
  is '��� ����� ����������';
comment on column SUBSIDY_DATA.amount
  is '���� �������   � �������';
comment on column SUBSIDY_DATA.purpose
  is '����������� �������';
comment on column SUBSIDY_DATA.signature
  is 'MAC ����� �����, ��������� ������ ���-������� �� HMA� SH1';
comment on column SUBSIDY_DATA.extrowid
  is '������������� ����� � �������� �������';
comment on column SUBSIDY_DATA.ref
  is '������� ���������';
comment on column SUBSIDY_DATA.err
  is '����������� ��� ������� ��� �����';

begin
-- Create/Rebegin
    execute immediate 'create index I_PK_SUBSIDY_DATA_REF on SUBSIDY_DATA (REF)
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SUBSIDY_DATA
  add constraint PK_SUBSIDY_DATA primary key (EXTREQID, EXTROWID)
  using index 
  tablespace BRSMDLI';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table SUBSIDY_DATA add feerate NUMBER(38)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table SUBSIDY_DATA add receiverrnk NUMBER(38)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table SUBSIDY_DATA add payeraccnum VARCHAR2(29)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table SUBSIDY_DATA add payerbankcode VARCHAR2(12)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table SUBSIDY_DATA
  add constraint UK_SUBSIDY_DATA unique (EXTROWID)
  using index 
  tablespace BRSDYND';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column SUBSIDY_DATA.payeraccnum
  is '����� ������� ����������';
comment on column SUBSIDY_DATA.payerbankcode
  is '��� ����� ����������';
comment on column SUBSIDY_DATA.feerate
  is '������� �����';
comment on column SUBSIDY_DATA.receiverrnk
  is '��� ����������';
