-- ======================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 14.03.2018
-- ======================================================================================
-- create view V_CUSTOMER_GCIF
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_CUSTOMER_GCIF
prompt -- ======================================================

create or replace force view V_CUSTOMER_GCIF
( KF
, CUST_ID
, GCIF
, CUST_TYPE
) as
select KF, RNK, GCIF, CUST_TYPE
  from EBKC_GCIF
;

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  V_CUSTOMER_GCIF           IS 'GCIF ідентифікатори клієнтів';

COMMENT ON COLUMN V_CUSTOMER_GCIF.KF        IS 'Код філіалу (МФО)';
COMMENT ON COLUMN V_CUSTOMER_GCIF.CUST_ID   IS 'РНК';
COMMENT ON COLUMN V_CUSTOMER_GCIF.CUST_TYPE IS 'Тип клієнта';
COMMENT ON COLUMN V_CUSTOMER_GCIF.GCIF      IS 'GCIF';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on V_CUSTOMER_GCIF to BARSREADER_ROLE;
grant SELECT on V_CUSTOMER_GCIF to BARS_ACCESS_DEFROLE;
grant SELECT on V_CUSTOMER_GCIF to UPLD;
