-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 25.01.2017
-- ======================================================================================
-- create view V_SB_OB22
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_SB_OB22
prompt -- ======================================================

create or replace view BARS.V_SB_OB22
( R020
, OB22
, NAME
, OPN_DT
, CLS_DT
) as
select R020, OB22, TXT, D_OPEN, D_CLOSE
  from BARS.SB_OB22
;

show errors

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_SB_OB22 IS 'Перелік діючих договорів кредитних продуктів ЮО (кредити + овердрафти)';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

GRANT SELECT ON BARS.V_SB_OB22 TO START1;
GRANT SELECT ON BARS.V_SB_OB22 TO BARS_ACCESS_DEFROLE;
