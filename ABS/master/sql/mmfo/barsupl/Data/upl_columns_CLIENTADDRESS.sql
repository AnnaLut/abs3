prompt CLIENTADDRESS columns
declare
l_file_id number;
begin
  select file_id into l_file_id from upl_files where file_code = 'CLIENTADDRESS';
  --удаляем все записи
  delete from upl_columns where file_id = l_file_id;
  --населяем заново
  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 1, 'MFO', 'МФО', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 2, 'RNK', 'РНК', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 3, 'J_COUNTRY', 'Юр. адр. Країна', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 4, 'J_ZIP', 'Юр. адр. індекс', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 5, 'J_DOMAIN', 'Юр. адр. область', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 6, 'J_REGION', 'Юр. адр. район', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 7, 'J_LOCALITY', 'Юр. адр. нас. пункт', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 8, 'J_ADDRESS', 'Юр. адр. адреса', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 9, 'J_TERRITORY_ID', 'Юр. адр. код адреси', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 10, 'J_LOCALITY_TYPE', 'Юр. адр. тип нас. пункту', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 11, 'J_STREET_TYPE', 'Юр. адр. тип вулиці', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 12, 'J_STREET', 'Юр. адр. вулиця', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 13, 'J_HOME_TYPE', 'Юр. адр. тип будинку', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 14, 'J_HOME', 'Юр. адр. будинок', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 15, 'J_HOMEPART_TYPE', 'Юр. адр. тип частини буд.', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 16, 'J_HOMEPART', 'Юр. адр. частина будинку', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 17, 'J_ROOM_TYPE', 'Юр. адр. тип житл. приміщ.', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 18, 'J_ROOM', 'Юр. адр. житл. приміщення', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 19, 'J_KOATUU', 'Юр. адр. код КОАТУУ', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 20, 'J_REGION_ID', 'Юр. адр. Код регіону', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 21, 'J_AREA_ID', 'Юр. адр. Код району', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 22, 'J_SETTLEMENT_ID', 'Юр. адр. Код населеного пункту', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 23, 'J_STREET_ID', 'Юр. адр. Код вулиці', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 24, 'J_HOUSE_ID', 'Юр. адр. Код будинку', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 25, 'F_COUNTRY', 'Факт. адр. Країна', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 26, 'F_ZIP', 'Факт. адр. індекс', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 27, 'F_DOMAIN', 'Факт. адр. область', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 28, 'F_REGION', 'Факт. адр. район', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 29, 'F_LOCALITY', 'Факт. адр. нас. пункт', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 30, 'F_ADDRESS', 'Пошт. адр. адреса', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 31, 'F_TERRITORY_ID', 'Факт. адр. код адреси', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 32, 'F_LOCALITY_TYPE', 'Факт. адр. тип нас. пункту', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 33, 'F_STREET_TYPE', 'Факт. адр. тип вулиці', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 34, 'F_STREET', 'Факт. адр. вулиця', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 35, 'F_HOME_TYPE', 'Факт. адр. тип будинку', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 36, 'F_HOME', 'Факт. адр. будинок', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 37, 'F_HOMEPART_TYPE', 'Факт. адр. тип част. будинку', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 38, 'F_HOMEPART', 'Факт. адр. частина будинку', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 39, 'F_ROOM_TYPE', 'Факт. адр. тип житл. приміщ.', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 40, 'F_ROOM', 'Факт. адр. житл. приміщ.', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 41, 'F_KOATUU', 'Факт. адр. код КОАТУУ', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 42, 'F_REGION_ID', 'Факт. адр. Код регіону', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 43, 'F_AREA_ID', 'Факт. адр. Код району', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 44, 'F_SETTLEMENT_ID', 'Факт. адр. Код населеного пункту', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 45, 'F_STREET_ID', 'Факт. адр. Код вулиці', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 46, 'F_HOUSE_ID', 'Факт. адр. Код будинку', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 47, 'P_COUNTRY', 'Пошт. адр. Країна', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 48, 'P_ZIP', 'Пошт. адр. індекс', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 49, 'P_DOMAIN', 'Пошт. адр. область', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 50, 'P_REGION', 'Пошт. адр. район', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 51, 'P_LOCALITY', 'Пошт. адр. насел. пункт', 'VARCHAR2', 30, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 52, 'P_ADDRESS', 'Пошт. адр. адреса', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 53, 'P_TERRITORY_ID', 'Пошт. адр. код адреси', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 54, 'P_LOCALITY_TYPE', 'Пошт. адр. тип нас. пункту', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 55, 'P_STREET_TYPE', 'Пошт. адр. тип вулиці', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 56, 'P_STREET', 'Пошт. адр. вулиця', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 57, 'P_HOME_TYPE', 'Пошт. адр. тип будинку', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 58, 'P_HOME', 'Пошт. адр. будинок', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 59, 'P_HOMEPART_TYPE', 'Пошт. адр. тип частини будинку', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 60, 'P_HOMEPART', 'Пошт. адр. частина будинку', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 61, 'P_ROOM_TYPE', 'Пошт. адр. тип житл. приміщ.', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 62, 'P_ROOM', 'Пошт. адр. житл. приміщ.', 'VARCHAR2', 100, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 63, 'P_KOATUU', 'Пошт. адр. код КОАТУУ', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 64, 'P_REGION_ID', 'Пошт. адр. Код регіону', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 65, 'P_AREA_ID', 'Пошт. адр. Код району', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 66, 'P_SETTLEMENT_ID', 'Пошт. адр. Код населеного пункту', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 67, 'P_STREET_ID', 'Пошт. адр. Код вулиці', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);

  insert into upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
  values (l_file_id, 68, 'P_HOUSE_ID', 'Пошт. адр. Код будинку', 'NUMBER', 10, 0, null, null, 'Y', null, null, null, null, null);
end;
/
commit;
/
