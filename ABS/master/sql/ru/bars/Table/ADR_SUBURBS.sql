-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_SUBURBS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create table ADR_SUBURBS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'ADR_SUBURBS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_SUBURBS', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_SUBURBS
( SUBURB_ID          number(10)     NOT NULL
, SUBURB_NAME        varchar2(50)   NOT NULL
, SUBURB_NAME_RU     varchar2(50)
, SETTLEMENT_ID      number(10)     NOT NULL
, CONSTRAINT SUBURBS_PK             PRIMARY KEY (SUBURB_ID)     USING INDEX TABLESPACE BRSSMLI
, CONSTRAINT FK_SUBURBS_SETTLEMENTS FOREIGN KEY (SETTLEMENT_ID) REFERENCES ADR_SETTLEMENTS (SETTLEMENT_ID)
) TABLESPACE BRSSMLD';
  
  dbms_output.put_line('Table BARS.ADR_SUBURBS created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_SUBURBS already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.ADR_SUBURBS               is 'Довідник передмість';

COMMENT ON COLUMN BARS.ADR_SUBURBS.SUBURB_ID      IS 'Ідентифікатор передмісття';
COMMENT ON COLUMN BARS.ADR_SUBURBS.SUBURB_NAME    IS 'Назва передмісття';
COMMENT ON COLUMN BARS.ADR_SUBURBS.SUBURB_NAME_RU IS 'Назва передмісття';
COMMENT ON COLUMN BARS.ADR_SUBURBS.SETTLEMENT_ID  IS 'Ідентифікатор населеного пункту';

prompt -- ======================================================
prompt -- table grants
prompt -- ======================================================

GRANT SELECT ON BARS.ADR_SUBURBS TO START1, BARSUPL, UPLD;
