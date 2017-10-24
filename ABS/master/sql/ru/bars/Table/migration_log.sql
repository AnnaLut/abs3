PROMPT ===========================================
PROMPT Create table MIGRATION_LOG
PROMPT ===========================================
begin
  execute immediate 'begin bpa.alter_policy_info(''MIGRATION_LOG'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin
  execute immediate 'begin bpa.alter_policy_info(''MIGRATION_LOG'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE "MIGRATION_LOG" 
   ("ID" NUMBER, 
  "MIGRATION_ID" NUMBER, 
  "MIGRATION_START_TIME" DATE, 
  "TABLE_NAME" VARCHAR2(255), 
  "OPERATION" VARCHAR2(255), 
  "ROW_COUNT" NUMBER,
  "TASK_START_TIME" TIMESTAMP(6), 
  "TASK_END_TIME" TIMESTAMP(6), 
  "TIME_DURATION" INTERVAL DAY (3) TO SECOND (3),
  "LOG_TYPE" VARCHAR2(255), 
  "LOG_MESSAGE" VARCHAR2(4000), 
  "ERROR_MESSAGE" VARCHAR2(4000)
   ) PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS 
  TABLESPACE "BRSSMLD" 
  PARTITION BY RANGE ("MIGRATION_START_TIME") INTERVAL (NUMTOYMINTERVAL(1,''MONTH'')) 
 (PARTITION "P0"  VALUES LESS THAN (TO_DATE('' 2016-01-01 00:00:00'', ''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN''))  
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING 
  TABLESPACE "BRSSMLD" ) ';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
  
begin  
  bpa.alter_policies('MIGRATION_LOG');  
end;
/
PROMPT ===========================================
PROMPT Create indexes on MIGRATION_LOG
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE UNIQUE INDEX "MIGRATION_LOG_PK" ON "MIGRATION_LOG" ("ID") 
PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
TABLESPACE "BRSSMLI" ';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT Add constraints on MIGRATION_LOG
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2260);
begin
execute immediate 'ALTER TABLE "MIGRATION_LOG" ADD CONSTRAINT "MIGRATION_LOG_PK" PRIMARY KEY ("ID")
USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS NOLOGGING 
TABLESPACE "BRSSMLI"  ENABLE';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

prompt ==================================
prompt Give grants on MIGRATION_LOG
prompt ==================================
grant select on MIGRATION_LOG to BARS_DM;
