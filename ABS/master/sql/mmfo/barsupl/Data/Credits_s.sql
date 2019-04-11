prompt barsupl Файл выгрузки: CREDITS_S
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[
select
                           nd
                          ,rnk
                          ,kf
                          ,okpo
                          ,cc_id
                          ,sdate
                          ,wdate
                          ,wdate_fact
                          ,vidd
                          ,prod
                          ,prod_clas
                          ,pawn
                          ,sdog
                          ,term
                          ,kv
                          ,pog_plan
                          ,pog_fact
                          ,borg_sy
                          ,borgproc_sy
                          ,bpk_nls
                          ,intrate
                          ,ptn_name
                          ,ptn_okpo
                          ,ptn_mother_name
                          ,open_date_bal22
                          ,ES000
                          ,ES003
                          ,VIDD_CUSTTYPE
						  ,ob22
						  ,nms
						  ,nls
                   from bars_dm.credits_stat c
                   where c.per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
				   and kf = sys_context('bars_context', 'user_mfo')
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
        where sql_id = 52;
end;
/

prompt file
begin
    insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
    values (52, 52, 'CREDITS_S', 'Credits_S', 0, '35', null, '10', 0, 'Вигрузка статичних даних по кредитах для CRM', 1, null, 'WHOLE', null, 1, null, 1, null, 1, null);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 52;

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 1, 'nd', 'id договору', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 2, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null, 'TRUNC_E2');

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 3, 'kf', 'Регіональне управління', 'CHAR', 6, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 4, 'okpo', 'ІПН', 'CHAR', 14, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 5, 'cc_id', '№ договору', 'CHAR', 30, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 6, 'sdate', 'Дата укладання договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 7, 'wdate', 'Дата закінчення договору (очікувана)', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 8, 'wdate_fact', 'Дата закінчення договору (фактична)', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 9, 'vidd', 'Тип договору', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 10, 'prod', 'Вид кредитного продукту', 'CHAR', 10, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 11, 'prod_clas', 'Класифікація кредитного продукту', 'CHAR', 6, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 12, 'pawn', 'Вид застави/Поручительства', 'CHAR', 10, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 13, 'sdog', 'Сума кредиту (загальна сума договору)', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 14, 'term', 'Строк кредиту (в місяцях)', 'NUMBER', 4, 0, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 15, 'kv', 'Валюта кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 16, 'pog_plan', 'Планова сума погашення за минулий місяць', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 17, 'pog_fact', 'Фактична сума погашення за минулий місяць', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 18, 'borg_sy', 'Сума залишку заборгованості на початок року, грн', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 19, 'borgproc_sy', 'Сума залишку заборгованості за відсотками на початок року, грн.', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 20, 'bpk_nls', 'Номер карткового рахунку(2625)', 'CHAR', 15, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 21, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 22, 'ptn_name', 'найменування партнера', 'VARCHAR2', 255, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 23, 'ptn_okpo', 'код ЄДРПОУ партнера', 'VARCHAR2', 14, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 24, 'ptn_mother_name', 'найменування материнської компанії', 'VARCHAR2', 255, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 25, 'open_date_bal22', 'дата відкриття рахунку 2202/03 або 2232/33', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 26, 'es000', 'Статус КД в реєстрі', 'VARCHAR2', 24, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 27, 'es003', 'Дата отримання відшкодування', 'VARCHAR2', 24, null, null, null, 'Y', null, null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
	values (52, 28, 'vidd_custtype', 'Тип клиента по виду договора: 3 - физическое лицо, 2 - юридическое лицо, 1 - банк', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null, null);
	
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (52, 29, 'ob22', 'Аналитика счета', 'VARCHAR2', 2, null, null, null, 'Y', null, null, null, null, null);
    
    insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (52, 30, 'nms', 'Название счета', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
    values (52, 31, 'NLS', 'Номер рахунку', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null, null);

end;
/
commit;