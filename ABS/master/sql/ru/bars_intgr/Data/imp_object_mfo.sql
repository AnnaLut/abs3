prompt bars_intgr/Data/imp_object_mfo.sql

--delete from imp_object_mfo;
begin
    insert into imp_object_mfo(kf, object_name, changenumber)
    select kf, 'CLIENTFO2', 0 from bars.mv_kf;
    commit;
exception
    when dup_val_on_index then rollback;
end;
/
begin
    insert into imp_object_mfo(kf, object_name, changenumber)
    select kf, 'CLIENT_ADDRESS', 0 from bars.mv_kf;
    commit;
exception
    when dup_val_on_index then rollback;
end;
/
begin
    insert into imp_object_mfo(kf, object_name, changenumber)
    select kf, 'ACCOUNTS', 0 from bars.mv_kf;
    commit;
exception
    when dup_val_on_index then rollback;
end;
/
