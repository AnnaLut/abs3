begin 
  bpa.alter_policy_info('CORP2_REL_CUSTOMERS', 'WHOLE',  null,  null, null, null);
end;
/

begin
  bpa.alter_policy_info('CORP2_REL_CUSTOMERS', 'FILIAL',  null,  null, null, null);
end;

/
-- Create table
begin
    execute immediate 'create table CORP2_REL_CUSTOMERS
(
  id               NUMBER not null,
  tax_code         VARCHAR2(15),
  first_name       VARCHAR2(200),
  last_name        VARCHAR2(200),
  second_name      VARCHAR2(200),
  doc_type         VARCHAR2(10),
  doc_series       VARCHAR2(10),
  doc_number       VARCHAR2(10),
  doc_organization VARCHAR2(300),
  doc_date         DATE,
  birth_date       DATE,
  created_date     DATE default sysdate,
  cell_phone       VARCHAR2(20),
  address          VARCHAR2(4000),
  email            VARCHAR2(100),  
  no_inn           char(1),
  ACSK_ACTUAL      NUMBER(1),
  LOGIN            VARCHAR2(60),
  ACTIVATE_DATE    DATE,
  KEY_ID           VARCHAR2(20)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table CORP2_REL_CUSTOMERS
  is 'Корисувачі Corp2';
-- Add comments to the columns 
comment on column CORP2_REL_CUSTOMERS.id
  is 'Ід корисувача';
comment on column CORP2_REL_CUSTOMERS.tax_code
  is 'ІНН корисувача';
comment on column CORP2_REL_CUSTOMERS.first_name
  is 'Імя користувача';
comment on column CORP2_REL_CUSTOMERS.last_name
  is 'Прізвище користувача';
comment on column CORP2_REL_CUSTOMERS.second_name
  is 'По-батькові користувача';
comment on column CORP2_REL_CUSTOMERS.doc_type
  is 'Тип документу';
comment on column CORP2_REL_CUSTOMERS.doc_series
  is 'Серія документу';
comment on column CORP2_REL_CUSTOMERS.doc_number
  is 'Номер документу';
comment on column CORP2_REL_CUSTOMERS.doc_organization
  is 'Організація, що видала документ';
comment on column CORP2_REL_CUSTOMERS.doc_date
  is 'Дата документу';
comment on column CORP2_REL_CUSTOMERS.birth_date
  is 'Дата народження';
comment on column CORP2_REL_CUSTOMERS.created_date
  is 'Дата створення користувача';
comment on column CORP2_REL_CUSTOMERS.cell_phone
  is 'Номер телефону';
comment on column CORP2_REL_CUSTOMERS.address
  is 'Адреса';
comment on column CORP2_REL_CUSTOMERS.email
  is 'Електронна адреса';
comment on column CORP2_REL_CUSTOMERS.no_inn
  is 'Ознака відмови від ІНН';
comment on column CORP2_REL_CUSTOMERS.acsk_actual
  is 'Ознака АЦСК';
comment on column CORP2_REL_CUSTOMERS.login
  is 'Логін користувача в КОРП2';
comment on column CORP2_REL_CUSTOMERS.activate_date
  is 'Дата активації';
comment on column CORP2_REL_CUSTOMERS.key_id
  is 'Номер ключа ';
comment on column CORP2_REL_CUSTOMERS.fio_card
  is 'ФІО користувача в родовому відмінку';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CORP2_REL_CUSTOMERS
  add constraint PK_CORP2_REL_CUSTOMERS_ID primary key (ID)
  using index 
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create unique index I_CORP2_REL_CUSTOMER on CORP2_REL_CUSTOMERS (LOGIN)
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
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table CORP2_REL_CUSTOMERS add fio_card VARCHAR2(70)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete, alter, debug on CORP2_REL_CUSTOMERS to BARS_ACCESS_DEFROLE;
