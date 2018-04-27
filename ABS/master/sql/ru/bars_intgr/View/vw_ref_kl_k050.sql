prompt view/vw_ref_kl_k050.sql
create or replace force view bars_intgr.vw_ref_kl_k050 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
K050, 
K051, 
K052, 
t.NAME, 
D_OPEN, 
D_CLOSE 
from bars.sp_k050 t;
