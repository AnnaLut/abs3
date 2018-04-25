prompt view/vw_ref_tobo.sql
create or replace force view bars_intgr.vw_ref_tobo as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
TOBO, 
t.NAME, 
B040, 
t.DESCRIPTION, 
DATE_OPENED, 
DATE_CLOSED 
from bars.TOBO t;
