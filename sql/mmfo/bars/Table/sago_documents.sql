BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SAGO_DOCUMENTS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SAGO_DOCUMENTS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

begin
    execute immediate 'create table BARS.SAGO_DOCUMENTS
(
  ref_our      NUMBER(38),
  ref_sago     NUMBER(38),
  act          VARCHAR2(4),
  act_type     NUMBER(1),
  act_date     DATE,
  total_amount NUMBER,
  reg_id       NUMBER(2),
  f_state      NUMBER(4),
  n_doc        VARCHAR2(10),
  d_doc        DATE,
  user_id      VARCHAR2(8),
  fio_reg      VARCHAR2(64),
  sign         VARCHAR2(256),
  request_id   NUMBER(38),
  id           NUMBER(38) not null
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

-- Add comments to the columns 
comment on column BARS.SAGO_DOCUMENTS.ref_our
  is '��� ������������� ���������';
comment on column BARS.SAGO_DOCUMENTS.ref_sago
  is '��������� ������������� �������� � ����';
comment on column BARS.SAGO_DOCUMENTS.act
  is '��� �������� ';
comment on column BARS.SAGO_DOCUMENTS.act_type
  is '��� ��������';
comment on column BARS.SAGO_DOCUMENTS.act_date
  is '���� ��������';
comment on column BARS.SAGO_DOCUMENTS.total_amount
  is '���� �������� � ������� ';
comment on column BARS.SAGO_DOCUMENTS.reg_id
  is '��� ������(������)';
comment on column BARS.SAGO_DOCUMENTS.f_state
  is '�������� ���� �������� � ������ (9999 � ��������
��������)';
comment on column BARS.SAGO_DOCUMENTS.n_doc
  is '����� ���������';
comment on column BARS.SAGO_DOCUMENTS.d_doc
  is '���� �������';
comment on column BARS.SAGO_DOCUMENTS.user_id
  is 'AD-�������������';
comment on column BARS.SAGO_DOCUMENTS.fio_reg
  is '�.�.�.';
comment on column BARS.SAGO_DOCUMENTS.sign
  is '�������� �����';
comment on column BARS.SAGO_DOCUMENTS.request_id
  is '����� ������';
comment on column BARS.SAGO_DOCUMENTS.id
  is '������������� ������';
-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table BARS.SAGO_DOCUMENTS
  add constraint PK_SAGO_DOCUMENTS primary key (ID)
  using index 
  tablespace BRSDYND
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
    execute immediate 'alter table BARS.SAGO_DOCUMENTS
                         add constraint UK_SAGO_DOCUMENTS unique (REF_SAGO)
                         using index 
                         tablespace BRSDYND
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
    if sqlcode = -2261 or sqlcode = -2260 or sqlcode = -2275 then null; else raise; 
    end if; 
end;
/

begin
    execute immediate 'alter table BARS.SAGO_DOCUMENTS
                         add constraint FK_SAGO_DOCUMENTS_REQ foreign key (REQUEST_ID)
                         references BARS.SAGO_REQUESTS (ID)';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 or sqlcode = -2275 then null; else raise; 
    end if; 
end;
/