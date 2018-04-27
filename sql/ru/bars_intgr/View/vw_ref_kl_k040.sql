prompt view/vw_ref_kl_k040.sql
create or replace force view bars_intgr.vw_ref_kl_k040 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
COUNTRY, 
t.NAME, 
GRP, 
FATF 
from bars.COUNTRY t;
