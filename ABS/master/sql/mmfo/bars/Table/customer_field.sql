prompt ... 


-- Create table
begin
    execute immediate 'create table CUSTOMER_FIELD
(
  tag             CHAR(5),
  name            VARCHAR2(70),
  b               NUMBER(1),
  u               NUMBER(1),
  f               NUMBER(1),
  tabname         VARCHAR2(60),
  byisp           NUMBER(1),
  type            CHAR(1),
  opt             NUMBER(1),
  tabcolumn_check VARCHAR2(30),
  sqlval          VARCHAR2(254),
  code            VARCHAR2(30) default ''OTHERS'',
  not_to_edit     NUMBER(1) default 0,
  hist            NUMBER(1),
  parid           NUMBER(22),
  u_nrez          NUMBER(1),
  f_nrez          NUMBER(1),
  f_spd           NUMBER(1),
  chkr            VARCHAR2(250),
  mask            VARCHAR2(50)
)
tablespace BRSSMLD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 


begin
  execute immediate 'alter table BARS.CUSTOMER_FIELD ADD chkr VARCHAR2(250)';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "chkr" already exists in table.');
    else raise;
    end if;
end;
/

begin
  execute immediate 'alter table BARS.CUSTOMER_FIELD ADD mask VARCHAR2(50)';
  dbms_output.put_line('Table altered.');
exception
  when OTHERS then
    if ( sqlcode = -01430 )
    then dbms_output.put_line('Column "mask" already exists in table.');
    else raise;
    end if;
end;
/

-- Add comments to the table 
comment on table CUSTOMER_FIELD
  is 'Справочник доп. реквизитов клиентов';
-- Add comments to the columns 
comment on column CUSTOMER_FIELD.tag
  is 'Код реквизита';
comment on column CUSTOMER_FIELD.name
  is 'Наименование реквизита';
comment on column CUSTOMER_FIELD.b
  is 'Признак заполнения для клиента Банк (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
comment on column CUSTOMER_FIELD.u
  is 'Признак заполнения для клиента ЮЛ (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
comment on column CUSTOMER_FIELD.f
  is 'Признак заполнения для клиента ФЛ (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
comment on column CUSTOMER_FIELD.tabname
  is 'Справочник';
comment on column CUSTOMER_FIELD.byisp
  is 'Учитывать доступ по исполнителю';
comment on column CUSTOMER_FIELD.type
  is 'Тип реквизита (N, D, S)';
comment on column CUSTOMER_FIELD.opt
  is 'Обязательность заполнения доп.реквизита(1/0)';
comment on column CUSTOMER_FIELD.tabcolumn_check
  is 'Контроль значения по полю';
comment on column CUSTOMER_FIELD.sqlval
  is 'Sql-выражение для умолчательного значения доп.реквизита (напр., select ''1'' from dual)';
comment on column CUSTOMER_FIELD.not_to_edit
  is 'Запретить редактировать в карточке клиента';
comment on column CUSTOMER_FIELD.hist
  is 'Признак: используется в историзированной таблице параметров';
comment on column CUSTOMER_FIELD.parid
  is 'Код параметра';
comment on column CUSTOMER_FIELD.u_nrez
  is 'Признак заполнения для клиента ЮЛ-нерезидент (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
comment on column CUSTOMER_FIELD.f_nrez
  is 'Признак заполнения для клиента ФЛ-нерезидент (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
comment on column CUSTOMER_FIELD.f_spd
  is 'Признак заполнения для клиента ФЛ-СПД (0-не заполнять, 1-заполнять, 2-заполнять обязательно)';
comment on column CUSTOMER_FIELD.chkr
  is 'Строка вызова процедуры проверки значения';
comment on column CUSTOMER_FIELD.mask
  is 'Маска ввода значения ';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint PK_CUSTOMERFIELD primary key (TAG)
  using index 
  tablespace BRSSMLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint UK_CUSTOMERFIELD_PARID unique (PARID)
  using index 
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint FK_CUSTOMERFIELD_CODES foreign key (CODE)
  references CUSTOMER_FIELD_CODES (CODE)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint FK_CUSTOMERFIELD_METACOLTYPES foreign key (TYPE)
  references META_COLTYPES (COLTYPE)
  novalidate';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


-- Create/Recreate check constraints 
begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_B
  check (b in (0, 1, 2))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_BYISP
  check (byisp in (0,1))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_CODE_NN
  check ("CODE" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_F
  check (f in (0, 1, 2))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_FNREZ
  check (f_nrez in (0, 1, 2))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_FSPD
  check (f_spd in (0, 1, 2))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_NAME_NN
  check ("NAME" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_NOTTOEDIT_NN
  check ("NOT_TO_EDIT" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_OPT
  check (opt in (0,1))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_TAG_NN
  check ("TAG" IS NOT NULL)
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_U
  check (u in (0, 1, 2))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table CUSTOMER_FIELD
  add constraint CC_CUSTOMERFIELD_UNREZ
  check (u_nrez in (0, 1, 2))
  novalidate';
 exception when others then 
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 

-- Grant/Revoke object privileges 
grant select, insert, update, delete on CUSTOMER_FIELD to ABS_ADMIN;
grant select on CUSTOMER_FIELD to BARSREADER_ROLE;
grant select on CUSTOMER_FIELD to BARSUPL;
grant select, insert, update, delete on CUSTOMER_FIELD to BARS_ACCESS_DEFROLE;
grant select on CUSTOMER_FIELD to BARS_DM;
grant select, insert, update, delete on CUSTOMER_FIELD to CUSTOMER_FIELD;
grant select on CUSTOMER_FIELD to RCC_DEAL;
grant select on CUSTOMER_FIELD to START1;
grant select on CUSTOMER_FIELD to UPLD;
grant select, insert, update, delete on CUSTOMER_FIELD to WR_ALL_RIGHTS;
grant select on CUSTOMER_FIELD to WR_CUSTREG;
grant select on CUSTOMER_FIELD to WR_REFREAD;
