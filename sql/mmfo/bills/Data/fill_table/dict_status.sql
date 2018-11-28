prompt fill dict_status
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SG', 'Вексель підписаний в ДКСУ', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SN', 'Вексель переданий до банку', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RC', 'Вексель отриманий ЦА', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SR', 'Вексель переданий з ЦА в регіон', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RR', 'Вексель отриманий в регіоні', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('OK', 'Вексель виданий отримувачу', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RQ', 'Первинний запит до ДКСУ', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('XX', 'Запит очікує формування витягу', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SN', 'Витяг переданий в ДКСУ', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RJ', 'Запит відбракований в ДКСУ', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('AX', 'Архів', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('IN', 'Документ створено', 'D');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('OK', 'Документ відправлено', 'D');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RJ', 'Документ видалено', 'D');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('AX', 'Архів', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('IN', 'Запит створений', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('OK', 'Отримана відповідь', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RQ', 'Запит відправлений в ДКСУ', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('SN', 'Запит відправлений', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('XX', 'Запит підтверджений, очікується витяг', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('GN', 'Вексель згенерований в ДКСУ', 'B');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('VH', 'Векселя видані стягувачу', 'R');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('VH', 'Векселя видані стягувачу', 'C');
insert /*+ ignore_row_on_dupkey_index(dict_status XPK_DICT_STATUS)*/ into dict_status (CODE, NAME, TYPE)
values ('RJ', 'Запит відбракований в ДКСУ', 'R');
commit;

update dict_status
set name = 'Стягувача зарезервовано'
where code = 'RQ'
and type = 'R';

commit;