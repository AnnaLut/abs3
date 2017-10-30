prompt CLIENTFO2 columns
declare
l_file_id number;
begin
  select file_id into l_file_id from upl_files where file_code = 'CLIENTFO2';
  --удаляем все записи
  delete from upl_columns where file_id = l_file_id;
  --населяем заново

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 1, 'LAST_NAME', 'Прізвище', 'VARCHAR2', 50, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 2, 'FIRST_NAME', 'Ім''я', 'VARCHAR2', 50, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 3, 'MIDDLE_NAME', 'По-батькові', 'VARCHAR2', 60, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 4, 'BDAY', 'Дата народження', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 5, 'GR', 'Громадянство', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 6, 'PASSP', 'Тип документу', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 7, 'SER', 'Серія', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 8, 'NUMDOC', 'Номер документу', 'VARCHAR2', 20, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 9, 'PDATE', 'Дата видачі', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 10, 'ORGAN', 'Орган видачі', 'VARCHAR2', 70, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 11, 'PASSP_EXPIRE_TO', 'Документ дійсний до', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 12, 'PASSP_TO_BANK', 'Дата пред''явлення документу банку', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 13, 'MFO', 'МФО', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 14, 'RNK', 'РНК', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 15, 'OKPO', 'ІНН', 'VARCHAR2', 14, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 16, 'CUST_STATUS', 'Статус клієнта в БАРС', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 17, 'CUST_ACTIVE', 'РНК активного клієнта', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 18, 'TELM', 'Мобільний телефон', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 19, 'TELW', 'Робочий телефон', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 20, 'TELD', 'Контактний телефон', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 21, 'TELADD', 'Додаткові телефони', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 22, 'EMAIL', 'Електронна пошта', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 23, 'ADR_POST_COUNTRY', 'Країна', 'VARCHAR2', 55, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 24, 'ADR_POST_DOMAIN', 'Область', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 25, 'ADR_POST_REGION', 'Район', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 26, 'ADR_POST_LOC', 'Населений пункт', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 27, 'ADR_POST_ADR', 'Вулиця, будинок, квартира', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 28, 'ADR_POST_ZIP', 'Поштовий індекс', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 29, 'ADR_FACT_COUNTRY', 'Країна', 'VARCHAR2', 55, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 30, 'ADR_FACT_DOMAIN', 'Область', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 31, 'ADR_FACT_REGION', 'Район', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 32, 'ADR_FACT_LOC', 'Населений пункт', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 33, 'ADR_FACT_ADR', 'Вулиця, будинок, квартира', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 34, 'ADR_FACT_ZIP', 'Поштовий індекс', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 35, 'ADR_WORK_COUNTRY', 'Країна', 'VARCHAR2', 55, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 36, 'ADR_WORK_DOMAIN', 'Область', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 37, 'ADR_WORK_REGION', 'Район', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 38, 'ADR_WORK_LOC', 'Населений пункт', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 39, 'ADR_WORK_ADR', 'Вулиця, будинок, квартира', 'VARCHAR2', 55, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 40, 'ADR_WORK_ZIP', 'Поштовий індекс', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 41, 'BRANCH', 'Відділення', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 42, 'NEGATIV_STATUS', 'Негативний статус', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 43, 'REESTR_MOB_BANK', 'Реєстрація в мобільному банкінгу', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 44, 'REESTR_INET_BANK', 'Реєстрація в інтернет-банкінгу', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 45, 'REESTR_SMS_BANK', 'Реєстрація в СМС-банкінгу', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 46, 'MONTH_INCOME', 'Сумарний місячний дохід', 'NUMBER', 22, 2, '99999990D00', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 47, 'SUBJECT_ROLE', 'Опис ролі суб''єкта', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 48, 'REZIDENT', 'Резидент', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 49, 'MERRIED', 'Сімейний стан', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 50, 'EMP_STATUS', 'Статус зайнятості особи', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 51, 'SUBJECT_CLASS', 'Класифікація суб''єкта', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 52, 'INSIDER', 'Ознака приналежності до інсайдерів', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 53, 'SEX', 'Стать', 'CHAR', 1, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 54, 'VIPK', 'Значення параметру ВІП', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 55, 'VIP_FIO_MANAGER', 'ПІБ працівника по ВІП', 'VARCHAR2', 250, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 56, 'VIP_PHONE_MANAGER', 'Телефон працівника по ВІП', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 57, 'DATE_ON', 'Дата відкриття клієнта', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 58, 'DATE_OFF', 'Дата закриття РНК клієнта', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 59, 'EDDR_ID', 'Номер запису в ЄДДР', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 60, 'IDCARD_VALID_DATE', 'Дійсний до (паспорт ID-картка)', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 61, 'IDDPL', 'Дата планової ідентифікації', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);


  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 62, 'BPLACE', 'Місце народження', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 63, 'SUBSD', 'Дата субсидії', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 64, 'SUBSN', 'Номер субсидії', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 65, 'ELT_N', 'ELT. Номер договору клієнт-банк', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 66, 'ELT_D', 'ELT. Дата договору клієнт-банк', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 67, 'GCIF', 'GCIF', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 68, 'NOMPDV', 'Номер в реєстрі НДС', 'VARCHAR2', 9, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 69, 'NOM_DOG', 'Номер договору на супровід', 'VARCHAR2', 10, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 70, 'SW_RN', 'Назва клієнта російською', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 71, 'Y_ELT', 'Автостягнення тарифу абонплати', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 72, 'ADM', 'Адмін. орган реєстрації', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 73, 'FADR', 'Адреса тимчасового перебування', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 74, 'ADR_ALT', 'Альтернативна адреса', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 75, 'BUSSS', 'Бізнес-сектор', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 76, 'PC_MF', 'БПК. Дівоче прізвище матері', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 77, 'PC_Z4', 'БПК. Загранпаспорт. Діє до', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 78, 'PC_Z3', 'БПК. Загранпаспорт. Ким виданий', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 79, 'PC_Z5', 'БПК. Загранпаспорт. Коли виданий', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 80, 'PC_Z2', 'БПК. Загранпаспорт. Номер', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 81, 'PC_Z1', 'БПК. Загранпаспорт. Серія', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 82, 'AGENT', 'БПК. Код ЄГРПОУ підприємства де працює', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 83, 'PC_SS', 'БПК. Сімейний стан', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 84, 'STMT', 'Від виписки', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 85, 'VIDKL', 'Від клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 86, 'VED', 'Вид економічної діяльності', 'CHAR', 5, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 87, 'TIPA', 'Вид незалежної проф діяльності', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 88, 'PHKLI', 'Види послуг, якими користується клієнт', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 89, 'AF1_9', 'Дані про реєстрацію як ФОП', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 90, 'IDDPD', 'Дата внесення в анкету останніх змін', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 91, 'DAIDI', 'Дата виконання та заходи поглиб. перевірки клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 92, 'DATVR', 'Дата відкриття першого рахунку', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 93, 'DATZ', ' Дата первинного заповнення анкети', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 94, 'DATE_PHOTO', 'Дата останньої фотографії', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 95, 'IDDPR', 'Дата проведеної ідентиф.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 96, 'ISE', 'Інституційний сектор економіки', 'CHAR', 5, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 97, 'OBSLU', 'Історія обслуговування клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 98, 'CRSRC', 'Джерело створення(DPT-деп.модуль, CCK-кред.мод.)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 99, 'DJOTH', 'Джерела. Інше', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 100, 'DJAVI', 'Джерела. Щомісячний дохід', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 101, 'DJ_TC', 'Джерела. Право на вимогу', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 102, 'DJOWF', 'Джерела. Власні кошти', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 103, 'DJCFI', 'Джерела. Срочні контракти та ін.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 104, 'DJ_LN', 'Джерела. Позика', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 105, 'DJ_FH', 'Джерела. Фінансова допомога', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 106, 'DJ_CP', 'Джерела. ЦП', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 107, 'CHORN', 'Чорнобильці', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 108, 'CRISK_KL', 'Клас позичальника', 'VARCHAR2', 1, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 109, 'BC', 'Клієнт банку', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 110, 'SPMRK', 'Код "особливі відмітки" нстнд.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 111, 'K013', 'Код виду клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 112, 'KODID', 'Код ідентифік. клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 113, 'COUNTRY', 'Код країни', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 114, 'MS_FS', 'Орг.-правова форма', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 115, 'MS_VD', 'Галузь виду діяльності', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 116, 'MS_GR', 'Належність до групи', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 117, 'LIM_KASS', 'Ліміт каси', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 118, 'LIM', 'Ліміт на активні операц.', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 119, 'LICO', 'Ліцензії на вик. певних опер.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 120, 'UADR', 'Місцезнаходж. юр. справи', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 121, 'MOB01', 'Мобільний 1', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 122, 'MOB02', 'Мобільний 2', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 123, 'MOB03', 'Мобільний 3', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 124, 'SUBS', 'Наявність субсидії', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 125, 'K050', 'Податковий код К050', 'CHAR', 3, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 126, 'DEATH', 'Смерть клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 127, 'NO_PHONE', 'Відсутність мобільного', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 128, 'NSMCV', 'Вид клієнта(кл/співр/деп/пенс)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 129, 'NSMCC', 'Код клієнта в карт. системі', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 130, 'NSMCT', 'Тип клієнта.А-власник карти, 2-торг.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 131, 'NOTES', 'Особливі примітки', 'VARCHAR2', 140, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 132, 'SAMZ', 'Самозайнятість', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 133, 'OREP', 'Репутація клієнта', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 134, 'OVIFS', 'Відповідність операцій відомій інф.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 135, 'AF6', 'Відповідн. операцій суті і напряму діяльн.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 136, 'FSKRK', 'Наяв.кред.заб.перед.інш.банками та ФО', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 137, 'FSOMD', 'Міс. совок. дохід сім''ї', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 138, 'FSVED', 'Зовнішньоєкономічна діяльність', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 139, 'FSZPD', 'Ведення підпр. діяльності(ФО)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 140, 'FSPOR', 'Прибуток за ост. фінанс. рік', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 141, 'FSRKZ', 'розм. поточн.кред.заборгов.по зобов.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 142, 'FSZOP', 'Збитки за останній фінрік', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 143, 'FSKPK', 'К-сть постійних контрагентів', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 144, 'FSKPR', 'К-сть штатних працівників', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 145, 'FSDIB', 'Наявність депозитів в інш. банках', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 146, 'FSCP', 'Власність - цінні папери', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 147, 'FSVLZ', 'Власність - земельна ділянка', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 148, 'FSVLA', 'Власність - авто', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 149, 'FSVLN', 'Власність - нерухомість', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 150, 'FSVLO', 'Власність - обладнання', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 151, 'FSSST', 'Соціальний статус(ФО)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 152, 'FSSOD', 'Сума основного доходу', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 153, 'FSVSN', 'Оцінка фін стану - підсумок', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 154, 'DOV_P', 'Паспортні дані довір. особи', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 155, 'DOV_A', 'Адреса довір. особи', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 156, 'DOV_F', 'Довірена особа', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 157, 'NMKV', 'Повне ім''я(міжн)', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 158, 'SN_GC', 'Повне ім''я(род. відм.)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 159, 'NMKK', 'Повне ім''я(скороч.)', 'VARCHAR2', 38, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 160, 'PRINSIDER', 'Наявність анкети інсайдера', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 161, 'NOTESEC', 'Примітки для СБ', 'VARCHAR2', 256, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 162, 'MB', 'Належність до малого бізнесу', 'CHAR', 1, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 163, 'PUBLP', 'Належність до публ. діячів', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 164, 'WORKB', 'Належність до співр. банку', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 165, 'C_REG', 'Районна ПІ', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 166, 'C_DST', 'Областна ПІ', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 167, 'RGADM', 'Рег. номер в адміністрації', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 168, 'RGTAX', 'Рег. номер ПІ', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 169, 'DATEA', 'Дата реєстр. в адмін.', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 170, 'DATET', 'Дата реєстр. в ПІ', 'DATE', 7, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 171, 'RNKP', 'Регістр. номер холдингу', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 172, 'CIGPO', 'Статус зайнятості', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 173, 'COUNTRY_NAME', 'Назва країни', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 174, 'TARIF', 'Страховий тариф(ФО)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 175, 'AINAB', 'Рахунки в інших банках', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 176, 'TGR', 'Тип державного реєстру', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 177, 'CUSTTYPE', 'Тип клієнта', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 178, 'RIZIK', 'Рівень ризику', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 179, 'SNSDR', 'Облікова серія, ном. свід. держ. реєстр.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 180, 'IDPIB', 'ПІБ співр., відпов. за ідент. та дослідж.', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 181, 'FS', 'Форма власності', 'CHAR', 2, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 182, 'SED', 'Форма господарювання(К051)', 'CHAR', 4, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 183, 'DJER', 'Характеристика джерел надх. доходу', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 184, 'CODCAGENT', 'Характеристика клієнта(К010)', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 185, 'SUTD', 'Характеристика суті діяльності', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 186, 'RVDBC', 'ЦРВ. DBCode', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 187, 'RVIBA', 'ЦРВ. Адреса відд. видачі картки', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 188, 'RVIDT', 'ЦРВ. Дата видачі картки', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 189, 'RV_XA', 'ЦРВ. Ім''я файла ХА', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 190, 'RVIBR', 'ЦРВ. Відділення видачі картки', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 191, 'RVIBB', 'ЦРВ. Відділення видачі картки(АБС)', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 192, 'RVRNK', 'ЦРВ. РНК в ЦРВ', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 193, 'RVPH1', 'ЦРВ. Телефон-1', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 194, 'RVPH2', 'ЦРВ. Телефон-2', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 195, 'RVPH3', 'ЦРВ. Телефон-3', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 196, 'SAB', 'Електронний код клієнта', 'VARCHAR2', 6, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 197, 'VIP_ACCOUNT_MANAGER', 'Аккаунт vip-менеджера в AD', 'VARCHAR2', 500, null, null, null, 'Y', null, null, null, null, null);
end;
/
commit;
/
