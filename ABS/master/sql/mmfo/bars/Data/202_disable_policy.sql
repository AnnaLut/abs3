
begin
    bars_policy_adm.alter_policy_info('TTS', 'FILIAL', null, null, null, null);
    bars_policy_adm.alter_policy_info('TTS', 'WHOLE', null, null, null, null);
    bars_policy_adm.alter_policies('TTS', true);
end;
/

