-- ======================================================================================
-- Module : ADR
-- Author : BAA
-- Date   : 14.06.2016
-- ======================================================================================
-- create view V_ADR_SETTLEMENTS_RGST
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_ADR_SETTLEMENTS_RGST
prompt -- ======================================================

create or replace view BARS.V_ADR_SETTLEMENTS_RGST
( SETL_ID
, SETL_NM
, SETL_TP_ID
, SETL_TP_NM
, REGION_ID
, AREA_ID
) as
select s.SETTLEMENT_ID
     , s.SETTLEMENT_NAME
     , s.SETTLEMENT_TYPE_ID
     , t.SETTLEMENT_TP_NM
     , s.REGION_ID
     , s.AREA_ID
  from BARS.ADR_SETTLEMENTS s
  join BARS.ADR_SETTLEMENT_TYPES t
    on ( t.SETTLEMENT_TP_ID = s.SETTLEMENT_TYPE_ID )
;

show err

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_ADR_SETTLEMENTS_RGST            IS 'Довідник населених пунктів';

COMMENT ON COLUMN BARS.V_ADR_SETTLEMENTS_RGST.SETL_ID    IS 'Ідентифікатор населеного пункту (equal to "SPIU.SUMMARYSETTLEMENTS.SUMMARYSETTLEMENTID"';
COMMENT ON COLUMN BARS.V_ADR_SETTLEMENTS_RGST.SETL_NM    IS 'Назва населеного пункту';
COMMENT ON COLUMN BARS.V_ADR_SETTLEMENTS_RGST.SETL_TP_ID IS 'Ідентифікатор типу населеного пункту';
COMMENT ON COLUMN BARS.V_ADR_SETTLEMENTS_RGST.SETL_TP_NM IS 'Назва типу населеного пункту';
COMMENT ON COLUMN BARS.V_ADR_SETTLEMENTS_RGST.REGION_ID  IS 'Ід. області (для міст обласного підпорядкування)';
COMMENT ON COLUMN BARS.V_ADR_SETTLEMENTS_RGST.AREA_ID    IS 'Ід. району';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_ADR_SETTLEMENTS_RGST TO BARS_ACCESS_DEFROLE;
