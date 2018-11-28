prompt fill dict_treasury_status
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (201, 'Видалений');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (202, 'Чорновий');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (203, 'Запит стягувача');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (204, 'Запит на виплату');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (205, 'Перевірений запит на виплату');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (206, 'Некоректний запит на виплату');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (207, 'Готовий до виплат');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (208, 'Випущені векселя');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (209, 'Векселя видані');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (210, 'Відхилений');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (211, 'Підтверджений');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (212, 'Переданий на уточнення в регіон');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (213, 'Підтверджений в регіоні');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (214, 'Підписаний першим підписом');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (215, 'Підписаний другим підписом');
insert /*+ ignore_row_on_dupkey_index(DICT_TREASURY_STATUS XPK_DICT_TREASURY_STATUS)*/ into dict_treasury_status (status_id, status_name)
values (218, 'Випущені векселя');
commit;