begin 
  bpa.alter_policy_info('CORP2_ACSK_CERTIFICATE_REQ', 'WHOLE',  null,  null, null, null);
end;
/
begin
  bpa.alter_policy_info('CORP2_ACSK_CERTIFICATE_REQ', 'FILIAL',  null,  null, null, null);
end;

/

-- Create table
begin
    execute immediate 'create table CORP2_ACSK_CERTIFICATE_REQ
(
  id                    NUMBER not null,
  rel_cust_id           NUMBER,
  request_time          DATE,
  request_state         NUMBER,
  request_state_message VARCHAR2(4000),
  certificate_sn        VARCHAR2(200),
  template_name         VARCHAR2(400),
  template_oid          VARCHAR2(200),
  certificate_id        VARCHAR2(200),
  certificate_body      CLOB,
  revoke_code           NUMBER,
  token_sn              VARCHAR2(200),
  token_name            VARCHAR2(400)
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
comment on table CORP2_ACSK_CERTIFICATE_REQ
  is 'Довідник запитів на сертифікати АЦСК';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_ACSK_CERTIFICATE_REQ
  add primary key (ID)
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
    if sqlcode = -1430 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/

-- Add comments to the table 
comment on table CORP2_ACSK_CERTIFICATE_REQ
  is 'Довідник запитів на сертифікати АЦСК';
-- Add comments to the columns 
comment on column CORP2_ACSK_CERTIFICATE_REQ.id
  is 'Ід запиту';
comment on column CORP2_ACSK_CERTIFICATE_REQ.rel_cust_id
  is 'Ід користувача';
comment on column CORP2_ACSK_CERTIFICATE_REQ.request_time
  is 'Час запиту';
comment on column CORP2_ACSK_CERTIFICATE_REQ.request_state
  is 'Статус запиту';
comment on column CORP2_ACSK_CERTIFICATE_REQ.request_state_message
  is 'Коментар до статусу';
comment on column CORP2_ACSK_CERTIFICATE_REQ.certificate_sn
  is 'Серійний номер сертифікату';
comment on column CORP2_ACSK_CERTIFICATE_REQ.template_name
  is 'Тимчасова назва';
comment on column CORP2_ACSK_CERTIFICATE_REQ.template_oid
  is 'Тимчасовий Ід';
comment on column CORP2_ACSK_CERTIFICATE_REQ.certificate_id
  is 'Ід сертифікату';
comment on column CORP2_ACSK_CERTIFICATE_REQ.certificate_body
  is 'Тіло сертифікату';
comment on column CORP2_ACSK_CERTIFICATE_REQ.token_sn
  is 'Серійний номер ключа';
comment on column CORP2_ACSK_CERTIFICATE_REQ.token_name
  is 'Назва ключа';

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on CORP2_ACSK_CERTIFICATE_REQ to BARS_ACCESS_DEFROLE;
