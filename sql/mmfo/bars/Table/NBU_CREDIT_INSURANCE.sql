begin
  BPA.ALTER_POLICY_INFO( 'NBU_CREDIT_INSURANCE', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'NBU_CREDIT_INSURANCE', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table NBU_CREDIT_INSURANCE
(
  kf      VARCHAR2(6) not null,
  numb    NUMBER(38) not null,
  branch  VARCHAR2(30),
  nmk     VARCHAR2(70),
  okpo    VARCHAR2(14),
  typezp  VARCHAR2(10),
  zallast VARCHAR2(30),
  zabday  VARCHAR2(30),
  rate    VARCHAR2(10),
  sum     VARCHAR2(30),
  tar     VARCHAR2(15),
  strsum  VARCHAR2(30),
  range   VARCHAR2(10),
  nls     VARCHAR2(15),
  kv      NUMBER(3),
  rnk     NUMBER(38),
  nd      NUMBER(38),
  pid     NUMBER(38) not null,
  state   NUMBER(1) default 0,
  message VARCHAR2(1000)
)
tablespace BRSDYND
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
comment on table NBU_CREDIT_INSURANCE
  is '������ ������������� ����������� �������� ���';
-- Add comments to the columns 
comment on column NBU_CREDIT_INSURANCE.kf
  is '��';
comment on column NBU_CREDIT_INSURANCE.numb
  is '��/�';
comment on column NBU_CREDIT_INSURANCE.branch
  is '������� ���������, ����';
comment on column NBU_CREDIT_INSURANCE.nmk
  is 'ϲ� �볺���';
comment on column NBU_CREDIT_INSURANCE.okpo
  is '��� �볺���';
comment on column NBU_CREDIT_INSURANCE.typezp
  is '��� �������� (��������, �������, ��������)';
comment on column NBU_CREDIT_INSURANCE.zallast
  is '������� �� ������� ���� ������ � ���. ���.';
comment on column NBU_CREDIT_INSURANCE.zabday
  is '������������� �������� ������������� �� ������ �����, ���.';
comment on column NBU_CREDIT_INSURANCE.rate
  is 'г��� ��������� ������,%';
comment on column NBU_CREDIT_INSURANCE.sum
  is '�������� ����, ���.';
comment on column NBU_CREDIT_INSURANCE.tar
  is '��������� ��������� �����, %';
comment on column NBU_CREDIT_INSURANCE.strsum
  is '��������� ����� �� ������ �����, ���.          (�.7 � �.8)';
comment on column NBU_CREDIT_INSURANCE.range
  is '� �������
930,75-6167';
comment on column NBU_CREDIT_INSURANCE.nls
  is '�������� ������� �볺��� �� ���� ����������� ��';
comment on column NBU_CREDIT_INSURANCE.kv
  is '������ �������';
comment on column NBU_CREDIT_INSURANCE.rnk
  is '��� ';
comment on column NBU_CREDIT_INSURANCE.nd
  is '�������� ��������';
comment on column NBU_CREDIT_INSURANCE.pid
  is 'ID ������������ ������';
comment on column NBU_CREDIT_INSURANCE.state
  is '�������. 0-���������, 1 - ����������� ��������, 2 - ������';
comment on column NBU_CREDIT_INSURANCE.message
  is '��������� �� ������';

-- Create/Rebegin
begin
    execute immediate '
create index I_NBUCREDITINSURANCE_KFND on NBU_CREDIT_INSURANCE (KF, ND)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin 
  execute immediate 'ALTER TABLE BARS.NBU_CREDIT_INSURANCE DROP PRIMARY KEY';
exception when others then 
  if sqlcode in (-942,-02441) then null; else raise; end if;
end;
/


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table NBU_CREDIT_INSURANCE
  add constraint PK_NBUCREDITINSURANCE primary key (PID, ND)
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

