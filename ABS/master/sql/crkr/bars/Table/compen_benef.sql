exec bpa.alter_policy_info('compen_benef', 'filial',  'M', 'M', 'M', 'M');
exec bpa.alter_policy_info('compen_benef', 'whole',  null,  'E', 'E', 'E');

-- Create table
begin
    execute immediate 'create table COMPEN_BENEF
(
  id_compen    NUMBER(14) not null,
  idb          INTEGER not null,
  code         CHAR(1),
  fiob         VARCHAR2(256),
  countryb     INTEGER default 804,
  fulladdressb VARCHAR2(999),
  icodb        VARCHAR2(128),
  doctypeb     INTEGER default 1,
  docserialb   VARCHAR2(16),
  docnumberb   VARCHAR2(32),
  docorgb      VARCHAR2(256),
  docdateb     DATE,
  clientbdateb DATE,
  clientsexb   CHAR(1) default ''0'',
  clientphoneb VARCHAR2(128),
  regdate      DATE,
  removedate   DATE,
  percent      NUMBER
)
tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table COMPEN_BENEF
  is 'Бенефіціари';
-- Add comments to the columns 
comment on column COMPEN_BENEF.id_compen
  is 'm_f_o_00000000 (ASVO_COMPEN.ID)';
comment on column COMPEN_BENEF.idb
  is 'PK РУ';
comment on column COMPEN_BENEF.code
  is 'Код бенефіціара (N-спадкоємець,D-довір.особа)';
comment on column COMPEN_BENEF.fiob
  is 'ПІБ';
comment on column COMPEN_BENEF.countryb
  is 'Код країни';
comment on column COMPEN_BENEF.fulladdressb
  is 'Адреса';
comment on column COMPEN_BENEF.icodb
  is 'Код ОКПО';
comment on column COMPEN_BENEF.doctypeb
  is 'Вид документу';
comment on column COMPEN_BENEF.docserialb
  is 'Серія документу';
comment on column COMPEN_BENEF.docnumberb
  is 'Номер документу';
comment on column COMPEN_BENEF.docorgb
  is 'Орган, що видав документ';
comment on column COMPEN_BENEF.docdateb
  is 'Дата видачі документу';
comment on column COMPEN_BENEF.clientbdateb
  is 'Дата народження';
comment on column COMPEN_BENEF.clientsexb
  is 'Стать';
comment on column COMPEN_BENEF.clientphoneb
  is 'Телефон';
comment on column COMPEN_BENEF.regdate
  is 'Дата реєстрації';
comment on column COMPEN_BENEF.removedate
  is 'Дата вилучення';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table COMPEN_BENEF
  add constraint PK_COMPEN_BENEF primary key (ID_COMPEN, IDB)
  using index 
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_BENEF
  add constraint FK_COMPEN_BENEF_PORTFOLIO foreign key (ID_COMPEN)
  references COMPEN_PORTFOLIO (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'alter table COMPEN_BENEF add branch VARCHAR2(30)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table COMPEN_BENEF add user_id NUMBER';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 'create index IDX_COMPEN_BENEF_ID on COMPEN_BENEF (ID_COMPEN)
  tablespace BRSMDLD';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 


comment on column COMPEN_BENEF.branch
  is 'Бранч';
comment on column COMPEN_BENEF.user_id
  is 'Ідентифікатор користувача створивший запис';

begin
    execute immediate 'alter table COMPEN_BENEF add eddr_id VARCHAR2(20)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

comment on column COMPEN_BENEF.eddr_id
  is 'Унікальний номер запису в ЄДДР';

-- Grant/Revoke object privileges 
grant select, insert, update, delete on COMPEN_BENEF to START1;
grant select, insert, update, delete on COMPEN_BENEF to WR_ALL_RIGHTS;
