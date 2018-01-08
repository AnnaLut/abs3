-- ======================================================================================
-- Module : SOC
-- Author : BAA
-- Date   : 14.07.2016
-- ======================================================================================
-- create view V_DPT_FILE_IMPR
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_DPT_FILE_IMPR
prompt -- ======================================================

create or replace view V_DPT_FILE_IMPR
( KF
, FILE_DT
, FILE_TP
, FILE_QTY
, USR_ID
) as
select fh.KF
     , fh.DAT              as FILE_DT
     , fh.TYPE_ID          as FILE_TP
     , count(fh.HEADER_ID) as FILE_QTY
     , fh.USR_ID
  from DPT_FILE_HEADER fh
 where fh.KF = sys_context('bars_context','user_mfo')
   and fh.DAT >= add_months(trunc(sysdate,'MM'),-6)
   and fh.TYPE_ID in ( 1, 2 )
   and fh.USR_ID = USER_ID
 group by fh.KF, fh.DAT, fh.USR_ID, fh.TYPE_ID;

show errors

grant select on V_DPT_FILE_IMPR to BARS_ACCESS_DEFROLE;
