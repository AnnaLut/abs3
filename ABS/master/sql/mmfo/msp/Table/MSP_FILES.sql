begin
    execute immediate 'create table MSP_FILES
(
  id               NUMBER(38),
  file_bank_num    VARCHAR2(5 CHAR),
  file_filia_num   VARCHAR2(5 CHAR),
  file_pay_day     VARCHAR2(2 CHAR),
  file_separator   VARCHAR2(1 CHAR),
  file_upszn_code  VARCHAR2(3 CHAR),
  header_lenght    NUMBER(3),
  file_date        VARCHAR2(8 CHAR),
  rec_count        NUMBER(6),
  payer_mfo        NUMBER(9),
  payer_acc        NUMBER(14),
  receiver_mfo     NUMBER(9),
  receiver_acc     NUMBER(14),
  debit_kredit     VARCHAR2(1 CHAR),
  pay_sum          NUMBER(19),
  pay_type         NUMBER(2),
  pay_oper_num     VARCHAR2(10 CHAR),
  attach_flag      VARCHAR2(1 CHAR),
  payer_name       VARCHAR2(27 CHAR),
  receiver_name    VARCHAR2(27 CHAR),
  payment_purpose  VARCHAR2(160 CHAR),
  filia_num        NUMBER(5),
  deposit_code     NUMBER(3),
  process_mode     VARCHAR2(10 CHAR),
  checksum         VARCHAR2(32 CHAR),
  state_id         NUMBER(2),
  envelope_file_id NUMBER(38),
  comm             VARCHAR2(4000)
)
tablespace BRSBIGD
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
comment on table MSP_FILES
  is '���� ����� � �������';
-- Add comments to the columns 
comment on column MSP_FILES.id
  is 'id �����';
comment on column MSP_FILES.file_bank_num
  is '����� ���������� ��볿 �����';
comment on column MSP_FILES.file_filia_num
  is '����� ������� ��볿 �����';
comment on column MSP_FILES.file_pay_day
  is '���� �������';
comment on column MSP_FILES.file_separator
  is '������-��������� ����� � ���������� �����- �.�';
comment on column MSP_FILES.file_upszn_code
  is '��� ����� ����';
comment on column MSP_FILES.header_lenght
  is '������� ���������';
comment on column MSP_FILES.file_date
  is '���� ��������� �����';
comment on column MSP_FILES.rec_count
  is '�i���i��� i�������i���� ����i�';
comment on column MSP_FILES.payer_mfo
  is '��� �����-��������';
comment on column MSP_FILES.payer_acc
  is '������� ��������';
comment on column MSP_FILES.receiver_mfo
  is '��� �����-����������';
comment on column MSP_FILES.receiver_acc
  is '������� ����������';
comment on column MSP_FILES.debit_kredit
  is '������ "�����/������" �������';
comment on column MSP_FILES.pay_sum
  is '���� (� ���.) �������';
comment on column MSP_FILES.pay_type
  is '��� �������';
comment on column MSP_FILES.pay_oper_num
  is '����� (������i����) �������';
comment on column MSP_FILES.attach_flag
  is '������ ��������i ������� �� �������';
comment on column MSP_FILES.payer_name
  is '������������ ��������';
comment on column MSP_FILES.receiver_name
  is '������������ ����������';
comment on column MSP_FILES.payment_purpose
  is '����������� �������';
comment on column MSP_FILES.filia_num
  is '����� �i�i�';
comment on column MSP_FILES.deposit_code
  is '��� ������';
comment on column MSP_FILES.process_mode
  is '������ �������';
comment on column MSP_FILES.checksum
  is '�� ��� ��';
comment on column MSP_FILES.state_id
  is '���� �����';
comment on column MSP_FILES.envelope_file_id
  is 'id ��������������� �����';

begin
-- Create/Rebegin
    execute immediate 'create index I_MSP_FILES_ENV_FILE_ID on MSP_FILES (ENVELOPE_FILE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'create index I_MSP_FILE_STATE_ID on MSP_FILES (STATE_ID)';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table MSP_FILES
  add constraint PK_MSP_FILE primary key (ID)
  using index';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILES
  add constraint FK_MSP_FILE_STATE_ID foreign key (STATE_ID)
  references MSP_FILE_STATE (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table MSP_FILES
  add constraint CC_MSP_FILE_ENV_FILE_ID_NN
  check ("ENVELOPE_FILE_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table MSP_FILES
  add constraint CC_MSP_FILE_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 
