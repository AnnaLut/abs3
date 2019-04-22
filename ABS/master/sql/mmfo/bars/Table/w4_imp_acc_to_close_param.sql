prompt w4_imp_acc_to_close_param
begin
    bpa.alter_policy_info('W4_IMP_ACC_TO_CLOSE_PARAM', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('W4_IMP_ACC_TO_CLOSE_PARAM', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate q'[
create table w4_imp_acc_to_close_param
(
exp_id number,
main_acc number,
tag varchar2(64),
val varchar2(500)
)]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
begin
    execute immediate 'alter table w4_imp_acc_to_close_param drop constraint XPK_IMP_ACC_TO_CLOSE_PARAM';
exception
    when others then
        if sqlcode = -2443 then null; else raise; end if;
end;
/
prompt I_W4_ACC_TO_CLOSE_PARAM_EID
begin
    execute immediate 'create index I_W4_ACC_TO_CLOSE_PARAM_EID on w4_imp_acc_to_close_param(exp_id)';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table w4_imp_acc_to_close_param is 'Доп. параметры / расхождения для счетов к закрытию от Way4';
comment on column w4_imp_acc_to_close_param.exp_id is 'Номер выгрузки';
comment on column w4_imp_acc_to_close_param.main_acc is 'acc основного счета';
comment on column w4_imp_acc_to_close_param.tag is 'тег для протокола (обычно номер счета)';
comment on column w4_imp_acc_to_close_param.val is 'значение расхождения: дата, код блокировки, остаток и т.д.';
grant select on w4_imp_acc_to_close_param to bars_access_defrole;