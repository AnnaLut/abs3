PROMPT ===========================================
PROMPT Create table MGR_CHECKS
PROMPT ===========================================
begin
  execute immediate 'begin bpa.alter_policy_info(''MGR_CHECKS'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''MGR_CHECKS'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE BARS.MGR_CHECKS
(
  "KF"             VARCHAR2(6 BYTE) CONSTRAINT "CC_MGRCHECKS_KF_NN" NOT NULL,
  "CHECK_ORDER"    INTEGER CONSTRAINT "CC_MGRCHECKS_CHECKORDER_NN" NOT NULL,
  "CHECK_PROC"     VARCHAR2(93 BYTE) CONSTRAINT "CC_MGRCHECKS_CHECKPROC_NN" NOT NULL,
  "CHECK_STATUS"   VARCHAR2(30 BYTE)              DEFAULT ''SUCCEEDED'' CONSTRAINT "CC_MGRCHECKS_CHECKSTATUS_NN" NOT NULL,
  "CHECK_COMMENT"  VARCHAR2(250 BYTE), 
  CONSTRAINT "PK_MGRCHECKS"
  PRIMARY KEY
  ("KF", "CHECK_PROC")
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
PROMPT ADD COMMENTS ON BARS.MGR_CHECKS
PROMPT ==========================================
begin
execute immediate 'COMMENT ON TABLE BARS.MGR_CHECKS IS ''Проверки перед миграцией''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECKS.KF IS ''Код филиала''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_ORDER IS ''Порядковый номер проверки''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_PROC IS ''Процедура проверки''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_STATUS IS ''Статус проверки: SUCCEEDED/FAILED''';
execute immediate 'COMMENT ON COLUMN BARS.MGR_CHECKS.CHECK_COMMENT IS ''Комментарий проверки''';
end;
/

PROMPT ===========================================
PROMPT CREATE PRIMARY KEY CONSTRAINT PK_MGRCHECKS
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2260);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECKS ADD (
  CONSTRAINT "PK_MGRCHECKS"
  PRIMARY KEY ("KF", "CHECK_PROC")
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_MGRCHECKS_KF_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECKS ADD (
  CONSTRAINT CC_MGRCHECKS_KF_NN
  CHECK ("KF" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_MGRCHECKS_CHECKORDER_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECKS ADD (
  CONSTRAINT CC_MGRCHECKS_CHECKORDER_NN
  CHECK ("CHECK_ORDER" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_MGRCHECKS_CHECKPROC_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECKS ADD (
  CONSTRAINT "CC_MGRCHECKS_CHECKPROC_NN"
  CHECK ("CHECK_PROC" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_MGRCHECKS_CHECKSTATUS_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.MGR_CHECKS ADD (
  CONSTRAINT "CC_MGRCHECKS_CHECKSTATUS_NN"
  CHECK ("CHECK_STATUS" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
