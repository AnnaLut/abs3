begin 
  bpa.alter_policy_info('CORP2_ACC_USERS', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_ACC_USERS', 'FILIAL',  null,  null, null, null);
end;
/

-- Create table
begin
    execute immediate 'create table CORP2_ACC_USERS
(
  nls             varchar2(20),
  kv              varchar2(20),
  kf              varchar2(10),
  user_id         NUMBER,
  cust_id         NUMBER,
  can_view        VARCHAR2(1),
  can_debit       VARCHAR2(1),
  can_visa        VARCHAR2(1),
  visa_id         INTEGER,
  active          VARCHAR2(1) default ''N'',
  sequential_visa VARCHAR2(1),
  constraint PK_CRPACCUSERS primary key (NLS, KV, KF, USER_ID)
)
organization index';

 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_ACC_USERS
  is '�������, �� �������� �����������';
-- Add comments to the columns 
comment on column CORP2_ACC_USERS.nls
  is '����� �������';
comment on column CORP2_ACC_USERS.kv
  is '��� ������ �������';
comment on column CORP2_ACC_USERS.kf
  is '���';
comment on column CORP2_ACC_USERS.user_id
  is '�� �����������';
comment on column CORP2_ACC_USERS.cust_id
  is '�� �볺���';
comment on column CORP2_ACC_USERS.can_view
  is '������, ���������� ���� ������ �������';
comment on column CORP2_ACC_USERS.can_debit
  is '������, ���������� ���� ���������� ����� � ����� �������';
comment on column CORP2_ACC_USERS.can_visa
  is '������, ���������� ���� ������� �����';
comment on column CORP2_ACC_USERS.visa_id
  is '����� ��� ����������� �� �������';
comment on column CORP2_ACC_USERS.active
  is '�������� ������ Y/N';
comment on column CORP2_ACC_USERS.sequential_visa
  is '����������� ���';

grant select, insert, update, delete, alter on CORP2_ACC_USERS to BARS_ACCESS_DEFROLE;