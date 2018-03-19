prompt view/vw_ref_kl_k060.sql
create or replace force view bars_intgr.vw_ref_kl_k060 as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
PRINSIDER, 
PRINSIDERLV1, 
t.NAME, 
D_OPEN, 
D_CLOSE 
from bars.PRINSIDER t;
