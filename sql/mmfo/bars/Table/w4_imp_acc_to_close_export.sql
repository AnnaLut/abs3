prompt table w4_imp_acc_to_close_export
begin
    bpa.alter_policy_info('W4_IMP_ACC_TO_CLOSE_EXPORT', 'WHOLE', null, null, null, null);
    bpa.alter_policy_info('W4_IMP_ACC_TO_CLOSE_EXPORT', 'FILIAL', null, null, null, null);
end;
/
begin
    execute immediate q'[
create table w4_imp_acc_to_close_export
(
exp_id number,
check_date date,
checked_rows number,
blocked_rows number,
constraint PK_W4_IMP_ACC_TO_CLOSE_EXPORT primary key (exp_id) using index tablespace brssmli
)
tablespace brssmld
]';
exception
    when others then
        if sqlcode = -955 then null; else raise; end if;
end;
/
comment on table w4_imp_acc_to_close_export is 'Список выгрузок счетов для закрытия от Way4';
comment on column w4_imp_acc_to_close_export.exp_id is 'Номер выгрузки';
comment on column w4_imp_acc_to_close_export.check_date is 'Дата проверки';
comment on column w4_imp_acc_to_close_export.checked_rows is 'Количество проверенных строк';
comment on column w4_imp_acc_to_close_export.blocked_rows is 'Количество строк, заблокированных для передачи';

grant select on w4_imp_acc_to_close_export to bars_access_defrole;