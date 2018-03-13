prompt refill table imp_object_dependency
delete from imp_object_dependency;

insert all
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('300465', 'CLIENTFO2', 'customer_update', 'RNK', 'custtype=3', 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('300465', 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('300465', 'CLIENTFO2', 'person_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('322669', 'CLIENTFO2', 'customer_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('322669', 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('322669', 'CLIENTFO2', 'person_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('324805', 'CLIENTFO2', 'customer_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('324805', 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('324805', 'CLIENTFO2', 'person_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('304665', 'CLIENTFO2', 'customer_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('304665', 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('304665', 'CLIENTFO2', 'person_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('351823', 'CLIENTFO2', 'customer_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('351823', 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('351823', 'CLIENTFO2', 'person_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('335106', 'CLIENTFO2', 'customer_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('335106', 'CLIENTFO2', 'customerw_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('335106', 'CLIENTFO2', 'person_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('300465', 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('322669', 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('324805', 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('304665', 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('351823', 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
into imp_object_dependency(KF, OBJECT_NAME, TABLE_NAME, KEY_COLUMN, SQL_PREDICATE, IDUPD) values ('335106', 'CLIENTFO2', 'customer_address_update', 'RNK', null, 1)
select 1 from dual;

commit;
