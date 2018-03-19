prompt view/vw_ref_dpt_tts_vidd.sql
create or replace force view bars_intgr.vw_ref_dpt_tts_vidd as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
											VIDD, 
											TT, 
											ISMAIN 
											from bars.DPT_TTS_VIDD t;

comment on table BARS_INTGR.VW_REF_DPT_TTS_VIDD is 'Допустимые операции по видам вкладов';
comment on column BARS_INTGR.VW_REF_DPT_TTS_VIDD.VIDD is 'Код вида вклада';
comment on column BARS_INTGR.VW_REF_DPT_TTS_VIDD.TT is 'Код операции';
