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
  is 'Параметри клієнта';
-- Add comments to the columns 
comment on column USSR2_ACT_CLIENT_DATA.act_id
  is 'Ідентифікатор актуалізації';
comment on column USSR2_ACT_CLIENT_DATA.crv_rnk
  is 'РНК клієнта у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.crv_dbcode
  is 'DBCODE клієнта у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.asvo_dbcode
  is 'DBCODE клієнта у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.asvo_rnk
  is 'РНК клієнта у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.cl_approved
  is 'Клієнта підтверджено';
comment on column USSR2_ACT_CLIENT_DATA.cl_comment
  is 'текст перевіки';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_type_crv
  is 'Ключовий реквізит - вид документу - ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_ser_crv
  is 'Ключовий реквізит - серія документу - ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_num_crv
  is 'Ключовий реквізит - номер документу - ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_type_asvo
  is 'Ключовий реквізит - вид документу - АСВО';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_ser_asvo
  is 'Ключовий реквізит - серія документу - АСВО';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_num_asvo
  is 'Ключовий реквізит - номер документу - АСВО';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_approved
  is 'Ключовий реквізит - документ підтверджено';
comment on column USSR2_ACT_CLIENT_DATA.key_doc_comment
  is 'Ключовий реквізит - текст перевіки';
comment on column USSR2_ACT_CLIENT_DATA.fio_crv
  is 'ПІБ у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.fio_asvo
  is 'ПІБ у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.fio_final
  is 'ПІБ кінцевий';
comment on column USSR2_ACT_CLIENT_DATA.bdate_crv
  is 'Дата народження у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.bdate_asvo
  is 'Дата народження у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.bdate_final
  is 'Дата народження кінцева';
comment on column USSR2_ACT_CLIENT_DATA.doc_issuer_crv
  is 'Ким видано документ у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.doc_issuer_asvo
  is 'Ким видано документ у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.doc_issuer_final
  is 'Ким видано документ кінцевий';
comment on column USSR2_ACT_CLIENT_DATA.doc_issue_date_crv
  is 'Коли видано документ у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.doc_issue_date_asvo
  is 'Коли видано документ у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.doc_issue_date_final
  is 'Коли видано документ кінцевий';
comment on column USSR2_ACT_CLIENT_DATA.adr_idx_crv
  is 'Адреса у ЦРВ - індекс';
comment on column USSR2_ACT_CLIENT_DATA.adr_idx_asvo
  is 'Адреса у АСВО - індекс';
comment on column USSR2_ACT_CLIENT_DATA.adr_idx_final
  is 'Адреса кінцева - індекс';
comment on column USSR2_ACT_CLIENT_DATA.adr_obl_crv
  is 'Адреса у ЦРВ - область';
comment on column USSR2_ACT_CLIENT_DATA.adr_obl_asvo
  is 'Адреса у АСВО - область';
comment on column USSR2_ACT_CLIENT_DATA.adr_obl_final
  is 'Адреса кінцева - область';
comment on column USSR2_ACT_CLIENT_DATA.adr_dst_crv
  is 'Адреса у ЦРВ - район';
comment on column USSR2_ACT_CLIENT_DATA.adr_dst_asvo
  is 'Адреса у АСВО - район';
comment on column USSR2_ACT_CLIENT_DATA.adr_dst_final
  is 'Адреса кінцева - район';
comment on column USSR2_ACT_CLIENT_DATA.adr_twn_crv
  is 'Адреса у ЦРВ - нас. пунк';
comment on column USSR2_ACT_CLIENT_DATA.adr_twn_asvo
  is 'Адреса у АСВО - нас. пунк';
comment on column USSR2_ACT_CLIENT_DATA.adr_twn_final
  is 'Адреса кінцева - нас. пунк';
comment on column USSR2_ACT_CLIENT_DATA.adr_adr_crv
  is 'Адреса у ЦРВ - вулиця, дім, квартира';
comment on column USSR2_ACT_CLIENT_DATA.adr_adr_asvo
  is 'Адреса у АСВО - вулиця, дім, квартира';
comment on column USSR2_ACT_CLIENT_DATA.adr_adr_final
  is 'Адреса кінцева - вулиця, дім, квартира';
comment on column USSR2_ACT_CLIENT_DATA.okpo_crv
  is 'ІПН у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.okpo_asvo
  is 'ІПН у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.okpo_final
  is 'ІПН кінцева';
comment on column USSR2_ACT_CLIENT_DATA.sec_word_crv
  is 'Секретне слово у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.sec_word_asvo
  is 'Секретне слово у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.sec_word_final
  is 'Секретне слово кінцева';
comment on column USSR2_ACT_CLIENT_DATA.tel1_crv
  is 'Телефон 1 у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.tel1_asvo
  is 'Телефон 1 у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.tel1_final
  is 'Телефон 1 кінцева';
comment on column USSR2_ACT_CLIENT_DATA.tel2_crv
  is 'Телефон 2 у ЦРВ';
comment on column USSR2_ACT_CLIENT_DATA.tel2_asvo
  is 'Телефон 2 у АСВО';
comment on column USSR2_ACT_CLIENT_DATA.tel2_final
  is 'Телефон 2 кінцева';

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
