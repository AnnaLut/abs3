prompt create view bars_intgr.vw_ref_ps_tts_xrm

create or replace force view vw_ref_ps_tts_xrm as
select  cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
		id,
		tt,
		nbs,
		dk,
		ob22 
from bars.V_PS_TTS_XRM t;

comment on table vw_ref_ps_tts_xrm is 'Доступні маски рахунків для операцій (PS_TTS_XRM)';