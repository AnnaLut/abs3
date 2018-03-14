declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create global temporary table tmp_loan
    (
            customer_code varchar2(4000 byte),
            loan_number varchar2(4000 byte),
            loan_date date,
            loan_amount number(38),
            request_id number(38),
            core_loan_kf varchar2(6 char),
            core_loan_id number(38),
            core_customer_id number(38),
            default_core_loan_kf varchar2(6 char),
            default_core_loan_id number(38)
    ) on commit delete rows';
exception
    when name_already_used then
         null;
end;
/
