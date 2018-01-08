-- ======================================================================================
-- Module : NBUR
-- Author : BAA
-- Date   : 30.11.2016
-- ======================================================================================
-- create view V_NBS_TIPS
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET ECHO         OFF
SET LINES        500
SET PAGES        500

prompt -- ======================================================
prompt -- create view V_NBS_TIPS
prompt -- ======================================================

create or replace force view V_NBS_TIPS
( NBS
, OB22
, TIP
, NAME
, ORD
) AS 
select n.NBS, n.OB22, n.TIP, t.NAME, t.ORD
  from NBS_TIPS n
  join TIPS     t
    on ( t.TIP = n.TIP )
 union
select p.NBS, null, t.TIP, t.NAME, t.ORD
  from PS   p
     , TIPS t
 where regexp_like( p.NBS, '^\d{4}$')
   and t.TIP = 'ODB'
 union
select null, null, t.TIP, t.NAME, t.ORD
  from TIPS t
 where t.TIP = 'ODB';

show errors

grant SELECT on V_NBS_TIPS to BARS_ACCESS_DEFROLE;
grant SELECT on V_NBS_TIPS to START1;
