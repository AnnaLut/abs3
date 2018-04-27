prompt view/vw_ref_tts_vob_xrm.sql
create or replace force view vw_ref_tts_vob_xrm as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO,
TT,
VOB,
t.NAME,
ORD
from bars.v_tts_vob_xrm t;
comment on table vw_ref_tts_vob_xrm is 'Операції - види документів';