prompt fill table bars_intgr.imp_object
prompt CLIENTFO2
begin
    insert into imp_object(object_name, object_proc, imp_order, active) values ('CLIENTFO2', 'xrm_import.import_clientfo2', 1, 1);
exception
    when dup_val_on_index then null;
end;
/
prompt CLIENT_ADDRESS
begin
    insert into imp_object(object_name, object_proc, imp_order, active) values ('CLIENT_ADDRESS', 'xrm_import.import_client_address', 2, 1);
exception
    when dup_val_on_index then null;
end;
/
prompt ACCOUNTS
begin
    insert into imp_object(object_name, object_proc, imp_order, active) values ('ACCOUNTS', 'xrm_import.import_accounts', 3, 1);
exception
    when dup_val_on_index then null;
end;
/
commit;
