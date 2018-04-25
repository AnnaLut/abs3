prompt view/vw_ref_staff_chk_xrm
create or replace force view vw_ref_staff_chk_xrm as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
LOGNAME, 
IDCHK, 
t.NAME 
from bars.v_staff_chk_xrm t;
comment on table vw_ref_staff_chk_xrm is 'Групи візування доступні користувачеві';