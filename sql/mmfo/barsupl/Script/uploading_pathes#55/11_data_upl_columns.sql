-- ================================================================================
-- Module : UPL
-- Date : 26.06.2017
-- ================================================================================
-- Опис полів файлу вивантаження
-- ================================================================================

/*
--**********************************
prompt дублирование файла 535 agrmchg0
prompt ТОЛЬКО ДЛЯ ТЕСТА
delete from BARSUPL.UPL_COLUMNS where file_id in ( 7535 );

insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE,
                                 COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH,
                                 SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 select 7535, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR,
        NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN
   from barsupl.upl_columns
  where file_id = 535;
--**********************************
*/

delete from BARSUPL.UPL_COLUMNS
 where file_id in ( 7535, 350, 351, 352, 355, 356, 221 );

---
--- ETL-***** INS_DEAL
--- Изменены форматы полей ID, STAFF_ID, PARTNER_ID, TYPE_ID, INS_RNK, SUM, SUM_KV, RNK, GRT_ID, ND, RENEW_NEED, RENEW_ID
--- убрал дробную часть
prompt Страхові договори 350
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 1, 'TYPE', 'Тип договора (страховые)', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 2, 'ID', 'Ідентифікатор', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 3, 'BRANCH', 'Код відділення', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 4, 'STAFF_ID', 'Код менеджера', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 5, 'CRT_DATE', 'Дата створення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 6, 'PARTNER_ID', 'Ідентифікатор СК', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 7, 'TYPE_ID', 'Ідентифікатор типу страхового договору', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 8, 'STATUS_ID', 'Ідентифікатор статусу договора', 'VARCHAR2', 100, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 9, 'STATUS_DATE', 'Дата останньої зміни статусу', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 10, 'STATUS_COMM', 'Коментар до встановленого статусу', 'VARCHAR2', 512, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 11, 'INS_RNK', 'РНК страхувальника', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 12, 'SER', 'Серія', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 13, 'NUM', 'Номер', 'VARCHAR2', 100, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 14, 'SDATE', 'Дата початку дії', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 15, 'EDATE', 'Дата кінця дії', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 16, 'SUM', 'Страхова сума', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 17, 'SUM_KV', 'Валюта страхової суми', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 18, 'INSU_TARIFF', 'Страховий тариф (%) (у випадку фіксованого тарифу)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 19, 'INSU_SUM', 'Страхова премія (у випадку фіксованої премії)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 20, 'OBJECT_TYPE', 'Тип обєкту страхування', 'VARCHAR2', 100, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 21, 'RNK', 'РНК для договорів страховання контрагента', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 22, 'GRT_ID', 'Ідентивікатор договору застави для договорів страхування застави', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 23, 'ND', 'Номер першого кредитного договору прив`язки', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 24, 'PAY_FREQ', 'Періодичність сплати чергового платежу', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 25, 'RENEW_NEED', 'Чи необхідно перезаключати новий договір після його закінчення', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (350, 26, 'RENEW_ID', 'Ідентифікатор нового договору страхування', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);

---
--- ETL-***** INS_PARTNERS
--- Изменены форматы полей ID, RNK, ACTIVE, CUSTTYPE
--- убрал дробную часть
prompt Акредитовані страхові компанії 351
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 1, 'ID', 'Ідентифікатор', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 2, 'NAME', 'Найменування', 'VARCHAR2', 300, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 3, 'RNK', 'РНК контрагента-компанії', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 4, 'AGR_NO', 'Номер договору про співробітництво', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 5, 'AGR_SDATE', 'Дата початку дії договору про співробітництво', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 6, 'AGR_EDATE', 'Дата закінчення дії договору про співробітництво', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 7, 'TARIFF_ID', 'Ід. тарифу на компанію', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 8, 'FEE_ID', 'Ід. комісії на компанію', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 9, 'LIMIT_ID', 'Ід. ліміту на компанію', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 10, 'ACTIVE', 'Флаг активності відносин', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (351, 11, 'CUSTTYPE', 'Тип контрагент', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);

---
--- ETL-***** INS_TYPES
--- Изменены форматы полей ID
--- убрал дробную часть
prompt Типи договорiв страхування 352
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (352, 1, 'ID', 'Ідентифікатор', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (352, 2, 'NAME', 'Найменування', 'VARCHAR2', 500, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (352, 3, 'OBJECT_TYPE', 'Тип об`єкту страхування', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);

---
--- ETL-***** INS_ADD_AGREEMENTS
--- Изменены форматы полей ID, DEAL_ID, STAFF_ID
--- убрал дробную часть
prompt Дод. угоди до страхових договорів 355
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 1, 'ID', 'Ідентифікатор', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 2, 'DEAL_ID', 'Ідентифікатор СД', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 3, 'BRANCH', 'Код відділення', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 4, 'STAFF_ID', 'Код менеджера', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 5, 'CRT_DATE', 'Дата створення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 6, 'SER', 'Серія ДУ', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 7, 'NUM', 'Номер ДУ', 'VARCHAR2', 100, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (355, 8, 'SDATE', 'Дата початку дії ДУ', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);

