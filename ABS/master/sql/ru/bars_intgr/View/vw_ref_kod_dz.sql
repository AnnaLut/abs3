prompt create view bars_intgr.vw_ref_kod_dz

create or replace force view vw_ref_kod_dz as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
n1, 
n2
from bars.kod_dz;
