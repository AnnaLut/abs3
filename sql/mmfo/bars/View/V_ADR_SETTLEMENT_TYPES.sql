-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 29.06.2016
-- ======================================================================================
-- create view V_ADR_SETTLEMENT_TYPES
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_ADR_SETTLEMENT_TYPES
prompt -- ======================================================

create or replace view BARS.V_ADR_SETTLEMENT_TYPES
( SETL_TP_ID
, SETL_TP_NM
)
as
select SETTLEMENT_TP_ID
     , SETTLEMENT_TP_NM
 from BARS.ADR_SETTLEMENT_TYPES
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_ADR_SETTLEMENT_TYPES              IS 'Довідник типів населених пунктів';

COMMENT ON COLUMN BARS.V_ADR_SETTLEMENT_TYPES.SETL_TP_ID   IS 'Ідентифікатор типу населеного пункту';
COMMENT ON COLUMN BARS.V_ADR_SETTLEMENT_TYPES.SETL_TP_NM   IS 'Назва типу населеного пункту';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_ADR_SETTLEMENT_TYPES TO BARS_ACCESS_DEFROLE;