---
--- ETL-***** INS_PAYMENTS_SCHEDULE
--- Изменены форматы полей ID, TYPE, PAYED (убрал дробную часть)
--- Изменен порядок полей в ПК (был TYPE,KF,ID - стал TYPE,ID,KF )
prompt Графік платежів по страховим договорам 356
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 0, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 1, 'ID', 'Ідентифікатор', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 2, 'TYPE', 'Тип договора (страховые)', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 3, 'DEAL_ID', 'Ідентифікатор договору страхування', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 4, 'PLAN_DATE', 'Планова дата платежу', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 5, 'FACT_DATE', 'Фактична дата платежу', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 6, 'PLAN_SUM', 'Планова сума платежу', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 7, 'FACT_SUM', 'Фактична сума платежу', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 8, 'PMT_NUM', 'Номер платіжки', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 9, 'PMT_COMM', 'Коментар (МФО, тип і тп)', 'VARCHAR2', 500, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (356, 10, 'PAYED', 'Платіж сплачено', 'NUMBER', 22, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);

---
--- ETL-19133 UPL - выгрузить новое поле в файле deposit (file_id=221) WB
---
prompt Добавление полей файла deposit 221

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 0, 'TYPE', 'Тип договора (депозит ФЛ)', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 0, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 1, 'DEPOSIT_ID', '№ депозита', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 2, 'VIDD', 'Код вида депозитного договора для ФЛ', 'NUMBER', 4, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 3, 'ACC', 'Внутр. номер осн. счета', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 4, 'KV', 'Код валюты', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 5, 'RNK', 'Рег.№ вкладчика', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 6, 'DAT_BEGIN', 'Дата начала вклада', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 7, 'DAT_END', 'Дата окончания вклада', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 9, 'MFO_P', 'МФО для выплаты %%', 'VARCHAR2', 6, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 11, 'LIMIT', 'Лимит (первоначальнаяч сумма договора)', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 14, 'DATZ', 'Дата заключ.вклада', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 19, 'FREQ', 'Периодичность выплаты %%', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 20, 'ND', '№ депозитного договора из договора', 'VARCHAR2', 35, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 21, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 22, 'STATUS', 'Состояние договора (0-активный, 9-не подписан)', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 24, 'ACC_D', 'Внутр.номер техн.счета', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 25, 'MFO_D', 'МФО техн.счета', 'VARCHAR2', 6, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 27, 'NMS_D', 'Наименование техн.счета', 'VARCHAR2', 38, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 30, 'STOP_ID', 'Код штрафа за досрочное расторжение', 'NUMBER', 4, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 31, 'KF', 'Код філіалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 32, 'USERID', 'Пользователь-инициатор открытия вклада', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 33, 'BSD', 'Балансовый основного счета', 'VARCHAR2', 4, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 34, 'CNT_DUBL', 'Кількіть пролонгацій договору', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 35, 'CASHLESS', 'Ознака безготівкового розміщення коштів (1 - безготівкове)', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 36, 'ARCHDOC_ID', 'Ідентифікатор депозитного договору в ЕАД', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 37, 'TUP', 'TUP для ХД', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (221, 38, 'WB', 'Канал продажу', 'CHAR', 1, NULL, NULL, NULL, 'N', NULL, NULL, 'N', NULL, NULL);



COMMIT;



--
-- COBUSUPMMFO-212 Барс ММФО, відсутня міграція функціоналу з Барс Міленіум Вигрузка протоколу формування файлу #A7».
--
delete from BARSUPL.UPL_COLUMNS
 where file_id in ( 566 ,567);
 
prompt  566 выгрузка А7
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 1, 'TOBO', 'Відділення', 'CHAR', 30, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 2, 'NLS', 'Номер рахунку', 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 3, 'KV', 'Валюта', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 4, 'DATF', 'Робоча дата', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 5, 'ACC', 'ACC', 'NUMBER', 38, 0, NULL, 'Y', 'Y', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 6, 'DK', '1-Дт 2-Кт (код)', 'CHAR', 1, NULL, NULL, 'Y', 'Y', NULL, NULL, 'N/A', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 7, 'NBS', 'Бал. рах. (код)', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 8, 'KV1', 'Код валюти (код)', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 9, 'S181', '1-короткостр. 2-довгостр. (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 10, 'R013', 'Параметр R013 (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 11, 'S240', 'Код сроку до погашення (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 12, 'K030', 'Резидент нiсть (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 13, 'R012', 'Вид рахунку (код)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 14, 'ZNAP', 'Значення показника', 'NUMBER', 24, 0, NULL, NULL, 'Y', NULL, NULL, 0, NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 15, 'RNK', 'Реєстр. номер контрагента', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 16, 'OKPO', 'ІНН контрагента', 'VARCHAR2', 14, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 17, 'NMK', 'ПІБ (назва) контрагента', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 18, 'MDATE', 'Дата погашення', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 19, 'ISP', 'Код відп. виконавця', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 20, 'ND', 'Номер кред. договору', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 21, 'CC_ID', 'Ід. договору', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 22, 'SDATE', 'Дата заключення договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 23, 'WDATE', 'Дата завершення договору', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 24, 'REF', 'Номер документу', 'NUMBER', 38, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 25, 'COMM', 'Коментар', 'VARCHAR2', 250, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (566, 26, 'KF', 'Код фiлiалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 2, NULL);

 prompt  567 file name for А7

Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 1, 'FILE_NAME', 'Ім`я сформованого файлу', 'CHAR', 12, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 2, 'VERSION_ID', 'Ід. версії файлу', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, '0', 3, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 3, 'START_TIME', 'Дата початку формування', 'DATE', 14, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 4, 'FINISH_TIME', 'Дата закiнчення формування', 'DATE', 14, NULL, 'ddmmyyyyhh24miss', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values   (567, 5, 'KF', 'Код фiлiалу (МФО)', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 2, NULL);


COMMIT;

--
-- FINISH
--