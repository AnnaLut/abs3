-- ======================================================================================
-- Module : SOC
-- Author : BAA
-- Date   : 14.07.2016
-- ======================================================================================
-- create view V_DPT_FILE_IMPR_DTL
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_DPT_FILE_IMPR_DTL
prompt -- ======================================================

create or replace view V_DPT_FILE_IMPR_DTL
( KF
, USR_ID
, FILE_DT
, FILE_TP
, FILE_NM
, FILE_SUM
, FILE_QTY
, FILE_HDR_ID
, TOT_AMT
, TOT_QTY
, PAID_QTY
, PAID_AMT
, BAD_QTY
, CLS_QTY
, PYMT_QTY
) as
select fh.KF
     , fh.USR_ID
     , fh.DAT     as FILE_DT
     , fh.TYPE_ID as FILE_TP
     , fh.FILENAME
     , fh.SUM/100
     , fh.INFO_LENGTH
     , fh.HEADER_ID
     , fr.TOT_AMT/100
     , fr.TOT_QTY
     , fr.PAID_QTY
     , fr.PAID_AMT/100
     , fr.BAD_QTY
     , fr.CLS_QTY
     , fr.PYMT_QTY
  from DPT_FILE_HEADER fh
  join ( select KF
              , HEADER_ID
              , sum(SUM)               as TOT_AMT
              , count(HEADER_ID)       as TOT_QTY
              , sum( nvl2(REF,  1,0) ) as PAID_QTY
              , sum( nvl2(REF,SUM,0) ) as PAID_AMT
              , sum(INCORRECT)         as BAD_QTY
              , sum(CLOSED)            as CLS_QTY
              , sum(MARKED4PAYMENT)    as PYMT_QTY
           from DPT_FILE_ROW
--          where KF = sys_context('bars_context','user_mfo')
          group by KF, HEADER_ID
       ) fr
    on ( fr.KF = fh.KF and fr.HEADER_ID = fh.HEADER_ID )
 where fh.KF = sys_context('bars_context','user_mfo')
   and fh.USR_ID = USER_ID
;

show errors

grant select on V_DPT_FILE_IMPR_DTL to BARS_ACCESS_DEFROLE;
