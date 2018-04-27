prompt create view bars_intgr.vw_ref_folders_tts_xrm

create or replace force view vw_ref_folders_tts_xrm as
select  cast(bars.F_OURMFO_G as varchar2(6)) MFO,
		idfo,
		tt,
		name 
from bars.V_FOLDERS_TTS_XRM t;

comment on table vw_ref_folders_tts_xrm is 'Групування операцій по каталогам (FOLDERS_TTS_XRM)';
