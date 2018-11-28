

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/META_NSIFUNCTION.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to META_NSIFUNCTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''META_NSIFUNCTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

prompt ... 


-- Create table
begin 
    execute immediate 'create table META_NSIFUNCTION
(
  tabid          NUMBER(38) not null,
  funcid         NUMBER(10) not null,
  descr          VARCHAR2(100),
  proc_name      VARCHAR2(254),
  proc_par       VARCHAR2(254),
  proc_exec      VARCHAR2(30),
  qst            VARCHAR2(254),
  msg            VARCHAR2(254),
  form_name      VARCHAR2(254),
  check_func     VARCHAR2(254),
  web_form_name  VARCHAR2(508),
  icon_id        NUMBER,
  custom_options CLOB
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
   execute immediate('alter table META_NSIFUNCTION add custom_options clob ');
exception when others then 
   null; 
end;
/

-- Add comments to the table 
comment on table META_NSIFUNCTION
  is 'Описание функций, выполняемых на справочниках';
-- Add comments to the columns 
comment on column META_NSIFUNCTION.tabid
  is 'Код таблицы';
comment on column META_NSIFUNCTION.funcid
  is 'Ид. функции для сортировки';
comment on column META_NSIFUNCTION.descr
  is 'Описание функции';
comment on column META_NSIFUNCTION.proc_name
  is 'Sql-процедура с параметрами';
comment on column META_NSIFUNCTION.proc_par
  is 'Описание параметров для Sql-процедуры';
comment on column META_NSIFUNCTION.proc_exec
  is 'Описание выпонения процедуры';
comment on column META_NSIFUNCTION.qst
  is 'Вопрос перед выполнением';
comment on column META_NSIFUNCTION.msg
  is 'Сообщение после удачного выполнения процедуры';
comment on column META_NSIFUNCTION.form_name
  is 'Функция центуры';
comment on column META_NSIFUNCTION.check_func
  is 'Функция проверки';
comment on column META_NSIFUNCTION.web_form_name
  is 'Функция WEB';
comment on column META_NSIFUNCTION.icon_id
  is 'Код иконки для кнопки';
comment on column META_NSIFUNCTION.custom_options
  is 'Дополнительные параметры функции';

-- Create/Recreate primary, unique and foreign key constraints 
begin
    execute immediate 'alter table META_NSIFUNCTION
  add constraint PK_METANSIFUNCTION primary key (TABID, FUNCID)
  using index 
  tablespace BRSSMLD
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
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


PROMPT *** ADD COLUMN  custom_options***
begin 
   execute immediate('alter table META_NSIFUNCTION add custom_options clob ');
exception when others then 
   null; 
end;
/

COMMENT ON TABLE BARS.META_NSIFUNCTION IS 'Описание функций, выполняемых на справочниках';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.WEB_FORM_NAME IS 'Функция WEB';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.ICON_ID IS 'Код иконки для кнопки';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.TABID IS 'Код таблицы';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.FUNCID IS 'Ид. функции для сортировки';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.DESCR IS 'Описание функции';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_NAME IS 'Sql-процедура с параметрами';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_PAR IS 'Описание параметров для Sql-процедуры';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.PROC_EXEC IS 'Описание выпонения процедуры';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.QST IS 'Вопрос перед выполнением';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.MSG IS 'Сообщение после удачного выполнения процедуры';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.FORM_NAME IS 'Функция центуры';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.CHECK_FUNC IS 'Функция проверки';
COMMENT ON COLUMN BARS.META_NSIFUNCTION.CUSTOM_OPTIONS IS 'Дополнительные парамeтры функции';



PROMPT *** Create  constraint CC_METANSIFUNCTION_DESCR_NN ***
begin   
    execute immediate 'alter table META_NSIFUNCTION
  add constraint FK_METANSIFUNCTION_ICONID foreign key (ICON_ID)
  references META_ICONS (ICON_ID)
  novalidate';
exception when others then
    if sqlcode = -2275 then null; else raise; 
    end if; 
 end;
/


begin   
    execute immediate 'alter table META_NSIFUNCTION
  add constraint FK_METANSIFUNCTION_METATABLES foreign key (TABID)
  references META_TABLES (TABID)
  novalidate';
exception when others then
    if sqlcode = -2275 then null; else raise; 
    end if; 
 end;
/


-- Create/Recreate check constraints 
begin   
    execute immediate 'alter table META_NSIFUNCTION
  add constraint CC_METANSIFUNCTION_DESCR_NN
  check (descr is not null)
  novalidate';
exception when others then
    if sqlcode = -2264 or sqlcode = -2261 then null; else raise; 
    end if; 
 end;
/

-- Grant/Revoke object privileges 
grant select on META_NSIFUNCTION to BARSREADER_ROLE;
grant select, insert, update, delete on META_NSIFUNCTION to BARS_ACCESS_DEFROLE;
grant select on META_NSIFUNCTION to BARS_DM;
grant select, insert, update, delete on META_NSIFUNCTION to START1;
grant select on META_NSIFUNCTION to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/META_NSIFUNCTION.sql =========*** End 
PROMPT ===================================================================================== 
