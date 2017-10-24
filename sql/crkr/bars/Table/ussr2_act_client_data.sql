exec bpa.alter_policy_info('USSR2_ACT_CLIENT_DATA', 'filial', null, null, null, null);
exec bpa.alter_policy_info('USSR2_ACT_CLIENT_DATA', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table USSR2_ACT_CLIENT_DATA
(
  act_id               NUMBER not null,
  crv_rnk              NUMBER,
  crv_dbcode           VARCHAR2(16),
  asvo_dbcode          VARCHAR2(16),
  asvo_rnk             NUMBER,
  cl_approved          NUMBER(1) default 0,
  cl_comment           VARCHAR2(300),
  key_doc_type_crv     NUMBER,
  key_doc_ser_crv      VARCHAR2(7),
  key_doc_num_crv      VARCHAR2(20),
  key_doc_type_asvo    NUMBER,
  key_doc_ser_asvo     VARCHAR2(7),
  key_doc_num_asvo     VARCHAR2(20),
  key_doc_approved     NUMBER(1) default 0,
  key_doc_comment      VARCHAR2(300),
  fio_crv              VARCHAR2(170),
  fio_asvo             VARCHAR2(170),
  fio_final            VARCHAR2(170),
  bdate_crv            DATE,
  bdate_asvo           DATE,
  bdate_final          DATE,
  doc_issuer_crv       VARCHAR2(300),
  doc_issuer_asvo      VARCHAR2(300),
  doc_issuer_final     VARCHAR2(300),
  doc_issue_date_crv   DATE,
  doc_issue_date_asvo  DATE,
  doc_issue_date_final DATE,
  adr_idx_crv          VARCHAR2(10),
  adr_idx_asvo         VARCHAR2(10),
  adr_idx_final        VARCHAR2(10),
  adr_obl_crv          VARCHAR2(120),
  adr_obl_asvo         VARCHAR2(120),
  adr_obl_final        VARCHAR2(120),
  adr_dst_crv          VARCHAR2(120),
  adr_dst_asvo         VARCHAR2(120),
  adr_dst_final        VARCHAR2(120),
  adr_twn_crv          VARCHAR2(120),
  adr_twn_asvo         VARCHAR2(120),
  adr_twn_final        VARCHAR2(120),
  adr_adr_crv          VARCHAR2(140),
  adr_adr_asvo         VARCHAR2(140),
  adr_adr_final        VARCHAR2(140),
  okpo_crv             VARCHAR2(120),
  okpo_asvo            VARCHAR2(120),
  okpo_final           VARCHAR2(120),
  sec_word_crv         VARCHAR2(120),
  sec_word_asvo        VARCHAR2(120),
  sec_word_final       VARCHAR2(120),
  tel1_crv             VARCHAR2(16),
  tel1_asvo            VARCHAR2(16),
  tel1_final           VARCHAR2(16),
  tel2_crv             VARCHAR2(16),
  tel2_asvo            VARCHAR2(16),
  tel2_final           VARCHAR2(16)
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
comment on table USSR2_ACT_CLIENT_DATA
  is '��������� �볺���';
-- Add comments to the columns 
comment on column USSR2_ACT_CLIENT_DATA.act_id
  is '������������� �����������';
comment on column USSR2_ACT_CLIENT_DATA.crv_rnk
  is '��� �볺��� � ���';
comment on column USSR2_ACT_CLIENT_DATA.crv_dbcode
  is 'DBCODE �볺��� � ���';
comment on column USSR2_ACT_CLIENT_DATA.asvo_dbcode
  is 'DBCODE �볺��� � ����';
comment on column USSR2_ACT_CLIENT_DATA.asvo_rnk
  is '��� �볺��� � ����';
comment on column USSR2_ACT_CLIENT_DATA.cl_approved
  is '�볺��� �����������';
comment on column USSR2_ACT_CLIENT_DATA.cl_comment
  is '����� �������';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_type_crv
  is '�������� ������� - ��� ��������� - ���';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_ser_crv
  is '�������� ������� - ���� ��������� - ���';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_num_crv
  is '�������� ������� - ����� ��������� - ���';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_type_asvo
  is '�������� ������� - ��� ��������� - ����';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_ser_asvo
  is '�������� ������� - ���� ��������� - ����';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_num_asvo
  is '�������� ������� - ����� ��������� - ����';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_approved
  is '�������� ������� - �������� �����������';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_comment
  is '�������� ������� - ����� �������';
comment on column USSR2_ACT_CLIENT_DATA.fio_crv
  is 'ϲ� � ���';
comment on column USSR2_ACT_CLIENT_DATA.fio_asvo
  is 'ϲ� � ����';
comment on column USSR2_ACT_CLIENT_DATA.fio_final
  is 'ϲ� �������';
comment on column USSR2_ACT_CLIENT_DATA.bdate_crv
  is '���� ���������� � ���';
comment on column USSR2_ACT_CLIENT_DATA.bdate_asvo
  is '���� ���������� � ����';
comment on column USSR2_ACT_CLIENT_DATA.bdate_final
  is '���� ���������� ������';
comment on column USSR2_ACT_CLIENT_DATA.doc_issuer_crv
  is '��� ������ �������� � ���';
comment on column USSR2_ACT_CLIENT_DATA.doc_issuer_asvo
  is '��� ������ �������� � ����';
comment on column USSR2_ACT_CLIENT_DATA.doc_issuer_final
  is '��� ������ �������� �������';
comment on column USSR2_ACT_CLIENT_DATA.doc_issue_date_crv
  is '���� ������ �������� � ���';
comment on column USSR2_ACT_CLIENT_DATA.doc_issue_date_asvo
  is '���� ������ �������� � ����';
comment on column USSR2_ACT_CLIENT_DATA.doc_issue_date_final
  is '���� ������ �������� �������';
comment on column USSR2_ACT_CLIENT_DATA.adr_idx_crv
  is '������ � ��� - ������';
comment on column USSR2_ACT_CLIENT_DATA.adr_idx_asvo
  is '������ � ���� - ������';
comment on column USSR2_ACT_CLIENT_DATA.adr_idx_final
  is '������ ������ - ������';
comment on column USSR2_ACT_CLIENT_DATA.adr_obl_crv
  is '������ � ��� - �������';
comment on column USSR2_ACT_CLIENT_DATA.adr_obl_asvo
  is '������ � ���� - �������';
comment on column USSR2_ACT_CLIENT_DATA.adr_obl_final
  is '������ ������ - �������';
comment on column USSR2_ACT_CLIENT_DATA.adr_dst_crv
  is '������ � ��� - �����';
comment on column USSR2_ACT_CLIENT_DATA.adr_dst_asvo
  is '������ � ���� - �����';
comment on column USSR2_ACT_CLIENT_DATA.adr_dst_final
  is '������ ������ - �����';
comment on column USSR2_ACT_CLIENT_DATA.adr_twn_crv
  is '������ � ��� - ���. ����';
comment on column USSR2_ACT_CLIENT_DATA.adr_twn_asvo
  is '������ � ���� - ���. ����';
comment on column USSR2_ACT_CLIENT_DATA.adr_twn_final
  is '������ ������ - ���. ����';
comment on column USSR2_ACT_CLIENT_DATA.adr_adr_crv
  is '������ � ��� - ������, ��, ��������';
comment on column USSR2_ACT_CLIENT_DATA.adr_adr_asvo
  is '������ � ���� - ������, ��, ��������';
comment on column USSR2_ACT_CLIENT_DATA.adr_adr_final
  is '������ ������ - ������, ��, ��������';
comment on column USSR2_ACT_CLIENT_DATA.okpo_crv
  is '��� � ���';
comment on column USSR2_ACT_CLIENT_DATA.okpo_asvo
  is '��� � ����';
comment on column USSR2_ACT_CLIENT_DATA.okpo_final
  is '��� ������';
comment on column USSR2_ACT_CLIENT_DATA.sec_word_crv
  is '�������� ����� � ���';
comment on column USSR2_ACT_CLIENT_DATA.sec_word_asvo
  is '�������� ����� � ����';
comment on column USSR2_ACT_CLIENT_DATA.sec_word_final
  is '�������� ����� ������';
comment on column USSR2_ACT_CLIENT_DATA.tel1_crv
  is '������� 1 � ���';
comment on column USSR2_ACT_CLIENT_DATA.tel1_asvo
  is '������� 1 � ����';
comment on column USSR2_ACT_CLIENT_DATA.tel1_final
  is '������� 1 ������';
comment on column USSR2_ACT_CLIENT_DATA.tel2_crv
  is '������� 2 � ���';
comment on column USSR2_ACT_CLIENT_DATA.tel2_asvo
  is '������� 2 � ����';
comment on column USSR2_ACT_CLIENT_DATA.tel2_final
  is '������� 2 ������';

-- Create/Rebegin
begin
    execute immediate 'create index I1_USSR2_ACT_CLIENT_DATA on USSR2_ACT_CLIENT_DATA (ASVO_DBCODE)
  tablespace USERS
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


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table USSR2_ACT_CLIENT_DATA
  add constraint PK_USSR2ACTCLDATA primary key (ACT_ID)
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
    execute immediate 'alter table USSR2_ACT_CLIENT_DATA
  add constraint FK_ACTCLDATA_AID_ACTS_ID foreign key (ACT_ID)
  references USSR2_ACTUALIZATIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on USSR2_ACT_CLIENT_DATA to PUBLIC;
