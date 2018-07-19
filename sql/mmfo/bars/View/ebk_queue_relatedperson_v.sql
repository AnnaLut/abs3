-- ======================================================================================
-- Module : CDM (ªÁÊ)
-- Author : BAA
-- Date   : 21.06.2018
-- ======================================================================================
-- create view EBK_QUEUE_RELATEDPERSON_V
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        200
SET PAGES        200

prompt -- ======================================================
prompt -- create view EBK_QUEUE_RELATEDPERSON_V
prompt -- ======================================================

create or replace force view EBK_QUEUE_RELATEDPERSON_V
( "KF"
, "relId"
, "RELATEDNESS"
, "relIntext"
, "RNK"
, "relRnk"
, "NOTES"
, CUST_ID
) AS
select c.kf
     , t.rel_id      as "relId"
     , r.relatedness
     , t.rel_intext  as "relIntext"
     , case
         when ( EBK_PARAMS.IS_CUT_RNK = 1 )
         then trunc(t.RNK/100)
         else t.RNK
       end           as RNK
     , t.rel_rnk     as "relRnk"
     , t.notes
     , t.RNK         as CUST_ID
  from V_CUSTOMER_REL t
     , CUST_REL r
     , CUSTOMER c
 where t.rel_id = r.id
   and t.rnk = c.rnk
   and c.CUSTTYPE = 3
   and (c.BC = 0 or c.BC is null)
   and (c.date_off is NULL or c.date_off > sysdate)
   and t.rnk <> t.rel_rnk
   and exists ( select null from EBKC_QUEUE_UPDATECARD
                 where CUST_TYPE = 'I'
                   and STATUS    = 0
                   and KF        = c.KF
                   and RNK       = c.RNK )
;

show errors;

grant SELECT on EBK_QUEUE_RELATEDPERSON_V to BARS_ACCESS_DEFROLE;
grant SELECT on EBK_QUEUE_RELATEDPERSON_V to BARSREADER_ROLE;
