exec bpa.alter_policy_info('USSR2_ACT_DPT_DATA', 'filial', null, null, null, null);
exec bpa.alter_policy_info('USSR2_ACT_DPT_DATA', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table USSR2_ACT_DPT_DATA
(
  act_id       NUMBER,
  id           NUMBER,
  crv_dpt_id   NUMBER,
  crv_branch   VARCHAR2(30),
  crv_nsc      VARCHAR2(19),
  crv_ost      NUMBER,
  asvo_dbcode  VARCHAR2(14),
  asvo_branch  VARCHAR2(30),
  asvo_nsc     VARCHAR2(19),
  asvo_ost     NUMBER,
  key_approved NUMBER(1),
  key_comment  VARCHAR2(300),
  pmt_sum      NUMBER,
  pmt_inf_ref  NUMBER,
  pmt_int_ref  NUMBER,
  crv_fio      VARCHAR2(100),
  asvo_fio     VARCHAR2(100)
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
comment on table USSR2_ACT_DPT_DATA
  is 'Параметри вкладу';
-- Add comments to the columns 
comment on column USSR2_ACT_DPT_DATA.act_id
  is 'Ідентифікатор актуалізації';
comment on column USSR2_ACT_DPT_DATA.crv_dpt_id
  is 'Ідентифікатор вкладу у ЦРВ';
comment on column USSR2_ACT_DPT_DATA.crv_branch
  is 'Код відділення вкладу у ЦРВ';
comment on column USSR2_ACT_DPT_DATA.crv_nsc
  is 'Номер вкладу у ЦРВ';
comment on column USSR2_ACT_DPT_DATA.crv_ost
  is 'Залишок по вкладу у ЦРВ';
comment on column USSR2_ACT_DPT_DATA.asvo_dbcode
  is 'DBCODE клієнта у АCВО';
comment on column USSR2_ACT_DPT_DATA.asvo_branch
  is 'Код відділення вкладу у АCВО';
comment on column USSR2_ACT_DPT_DATA.asvo_nsc
  is 'Номер вкладу у АCВО';
comment on column USSR2_ACT_DPT_DATA.asvo_ost
  is 'Залишок по вкладу у АCВО';
comment on column USSR2_ACT_DPT_DATA.key_approved
  is 'Ключовий реквізит - вклад підтверджено';
comment on column USSR2_ACT_DPT_DATA.key_comment
  is 'Ключовий реквізит - текст перевіки';
comment on column USSR2_ACT_DPT_DATA.pmt_sum
  is 'Сума платежу для списаня з вкладу';
comment on column USSR2_ACT_DPT_DATA.pmt_inf_ref
  is 'Референс інформаційного документу';
comment on column USSR2_ACT_DPT_DATA.pmt_int_ref
  is 'Референс внутрішнього документу';
comment on column USSR2_ACT_DPT_DATA.crv_fio
  is 'ПІБ власника вкладу у ЦРВ';
comment on column USSR2_ACT_DPT_DATA.asvo_fio
  is 'ПІБ власника вкладу у АCВО';

-- Create/Rebegin
begin
    execute immediate 'create index I1_USSR2_ACT_DPT_DATA on USSR2_ACT_DPT_DATA (ASVO_DBCODE)
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
    execute immediate 'alter table USSR2_ACT_DPT_DATA
  add constraint PK_USSR2ACTDPTDATA primary key (ACT_ID, ID)
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
    execute immediate 'alter table USSR2_ACT_DPT_DATA
  add constraint FK_ACTDPTDATA_AID_ACTS_ID foreign key (ACT_ID)
  references USSR2_ACTUALIZATIONS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table USSR2_ACT_DPT_DATA
  add constraint CC_ACTDPTDATA_KAPPROVED
  check (key_approved is null or key_approved in (0, 1))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACT_DPT_DATA
  add constraint CC_U2ACTDPTDATA_REFS
  check ((pmt_inf_ref is null and pmt_int_ref is null) or (pmt_inf_ref is not null and pmt_int_ref is not null))';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACT_DPT_DATA
  add constraint CC_USSR2ACTDPTDATA_ACTID_NN
  check ("ACT_ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table USSR2_ACT_DPT_DATA
  add constraint CC_USSR2ACTDPTDATA_ID_NN
  check ("ID" IS NOT NULL)';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select on USSR2_ACT_DPT_DATA to PUBLIC;
