PROMPT ===========================================
PROMPT Create table SEC_UPDATE_QUEUE
PROMPT ===========================================
begin
  execute immediate 'begin bpa.alter_policy_info(''SEC_UPDATE_QUEUE'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin
  execute immediate 'begin bpa.alter_policy_info(''SEC_UPDATE_QUEUE'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE BARS.SEC_UPDATE_QUEUE
(
  "UPDATE_TIME"  DATE CONSTRAINT "CC_SECUPDQ_UPDTIME_NN" NOT NULL,
  "USER_ID"      INTEGER CONSTRAINT "CC_SECUPDQ_USERID_NN" NOT NULL, 
  CONSTRAINT "PK_SECUPDQ"
  PRIMARY KEY
  ("UPDATE_TIME", "USER_ID")
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
PROMPT ADD COMMENTS ON BARS.SEC_UPDATE_QUEUE
PROMPT ==========================================
begin
execute immediate 'COMMENT ON TABLE BARS.SEC_UPDATE_QUEUE IS ''Очередь записей для обновления пользователских масок доступа к счетам''';
execute immediate 'COMMENT ON COLUMN BARS.SEC_UPDATE_QUEUE.UPDATE_TIME IS ''Плановое время обновления''';
execute immediate 'COMMENT ON COLUMN BARS.SEC_UPDATE_QUEUE.USER_ID IS ''ID пользователя''';
end;
/
PROMPT =========================================
PROMPT UPDATE_TIME and USER_ID NOT NULL
PROMPT ==========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -1442);
begin
execute immediate 'alter table BARS.SEC_UPDATE_QUEUE modify UPDATE_TIME NOT NULL';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -1442);
begin
execute immediate 'alter table BARS.SEC_UPDATE_QUEUE modify USER_ID NOT NULL';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
PROMPT ===========================================
PROMPT CREATE PRIMARY KEY CONSTRAINT PK_SECUPDQ
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2260);
begin
execute immediate '
ALTER TABLE BARS.SEC_UPDATE_QUEUE ADD (
  CONSTRAINT "PK_SECUPDQ"
  PRIMARY KEY ("UPDATE_TIME", "USER_ID")
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_SECUPDQ_UPDTIME_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.SEC_UPDATE_QUEUE ADD (
  CONSTRAINT "CC_SECUPDQ_UPDTIME_NN"
  CHECK ("UPDATE_TIME" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT CREATE CHECK CONSTRAINT CC_SECUPDQ_USERID_NN
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -2264);
begin
execute immediate '
ALTER TABLE BARS.SEC_UPDATE_QUEUE ADD (
  CONSTRAINT "CC_SECUPDQ_USERID_NN"
  CHECK ("USER_ID" IS NOT NULL)
  ENABLE VALIDATE)';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

