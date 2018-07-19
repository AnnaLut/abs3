-- ======================================================================================
-- Module : CDM
-- Author : BAA
-- Date   : 20.06.2018
-- ======================================================================================
-- create view V_EBK_SYNC_Q
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        200
SET PAGES        200

prompt -- ======================================================
prompt -- create view V_EBK_SYNC_Q
prompt -- ======================================================

create or replace view V_EBK_SYNC_Q
( KF
, CUST_ID
, CUST_TP
, CUST_TYPE
, EBK_MOD_TMS
, ABS_MOD_TMS
) as
select t1.KF
     , t1.RNK
     , case
       when ( t1.CUSTTYPE = 2 )
       then 'L'
       when ( t1.CUSTTYPE = 3 and t1.SED = '91  ' )
       then 'P'
       when ( t1.CUSTTYPE = 3 and t1.SED = '00  ' )
       then 'I'
       else null
       end as CUST_TP
     , t2.CUST_TYPE
     , t2.EBK_MOD_TMS
     , t2.ABS_MOD_TMS
  from ( select KF, RNK, CUSTTYPE, SED
           from customer
          where KF = sys_context('bars_context','user_mfo')
            and DATE_OFF Is Null
       ) t1
  left outer
  join ( select RNK, CUST_TYPE, EBK_MOD_TMS, ABS_MOD_TMS
           from EBKC_GCIF
          where KF = sys_context('bars_context','user_mfo')
            and lnnvl( EBK_MOD_TMS > ABS_MOD_TMS )
       ) t2 
    on ( t2.RNK = t1.RNK )
;

show errors;

grant SELECT on V_EBK_SYNC_Q to BARSREADER_ROLE;
grant SELECT on V_EBK_SYNC_Q to BARS_ACCESS_DEFROLE;
