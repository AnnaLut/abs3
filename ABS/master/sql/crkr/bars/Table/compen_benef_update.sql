exec bpa.alter_policy_info('compen_benef_update', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('compen_benef_update', 'whole',  null,  'E', 'E', 'E');


-- Create table
begin
    execute immediate 'create table COMPEN_BENEF_UPDATE
(
  idupd        NUMBER not null,
  id_compen    NUMBER(14),
  idb          INTEGER,
  code         CHAR(1),
  fiob         VARCHAR2(256),
  countryb     INTEGER,
  fulladdressb VARCHAR2(999),
  icodb        VARCHAR2(128),
  doctypeb     INTEGER,
  docserialb   VARCHAR2(16),
  docnumberb   VARCHAR2(32),
  docorgb      VARCHAR2(256),
  docdateb     DATE,
  clientbdateb DATE,
  clientsexb   CHAR(1),
  clientphoneb VARCHAR2(128),
  regdate      DATE,
  lastedit     DATE,
  userid       NUMBER not null,
  percent      NUMBER
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


-- Create/Rebegin
begin
    execute immediate 'create index I_BENEF_UPDATE_ID_COMPEN on COMPEN_BENEF_UPDATE (ID_COMPEN)
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_BENEF_UPDATE
  add constraint PK_COMPEN_BENEF_UPDATE primary key (IDUPD)
  using index 
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_BENEF_UPDATE add branch VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_BENEF_UPDATE add user_id NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_BENEF_UPDATE add eddr_id VARCHAR2(20)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_BENEF_UPDATE.eddr_id
  is 'Унікальний номер запису в ЄДДР';


comment on column COMPEN_BENEF_UPDATE.lastedit
  is 'Дата зміни';
comment on column COMPEN_BENEF_UPDATE.userid
  is 'Користувач який змінив запис';
comment on column COMPEN_BENEF_UPDATE.branch
  is 'Бранч';
comment on column COMPEN_BENEF_UPDATE.user_id
  is 'Ідентифікатор користувача створивший запис';