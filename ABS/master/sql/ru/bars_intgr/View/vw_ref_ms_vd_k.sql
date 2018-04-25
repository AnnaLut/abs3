prompt view/vw_ref_ms_vd_k.sql
create or replace force view bars_intgr.vw_ref_ms_vd_k as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
cast(ID as number(38)) as ID, 
t.NAME 
from bars.MS_VD_K t;
