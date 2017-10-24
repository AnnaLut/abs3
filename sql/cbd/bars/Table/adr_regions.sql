-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 22.01.2016
-- ======================================================================================
-- create table ADR_REGIONS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create table ADR_REGIONS
prompt -- ======================================================

SET FEEDBACK     OFF

begin
  BPA.ALTER_POLICY_INFO( 'ADR_REGIONS', 'WHOLE' , null, null, null, null );
  BPA.ALTER_POLICY_INFO( 'ADR_REGIONS', 'FILIAL', null, null, null, null );
end;
/

begin
  execute immediate 'CREATE TABLE BARS.ADR_REGIONS
( Region_ID        number(10)    NOT NULL
, Region_NAME      varchar2(50)  NOT NULL
, Region_NAME_RU   varchar2(50)
, COUNTRY_ID       number(3)     default 804   NOT NULL
, KOATUU           varchar2(2)
, ISO3166_2        varchar2(5)
, CONSTRAINT PK_REGIONS         PRIMARY KEY (REGION_ID)  USING INDEX TABLESPACE BRSSMLI
, CONSTRAINT FK_REGIONS_COUNTRY FOREIGN KEY (COUNTRY_ID) REFERENCES COUNTRY (COUNTRY)
) TABLESPACE BRSSMLD';
  
  dbms_output.put_line('Table BARS.ADR_REGIONS created.');
  
exception
  when OTHERS then 
    if (sqlcode = -00955)
    then dbms_output.put_line('Table BARS.ADR_REGIONS already exists.');
    else raise;
    end if;  
end;
/

SET FEEDBACK ON

prompt -- ======================================================
prompt -- table comments
prompt -- ======================================================

comment on Table  BARS.ADR_REGIONS                is 'Довідник областей';

comment on column BARS.ADR_REGIONS.Region_ID      IS 'Ідентифікатор області';
comment on column BARS.ADR_REGIONS.Region_NAME    IS 'Назва області';
comment on column BARS.ADR_REGIONS.Region_NAME_RU IS 'Назва області';
comment on column BARS.ADR_REGIONS.COUNTRY_ID     IS 'Код країни';

prompt -- ======================================================
prompt -- table grants
prompt -- ======================================================

GRANT SELECT ON ADR_REGIONS TO START1, BARSUPL, UPLD;
