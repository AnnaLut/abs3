prompt barsupl Файл выгрузки: BPK2
prompt sql
prompt delta
declare
l_sql_text clob := to_clob(q'[

select  branch,
        kf,
        rnk,
        nd,
        dat_begin,
        bpk_type,
        nls,
        daos,
        kv,
        intrate,
        ostc,
        date_lastop,
        cred_line,
        cred_lim,
        use_cred_sum,
        dazs,
        blkd,
        blkk,
        bpk_status,
        pk_okpo,
        pk_name,
        pk_okpo_n,
        vid,
        lie_sum,
        lie_val,
        lie_date,
        lie_docn,
        lie_atrt,
        lie_doc,
        pk_term,
        pk_oldnd,
        pk_work,
        pk_cntrw,
        pk_ofax,
        pk_phone,
        pk_pcodw,
        pk_odat,
        pk_strtw,
        pk_cityw,
        pk_offic,
        dkbo_date_off,
        dkbo_start_date,
        dkbo_deal_number,
        kos,
        dos,
        w4_arsum,
        w4_kproc,
        w4_sec,
        acc,
		ob22,
		nms
        from bars_dm.bpk_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID('DAY',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[Платіжні картки 2 для CRM - зміни]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (4, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.3'
        where sql_id = 4;
end;
/
prompt full
declare
l_sql_text clob := to_clob(q'[

select  branch,
        kf,
        rnk,
        nd,
        dat_begin,
        bpk_type,
        nls,
        daos,
        kv,
        intrate,
        ostc,
        date_lastop,
        cred_line,
        cred_lim,
        use_cred_sum,
        dazs,
        blkd,
        blkk,
        bpk_status,
        pk_okpo,
        pk_name,
        pk_okpo_n,
        vid,
        lie_sum,
        lie_val,
        lie_date,
        lie_docn,
        lie_atrt,
        lie_doc,
        pk_term,
        pk_oldnd,
        pk_work,
        pk_cntrw,
        pk_ofax,
        pk_phone,
        pk_pcodw,
        pk_odat,
        pk_strtw,
        pk_cityw,
        pk_offic,
        dkbo_date_off,
        dkbo_start_date,
        dkbo_deal_number,
        kos,
        dos,
        w4_arsum,
        w4_kproc,
        w4_sec,
        acc
        from bars_dm.bpk_plt
        where per_id=bars_dm.dm_import.GET_PERIOD_ID('MONTH',nvl(to_date(:param1, 'dd/mm/yyyy'), trunc(sysdate)))
]');
l_descript varchar2(250) := q'[Платіжні картки 2 для CRM - MONTH]';
begin
    insert into upl_sql(sql_id, sql_text, descript, vers)
    values (5, l_sql_text, l_descript, '1.0');
exception
    when dup_val_on_index then
        update barsupl.upl_sql
        set sql_text = l_sql_text,
            descript = l_descript,
            vers = '1.1'
        where sql_id = 5;
end;
/
prompt file
begin
	insert into barsupl.upl_files (FILE_ID, SQL_ID, FILE_CODE, FILENAME_PRFX, EQVSPACE, DELIMM, DEC_DELIMM, ENDLINE, HEAD_LINE, DESCRIPT, ORDER_ID, NULLVAL, DATA_TYPE, DOMAIN_CODE, ISACTIVE, SEQ_CASHE, GK_INDICATOR, MASTER_CKGK, CRITICAL_FLG, PARTITIONED)
	values (4, 4, 'BPK2', 'Bpk2', 0, '35', null, '13||10', 0, 'Вивантаження даних по платіжним карткам(2)', 1, null, 'WHOLE', null, 1, null, 1, null, 0, 1);
exception
    when dup_val_on_index then
        null;
end;
/
prompt columns
begin
    delete from barsupl.upl_columns
    where file_id = 4;

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 1, 'branch', 'Відділення', 'CHAR', 30, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 2, 'kf', 'РУ', 'CHAR', 12, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 3, 'rnk', 'РНК', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 4, 'nd', 'Номер договору', 'NUMBER', 15, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 5, 'dat_begin', 'Дата договору', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 6, 'bpk_type', 'Тип платіжної карти', 'VARCHAR2', 50, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 7, 'nls', 'номер рахунку', 'VARCHAR2', 15, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 8, 'daos', 'Дата відкриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 9, 'kv', 'Валюта рахунку', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 10, 'intrate', 'Відсоткова ставка', 'NUMBER', 5, 2, '990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 11, 'ostc', 'Поточний залишок на рахунку', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 12, 'date_lastop', 'Дата останньої операції', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 13, 'cred_line', 'Кредитна лінія', 'VARCHAR2', 20, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 14, 'cred_lim', 'Сума встановленої кред.лінії', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 15, 'use_cred_sum', 'Використана сума кред.лінії', 'NUMBER', 15, 2, '9999999999990D00', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 16, 'dazs', 'Дата закриття рахунку', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 17, 'blkd', 'Код блокування рахунку по дебету', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 18, 'blkk', 'Код блокування рахунку по кредиту', 'NUMBER', 3, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 19, 'bpk_status', 'Статус договору по рахунку (1-відкритий, 0-закритий)', 'NUMBER', 1, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 20, 'pk_okpo', 'Зарплатний проект, ЄДРПОУ організації', 'VARCHAR2', 10, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 21, 'pk_name', 'Зарплатний проект, Назва організації', 'VARCHAR2', 100, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 22, 'pk_okpo_n', 'Зарплатний проект, Код структурного підрозділу', 'NUMBER', 22, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 23, 'VID', 'Вид рахунку (ДФС)', 'VARCHAR2', 35, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 24, 'LIE_SUM', 'Арешт рахунку. Сума обтяження', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 25, 'LIE_VAL', 'Арешт рахунку. Валюта обтяження', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 26, 'LIE_DATE', 'Арешт рахунку. Дата документа', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 27, 'LIE_DOCN', 'Арешт рахунку. Номер документа', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 28, 'LIE_ATRT', 'Арешт рахунку. Орган, який видав документ', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 29, 'LIE_DOC', 'Арешт рахунку. Назва документу', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 30, 'PK_TERM', 'БПК. Кількість місяців дії картки', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 31, 'PK_OLDND', 'БПК. Номер договору по ЗП', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 32, 'PK_WORK', 'БПК. Місце роботи', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 33, 'PK_CNTRW', 'БПК. Місце роботи: країна', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 34, 'PK_OFAX', 'БПК. Місце роботи: FAX', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 35, 'PK_PHONE', 'БПК. Місце роботи: телефон', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 36, 'PK_PCODW', 'БПК. Місце роботи: поштовий індекс', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 37, 'PK_ODAT', 'БПК. Місце роботи: з якого часу працює', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 38, 'PK_STRTW', 'БПК. Місце роботи: вулиця', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 39, 'PK_CITYW', 'БПК. Місце роботи: місто', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 40, 'PK_OFFIC', 'БПК. Посада', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 41, 'DKBO_DATE_OFF', 'Дата розірвання ДКБО', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 42, 'DKBO_START_DATE', 'Дата приєднання до ДКБО', 'DATE', 10, null, 'dd/mm/yyyy', null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 43, 'DKBO_DEAL_NUMBER', '№ договору ДКБО', 'VARCHAR2', 30, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 44, 'KOS', 'Обороти Кредит', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 45, 'DOS', 'Обороти Дебет', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 46, 'W4_ARSUM', 'Way4. Арештована сума', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 47, 'W4_KPROC', 'Way4. Відсоток по кредиту', 'VARCHAR2', 254, null, null, null, 'Y', null, null, null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 48, 'W4_SEC', 'Way4. Тайне слово', 'VARCHAR2', 254, null, null, null, 'Y', null, '35,09,13,10|32,32,32,32', null, null);

	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 49, 'ACC', 'Унікальний ідентифікатор рахунку', 'NUMBER', 24, 0, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 50, 'ob22', 'Аналітика рахунку', 'CHAR', 2, null, null, null, 'Y', null, null, null, null);
	
	insert into barsupl.upl_columns (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID)
	values (4, 51, 'nms', 'Назва рахунку', 'VARCHAR2', 70, null, null, null, 'Y', null, null, null, null);	

end;
/
commit;