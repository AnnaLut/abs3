-- ======================================================================================
-- Module : DPU
-- Author : BAA
-- Date   : 16.11.2017
-- ======================================================================================
-- create view V_DPU_NBS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_DPU_NBS
prompt -- ======================================================

CREATE OR REPLACE FORCE VIEW V_DPU_NBS
( NBS_CODE
, NBS_NAME
, NBS_S181
) AS
select p.NBS, p.NAME, d.IRVK
  from PS p
  join ( select unique IRVK, NBS_DEP
           from DPU_NBS4CUST
       ) d
    on ( d.NBS_DEP = p.NBS )
 where p.D_CLOSE Is Null
 order by d.IRVK, p.NBS;
/

show errors;

prompt -- ======================================================
prompt -- Comments
prompt -- ======================================================

COMMENT ON TABLE  V_DPU_NBS             IS ' депозитного модуля ЮЛ';

prompt -- ======================================================
prompt -- Grants
prompt -- ======================================================

grant SELECT on V_DPU_NBS to ABS_ADMIN;
grant SELECT on V_DPU_NBS to BARS_ACCESS_DEFROLE;
grant SELECT on V_DPU_NBS to START1;
