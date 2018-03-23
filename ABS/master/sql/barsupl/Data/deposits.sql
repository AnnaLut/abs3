prompt barsupl Файл выгрузки: DEPOSITS
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select d.branch
                ,d.kf
                ,d.rnk
                ,d.nd
                ,d.dat_begin
                ,d.dat_end
                ,d.nls
                ,d.vidd
                ,d.term
                ,d.sdog
                ,d.massa
                ,d.kv
                ,d.intrate
                ,d.sdog_begin
                ,d.last_add_date
                ,d.last_add_suma
                ,d.ostc
                ,d.suma_proc
                ,d.suma_proc_plan
                ,d.deposit_id
                ,d.dpt_status
                ,d.suma_proc_payoff
                ,d.date_proc_payoff
                ,d.date_dep_payoff
                ,d.datz
                ,d.dazs
                ,d.blkd
                ,d.blkk
                ,d.cnt_dubl
                ,d.archdoc_id
                ,d.wb
				,d.ob22
				,d.nms
          from bars_dm.deposits d
          where d.per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Депозити, зміни]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (55, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 55;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[
select d.branch
                ,d.kf
                ,d.rnk
                ,d.nd
                ,d.dat_begin
                ,d.dat_end
                ,d.nls
                ,d.vidd
                ,d.term
                ,d.sdog
                ,d.massa
                ,d.kv
                ,d.intrate
                ,d.sdog_begin
                ,d.last_add_date
                ,d.last_add_suma
                ,d.ostc
                ,d.suma_proc
                ,d.suma_proc_plan
                ,d.deposit_id
                ,d.dpt_status
                ,d.suma_proc_payoff
                ,d.date_proc_payoff
                ,d.date_dep_payoff
                ,d.datz
                ,d.dazs
                ,d.blkd
                ,d.blkk
                ,d.cnt_dubl
                ,d.archdoc_id
                ,d.wb
				,d.ob22
				,d.nms
          from bars_dm.deposits d
          where d.per_id=bars_dm.dm_import.GET_PERIOD_ID('MONTH',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Депозити]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (56, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.1'
        where sql_id = 56;
end;
/
prompt file
begin
	insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
	values (55, 55, 'DEPOSITS', 'Deposits', 0, '35', null, '10', 0, 'Вигрузка даних по депозитах для CRM', 1, null, 'WHOLE', null, 1, null, 1, null, 1, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 55;

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 1, 'branch', 'Відділення', 'CHAR', 30, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 2, 'kf', 'РУ', 'CHAR', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 3, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 4, 'nd', '№ договору', 'CHAR', 35, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 5, 'dat_begin', 'Договір від', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 6, 'dat_end', 'Дата закінчення договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 7, 'nls', 'Номер рахунку', 'CHAR', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 8, 'vidd', 'Вид вкладу', 'NUMBER', 5, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 9, 'term', 'Строк вкладу', 'NUMBER', 4, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 10, 'sdog', 'Сума вкладу', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 11, 'massa', 'Маса вкладу', 'NUMBER', 8, 2, '999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 12, 'kv', 'Валюта вкладу', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 13, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 14, 'sdog_begin', 'Початкова сума вкладу', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 15, 'last_add_date', 'Дата останього поповнення', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 16, 'last_add_suma', 'Сума останього поповнення', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 17, 'ostc', 'Поточний залишок', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 18, 'suma_proc', 'Поточна сума нарахованих проц.', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 19, 'suma_proc_plan', 'Сума відсотків на планову дату виплати', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 20, 'deposit_id', 'id депозиту', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 21, 'dpt_status', 'Статус деп.договору', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 22, 'suma_proc_payoff', 'Сума виплачених відсотків', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 23, 'date_proc_payoff', 'Дата виплати відсотків', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 24, 'date_dep_payoff', 'Дата виплати депозиту', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 25, 'datz', 'Дата заключення вкладу', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 26, 'dazs', 'Дата закриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 27, 'blkd', 'Код блокування рахунку по дебету', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 28, 'blkk', 'Код блокування рахунку по кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 29, 'cnt_dubl', 'кількість пролонгацій', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 30, 'archdoc_id', 'Ідентифікатор депозитного договору в ЕАД', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 31, 'wb', 'Признак онлайн-депозиту', 'CHAR', 1, null, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 32, 'ob22', 'Аналітика рахунку', 'CHAR', 2, null, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (55, 33, 'nms', 'Назва рахунку', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null);

end;
/
commit;