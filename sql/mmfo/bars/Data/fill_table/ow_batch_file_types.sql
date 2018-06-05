delete from OW_BATCH_FILETYPES;

insert into OW_BATCH_FILETYPES (ID, DESCR, CODE)
values (0, 'Пакетне відкриття', '');

insert into OW_BATCH_FILETYPES (ID, DESCR, CODE)
values (1, 'Зарплатний проект', 'BPK_PKG_OPENCARD');

insert into OW_BATCH_FILETYPES (ID, DESCR, CODE)
values (2, 'Картка киянина', 'BPK_PKG_OPENCARDKK');

insert into OW_BATCH_FILETYPES (ID, DESCR, CODE)
values (3, 'Студентські квитки', '');

insert into OW_BATCH_FILETYPES (ID, DESCR, CODE)
values (4, 'Муніципальний проект', 'BPK_PKG_OPENCARDM');

commit;