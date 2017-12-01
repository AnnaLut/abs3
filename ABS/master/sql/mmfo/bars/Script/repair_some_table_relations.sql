declare
    constraint_doesnt_exist exception;
    pragma exception_init(constraint_doesnt_exist, -2443);
begin
    execute immediate 'alter table bars.acr_docs drop constraint fk_acrdocs_intaccn2';
exception
    when constraint_doesnt_exist then
         null;
end;
/

declare
    constraint_doesnt_exist exception;
    pragma exception_init(constraint_doesnt_exist, -2443);
begin
    execute immediate 'alter table bars.acr_docs drop constraint fk_acrdocs_kf';
exception
    when constraint_doesnt_exist then
         null;
end;
/

-- clear data
begin
    delete staff_ad_user t
    where  t.active_directory_name = 'OSCHADBANK\YURYKNMI';

    commit;
end;
/
-- remove wrong index
declare
    index_doesnt_exist exception;
    pragma exception_init(index_doesnt_exist, -1418);
begin
    execute immediate 'drop index staff_ad_user_idx';
exception
    when index_doesnt_exist then
         null;
end;
/
-- create proper index
declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate 'create unique index uix_staff_ad_user_id on staff_ad_user (user_id) tablespace brsmdli';
exception
    when name_already_used then
         null;
end;
/

declare
    unique_key_doesnt_exist exception;
    pragma exception_init(unique_key_doesnt_exist, -2442);
begin
    execute immediate 'alter table sgn_ext_store drop unique (ref, sign_id) cascade drop index';
exception
    when unique_key_doesnt_exist then
         null;
end;
/

declare
    index_already_exists exception;
    pragma exception_init(index_already_exists, -955);
begin
    execute immediate 'create unique index bars.ui_sgnextstore_sign_id on bars.sgn_ext_store (sign_id) tablespace brsmdli';
exception
    when index_already_exists then
         null;
end;
/
