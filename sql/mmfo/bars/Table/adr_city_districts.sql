-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 12.01.2015
-- ======================================================================================
-- create table ADR_CITY_DISTRICTS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500


prompt -- ======================================================
prompt -- create Table ADR_CITY_DISTRICTS
prompt -- ======================================================

SET FEEDBACK     OFF

begin
  BPA.ALTER_POLICY_INFO( 'ADR_CITY_DISTRICTS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_CITY_DISTRICTS', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_CITY_DISTRICTS
( DISTRICT_ID        number(3)     constraint CC_CITYDISTRICTS_DISTID_NN     NOT NULL
, DISTRICT_NAME      varchar2(50)  constraint CC_CITYDISTRICTS_DISTNM_NN     NOT NULL
, DISTRICT_NAME_RU   varchar2(50)
, SETTLEMENT_ID      number(10)    constraint CC_CITYDISTRICTS_SETLMNTID_NN  NOT NULL
, SPIU_DISTRICT_ID   number(10)    constraint CC_CITYDISTRICTS_SPIUDISTID_NN NOT NULL
, CONSTRAINT PK_CITYDISTRICTS             PRIMARY KEY (DISTRICT_ID)   USING INDEX TABLESPACE BRSSMLI
, CONSTRAINT FK_CITYDISTRICTS_SETTLEMENTS FOREIGN KEY (SETTLEMENT_ID) REFERENCES ADR_SETTLEMENTS (SETTLEMENT_ID)
) TABLESPACE BRSSMLD';
  
  dbms_output.put_line('Table BARS.ADR_CITY_DISTRICTS created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_CITY_DISTRICTS already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.ADR_CITY_DISTRICTS                  is 'Довідник внутрішньоміських районів';

COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.DISTRICT_ID      IS 'Ід. району в місті';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.DISTRICT_NAME    IS 'Назва району';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.DISTRICT_NAME_RU IS 'Назва району (мовою мордора)';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.SETTLEMENT_ID    IS 'Ідентифікатор населеного пункту';
COMMENT ON COLUMN BARS.ADR_CITY_DISTRICTS.SPIU_DISTRICT_ID IS 'Original ID from "SPIU.CITYDISTRICTS.CITYDISTRICTID"';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.ADR_CITY_DISTRICTS TO START1, BARSUPL, UPLD;
