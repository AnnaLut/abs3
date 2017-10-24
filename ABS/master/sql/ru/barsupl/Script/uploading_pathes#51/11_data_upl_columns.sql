-- ================================================================================
-- Module : UPL
-- Date : 05.05.2017
-- ================================================================================
-- Опис полів файлу вивантаження
-- ================================================================================

delete from BARSUPL.UPL_COLUMNS
 where file_id in ( 181, 182, 123, 555, 120 )
;

--
-- STAFF (staff) / 181 (ETL-18165 - UPL - возвращаем на предыдущую версию)
--
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 1, 'ID', 'Код пользователя', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 2, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 2);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 3, 'FIO', 'ФИО пользователя', 'VARCHAR2', 60, NULL, NULL, NULL, 'N', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 4, 'LOGNAME', 'Имя пользователя БД', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 5, 'TYPE', 'Признак отв.исп.', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 6, 'TABN', 'Табельный №', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 7, 'DISABLE', 'Признак блокировки пользователя', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 8, 'CLSID', 'Категория пользователя (CLSID<0 - технічний)', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 9, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 10, 'ACTIVE', 'Активность пользователя', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 11, 'CREATED', 'Дата заведення користувача в АБС', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (181, 12, 'EXPIRED', 'Дата деактивації користувача АБС', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);

--
-- STAFF_AD (staffad) / 182 (ETL-18165 - UPL - добавить в выгрузку файла STAFF поле "Учетная запись в AD")
--
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 1, 'ID', 'Код пользователя', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 2, 'FIO', 'ФИО пользователя', 'VARCHAR2', 60, NULL, NULL, NULL, 'N', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 3, 'LOGNAME', 'Имя пользователя БД', 'VARCHAR2', 30, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 4, 'TYPE', 'Признак отв.исп.', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 5, 'TABN', 'Табельный №', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 6, 'DISABLE', 'Признак блокировки пользователя', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 7, 'CLSID', 'Категория пользователя (CLSID<0 - технічний)', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 8, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 9, 'ACTIVE', 'Активность пользователя', 'NUMBER', 1, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 10, 'CREATED', 'Дата заведення користувача в АБС', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 11, 'EXPIRED', 'Дата деактивації користувача АБС', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values (182, 12, 'ACTIVE_DIRECTORY_NAME', 'ACTIVE DIRECTORY NAME користувача', 'VARCHAR2', 255, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);

