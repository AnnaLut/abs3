-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_HOUSES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500
SET FEEDBACK     OFF

prompt -- ======================================================
prompt -- create Table ADR_HOUSES
prompt -- ======================================================

begin
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_HOUSES
( HOUSE_ID          number(10)  NOT NULL
, STREET_ID         number(10)  NOT NULL
, DISTRICT_ID       number(10)
, HOUSE_NUM         varchar2(5)
, HOUSE_NUM_ADD     varchar2(15)
, POSTAL_CODE       varchar2(5)
, LATITUDE          varchar2(15)
, LONGITUDE         varchar2(15)
, CONSTRAINT PK_HOUSENUMS               PRIMARY KEY (HOUSE_ID)    USING INDEX TABLESPACE BRSMDLI
, CONSTRAINT FK_HOUSENUMS_CITYDISTRICTS FOREIGN KEY (DISTRICT_ID) REFERENCES ADR_CITY_DISTRICTS (DISTRICT_ID)
, CONSTRAINT FK_HOUSENUMS_STREETS       FOREIGN KEY (STREET_ID)   REFERENCES ADR_STREETS (STREET_ID)
) TABLESPACE BRSMDLD';
  
  dbms_output.put_line('Table BARS.ADR_HOUSES created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_HOUSES already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- Table comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.ADR_HOUSES               IS 'Довідник номерів будинків';

COMMENT ON COLUMN BARS.ADR_HOUSES.HOUSE_ID      IS 'Ід. будинку';
COMMENT ON COLUMN BARS.ADR_HOUSES.STREET_ID     IS 'Ід. вулиці (в населеному пункті)';
COMMENT ON COLUMN BARS.ADR_HOUSES.HOUSE_NUM     IS 'Номер будинку';
COMMENT ON COLUMN BARS.ADR_HOUSES.HOUSE_NUM_ADD IS 'дополнительная часть номера дома (содержит дробную или буквенную часть)';
COMMENT ON COLUMN BARS.ADR_HOUSES.POSTAL_CODE   IS 'Поштовий індекс будинку';
COMMENT ON COLUMN BARS.ADR_HOUSES.DISTRICT_ID   IS 'Ід. району в місті';
COMMENT ON COLUMN BARS.ADR_HOUSES.LATITUDE      IS 'Географічні координати будинку (широта)';
COMMENT ON COLUMN BARS.ADR_HOUSES.LONGITUDE     IS 'Географічні координати будинку (довгота)';

prompt -- ======================================================
prompt -- Table grants
prompt -- ======================================================

GRANT SELECT ON BARS.ADR_HOUSES TO START1, BARSUPL, UPLD;

SET FEEDBACK OFF

begin
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES_ERRLOG', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES_ERRLOG', 'FILIAL', null, null, null, null );
end;
/

begin
  dbms_errlog.create_error_log('ADR_HOUSES','ADR_HOUSES_ERRLOG');
  dbms_output.put_line('Table BARS.ADR_HOUSES_ERRLOG created.');
exception
  when OTHERS then
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_HOUSES_ERRLOG already exists.');
    else raise;
    end if;
end;
/

SET FEEDBACK ON
