begin
    bars_policy_adm.alter_policy_info('INT_RECKONINGS', 'WHOLE', null, 'E', 'E', 'E');
    bars_policy_adm.alter_policy_info('INT_RECKONINGS', 'FILIAL', null, null, null, null);
    bars_policy_adm.alter_policy_info('INT_RECKONINGS', 'CENTER', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table int_reckonings
     (
            id number(38) not null,
            line_type_id number(5) not null,
            deal_id number(38),
            account_id number(38) not null,
            interest_kind_id number(5) not null,
            date_from date not null,
            date_through date not null,
            account_rest number(38),
            interest_rate number(38, 12),
            interest_amount number(38),
            interest_tail number,
            state_id number(5) not null,
            grouping_line_id number(38),
            accrual_purpose varchar2(160 char),
            payment_purpose varchar2(160 char),
            accrual_document_id number(38),
            payment_document_id number(38)
     )
     enable row movement
     tablespace brsbigd
     partition by range (date_from) interval (numtoyminterval(1, ''month''))
     (
          partition initial_partition values less than (date ''2017-01-01'')
     )';
exception
    when name_already_used then null;
end;
/

declare
    name_already_used exception;
    table_can_have_only_one_pk exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(table_can_have_only_one_pk, -2260);
begin
    execute immediate 'alter table int_reckonings add constraint pk_int_reckonings primary key (id) using index tablespace brsbigi';
exception
    when name_already_used or table_can_have_only_one_pk then null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_int_reckonings_account_id on int_reckonings (account_id) tablespace brsbigi';
exception
    when name_already_used then null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create index i_int_reckonings_group_id on int_reckonings (grouping_line_id) tablespace brsbigi';
exception
    when name_already_used then null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index i_int_reckonings_accr_doc_id on int_reckonings (accrual_document_id) tablespace brsbigi';
exception
    when name_already_used then null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index i_int_reckonings_paym_doc_id on int_reckonings (payment_document_id) tablespace brsbigi';
exception
    when name_already_used then null;
end;
/

declare
    constraint_name_already_used exception;
    reference_already_exists exception;
    pragma exception_init(constraint_name_already_used, -1451);
    pragma exception_init(reference_already_exists, -2275);
begin
    execute immediate 'alter table int_reckonings add constraint fk_reck_ref_account foreign key (account_id) references accounts (acc)';
exception
    when constraint_name_already_used or reference_already_exists then null;
end;
/

declare
    constraint_name_already_used exception;
    reference_already_exists exception;
    pragma exception_init(constraint_name_already_used, -1451);
    pragma exception_init(reference_already_exists, -2275);
begin
    execute immediate 'alter table int_reckonings add constraint fk_reck_line_ref_group_line foreign key (grouping_line_id) references int_reckonings (id)';
exception
    when constraint_name_already_used or reference_already_exists then null;
end;
/

declare
    constraint_name_already_used exception;
    reference_already_exists exception;
    pragma exception_init(constraint_name_already_used, -1451);
    pragma exception_init(reference_already_exists, -2275);
begin
    execute immediate 'alter table int_reckonings add constraint fk_reck_ref_accr_document foreign key (accrual_document_id) references oper (ref)';
exception
    when constraint_name_already_used or reference_already_exists then null;
end;
/

declare
    constraint_name_already_used exception;
    reference_already_exists exception;
    pragma exception_init(constraint_name_already_used, -1451);
    pragma exception_init(reference_already_exists, -2275);
begin
    execute immediate 'alter table int_reckonings add constraint fk_reck_ref_paym_document foreign key (payment_document_id) references oper (ref)';
exception
    when constraint_name_already_used or reference_already_exists then null;
end;
/

comment on table int_reckonings is 'Дані розрахунків/нарахувань/виплат відсотків по рахунках';

comment on column int_reckonings.id                  is 'Ідентифікатор розрахунку відсотків';
comment on column int_reckonings.line_type_id        is 'Тип даних по відсотках (код довідника "RECKONING_LINE_TYPE")';
comment on column int_reckonings.deal_id             is 'Ідентифікатор угоди, до якої відноситься розрахунок відсотків';
comment on column int_reckonings.account_id          is 'Ідентифікатор рахунку по якому виконується розрахунок відсотків';
comment on column int_reckonings.interest_kind_id    is 'Вид розрахунку відсотків (довідник - таблиця int_idn)';
comment on column int_reckonings.date_from           is 'Дата початку періоду (включається в період)';
comment on column int_reckonings.date_through        is 'Дата завершення періоду (включається в період)';
comment on column int_reckonings.account_rest        is 'Залишок рахунку протягом періоду нарахування';
comment on column int_reckonings.interest_rate       is 'Відсоткова ставка, що діє протягом періоду нарахування';
comment on column int_reckonings.interest_amount     is 'Сума відсотків';
comment on column int_reckonings.interest_tail       is 'Залишок дробової частини відсотків';
comment on column int_reckonings.state_id            is 'Стан обробки запису (код довідника "INTEREST_RECKONING_STATE")';
comment on column int_reckonings.grouping_line_id    is 'Ідентифікатор групуючого запису, що об''єднує сиру аналітику розрахунку відсотків';
comment on column int_reckonings.accrual_purpose     is 'Встановлене вручну призначення документа нарахування';
comment on column int_reckonings.payment_purpose     is 'Встановлене вручну призначення документа виплати відсотків';
comment on column int_reckonings.accrual_document_id is 'Ідентифікатор документу нарахування';
comment on column int_reckonings.payment_document_id is 'Ідентифікатор документу виплати (для пасивів)';

