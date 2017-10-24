exec bpa.alter_policy_info('compen_clients', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('compen_clients', 'whole',  null,  'E', 'E', 'E');

-- Create table
begin
    execute immediate 'create table COMPEN_CLIENTS
(
  rnk    NUMBER not null,
  fio    VARCHAR2(100),
  dbcode VARCHAR2(20),
  mfo    VARCHAR2(12),
  nls    VARCHAR2(15)
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Rebegin
begin
    execute immediate 'create index IDX_COMPENCLIENTS_CODE on COMPEN_CLIENTS (DBCODE)
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_CLIENTS
  add constraint PK_COMPENCLIENTS primary key (RNK)
  using index 
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table COMPEN_CLIENTS
  add constraint CC_COMPEN_CLIENTS_MFO_NN
  check ("MFO" is not null)
  disable
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_CLIENTS
  add constraint CC_COMPEN_CLIENTS_NLS_NN
  check ("NLS" is not null)
  disable
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_CLIENTS add date_val_reg DATE';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_CLIENTS add secondary NUMBER(1) default 0';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_CLIENTS add okpo VARCHAR2(10)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_CLIENTS add open_cl date';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

alter table COMPEN_CLIENTS modify dbcode VARCHAR2(32);


alter table COMPEN_CLIENTS
  enable novalidate constraint CC_COMPEN_CLIENTS_MFO_NN ;
alter table COMPEN_CLIENTS
  enable novalidate constraint CC_COMPEN_CLIENTS_NLS_NN ;

begin
  update COMPEN_CLIENTS set mfo = substr(mfo, 1, 6) where length(mfo) > 6;
end;
/
alter table COMPEN_CLIENTS modify mfo VARCHAR2(6);

-- Add comments to the columns 
comment on column COMPEN_CLIENTS.date_val_reg
  is 'Дата тіпа валютування. Планова дата виплати';
comment on column COMPEN_CLIENTS.secondary
  is '1 - Представник; 0 - Звичайна фіз. особа';
comment on column COMPEN_CLIENTS.okpo
  is 'Код ЄДРПОУ';
comment on column COMPEN_CLIENTS.open_cl
  is 'Дата заведення клієнта';