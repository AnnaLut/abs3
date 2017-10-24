exec bpa.alter_policy_info('CUSTOMER_CRKR_UPDATE', 'filial', null, null, null, null);
exec bpa.alter_policy_info('CUSTOMER_CRKR_UPDATE', 'whole',  null,  null, null, null);

-- Create table
begin
    execute immediate 'create table CUSTOMER_CRKR_UPDATE
(
  id            NUMBER not null,
  rnk           NUMBER(38) not null,
  name          VARCHAR2(70),
  inn           VARCHAR2(14),
  id_sex        CHAR(1),
  birth_date    DATE,
  rezid         NUMBER,
  id_doc_type   INTEGER,
  ser           VARCHAR2(10),
  numdoc        VARCHAR2(20),
  date_of_issue DATE,
  tel           VARCHAR2(20),
  tel_mob       VARCHAR2(20),
  branch        VARCHAR2(30) not null,
  notes         VARCHAR2(140),
  date_registry DATE not null,
  zip           VARCHAR2(20),
  domain        VARCHAR2(30),
  region        VARCHAR2(30),
  locality      VARCHAR2(30),
  address       VARCHAR2(100),
  user_id       NUMBER,
  user_fio      VARCHAR2(100),
  lastedit      DATE default sysdate,
  mfo           VARCHAR2(12),
  nls           VARCHAR2(15)
)
tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Rebegin
begin
    execute immediate 'create index IDX_CUSTOMER_CRKR_UPD_RNK on CUSTOMER_CRKR_UPDATE (RNK)
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE
  add constraint PK_CUSTOMER_CRKR_UPD primary key (ID)
  using index 
  tablespace BRSBIGD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add secondary NUMBER(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add okpo VARCHAR2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add date_val_reg DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add change_info varchar2(2000)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add birth_place varchar2(70)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add eddr_id varchar2(20)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add actual_date date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CUSTOMER_CRKR_UPDATE add country_id number(3)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


comment on column CUSTOMER_CRKR_UPDATE.date_registry
  is '';
comment on column CUSTOMER_CRKR_UPDATE.secondary
  is '1 - Представник; 0 - Звичайна фіз. особа';
comment on column CUSTOMER_CRKR_UPDATE.okpo
  is 'Код ЄДРПОУ';
comment on column CUSTOMER_CRKR_UPDATE.date_val_reg
  is 'Дата тіпа валютування. Планова дата виплати';
comment on column CUSTOMER_CRKR_UPDATE.change_info
  is 'Зміни по полям';
-- Grant/Revoke object privileges 
grant select on CUSTOMER_CRKR_UPDATE to BARS_ACCESS_DEFROLE;
