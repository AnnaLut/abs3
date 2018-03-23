prompt перезаливаем dm_obj - объекты для выгрузок

delete from dm_obj;

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CREDITS_D', 'DAY', 'dm_import.credits_dyn_imp', 1, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('DEPOSITS', 'DAY', 'dm_import.deposits_imp', 3, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('ACCOUNTS', 'DAY', 'dm_import.accounts_imp', 4, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('BPK', 'DAY', 'dm_import.bpk_imp', 5, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CLIENTFO', 'DAY', 'dm_import.customers_imp', 6, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CLIENTUR', 'DAY', 'dm_import.custur_imp', 7, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('ZASTAVA', 'DAY', 'dm_import.zastava_imp', 8, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CUSTREL', 'DAY', 'dm_import.custur_rel_imp', 9, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('DEPOSITS_PLT', 'DAY', 'dm_import.deposits_plt_imp', 10, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('BPK_PLT', 'DAY', 'dm_import.bpk_plt_imp', 11, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CUSTOMERS_PLT', 'DAY', 'dm_import.customers_plt_imp', 12, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CUSTSEGM', 'DAY', 'dm_import.cust_segm_imp', 13, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CREDITS_S', 'DAY', 'dm_import.credits_stat_imp', 14, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CLIENTFO', 'MONTH', 'dm_import.customers_imp', 1, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('DEPOSITS', 'MONTH', 'dm_import.deposits_imp', 2, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('ACCOUNTS', 'MONTH', 'dm_import.accounts_imp', 3, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('BPK', 'MONTH', 'dm_import.bpk_imp', 4, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CLIENTUR', 'MONTH', 'dm_import.custur_imp', 5, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CUSTREL', 'MONTH', 'dm_import.custur_rel_imp', 6, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CUSTSEGM', 'MONTH', 'dm_import.cust_segm_imp', 7, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('DEPOSITS_PLT', 'MONTH', 'dm_import.deposits_plt_imp', 8, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('BPK_PLT', 'MONTH', 'dm_import.bpk_plt_imp', 9, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CUSTOMERS_PLT', 'MONTH', 'dm_import.customers_plt_imp', 10, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CREDITS_ZAL', 'MONTH', 'dm_import.credits_zal_imp', 11, 1);

insert into dm_obj (OBJ_NAME, IMP_TYPE, OBJ_PROC, IMP_ORDER, ACTIVE)
values ('CREDITS_ZAL', 'DAY', 'dm_import.credits_zal_imp', 15, 1);

commit;
