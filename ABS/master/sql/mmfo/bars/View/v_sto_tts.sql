prompt view V_STO_TTS
create or replace force view v_sto_tts
as
select t.tt, t.name 
from STO_TTS t;

grant select on bars.v_sto_tts to bars_access_defrole;

comment on table v_sto_tts is '��������, ��������� ��� ���������� ��������';
comment on column v_sto_tts.tt is '��� ��������';
comment on column v_sto_tts.name is '�������� �������� (������ ��������������� tts)';
