-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_SETTLEMENT_TYPES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create Table ADR_SETTLEMENT_TYPES
prompt -- ======================================================

SET FEEDBACK     OFF

begin
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENT_TYPES', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENT_TYPES', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_SETTLEMENT_TYPES
( SETTLEMENT_TP_ID       number(3)   NOT NULL
, SETTLEMENT_TP_NM     varchar2(50)  NOT NULL
, SETTLEMENT_TP_NM_RU  varchar2(50)
, CONSTRAINT PK_SETTLEMENTTYPES PRIMARY KEY (SETTLEMENT_TP_ID) USING INDEX TABLESPACE BRSSMLI
) TABLESPACE BRSSMLD';
  
  dbms_output.put_line('Table ADR_SETTLEMENT_TYPES created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table ADR_SETTLEMENT_TYPES already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on Table  BARS.ADR_SETTLEMENT_TYPES                     is 'Довідник типів населених пунктів';

COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_ID    IS 'Ідентифікатор типу населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_NM    IS 'Назва типу населеного пункту';
COMMENT ON COLUMN BARS.ADR_SETTLEMENT_TYPES.SETTLEMENT_TP_NM_RU IS 'Назва типу населеного пункту';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON ADR_SETTLEMENT_TYPES TO START1, BARSUPL, UPLD;
