declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_loan
     (
            id number(38) not null,
            customer_object_id number(38) not null,
            loan_number varchar2(30 char) not null,
            loan_date date not null,
            loan_amount number(38),
            loan_currency_id number(3),
            core_loan_kf varchar2(6 char) not null,
            core_loan_id number(38) not null
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index uix_nbu_reported_loan on nbu_reported_loan (customer_object_id, loan_number, loan_date) tablespace brsmdli compress 2';
exception
    when name_already_used then
         null;
end;
/