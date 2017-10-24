create or replace view V_NBUR_1PB_IMPORTED
( KF
, DOC_REF
, TXN_CODE
, TXN_NM
, CUST_ST
, CUST_CODE
, CUST_NM
) as
select KF
     , DOC_REF
     , TXN_CODE
     , TXN_NM
     , CUST_ST
     , CUST_CODE
     , CUST_NM
  from NBUR_EXG_1PB
 where CLNT_ID = 'IMPORTED'
;

show err

grant select on V_NBUR_1PB_IMPORTED to BARS_ACCESS_DEFROLE;
