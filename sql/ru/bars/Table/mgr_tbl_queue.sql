PROMPT ===========================================
PROMPT Create table MGR_TBL_QUEUE
PROMPT ===========================================

begin
  execute immediate 'begin bpa.alter_policy_info(''MGR_TBL_QUEUE'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin
  execute immediate 'begin bpa.alter_policy_info(''MGR_TBL_QUEUE'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE "MGR_TBL_QUEUE" 
   ("ID"                    NUMBER,
    "OWNER"                 VARCHAR2(30 char),
    "TABLE_NAME"            VARCHAR2(30 char), 
    "MODULE"                VARCHAR2(30 char),
    "DESC_TBL"              VARCHAR2(255 char), 
    "COMMENT_MGR"           VARCHAR2(4000 byte),
    "CLEAN"                 VARCHAR2(1 char),
    "CLEAN_PROC"            VARCHAR2(4000 byte),
    "CLEAN_ORD"             NUMBER(30),
    "MIGRATION"             VARCHAR2(1 char),
    "MIGRATION_PROC"        VARCHAR2(4000 byte),
    "MIGRATION_ORD"         NUMBER(30),
    "MIGR_NSUP_COL_TYPE"    VARCHAR2(1 char),
    "ROW_COUNT"             NUMBER,
    "SQNC_RESET"            VARCHAR2(1 char),
    "SQNC_NAME"             VARCHAR2(30 char),
    "SQNC_COLUMN"           VARCHAR2(30 char),
    "KF"                    VARCHAR2(1 char),
    "BRANCH"                VARCHAR2(1 char),
    "POLICY_MMFO"           VARCHAR2(1 char)
    )  
  TABLESPACE "BRSSMLD"
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
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
 
Begin  
bpa.alter_policies('MGR_TBL_QUEUE');  
end;
/
PROMPT ===========================================
PROMPT Create indexes on MGR_TBL_QUEUE
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate '
CREATE UNIQUE INDEX "MGR_TBL_QUEUE_PK" ON "MGR_TBL_QUEUE" ("ID") 
LOGGING
TABLESPACE BRSSMLI
PCTFREE    10
INITRANS   2
MAXTRANS   255
STORAGE    (
            INITIAL          64K
            NEXT             1M
            MAXSIZE          UNLIMITED
            MINEXTENTS       1
            MAXEXTENTS       UNLIMITED
            PCTINCREASE      0
            BUFFER_POOL      DEFAULT
            FLASH_CACHE      DEFAULT
            CELL_FLASH_CACHE DEFAULT
           )
NOPARALLEL
';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/


PROMPT ===========================================
PROMPT Add constraints on MGR_TBL_QUEUE
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2260);
begin
execute immediate 'ALTER TABLE "MGR_TBL_QUEUE" ADD CONSTRAINT "MGR_TBL_QUEUE_PK" PRIMARY KEY ("ID")
USING INDEX tablespace BRSSMLI
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
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