--
-- NBU23_REZ (nbu23rez) / 555 (изменили формат полей ACC_R0, ACC_R30 на NUMBER(15.0) c NUMBER(22.10) иначе хвосты на ММФО не отрезались)
--
-- DWH ETL-18425 UPL - добавить в выгрузку NBU_23_REZ поля
--  в выгрузку NBU_23_REZ поля PD_0, FIN_Z, ISTVAL_351, RPB, S080, S080_Z, DDD_6B, FIN_P, FIN_D, Z, PD
-- 

Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable,  null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 0, 'KF', 'Код філіалу (МФО)', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 1);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 1, 'FDAT', 'Зв.дата(01.11.2012.', 'DATE', 8, NULL, 'ddmmyyyy', 'Y', 'N', NULL, NULL, '31/12/9999', 2);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 2, 'ID', 'Перв ключ:Мод+ид', 'VARCHAR2', 50, NULL, NULL, 'Y', 'N', NULL, NULL, '0', 3);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 3, 'RNK', 'Реєстраційний номер клієнта (РНК)', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 4, 'NBS', 'Бал.рах', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 5, 'KV', 'Вал дог', 'NUMBER', 3, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 6, 'ND', 'Реф дог', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 7, 'CC_ID', 'Ид.дог', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 8, 'ACC', 'Внутренний номер счета', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 9, 'NLS', '№ рах', 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 10, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 11, 'FIN', 'Фин.клас', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 12, 'OBS', 'Обсуг.', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 13, 'KAT', 'Кат.якост', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 14, 'K', 'Коефіціент ризику', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 15, 'IRR', 'Эфф.% ст КД - использованная', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 16, 'ZAL', 'Забезпеч.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 17, 'BV', 'Бал.варт', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 18, 'PV', 'Справ.варт', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 19, 'REZ', 'Рез-ном.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 20, 'REZQ', 'Рез-екв.', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 21, 'DD', 'DD', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 22, 'DDD', 'DDD', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 23, 'BVQ', 'Бал.варт активу, екв в 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 24, 'CUSTTYPE', 'Тип клієнта', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 25, 'IDR', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 26, 'WDATE', 'WDATE', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 27, 'OKPO', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 28, 'NMK', 'Назва клієнта', 'VARCHAR2', 35, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 29, 'RZ', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 30, 'PAWN', 'вид залога', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 31, 'ISTVAL', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 32, 'R013', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 33, 'REZN', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 34, 'REZNQ', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 35, 'ARJK', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 36, 'REZD', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 37, 'PVZ', 'Враховане (частина або все Справ.варт) забезпечення, ном в 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 38, 'PVZQ', 'Враховане (частина або все Справ.варт) забезпечення, екв в 1.00', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 39, 'ZALQ', 'Лiкв.забез~екв~ZALq', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 40, 'ZPR', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 41, 'ZPRQ', NULL, 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 42, 'PVQ', 'Теперішня вартість майбутніх грошових потоків на звітну дату за ефективною ставкою (еквівалент)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 43, 'RU', NULL, 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 44, 'INN', NULL, 'VARCHAR2', 20, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 45, 'NRC', NULL, 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 46, 'SDATE', 'Дата начала договора', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 47, 'IR', 'Ном.% ст сч - текущая', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 48, 'S031', 'код вида залога по классификации НБУ', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 49, 'K040', 'K040', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 50, 'PROD', NULL, 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 51, 'K110', 'K110', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 52, 'K070', 'K070', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 53, 'K051', 'K051', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 54, 'S260', NULL, 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 55, 'R011', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 56, 'R012', NULL, 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 57, 'S240', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 58, 'S180', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 59, 'S580', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 60, 'NLS_REZ', 'Рахунок для вiдобра~рез~NLS_REZ', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 61, 'NLS_REZN', 'Рахунок для вiдобра~рез(нал)~NLS_REZN', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 62, 'S250', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 63, 'ACC_R', 'ACC счета резерва вкл.в налоговый', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 64, 'FIN_R', NULL, 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 65, 'DISKONT', 'Сума Зменшення рез за рахунок дисконту', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 66, 'ISP', 'Виконавець по рахунку актива', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 67, 'OB22', NULL, 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 68, 'TIP', NULL, 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 69, 'SPEC', NULL, 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 70, 'ZAL_BL', 'Сума Залога балансовая', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 71, 'S280_290', 'код количества дней просрочки', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 72, 'ZAL_BLQ', 'Сума Залога балансовая (екв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 73, 'ACC_RN', 'ACC счета резерва не вкл.в налоговый', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 74, 'OB22_REZ', 'OB22 для счета резерва вкл.в налоговый', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 75, 'OB22_REZN', 'OB22 для счета резерва не вкл.в налоговый', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 76, 'IR0', 'Ном.% ст сч - начальная', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 77, 'IRR0', 'Эфф.% ст КД - известная', 'NUMBER', 20, 12, '99999990D000000000000', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 78, 'ND_CP', 'Ном.договора для группировки по резервам', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 79, 'SUM_IMP', 'Затраты на реализацию (ном.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 80, 'SUMQ_IMP', 'Затраты на реализацию (экв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 81, 'PV_ZAL', 'Поток*К', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 82, 'VKR', 'Внутр.кред.рейтинг', 'VARCHAR2', 10, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 83, 'S_L', 'Залог*коэф.ликв.-затраты на реал.(ном.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 84, 'SQ_L', 'Залог*коэф.ликв.-затраты на реал.(экв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 85, 'ZAL_SV', 'Справедлива вартість забезпечення (ном.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 86, 'ZAL_SVQ', 'Справедлива вартість забезпечення (екв.)', 'NUMBER', 20, 2, '999999999999999990D00', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 87, 'GRP', 'група активу портфельного методу', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 88, 'KOL_SP', 'Кількість днів прострочки', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 89, 'REZ39', 'Сумма резерва (ном.) из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 90, 'PVP', 'Сума очікуваних майбутніх грошових потоків за кредитом відповідно до договору ', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 91, 'BV_30', 'Просрочено свыше 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 92, 'BVQ_30', 'Просрочено свыше 30 дней укв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 93, 'REZ_30', 'Резерв свыше 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 94, 'REZQ_30', 'Резерв свыше 30 дней укв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 95, 'NLS_REZ_30', 'счет резерва по нач.% проср.>30 дней', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 96, 'ACC_R30', 'acc счета резерва по нач.% проср.>30 дней', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 97, 'OB22_REZ_30', 'Ob22 счета резерва по нач.% проср.>30 дней', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 98, 'BV_0', 'Просрочено менее 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 99, 'BVQ_0', 'Просрочено менее 30 дней екв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 100, 'REZ_0', 'Резерв менее 30 дней ном.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 101, 'REZQ_0', 'Резерв менее 30 дней укв.', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 102, 'NLS_REZ_0', 'счет резерва по нач.% проср.<30 дней', 'VARCHAR2', 15, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 103, 'ACC_R0', 'acc счета резерва по нач.% проср.<30 дней', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 104, 'OB22_REZ_0', 'Ob22 счета резерва по нач.% проср.<30 дней', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 105, 'KAT39', 'Категория риска из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 106, 'REZQ39', 'Сумма резерва (экв.) из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 107, 'S250_39', 'Метка расчета резерва на индивидуальной или коллективной основе', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 108, 'REZ23', 'Сумма резерва ПО 23 ПОСТ (ном.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 109, 'REZQ23', 'Сумма резерва ПО 23 ПОСТ (экв.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 110, 'KAT23', 'Категория риска из FINEVARE', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 111, 'S250_23', 'Метка расчета резерва на индивидуальной или коллективной основе', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 112, 'TIPA', 'Тип.актива', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 113, 'DAT_MI', 'Дата миграции кредита', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31/12/9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 114, 'BVUQ', 'Зкоригована бал.варт.екв', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 115, 'BVU', 'Зкоригована бал.варт.ном', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 116, 'EAD', '(BV - SNA) - EAD(ном.) Експозиція під риз-ком на дату оцінки', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 117, 'EADQ', '(BVQ - SNAQ) - EADQ(екв.) Експозиція під риз-ком на дату оцінки', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 118, 'CR', 'Кредитний ризик CR (ном.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 119, 'CRQ', 'Кредитний ризик CRQ (екв.)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 120, 'FIN_351', 'Скоригований клас (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 121, 'KOL_351', 'К-ть днів прострочки (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 122, 'KPZ', 'Коеф-т покриття забезпеченням (Кпз)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 123, 'KL_351', 'Коеф.ліквідності забезпечення (351)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 124, 'LGD', 'Втрати в разі дефолту (LGD)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 125, 'OVKR', 'Ознаки високого кредитного ризику', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 126, 'P_DEF', 'Події дефолту', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 127, 'OVD', 'Ознаки визнання дефолту', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 128, 'OPD', 'Ознаки припинення дефолту', 'VARCHAR2', 50, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 129, 'ZAL_351', 'Рівень повернення боргу за рахунок реалізації забезпечення ном.(CV*k)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 130, 'ZALQ_351', 'Рівень повернення боргу за рахунок реалізації забезпечення екв.(CV*k)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 131, 'RC', 'Рівень повернення боргу за рахунок інших надходжень ном.(RC)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 132, 'RCQ', 'Рівень повернення боргу за рахунок інших надходжень екв.(RCQ)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 133, 'CCF', 'Коефіцієнт кредитної конверсії (CCF)', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (555, 134, 'TIP_351', 'Тип актива 351 постанова', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS 
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 135, 'PD_0', 'Безризикові (PD=0)', 'NUMBER',    22, 10, '999999999990D0099999999', NULL, 'Y',    NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 138, 'RPB', 'Рівень покриття боргу', 'NUMBER',  22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 139, 'S080', 'Параметр Фин.класа по FIN_351', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 136, 'FIN_Z', 'Клас контрагента, визначений на основі інтегрального показника', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE,NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 137, 'ISTVAL_351', 'Джерело валютної виручки згідно з постановою 351', 'NUMBER',  1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 140, 'S080_Z', 'Параметр Фин.класа по FIN_Z', 'VARCHAR2', 1, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 141, 'DDD_6B', 'DDD для файла #6B', 'VARCHAR2', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 142, 'FIN_P', 'Скоригований клас з вр. прост.', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 143, 'FIN_D', 'Скоригований клас на події/ознаки дефолту', 'NUMBER',15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 144, 'Z', 'Інтегральний показник', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
 Values
   (555, 145, 'PD', 'Коеф. імовірності дефолту', 'NUMBER', 22, 10, '999999999990D0099999999', NULL, 'Y', NULL, NULL, '0', NULL);


--
-- PERSON (person) / 123 (ETL-18224 - добавлена колонка "ORGAN")
--
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 1, 'RNK', 'Регистрационный номер клиента', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 2, 'SEX', 'Пол', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 3, 'BDAY', 'Дата рождения', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 4, 'PASSP', 'Тип удостоверяющего документа', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 5, 'NUMDOC', '№ док', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 6, 'SER', 'Серия док', 'CHAR', 10, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 7, 'PDATE', 'Дата выдачи док', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 9, 'TELD', 'Домашний телефон', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 10, 'TELW', 'Рабочий телефон', 'CHAR', 20, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 11, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 11);
Insert into BARSUPL.UPL_COLUMNS   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values   (123, 12, 'ORGAN', 'Организация, выдавшая удостоверяющий документ', 'CHAR', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', 'N/A', NULL);

--
-- CUSTOMER_EXTERN (custext) / 120 (ETL-18284 - UPL - исправить табуляцию в файле)
--
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 1, 'ID', 'Код уникалный', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 2, 'NAME', 'Наименование/ФИО', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 3, 'DOC_TYPE', 'Тип документа', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 4, 'DOC_SERIAL', 'Серия документв', 'VARCHAR2', 30, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 5, 'DOC_NUMBER', 'Номер документа', 'VARCHAR2', 5, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 6, 'DOC_DATE', 'Дата выдачи документа', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 7, 'DOC_ISSUER', 'Место выдачи документа', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 8, 'BIRTHDAY', 'Дата рождения', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 9, 'BIRTHPLACE', 'Место рождения', 'VARCHAR2', 70, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 10, 'SEX', 'Пол', 'CHAR', 1, NULL, NULL, NULL, 'N', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 11, 'ADR', 'Адрес', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 12, 'TEL', 'Телефон', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 13, 'EMAIL', 'E_mail', 'VARCHAR2', 100, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 14, 'CUSTTYPE', 'Признак (1-ЮЛ, 2-ФЛ)', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 15, 'OKPO', 'ОКПО', 'VARCHAR2', 14, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 16, 'COUNTRY', 'Код страны', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 17, 'REGION', 'Код региона', 'VARCHAR2', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 18, 'FS', 'Форма собственности (K081)', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 19, 'VED', 'Вид эк. деят-ти (K110)', 'CHAR', 5, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 20, 'SED', 'Орг.-правовая форма (K051)', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 21, 'ISE', 'Инст. сектор экономики (K070)', 'CHAR', 5, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL);
Insert into BARSUPL.UPL_COLUMNS
   (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id)
 Values
   (120, 22, 'KF', 'Филиал', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2);


COMMIT;



--
-- FINISH
--