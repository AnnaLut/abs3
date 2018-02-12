-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 14.06.2016
-- ======================================================================================
-- create view V_ADR_STREETS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_ADR_STREETS
prompt -- ======================================================

create or replace view BARS.V_ADR_STREETS
( STR_ID
, STR_NM
, STR_TP_ID
, STR_TP_NM
, SETL_ID
) as
select s.STREET_ID
     , s.STREET_NAME
     , s.STREET_TYPE
     , t.STR_TP_NM
     , s.SETTLEMENT_ID
  from BARS.ADR_STREETS s
  join BARS.ADR_STREET_TYPES t
    on ( t.STR_TP_ID = s.STREET_TYPE )
 where END_DT Is Null
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_ADR_STREETS           IS 'Довідник вулиць';

COMMENT ON COLUMN BARS.V_ADR_STREETS.STR_ID    IS 'Ідентифікатор вулиці';
COMMENT ON COLUMN BARS.V_ADR_STREETS.STR_NM    IS 'Назва вулиці';
COMMENT ON COLUMN BARS.V_ADR_STREETS.STR_TP_ID IS 'Ідентифікатор типу вулиці';
COMMENT ON COLUMN BARS.V_ADR_STREETS.STR_TP_NM IS 'Назва типу вулиці';
COMMENT ON COLUMN BARS.V_ADR_STREETS.SETL_ID   IS 'Ідентифікатор населеного пункту';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_ADR_STREETS TO BARS_ACCESS_DEFROLE;
