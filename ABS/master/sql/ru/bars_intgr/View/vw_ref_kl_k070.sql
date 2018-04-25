prompt view/vw_ref_kl_k070.sql
create or replace force view bars_intgr.vw_ref_kl_k070 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
ISE, 
t.NAME, 
D_CLOSE 
from bars.ISE t;
