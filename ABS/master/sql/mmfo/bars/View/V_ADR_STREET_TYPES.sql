-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 30.06.2016
-- ======================================================================================
-- create view V_ADR_STREET_TYPES 
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_ADR_STREET_TYPES 
prompt -- ======================================================

create or replace view BARS.V_ADR_STREET_TYPES
( STR_TP_ID
, STR_TP_NM
) as
select STR_TP_ID
     , STR_TP_NM
  from BARS.ADR_STREET_TYPES
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_ADR_STREET_TYPES             IS 'Довідник типів вулиць';

COMMENT ON COLUMN BARS.V_ADR_STREET_TYPES.STR_TP_ID   IS 'Ідентифікатор типу вулиці';
COMMENT ON COLUMN BARS.V_ADR_STREET_TYPES.STR_TP_NM   IS 'Назва типу вулиці';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_ADR_STREET_TYPES TO BARS_ACCESS_DEFROLE;
