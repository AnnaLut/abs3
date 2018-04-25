prompt view/vw_ref_staff_tts_xrm.sql
create or replace force view vw_ref_staff_tts_xrm as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
LOGNAME, 
TT 
from bars.v_staff_tts_xrm t;
comment on table vw_ref_staff_tts_xrm is 'Операції доступні користувачеві';