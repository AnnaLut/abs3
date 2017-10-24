prompt ... 
begin 
  BPA.ALTER_POLICY_INFO( 'META_CALL_SETTINGS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'META_CALL_SETTINGS', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table META_CALL_SETTINGS
(
  id              NUMBER(38) not null,
  code            VARCHAR2(30),
  call_from       VARCHAR2(30),
  web_form_name   VARCHAR2(400),
  tabid           NUMBER(38),
  funcid          NUMBER(38),
  accesscode      NUMBER(2),
  show_dialog     VARCHAR2(30),
  link_type       VARCHAR2(30),
  insert_after    NUMBER(1) default 0,
  edit_mode       VARCHAR2(30) default ''ROW_EDIT'',
  summ_visible    NUMBER(1) default 0,
  conditions      CLOB,
  excel_opt       VARCHAR2(30),
  add_with_window NUMBER(1) default 0,
  switch_of_deps  NUMBER(1) default 0,
  show_count      NUMBER(1) default 0,
  save_column     VARCHAR2(30),
  codeapp         VARCHAR2(30 CHAR),
  base_options    VARCHAR2(1000)
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
comment on table META_CALL_SETTINGS
  is 'Описание вызова метаданных';
-- Add comments to the columns 
comment on column META_CALL_SETTINGS.id
  is 'идентификатор';
comment on column META_CALL_SETTINGS.code
  is 'строковой уникальный идентификатор для вызова из кода других приложений.';
comment on column META_CALL_SETTINGS.call_from
  is 'строковое поле, определяет где планируется использование. Т.к. строка создается для конкретной цели.';
comment on column META_CALL_SETTINGS.web_form_name
  is 'Для url, либо как альтернатива старой строке, если по каким либо причинам не получится вынести настройки в столбцы.';
comment on column META_CALL_SETTINGS.tabid
  is 'если есть процедура before - описываем её в meta_nsifunction часть ключа,';
comment on column META_CALL_SETTINGS.funcid
  is 'если есть процедура before - описываем её в meta_nsifunction часть ключа';
comment on column META_CALL_SETTINGS.accesscode
  is 'альтернатива старого ACCESSCODE.';
comment on column META_CALL_SETTINGS.show_dialog
  is 'показывать ли окно с фильтрами в любом случае.';
comment on column META_CALL_SETTINGS.link_type
  is 'относится к переходу в новый справочник. OPEN_IN_WINDOW - Будет открыт в модальном окне(по умолчанию в новой вкладке). OPEN_IN_TUBE - В НОВОЙ ВКЛАДКЕ. ';
comment on column META_CALL_SETTINGS.insert_after
  is 'добавление новой строки не в начале, в конце грида';
comment on column META_CALL_SETTINGS.edit_mode
  is 'тип редактирования MULTI_EDIT - множественное редактирование ROW_EDIT - построчное(по умолчанию)';
comment on column META_CALL_SETTINGS.summ_visible
  is 'считать итоговую строку по видимым записям 0 - по всей выборке(по умолчанию).';
comment on column META_CALL_SETTINGS.conditions
  is 'условия отбора';
comment on column META_CALL_SETTINGS.excel_opt
  is 'перечисление для настройки выгрузки в EXCEL WITHOUT_EXCEL , XLSX, XLSX_XLS, XLS';
comment on column META_CALL_SETTINGS.add_with_window
  is 'Добавление новой строки будет с помощью окна, 0 - вставка строки в грид.';
comment on column META_CALL_SETTINGS.switch_of_deps
  is 'Выключить все ONLINE зависимости.';
comment on column META_CALL_SETTINGS.show_count
  is 'показывать кол-во записей в выборке 0 - не показывать';
comment on column META_CALL_SETTINGS.save_column
  is 'текстовое, сохранять колонки, настроенные ';
comment on column META_CALL_SETTINGS.codeapp
  is 'для вызова справочника, составной ключ. Вместе с TABID.';
comment on column META_CALL_SETTINGS.base_options
  is 'Параметры, которые будут перекрывать параметры дочерних табличных форм';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint PK_METACALLSETTINGS primary key (ID)
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
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint UK_METACALLSETTINGS_CODE unique (CODE)
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
    if sqlcode = -2261 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_CALLFROM foreign key (CALL_FROM)
  references CALL_TAB_NAME (NAME)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_CODEAPP foreign key (TABID, CODEAPP)
  references REFAPP (TABID, CODEAPP)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_FUNCID foreign key (TABID, FUNCID)
  references META_NSIFUNCTION (TABID, FUNCID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table META_CALL_SETTINGS
  add constraint FK_METACALLSETTINGS_TABID foreign key (TABID)
  references META_TABLES (TABID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 




