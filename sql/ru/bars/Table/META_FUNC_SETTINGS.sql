prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'META_FUNC_SETTINGS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'META_FUNC_SETTINGS', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table META_FUNC_SETTINGS
(
  id            NUMBER(38) not null,
  tabid         NUMBER(38),
  funcid        NUMBER(38),
  func_type     VARCHAR2(30),
  link          VARCHAR2(30),
  main_set_id   NUMBER(38),
  after_func_id NUMBER(38),
  msg           VARCHAR2(50),
  qst           VARCHAR2(50),
  descr         VARCHAR2(50)
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
comment on table META_FUNC_SETTINGS
  is 'Описание параметров функций';
-- Add comments to the columns 
comment on column META_FUNC_SETTINGS.id
  is 'идентификатор';
comment on column META_FUNC_SETTINGS.tabid
  is 'ид таблицы';
comment on column META_FUNC_SETTINGS.funcid
  is 'вместе с TABID Ключ таблицы NSIFUNCTION , если у нас процедура.';
comment on column META_FUNC_SETTINGS.func_type
  is 'описывает тип выполняемой функции. Константы, желательно сделать через перечисление. Например PROC - оракловая процедура. ONLINE - функционал, который будет действовать во время работы(например пересчёт суммы при наведении на числовые столбики и др).,';
comment on column META_FUNC_SETTINGS.link
  is 'веб ссылка, которая откроется в окне, либо в табе.';
comment on column META_FUNC_SETTINGS.main_set_id
  is 'ID таблицы META_CALL_SETTINGS';
comment on column META_FUNC_SETTINGS.after_func_id
  is 'Ссылка на id этой таблицы. Функция, которая должна выполнится после текущей, при отсутствии эксепшина.';
comment on column META_FUNC_SETTINGS.msg
  is 'Сообщение';
comment on column META_FUNC_SETTINGS.qst
  is 'Вопрос';
comment on column META_FUNC_SETTINGS.descr
  is 'Семантика, описание';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table META_FUNC_SETTINGS
  add constraint PK_METAFUNCSETTINGS primary key (ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_FUNC_SETTINGS
  add constraint FK_METAFUNCSETTINGS_AFTFUNCID foreign key (AFTER_FUNC_ID)
  references META_FUNC_SETTINGS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_FUNC_SETTINGS
  add constraint FK_METAFUNCSETTINGS_FUNCID foreign key (TABID, FUNCID)
  references META_NSIFUNCTION (TABID, FUNCID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_FUNC_SETTINGS
  add constraint FK_METAFUNCSETTINGS_MAINSETID foreign key (MAIN_SET_ID)
  references META_CALL_SETTINGS (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_FUNC_SETTINGS
  add constraint FK_METAFUNCSETTINGS_TABID foreign key (TABID)
  references META_TABLES (TABID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 

