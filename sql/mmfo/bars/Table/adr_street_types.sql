-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_STREET_TYPES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create Table ADR_STREET_TYPES
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'ADR_STREET_TYPES', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_STREET_TYPES', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_STREET_TYPES
( STR_TP_ID     number(3)      NOT NULL
, STR_TP_NM     varchar2(12)   NOT NULL
, STR_TP_NM_RU  varchar2(12)
, CONSTRAINT PK_STREETTYPES PRIMARY KEY (STR_TP_ID) USING INDEX  TABLESPACE BRSSMLI
) TABLESPACE BRSSMLD';
  
  dbms_output.put_line('Table BARS.ADR_STREET_TYPES created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_STREET_TYPES already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.ADR_STREET_TYPES              IS 'Довідник типів вулиць';

COMMENT ON COLUMN BARS.ADR_STREET_TYPES.STR_TP_ID    IS 'Ід.   типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREET_TYPES.STR_TP_NM    IS 'Назва типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREET_TYPES.STR_TP_NM_RU IS 'Назва типу вулиці';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.ADR_STREET_TYPES TO START1, BARSUPL, UPLD;
