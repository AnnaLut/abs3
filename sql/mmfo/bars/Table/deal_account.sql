begin
    bars_policy_adm.alter_policy_info('DEAL_ACCOUNT', 'WHOLE', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table deal_account
     (
            deal_id              number(38) not null,
            account_type_id      number(38) not null,
            account_id           number(38) not null
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/

comment on table deal_account is 'Зв''язок угоди з її рахунками';

comment on column deal_account.deal_id is 'Ідентифікатор угоди, до якої відноситься рахунок';
comment on column deal_account.account_type_id is 'Тип рахунку (роль, яку виконує даний рахунок в рамках угоди)';
comment on column deal_account.account_id is 'Ідентифікатор рахунку, пов''язаного з угодою';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'CREATE INDEX IDX_DEAL_ACCOUNT_DEAL ON DEAL_ACCOUNT (DEAL_ID) TABLESPACE BRSMDLI';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'CREATE INDEX IDX_DEAL_ACCOUNT_ACCOUNT ON DEAL_ACCOUNT (ACCOUNT_ID) TABLESPACE BRSMDLI';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table accounts in exclusive mode;
    lock table deal_account in exclusive mode;

    execute immediate 'alter table deal_account add constraint fk_deal_acc_reference_accounts foreign key (account_id) references accounts (acc)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table deal in exclusive mode;
    lock table deal_account in exclusive mode;

    execute immediate 'alter table deal_account add constraint fk_deal_acc_reference_deal foreign key (deal_id) references deal (id)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/

declare
    name_already_used exception;
    such_constraint_already_exists exception;
    pragma exception_init(name_already_used, -955);
    pragma exception_init(such_constraint_already_exists, -2275);
begin
    lock table deal_account_type in exclusive mode;
    lock table deal_account in exclusive mode;

    execute immediate 'alter table deal_account add constraint fk_deal_acc_ref_acc_type foreign key (account_type_id) references deal_account_type (id)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/
