prompt barsupl Файл выгрузки: BPK
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select
       b.branch
      ,b.kf
      ,b.rnk
      ,b.nd
      ,b.dat_begin
      ,b.BPK_TYPE
      ,b.nls
      ,b.daos
      ,b.kv
      ,b.intrate
      ,b.ostc
      ,b.date_lastop
      ,b.cred_line
      ,b.cred_lim
      ,b.use_cred_sum
      ,b.dazs
      ,b.blkd
      ,b.blkk
      ,b.bpk_status
      ,b.pk_okpo
      ,b.pk_name
      ,b.pk_okpo_n
  from bars_dm.bpk b
   where b.per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Платіжні картки, зміни]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (59, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.3'
        where sql_id = 59;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[
select
       b.branch
      ,b.kf
      ,b.rnk
      ,b.nd
      ,b.dat_begin
      ,b.BPK_TYPE
      ,b.nls
      ,b.daos
      ,b.kv
      ,b.intrate
      ,b.ostc
      ,b.date_lastop
      ,b.cred_line
      ,b.cred_lim
      ,b.use_cred_sum
      ,b.dazs
      ,b.blkd
      ,b.blkk
      ,b.bpk_status
      ,b.pk_okpo
      ,b.pk_name
      ,b.pk_okpo_n
  from bars_dm.bpk b
  where b.per_id=bars_dm.dm_import.get_period_id('MONTH',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Платіжні картки]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (60, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 60;
end;
/
prompt file
begin
	insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
	values (59, 59, 'BPK', 'Bpk', 0, '35', null, '10', 0, 'Вивантаження даних по платіжних картках', 1, null, 'WHOLE', null, 1, null, 1, null, 1, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 59;

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 1, 'branch', 'Відділення', 'CHAR', 30, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 2, 'kf', 'РУ', 'CHAR', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 3, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 4, 'nd', 'Номер договору', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 5, 'dat_begin', 'Дата договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 6, 'bpk_type', 'Тип платіжної карти', 'CHAR', 50, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 7, 'nls', 'номер рахунку', 'CHAR', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 8, 'daos', 'Дата відкриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 9, 'kv', 'Валюта рахунку', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 10, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 11, 'ostc', 'Поточний залишок на рахунку', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 12, 'date_lastop', 'Дата останньої операції', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 13, 'cred_line', 'Кредитна лінія', 'CHAR', 20, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 14, 'cred_lim', 'Сума встановленої кред.лінії', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 15, 'use_cred_sum', 'Використана сума кред.лінії', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 16, 'dazs', 'Дата закриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 17, 'blkd', 'Код блокування рахунку по дебету', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 18, 'blkk', 'Код блокування рахунку по кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 19, 'bpk_status', 'Статус договору по рахунку (1-відкритий, 0-закритий)', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 20, 'pk_okpo', 'Зарплатний проект, ЄДРПОУ організації', 'VARCHAR2', 10, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 21, 'pk_name', 'Зарплатний проект, Назва організації', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (59, 22, 'pk_okpo_n', 'Зарплатний проект, Код структурного підрозділу', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null);

end;
/
commit;