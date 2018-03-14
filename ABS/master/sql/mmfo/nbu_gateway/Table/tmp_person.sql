declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create global temporary table tmp_person
    (
            person_code varchar2(30 char),
            total_loans_amount number(38),
            request_id number(38),
            core_person_kf varchar2(6 char),
            core_person_id number(38),
            default_core_person_kf varchar2(6 char),
            default_core_person_id number(38)
    ) on commit delete rows';
exception
    when name_already_used then
         null;
end;
/
