prompt view/vw_ref_tts.sql
create or replace force view bars_intgr.vw_ref_tts as
select cast(bars.F_OURMFO_G as varchar2(6)) MFO, 
VID, 
t.NAME 
from bars.VIDS t;

comment on table BARS_INTGR.VW_REF_TTS is 'Справочник типов транзакций';
comment on column BARS_INTGR.VW_REF_TTS.NAME is 'Наименование транзакции';
