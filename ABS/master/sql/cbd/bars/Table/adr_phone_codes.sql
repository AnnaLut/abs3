-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_PHONE_CODES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table ADR_PHONE_CODES
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'ADR_PHONE_CODES', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_PHONE_CODES', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_PHONE_CODES
( PHONE_CODE_ID      number(10)    NOT NULL
, PHONE_CODE         varchar2(10)  NOT NULL
, PHONE_ADD_NUM      varchar2(10)
, CONSTRAINT PK_PHONECODES PRIMARY KEY (PHONE_CODE_ID) USING INDEX TABLESPACE BRSSMLI
) TABLESPACE BRSSMLD';
  
  dbms_output.put_line('Table BARS.ADR_PHONE_CODES created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_PHONE_CODES already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on Table  BARS.ADR_PHONE_CODES                is 'Довідник телефонних кодів';

COMMENT ON COLUMN BARS.ADR_PHONE_CODES.PHONE_CODE_ID  is 'Ід. телефонного коду';
COMMENT ON COLUMN BARS.ADR_PHONE_CODES.PHONE_CODE     is 'Телефонний код';
COMMENT ON COLUMN BARS.ADR_PHONE_CODES.PHONE_ADD_NUM  is 'Додатковий номер';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON ADR_PHONE_CODES TO START1, BARSUPL, UPLD;
