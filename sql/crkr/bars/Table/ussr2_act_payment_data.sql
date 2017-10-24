exec bpa.alter_policy_info('USSR2_ACT_PAYMENT_DATA', 'filial', null, null, null, null);
exec bpa.alter_policy_info('USSR2_ACT_PAYMENT_DATA', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table USSR2_ACT_PAYMENT_DATA
(
  act_id                NUMBER not null,
  card_issue_date       DATE,
  card_abs_branch       VARCHAR2(30),
  card_abs_account      VARCHAR2(20),
  payment_date          DATE,
  card_issue_branch     VARCHAR2(30),
  card_issue_branch_adr VARCHAR2(300),
  card_abs_match        VARCHAR2(100),
  card_abs_match_text   VARCHAR2(1000),
  card_abs_match_fileid NUMBER,
  payment_match         VARCHAR2(100),
  payment_match_text    VARCHAR2(1000),
  payment_match_date    DATE
)
tablespace BRSBIGD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 4M
    next 4M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table USSR2_ACT_PAYMENT_DATA
  is '�������� �������';
-- Add comments to the columns 
comment on column USSR2_ACT_PAYMENT_DATA.act_id
  is '������������� �����������';
comment on column USSR2_ACT_PAYMENT_DATA.card_issue_date
  is '���� ������ ������';
comment on column USSR2_ACT_PAYMENT_DATA.card_abs_branch
  is '³������� ������ � ��c';
comment on column USSR2_ACT_PAYMENT_DATA.card_abs_account
  is '��������� ������� � ��c';
comment on column USSR2_ACT_PAYMENT_DATA.payment_date
  is '���� �������';
comment on column USSR2_ACT_PAYMENT_DATA.card_issue_branch
  is '��� �������� ������ ������ (������)';
comment on column USSR2_ACT_PAYMENT_DATA.card_issue_branch_adr
  is '������ �������� ������ ������';
comment on column USSR2_ACT_PAYMENT_DATA.card_abs_match
  is '�������� ���������� ��� �������� ��������� �������';
comment on column USSR2_ACT_PAYMENT_DATA.card_abs_match_text
  is '����� �������� ���������� ��� �������� ��������� �������';
comment on column USSR2_ACT_PAYMENT_DATA.card_abs_match_fileid
  is '�� ����� ��������';
comment on column USSR2_ACT_PAYMENT_DATA.payment_match
  is '�������� ���������� ��� �������';
comment on column USSR2_ACT_PAYMENT_DATA.payment_match_text
  is '�������� ���������� ��� ������� - �����';
comment on column USSR2_ACT_PAYMENT_DATA.payment_match_date
  is '�������� ���������� ��� ������� - ����';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table USSR2_ACT_PAYMENT_DATA
  add constraint PK_USSR2ACTPMTDATA primary key (ACT_ID)
  using index 
  tablespace BRSBIGI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 4M
    next 4M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACT_PAYMENT_DATA
  add constraint FK_ACTPMTDATA_AID_ACTS_ID foreign key (ACT_ID)
  references USSR2_ACTUALIZATIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on USSR2_ACT_PAYMENT_DATA to PUBLIC;
