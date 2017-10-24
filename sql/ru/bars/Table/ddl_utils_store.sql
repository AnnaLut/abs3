PROMPT ===========================================
PROMPT Create table DDL_UTILS_STORE
PROMPT ===========================================
begin
  execute immediate 'begin bpa.alter_policy_info(''DDL_UTILS_STORE'', ''WHOLE'',  null, null, null, null); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/

declare 
    ex_already_exists exception;
    pragma exception_init(ex_already_exists, -955);
begin
execute immediate 'CREATE TABLE DDL_UTILS_STORE
(
  "TABLE_NAME"  VARCHAR2(35),
  "OBJECT_NAME"  VARCHAR2(35),
  "OBJECT_TYPE"  VARCHAR2(35),
  "SQL_TEXT"  CLOB
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
exception
    when ex_already_exists then null;
    when others then raise;
end;
/

prompt ==================================
prompt Give grants on DDL_UTILS_STORE
prompt ==================================
grant select, insert, update, delete on DDL_UTILS_STORE to ABS_ADMIN;
grant select, insert, update, delete on DDL_UTILS_STORE to BARS_ACCESS_DEFROLE;
