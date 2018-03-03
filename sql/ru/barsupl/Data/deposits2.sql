prompt barsupl Файл выгрузки: DEPOSITS2
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select branch,
                      kf,
                      rnk,
                      nd,
                      dat_begin,
                      dat_end,
                      nls,
                      vidd_name,
                      term,
                      sdog,
                      massa,
                      kv,
                      intrate,
                      sdog_begin,
                      last_add_date,
                      last_add_suma,
                      ostc,
                      suma_proc,
                      suma_proc_plan,
                      deposit_id,
                      dpt_status,
                      suma_proc_payoff,
                      date_proc_payoff,
                      date_dep_payoff,
                      datz,
                      dazs,
                      blkd,
                      blkk,
                      cnt_dubl,
                      archdoc_id,
                      ncash,
                      name_d,
                      okpo_d,
                      nls_d,
                      mfo_d,
                      name_p,
                      okpo_p,
                      nlsb,
                      mfob,
                      nlsp,
                      rosp_m,
                      mal,
                      ben,
                      vidd,
					  wb,
					  ob22,
					  nms
                      from bars_dm.deposit_plt
          where per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Депозити(пілот)]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (10053, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 10053;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[
select branch,
                      kf,
                      rnk,
                      nd,
                      dat_begin,
                      dat_end,
                      nls,
                      vidd_name,
                      term,
                      sdog,
                      massa,
                      kv,
                      intrate,
                      sdog_begin,
                      last_add_date,
                      last_add_suma,
                      ostc,
                      suma_proc,
                      suma_proc_plan,
                      deposit_id,
                      dpt_status,
                      suma_proc_payoff,
                      date_proc_payoff,
                      date_dep_payoff,
                      datz,
                      dazs,
                      blkd,
                      blkk,
                      cnt_dubl,
                      archdoc_id,
                      ncash,
                      name_d,
                      okpo_d,
                      nls_d,
                      mfo_d,
                      name_p,
                      okpo_p,
                      nlsb,
                      mfob,
                      nlsp,
                      rosp_m,
                      mal,
                      ben,
                      vidd,
					  wb,
					  ob22,
					  nms
                      from bars_dm.deposit_plt
          where per_id=bars_dm.dm_import.GET_PERIOD_ID('MONTH',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[CRM, Депозити(пілот) - MONTH]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (10055, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.2'
        where sql_id = 10055;
end;
/
prompt file
begin
	insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
	values (10052, 10053, 'DEPOSITS2', 'Deposits2', 0, '35', null, '13||10', 0, 'Вивантаження даних по депозитах2 для CRM', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 10052;

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 1, 'branch', 'Відділення', 'CHAR', 30, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 2, 'kf', 'РУ', 'CHAR', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 3, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 4, 'nd', '№ договору', 'VARCHAR2', 35, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 5, 'dat_begin', 'Договір від', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 6, 'dat_end', 'Дата закінчення договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 7, 'nls', 'Номер рахунку', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 8, 'vidd_name', 'Вид вкладу', 'VARCHAR2', 50, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 9, 'term', 'Строк вкладу', 'NUMBER', 4, 2, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 10, 'sdog', 'Сума вкладу', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 11, 'massa', 'Маса вкладу', 'NUMBER', 8, 2, '999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 12, 'kv', 'Валюта вкладу', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 13, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 14, 'sdog_begin', 'Початкова сума вкладу', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 15, 'last_add_date', 'Дата останього поповнення', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 16, 'last_add_suma', 'Сума останього поповнення', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 17, 'ostc', 'Поточний залишок', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 18, 'suma_proc', 'Поточна сума нарахованих проц.', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 19, 'suma_proc_plan', 'Сума відсотків на планову дату виплати', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 20, 'deposit_id', 'id депозиту', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 21, 'dpt_status', 'Статус деп.договору', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 22, 'suma_proc_payoff', 'Сума виплачених відсотків', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 23, 'date_proc_payoff', 'Дата виплати відсотків', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 24, 'date_dep_payoff', 'Дата виплати депозиту', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 25, 'datz', 'Дата заключення вкладу', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 26, 'dazs', 'Дата закриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 27, 'blkd', 'Код блокування рахунку по дебету', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 28, 'blkk', 'Код блокування рахунку по кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 29, 'cnt_dubl', 'кількість пролонгацій', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 30, 'archdoc_id', 'Ідентифікатор депозитного договору в ЕАД', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 31, 'ncash', 'Форма депозита (нал/безнал)', 'VARCHAR2', 128, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 32, 'name_d', 'Получатель депозита', 'VARCHAR2', 128, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 33, 'okpo_d', 'Код получателя депозита', 'VARCHAR2', 14, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 34, 'NLS_D', 'Номер счета получателя депозита', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 35, 'MFO_D', 'МФО счета получателя депозита', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 36, 'NAME_P', 'Получатель процентов', 'VARCHAR2', 128, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 37, 'OKPO_P', 'Код получателя  процентов', 'VARCHAR2', 14, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 38, 'NLSB', 'Номер счета получателя  процентов', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 39, 'MFOB', 'МФО счета получателя  процентов', 'VARCHAR2', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 40, 'NLSP', 'Номер счета процентов', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 41, 'ROSP_M', 'Вклад в пользу малолетнего лица', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 42, 'MAL', 'Вклад на имя малолетнего лица', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 43, 'BEN', 'Вклад на бенефициара', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 44, 'vidd', 'код вид вкладу', 'NUMBER', 5, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 45, 'WB', 'Открыт в онлайне', 'VARCHAR2', 1, null, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 46, 'ob22', 'Аналітика рахунку', 'CHAR', 2, null, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (10052, 47, 'nms', 'Назва рахунку', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null);

end;
/
commit;