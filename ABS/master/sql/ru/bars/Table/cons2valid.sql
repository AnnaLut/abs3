PROMPT ===========================================
PROMPT Create table BARS.CONS2VALID
PROMPT ===========================================
begin
  execute immediate 'begin bpa.alter_policy_info(''CONS2VALID'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

begin
  execute immediate 'begin bpa.alter_policy_info(''CONS2VALID'', ''FILIAL'', null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE BARS.CONS2VALID
(
  "NUM"                NUMBER,
  "OWNER"              VARCHAR2(30 BYTE),
  "CONSTRAINT_NAME"    VARCHAR2(30 BYTE)          NOT NULL,
  "CONSTRAINT_TYPE"    VARCHAR2(1 BYTE),
  "TABLE_NAME"         VARCHAR2(30 BYTE)          NOT NULL,
  "R_OWNER"            VARCHAR2(30 BYTE),
  "R_CONSTRAINT_NAME"  VARCHAR2(30 BYTE),
  "DELETE_RULE"        VARCHAR2(9 BYTE),
  "STATUS"             VARCHAR2(8 BYTE),
  "DEFERRABLE"         VARCHAR2(14 BYTE),
  "DEFERRED"           VARCHAR2(9 BYTE),
  "VALIDATED"          VARCHAR2(13 BYTE),
  "GENERATED"          VARCHAR2(14 BYTE),
  "BAD"                VARCHAR2(3 BYTE),
  "RELY"               VARCHAR2(4 BYTE),
  "LAST_CHANGE"        DATE,
  "INDEX_OWNER"        VARCHAR2(30 BYTE),
  "INDEX_NAME"         VARCHAR2(30 BYTE),
  "INVALID"            VARCHAR2(7 BYTE),
  "VIEW_RELATED"       VARCHAR2(14 BYTE)
)
TABLESPACE BRSDYND
RESULT_CACHE (MODE DEFAULT)
PCTUSED    0
PCTFREE    10
INITRANS   1
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
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

PROMPT ===========================================
PROMPT NOT NULL CONSTRAINT_NAME and TABLE_NAME
PROMPT ===========================================
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -1442);
begin
execute immediate 'ALTER TABLE BARS.CONS2VALID MODIFY CONSTRAINT_NAME NOT NULL';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -1442);
begin
execute immediate 'ALTER TABLE BARS.CONS2VALID MODIFY TABLE_NAME NOT NULL';
exception
    when ex_already_exists then null;
    when others then raise;
end;
/
prompt ==================================
prompt Give grants on BARS.CONS2VALID
prompt ==================================
grant select on BARS.CONS2VALID to BARS_DM;
/
