prompt create view bars_intgr.vw_ref_sw_banks

create or replace force view vw_ref_sw_banks as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
BIC,
NAME
from bars.sw_banks t;
