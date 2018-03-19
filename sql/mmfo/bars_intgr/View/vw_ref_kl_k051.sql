prompt view/vw_ref_kl_k051.sql
create or replace force view bars_intgr.vw_ref_kl_k051 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
SED, 
t.NAME, 
D_CLOSE 
from bars.SED t;
