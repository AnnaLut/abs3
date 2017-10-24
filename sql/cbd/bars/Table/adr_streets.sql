-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_STREETS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create Table ADR_STREETS
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'ADR_STREETS', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_STREETS', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_STREETS
( STREET_ID       NUMBER(10)    CONSTRAINT CC_STREETS_STREETID_NN     NOT NULL
, STREET_NAME     VARCHAR2(50)  CONSTRAINT CC_STREETS_STREETNAME_NN   NOT NULL
, STREET_NAME_RU  VARCHAR2(50)
, STREET_TYPE     NUMBER(3)     CONSTRAINT CC_STREETS_STREETTYPE_NN   NOT NULL
, SETTLEMENT_ID   NUMBER(10)    CONSTRAINT CC_STREETS_SETTLEMENTID_NN NOT NULL
, EFF_DT               DATE     CONSTRAINT CC_STREETS_EFFDT_NN        NOT NULL
, END_DT               DATE
, CONSTRAINT PK_STREETS             PRIMARY KEY (STREET_ID)    USING INDEX TABLESPACE BRSMDLI
, CONSTRAINT FK_STREETS_STREETTYPES FOREIGN KEY (STREET_TYPE)   REFERENCES ADR_STREET_TYPES (STR_TP_ID)
, CONSTRAINT FK_STREETS_SETTLEMENTS FOREIGN KEY (SETTLEMENT_ID) REFERENCES ADR_SETTLEMENTS (SETTLEMENT_ID)
) TABLESPACE BRSMDLD';
  
  dbms_output.put_line('Table BARS.ADR_STREETS created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_STREETS already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

comment on Table  BARS.ADR_STREETS is 'Довідник вулиць';

COMMENT ON COLUMN BARS.ADR_STREETS.STREET_ID      IS 'Ідентифікатор вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_NAME    IS 'Назва вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_NAME_RU IS 'Назва вулиці (RUS)';
COMMENT ON COLUMN BARS.ADR_STREETS.STREET_TYPE    IS 'Ідентифікатор типу вулиці';
COMMENT ON COLUMN BARS.ADR_STREETS.SETTLEMENT_ID  IS 'Ідентифікатор населеного пункту';
COMMENT ON COLUMN BARS.ADR_STREETS.EFF_DT         IS 'The date from which an instance of the entity is valid.'
COMMENT ON COLUMN BARS.ADR_STREETS.END_DT         IS 'The date after which an instance of the entity is no longer valid.'

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.ADR_STREETS TO START1, BARSUPL, UPLD;
