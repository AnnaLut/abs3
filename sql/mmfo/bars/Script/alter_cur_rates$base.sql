PROMPT *** Alter policy CUR_RATES***
begin
    bars_policy_adm.alter_policy_info('CUR_RATES', 'WHOLE', null, null, null, null);
    bars_policy_adm.alter_policy_info('CUR_RATES', 'FILIAL', null, null, null, null);
    bars_policy_adm.alter_policy_info('CUR_RATES', 'CENTER', null, null, null, null);

    bars_policy_adm.remove_policies('CUR_RATES');

    commit;
end;
/

PROMPT *** Drop index I1_CURRATES$BASE ***
declare
    index_doesnt_exist exception;
    pragma exception_init(index_doesnt_exist, -1418);
begin
    execute immediate 'DROP INDEX BARS.I1_CURRATES$BASE';
exception
    when index_doesnt_exist then
         null;
end;
/
