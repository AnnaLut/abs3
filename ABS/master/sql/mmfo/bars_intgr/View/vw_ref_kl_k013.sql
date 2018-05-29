prompt view/vw_ref_kl_k013
create or replace force view bars_intgr.vw_ref_kl_k013 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO,
cast(t.K013 as varchar2(1)) as K013,
t.TXT, 
D_OPEN, 
D_CLOSE 
from bars.KL_K013 t;
