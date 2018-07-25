prompt fill table bars_intgr.imp_object
prompt CLIENTFO2
begin
    insert into imp_object(object_name, object_proc, imp_order, active, imp_mode) values ('CLIENTFO2', 'xrm_import.import_clientfo2', 1, 1, 'DELTA');
exception
    when dup_val_on_index then null;
end;
/
prompt CLIENT_ADDRESS
begin
    insert into imp_object(object_name, object_proc, imp_order, active, imp_mode) values ('CLIENT_ADDRESS', 'xrm_import.import_client_address', 2, 1, 'DELTA');
exception
    when dup_val_on_index then null;
end;
/
prompt ACCOUNTS
begin
    insert into imp_object(object_name, object_proc, imp_order, active, imp_mode) values ('ACCOUNTS', 'xrm_import.import_accounts', 3, 1, 'DELTA');
exception
    when dup_val_on_index then null;
end;
/
prompt BPK2
begin
    insert into imp_object(object_name, object_proc, imp_order, active, imp_mode) values ('BPK2', 'xrm_import.import_bpk2', 4, 1, 'DELTA');
exception
    when dup_val_on_index then null;
end;
/
prompt DEPOSITS2
begin
    insert into imp_object(object_name, object_proc, imp_order, active, imp_mode) values ('DEPOSITS2', 'xrm_import.import_deposits2', 5, 1, 'DELTA');
exception
    when dup_val_on_index then null;
end;
/
prompt ACCOUNTS_CASH
begin
    insert into imp_object(object_name, object_proc, imp_order, active, imp_mode) values ('ACCOUNTS_CASH', 'xrm_import.import_accounts_cash', 6, 1, 'DELTA');
exception
    when dup_val_on_index then null;
end;
/
commit;
