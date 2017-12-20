-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 18.12.2017
-- ===================================== <Comments> =====================================
-- create unique index
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET TIMING       OFF
SET DEFINE       OFF
SET FEEDBACK     OFF
SET LINES        500
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON

begin
  NBUR_UTIL.SET_COL('NBUR_DM_CUSTOMERS',     'K072','CHAR(2)');
  NBUR_UTIL.SET_COL('NBUR_DM_CUSTOMERS_ARCH','K072','CHAR(2)');
end;
/
