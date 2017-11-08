prompt BPK2 columns
declare
l_file_id number;
begin
  select file_id into l_file_id from upl_files where file_code = 'BPK2';
  --удаляем все записи
  delete from upl_columns where file_id = l_file_id;
  --населяем заново
  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 1, 'branch', 'Відділення', 'CHAR', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 2, 'kf', 'РУ', 'CHAR', 12, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 3, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 4, 'nd', 'Номер договору', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 5, 'dat_begin', 'Дата договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 6, 'bpk_type', 'Тип платіжної карти', 'VARCHAR2', 50, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 7, 'nls', 'номер рахунку', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 8, 'daos', 'Дата відкриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 9, 'kv', 'Валюта рахунку', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 10, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 11, 'ostc', 'Поточний залишок на рахунку', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 12, 'date_lastop', 'Дата останньої операції', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 13, 'cred_line', 'Кредитна лінія', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 14, 'cred_lim', 'Сума встановленої кред.лінії', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 15, 'use_cred_sum', 'Використана сума кред.лінії', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 16, 'dazs', 'Дата закриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 17, 'blkd', 'Код блокування рахунку по дебету', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 18, 'blkk', 'Код блокування рахунку по кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 19, 'bpk_status', 'Статус договору по рахунку (1-відкритий, 0-закритий)', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 20, 'pk_okpo', 'Зарплатний проект, ЄДРПОУ організації', 'VARCHAR2', 10, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 21, 'pk_name', 'Зарплатний проект, Назва організації', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 22, 'pk_okpo_n', 'Зарплатний проект, Код структурного підрозділу', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 23, 'VID', 'Вид рахунку (ДФС)', 'VARCHAR2', 35, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 24, 'LIE_SUM', 'Арешт рахунку. Сума обтяження', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 25, 'LIE_VAL', 'Арешт рахунку. Валюта обтяження', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 26, 'LIE_DATE', 'Арешт рахунку. Дата документа', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 27, 'LIE_DOCN', 'Арешт рахунку. Номер документа', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 28, 'LIE_ATRT', 'Арешт рахунку. Орган, який видав документ', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 29, 'LIE_DOC', 'Арешт рахунку. Назва документу', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 30, 'PK_TERM', 'БПК. Кількість місяців дії картки', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 31, 'PK_OLDND', 'БПК. Номер договору по ЗП', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 32, 'PK_WORK', 'БПК. Місце роботи', 'VARCHAR2', 254, null, null, null, 'Y', null, 	'35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 33, 'PK_CNTRW', 'БПК. Місце роботи: країна', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 34, 'PK_OFAX', 'БПК. Місце роботи: FAX', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 35, 'PK_PHONE', 'БПК. Місце роботи: телефон', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 36, 'PK_PCODW', 'БПК. Місце роботи: поштовий індекс', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 37, 'PK_ODAT', 'БПК. Місце роботи: з якого часу працює', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 38, 'PK_STRTW', 'БПК. Місце роботи: вулиця', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 39, 'PK_CITYW', 'БПК. Місце роботи: місто', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 40, 'PK_OFFIC', 'БПК. Посада', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 41, 'DKBO_DATE_OFF', 'Дата розірвання ДКБО', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 42, 'DKBO_START_DATE', 'Дата приєднання до ДКБО', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 43, 'DKBO_DEAL_NUMBER', '№ договору ДКБО', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 44, 'KOS', 'Обороти Кредит', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 45, 'DOS', 'Обороти Дебет', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 46, 'W4_ARSUM', 'Way4. Арештована сума', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 47, 'W4_KPROC', 'Way4. Відсоток по кредиту', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 48, 'W4_SEC', 'Way4. Тайне слово', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 49, 'ACC', 'Унікальний ідентифікатор рахунку', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');
end;
/
commit;
/
