prompt view/vw_ref_kl_k110.sql
create or replace force view bars_intgr.vw_ref_kl_k110 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
VED, 
t.NAME, 
OELIST, 
D_CLOSE 
from bars.VED t;
