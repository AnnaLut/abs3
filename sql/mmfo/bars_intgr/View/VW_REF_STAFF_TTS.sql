prompt bars_intgr.VW_REF_STAFF_TTS

create or replace force view bars_intgr.VW_REF_STAFF_TTS
as
select * from bars.v_staff_tts_xrm t;

comment on table bars_intgr.VW_REF_STAFF_TTS is '�������� ������� ������������ (STAFF_TTS)';