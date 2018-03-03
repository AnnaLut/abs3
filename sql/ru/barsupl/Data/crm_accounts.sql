prompt barsupl Файл выгрузки: ACCOUNTS
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select
        a.branch
       ,a.kf
       ,a.rnk
       ,a.nls
       ,a.vidd
       ,a.daos
       ,a.kv
       ,a.intrate
       ,a.massa
       ,a.count_zl
       ,a.ostc
       ,a.ob_mon
       ,a.last_add_date
       ,a.last_add_suma
       ,a.dazs
       ,a.blkd
       ,a.blkk
       ,a.acc_status
	   ,a.ob22
	   ,a.nms
   from bars_dm.dm_accounts a
   where a.per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Поточні рахунки, зміни]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (57, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.3'
        where sql_id = 57;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[
select
       a.branch
      ,a.kf
      ,a.rnk
      ,a.nls
      ,a.vidd
      ,a.daos
      ,a.kv
      ,a.intrate
      ,a.massa
      ,a.count_zl
      ,a.ostc
      ,a.ob_mon
      ,a.last_add_date
      ,a.last_add_suma
      ,a.dazs
      ,a.blkd
      ,a.blkk
      ,a.acc_status
	  ,a.ob22
	  ,a.nms
  from bars_dm.dm_accounts a
  where a.per_id=bars_dm.dm_import.get_period_id('MONTH',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Поточні рахунки]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (58, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 58;
end;
/
prompt file
begin
	insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
	values (57, 57, 'ACCOUNTS', 'Accounts', 0, '35', null, '10', 0, 'Вигрузка поточних рахунків ФО для CRM', 1, null, 'WHOLE', null, 1, null, 1, null, 1, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 57;

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 1, 'branch', 'Відділення', 'CHAR', 30, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 2, 'kf', 'РУ', 'CHAR', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 3, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 4, 'nls', 'Номер рахунку', 'CHAR', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 5, 'vidd', 'Вид вкладу', 'CHAR', 10, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 6, 'daos', 'Дата відкриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 7, 'kv', 'Валюта', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 8, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 9, 'massa', 'Вага злитку', 'NUMBER', 6, 2, '9990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 10, 'count_zl', 'Кількість злитків', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 11, 'ostc', 'Поточний залишок', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 12, 'ob_mon', 'Обороти по рахунку за місяць', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 13, 'last_add_date', 'Дата останнього поповнення', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 14, 'last_add_suma', 'Сума останього поповнення', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 15, 'dazs', 'Дата закриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 16, 'blkd', 'Код блокування рахунку по дебету', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 17, 'blkk', 'Код блокування рахунку по кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 18, 'acc_status', 'Статус рахунку (1-відкритий, 0-закритий)', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 19, 'ob22', 'Аналітика рахунку', 'CHAR', 2, null, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (57, 20, 'nms', 'Назва рахунку', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null);
end;
/
commit;