prompt bars_intgr/data/imp_object_dependency.sql
prompt перезаливаем imp_object_dependency - справочник таблиц-зависимостей
begin
    delete from bars_intgr.imp_object_dependency;
    for rec in (select kf from bars.mv_kf)
    loop
        insert all
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'CLIENTFO2', 'customer_update', 'RNK', 'custtype=3', 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'CLIENTFO2', 'person_update', 'RNK', null, 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'CLIENT_ADDRESS', 'customer_address_update', 'RNK', null, 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'ACCOUNTS', 'accounts_update', 'ACC', null, 1)
		into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'BPK2', 'bpk_acc_update', 'ACC_PK', null, 1)
		into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'BPK2', 'w4_acc_update', 'ACC_PK', null, 1)
		into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'BPK2', 'accounts_update', 'ACC', null, 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'DEPOSITS2', 'dpt_deposit_clos', 'DEPOSIT_ID', null, 1)
        into bars_intgr.imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values (rec.kf, 'ACCOUNTS_CASH', 'accounts_update', 'ACC', null, 1)
        select 1 from dual;
    end loop;
    commit;
end;
/

