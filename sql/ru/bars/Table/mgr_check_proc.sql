PROMPT ===========================================
PROMPT Create table BARS.MGR_CHECK_PROC
PROMPT ===========================================
begin
  execute immediate 'begin bpa.alter_policy_info(''MGR_CHECK_PROC'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''MGR_CHECK_PROC'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE BARS.MGR_CHECK_PROC
(
  "PROC_NAME"      VARCHAR2(93 BYTE) CONSTRAINT "CC_MGRCHECKPROC_PROCNAME_NN" NOT NULL,
  "CREATION_TIME"  DATE                           DEFAULT sysdate CONSTRAINT "CC_MGRCHECKPROC_CRTIME_NN" NOT NULL,
  "PROC_COMMENT"   VARCHAR2(128 BYTE), 
  CONSTRAINT "PK_MGRCHECKPROC"
  PRIMARY KEY
  ("PROC_NAME")
  ENABLE VALIDATE
)
ORGANIZATION INDEX
PCTTHRESHOLD 50
TABLESPACE BRSSMLD
RESULT_CACHE (MODE DEFAULT)
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             64K
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
LOGGING 
NOPARALLEL
NOMONITORING';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT =========================================
PROMPT ADD COMMENTS ON BARS.MGR_CHECK_PROC
PROMPT ==========================================
begin
execute immediate 'COMMENT ON TABLE BARS.MGR_CHECK_PROC IS ''Процедуры проверки перед миграцией''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECK_PROC.PROC_NAME IS ''Порядковый номер проверки''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECK_PROC.CREATION_TIME IS ''Время создания процедуры''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECK_PROC.PROC_COMMENT IS ''Комментарий процедуры проверки''';
end;
/



PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_MGRCHECKPROC_PROCNAME_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECK_PROC ADD (
  CONSTRAINT "CC_MGRCHECKPROC_PROCNAME_NN"
  CHECK ("PROC_NAME" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_MGRCHECKPROC_CRTIME_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECK_PROC ADD (
  CONSTRAINT "CC_MGRCHECKPROC_CRTIME_NN"
  CHECK ("CREATION_TIME" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
