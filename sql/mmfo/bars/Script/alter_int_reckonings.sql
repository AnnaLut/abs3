begin
    bars_policy_adm.alter_policy_info('INT_RECKONINGS', 'WHOLE', null, null, null, null);
    bars_policy_adm.alter_policies('INT_RECKONINGS', p_enable => true);
end;
/

declare
    column_already_exists exception;
    pragma exception_init(column_already_exists, -1430);
begin
    execute immediate 'alter table int_reckonings add is_grouping_unit varchar2(1 char)';
exception
    when column_already_exists then
         null;
end;
/

comment on column int_reckonings.is_grouping_unit    is 'ќзнака групуючого запису (об''ЇднуЇ дек≥лька пер≥од≥в нарахувань в один р€док)';

begin
    update int_reckonings t
    set    t.is_grouping_unit = case when (select count(*) from int_reckonings r where r.grouping_line_id = t.id) > 0 then 'Y' else 'N' end,
           t.line_type_id = 1;

    commit;
end;
/
