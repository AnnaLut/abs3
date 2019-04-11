begin
    bars_policy_adm.alter_policy_info('DEAL_BALANCE_ACCOUNT_SETTINGS', 'WHOLE', null, null, null, null);
end;
/

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table deal_balance_account_settings
     (
            account_type_id      number(38) not null,
            deal_group_id        number(38),
            currency_id          number(3),
            product_id           number(38),
            balance_account      varchar2(4 char) not null,
            ob22_code            varchar2(2 char)
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/

comment on table deal_balance_account_settings is 'Прив''язка балансових рахунків, до типів рахунків';

comment on column deal_balance_account_settings.account_type_id  is 'Тип рахунку (роль, яку виконує даний рахунок)';
comment on column deal_balance_account_settings.currency_id      is 'Ідентифікатор валюти, в якій виконується операція (може не співпадати з валютою прив''язаного рахунку)';
comment on column deal_balance_account_settings.product_id       is 'Ідентифікатор продукту, по угоді якого виконується операція';
comment on column deal_balance_account_settings.balance_account  is 'Балансовий рахунок, що відповідає заданій комбінації параметрів';
comment on column deal_balance_account_settings.ob22_code        is 'Код ОБ22, що відповідає заданій комбінації параметрів';

declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'CREATE UNIQUE INDEX UIX_DEAL_BAL_ACCOUNT_SETTINGS ON DEAL_BALANCE_ACCOUNT_SETTINGS (ACCOUNT_TYPE_ID, DEAL_GROUP_ID, CURRENCY_ID, PRODUCT_ID) TABLESPACE BRSMDLI COMPRESS 3';
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
    lock table deal in exclusive mode;
    lock table deal_balance_account_settings in exclusive mode;

    execute immediate 'alter table deal_balance_account_settings add constraint fk_deal_bal_acc_ref_acc_type foreign key (account_type_id) references deal_account_type (id)';
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
    lock table deal_product in exclusive mode;
    lock table deal_balance_account_settings in exclusive mode;

    execute immediate 'alter table deal_balance_account_settings add constraint fk_deal_bal_acc_ref_product foreign key (product_id) references deal_product (id)';
exception
    when name_already_used or such_constraint_already_exists then
         null;
end;
/
