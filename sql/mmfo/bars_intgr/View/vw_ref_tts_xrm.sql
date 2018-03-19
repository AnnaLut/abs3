prompt create view bars_intgr.vw_ref_tts_xrm

create or replace force view vw_ref_tts_xrm as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
"TT", 
"NAME", 
"FLI", 
"KVA", 
"KVB", 
"DEF",
CONTRACTA_ABS_SEL,
CONTRACTB_ABS_SEL
from bars.v_tts_xrm;

comment on table VW_REF_TTS_XRM is 'Операції(KOP)';