begin
    bpa.alter_policy_info('DEAL_PRODUCT', 'WHOLE' , null, null, null, null);
    bpa.remove_policies('DEAL_PRODUCT');
    bpa.add_policies('DEAL_PRODUCT');
end;
/

declare
    column_already_exists exception;
    pragma exception_init(column_already_exists, -1430);
begin
    execute immediate 'alter table deal_product add is_active char(1 char) default ''Y'' not null';
exception
    when column_already_exists then
         null;
end;
/

declare
    column_doesnt_exist exception;
    pragma exception_init(column_doesnt_exist, -904);
begin
    execute immediate 'alter table deal_product drop column state_id';
exception
    when column_doesnt_exist then
         null;
end;
/


declare
    cant_drop_nonexistent_constr exception;
    pragma exception_init(cant_drop_nonexistent_constr, -2443);
begin
    execute immediate 'alter table deal_product drop constraint cc_prod_seg_of_business_nn';
exception
    when cant_drop_nonexistent_constr then
         null;
end;
/