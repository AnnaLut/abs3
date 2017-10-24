-- ======================================================================================
-- Module : CDM (EBK)
-- Author : BAA
-- Date   : 24.01.2017
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

create or replace view BARS.V_CUSTOMER_GCIF
( KF
, CUST_ID
, GCIF
, CUST_TYPE
) as
select KF, RNK, GCIF, CUST_TYPE
  from ( select KF, RNK, GCIF, CUST_TYPE
           from EBKC_GCIF
          union
         select SLAVE_KF, SLAVE_RNK, GCIF, CUST_TYPE
           from EBKC_SLAVE
          where SLAVE_KF = sys_context('bars_context','user_mfo')
       )
;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  BARS.V_CUSTOMER_GCIF             IS 'Відсоткові ставки в розрізі рахунків';

COMMENT ON COLUMN BARS.V_CUSTOMER_GCIF.KF          IS 'Код філіалу (МФО)';
COMMENT ON COLUMN BARS.V_CUSTOMER_GCIF.CUST_ID     IS 'РНК';
COMMENT ON COLUMN BARS.V_CUSTOMER_GCIF.CUST_TYPE   IS 'Тип клієнта';
COMMENT ON COLUMN BARS.V_CUSTOMER_GCIF.GCIF        IS 'GCIF';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant select on BARS.V_CUSTOMER_GCIF to BARS_ACCESS_DEFROLE;
