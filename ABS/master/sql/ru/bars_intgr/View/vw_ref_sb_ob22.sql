prompt view/vw_ref_sb_ob22.sql
create or replace force view bars_intgr.vw_ref_sb_ob22 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
r020, 
ob22, 
txt 
from bars.sb_ob22;
