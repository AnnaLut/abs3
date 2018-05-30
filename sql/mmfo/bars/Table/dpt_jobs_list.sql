PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LIST.sql =========*** Run ***
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to DPT_JOBS_LIST ***

begin
  bpa.alter_policy_info( 'DPT_JOBS_LIST', 'CENTER', null, null, null, null );
  bpa.alter_policy_info( 'DPT_JOBS_LIST', 'FILIAL',  'd',  'E',  'E',  'E' );
  bpa.alter_policy_info( 'DPT_JOBS_LIST', 'WHOLE',  null, null, null, null );
end;
/

PROMPT *** Create  table DPT_JOBS_LIST ***

begin
  execute immediate 'create table DPT_JOBS_LIST
( JOB_ID     NUMBER(38)
, JOB_CODE   CHAR(8)       constraint CC_DPTJOBSLIST_JOBCODE_NN NOT NULL
, JOB_NAME   VARCHAR2(100) constraint CC_DPTJOBSLIST_JOBNAME_NN NOT NULL
, JOB_PROC   VARCHAR2(128) constraint CC_DPTJOBSLIST_JOBPROC_NN NOT NULL
, ORD        NUMBER(5)
, DELETED    DATE
, RUN_LVL    number(1) default 3
, constraint PK_DPTJOBSLIST primary key (JOB_ID) using index tablespace BRSSMLI
, constraint UK_DPTJOBSLIST unique (JOB_PROC) using index tablespace BRSSMLI
, constraint UK_DPTJOBSLIST_JOBCODE unique (JOB_CODE) using index tablespace BRSSMLI
) tablespace BRSSMLD';
exception
  when others then
    if sqlcode=-955 then null; else raise; end if;
end;
/

prompt -- ======================================================
prompt -- Alter table
prompt -- ======================================================

declare
  e_col_exists           exception;
  pragma exception_init( e_col_exists, -01430 );
begin   
  execute immediate 'alter table DPT_JOBS_LIST add RUN_LVL number(1) default 3';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_col_exists
  then null;
end;
/

PROMPT *** Create constraint UK_DPTJOBSLIST_JOBCODE ***

declare
  e_unq_key_exists  exception; -- e_uk_exists
  pragma exception_init( e_unq_key_exists, -02261 );
begin
  execute immediate 'alter table DPT_JOBS_LIST add constraint UK_DPTJOBSLIST_JOBCODE unique (JOB_CODE) using index tablespace BRSSMLI';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_unq_key_exists 
  then null;
END;
/

prompt -- ======================================================
prompt -- Indexes
prompt -- ======================================================

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Apply policies
prompt -- ======================================================

begin
  bpa.alter_policies( 'DPT_JOBS_LIST' );
end;
/

commit;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

comment on table  DPT_JOBS_LIST          is 'Справочник автоматических операций';
comment on column DPT_JOBS_LIST.JOB_ID   is '№ операции';
comment on column DPT_JOBS_LIST.JOB_CODE is 'Код операции';
comment on column DPT_JOBS_LIST.JOB_NAME is 'Наименование операции';
comment on column DPT_JOBS_LIST.JOB_PROC is 'Имя выполняемой процедуры';
comment on column DPT_JOBS_LIST.ORD      is '№ п/п';
comment on column DPT_JOBS_LIST.RUN_LVL  is 'Запуск завдання від: 0=слеша, 1=МФО, 2=бранчу 2-го рівня, 3=бранчу 3-го рівня';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on DPT_JOBS_LIST to BARSREADER_ROLE;
grant SELECT on DPT_JOBS_LIST to BARS_ACCESS_DEFROLE;
grant SELECT on DPT_JOBS_LIST to BARS_DM;
grant SELECT on DPT_JOBS_LIST to UPLD;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_JOBS_LIST.sql =========*** End ***
PROMPT ===================================================================================== 