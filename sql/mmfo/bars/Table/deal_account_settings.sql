begin
    bars_policy_adm.alter_policy_info('DEAL_ACCOUNT_SETTINGS', 'WHOLE', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table deal_account_settings
     (
            account_type_id      number(38) not null,
            deal_group_id        number(38),
            currency_id          number(3),
            product_id           number(38),
            branch_code          varchar2(30 char),
            account_id           number(38) not null
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/

comment on table deal_account_settings is 'Прив''язка рахунків, до типів рахунків';

comment on column deal_account_settings.account_type_id  is 'Тип рахунку (роль, яку виконує даний рахунок)';
comment on column deal_account_settings.currency_id      is 'Ідентифікатор валюти, в якій виконується операція (може не співпадати з валютою прив''язаного рахунку)';
comment on column deal_account_settings.product_id       is 'Ідентифікатор продукту, по угоді якого виконується операція';
comment on column deal_account_settings.branch_code      is 'Код відділення, в якому виконується операція';
comment on column deal_account_settings.account_id       is 'Ідентифікатор рахунку, що відповідає заданій комбінації параметрів';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'CREATE UNIQUE INDEX UIDX_DEAL_ACCOUNT_SETTINGS ON DEAL_ACCOUNT_SETTINGS (ACCOUNT_TYPE_ID, DEAL_GROUP_ID, CURRENCY_ID, PRODUCT_ID, BRANCH_CODE) TABLESPACE BRSMDLI COMPRESS 4';
exception
    when name_already_used then
         null;
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'CREATE INDEX I_DEAL_ACCOUNT_SETTINGS2 ON DEAL_ACCOUNT_SETTINGS (ACCOUNT_ID) TABLESPACE BRSMDLI';
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
    lock table deal_account_settings in exclusive mode;

    execute immediate 'alter table deal_account_settings add constraint fk_deal_acc_sett_ref_accounts foreign key (account_id) references accounts (acc)';
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
    lock table deal_account_settings in exclusive mode;

    execute immediate 'alter table deal_account_settings add constraint fk_deal_acc_sett_ref_acc_type foreign key (account_type_id) references deal_account_type (id)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/
