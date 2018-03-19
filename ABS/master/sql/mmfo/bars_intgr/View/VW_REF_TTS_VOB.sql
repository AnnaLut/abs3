prompt bars_intgr.VW_REF_TTS_VOB

create or replace force view bars_intgr.VW_REF_TTS_VOB
as
select t.tt, t.vob, t.name, t.ord from bars.v_tts_vob_xrm t;