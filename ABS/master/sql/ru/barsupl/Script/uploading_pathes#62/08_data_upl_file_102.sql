-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 102
--define ssql_id  = 102,1102

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 102');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (102))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 102,1102');
end;
/

-- ***************************************************************************
-- ETL-23702  UPL - добавить в файл accounts значения поля NBS (балансовый счет) из исторической таблицы (HIST)
-- COBUMMFO-7805   SC-1011421 Для вивантаження у Корпоративне Сховище додати до вивантаження файлу accounts поле nbs із історичної таблиці рахунків
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (102,1102);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select /*+ parallel */
       u.acc,
       u.kf,
       u.nls,
       u.kv,
       u.branch,
       acc.nbs,
       u.daos,
       u.nms,
       u.lim,
       u.pap,
       u.tip,
       u.vid,
       u.dazs,
       u.accc,
       u.blkd,
       u.blkk,
       u.rnk,
       nvl(u.ob22, acc.ob22) ob22,
       u.mdate,
       nvl (s1.initiator, ''0'') initcode,
       u.effectdate,
       u.globalbd,
       u.nbs
  from bars.accounts acc,
       (select *
          from bars.accounts_update au1
         where idupd in (
                         select max(idupd) idupd
                           from bars.accounts_update au21, dt
                          where au21.idupd in (
                                                select max(idupd)
                                                  from bars.accounts_update au22, dt
                                                 where effectdate <= dt2
                                                 group by acc
                                                union all
                                                select max(idupd)  --по отдельным балансовым всегда текущее состояние только для ГРЦ
                                                  from bars.accounts_update au25, bars.accounts a, dt
                                                 where (a.nls like ''14%'' or a.nls like ''31%'' or a.nls like ''32%'' or a.nls like ''33%'' or a.nls like ''41%'' or a.nls like ''42%'' or a.nls like ''3541%'')
                                                   and au25.acc = a.acc
                                                   and au25.effectdate <= dt2
                                                 group by a.acc
                                                union all
                                                select max(idupd) --открытые задним числом и реанимированые
                                                  from bars.accounts_update au23, dt
                                                 where globalbd >= dt2
                                                   and daos <= dt2
                                                 group by acc, au23.globalbd
                                                having sum( case when chgaction in (1,4) then 1 else 0 end ) > 0
                                                    or (min(chgaction) = 0 and coalesce(max(dazs),to_date(''01/01/1900'',''dd/mm/yyyy'')) <= max(dt2))
                                               )
                          group by acc
                        )
       ) u,
       bars.specparam_cp_ob s1
 where acc.acc = u.acc
   and acc.acc = s1.acc(+)');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (102, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Счета банка', '7.9');

 end;
/

declare l_clob clob;
begin
  l_clob:= to_clob('with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select /*+ parallel */
       u.acc,
       u.kf,
       u.nls,
       u.kv,
       u.branch,
       acc.nbs,
       u.daos,
       u.nms,
       u.lim,
       u.pap,
       u.tip,
       u.vid,
       u.dazs,
       u.accc,
       u.blkd,
       u.blkk,
       u.rnk,
       u.ob22,
       u.mdate,
       nvl (s1.initiator, ''0'') initcode,
       u.effectdate,
       u.globalbd,
       u.nbs
  from bars.accounts acc,
       (select *
          from bars.accounts_update au1
         where idupd in (
                         select max(idupd) idupd
                           from bars.accounts_update au21, dt
                          where au21.idupd in (
                                                select max(idupd)
                                                  from bars.accounts_update au22, dt
                                                 where globalbd >= dt1
                                                   and effectdate <= dt2
                                                 group by acc
                                                union all
                                                select max(idupd)  --по отдельным балансовым всегда текущее состояние только для ГРЦ
                                                  from bars.accounts_update au25, bars.accounts a, dt
                                                 where (a.nls like ''14%'' or a.nls like ''31%'' or a.nls like ''32%'' or a.nls like ''33%'' or a.nls like ''41%'' or a.nls like ''42%'' or a.nls like ''3541%'')
                                                   and au25.acc = a.acc
                                                   and au25.effectdate <= dt2
                                                 group by a.acc
                                                union all
                                                select max(idupd) --открытые задним числом и реанимированые
                                                  from bars.accounts_update au23, dt
                                                 where globalbd >= dt1
                                                   and daos <= dt2
                                                 group by acc, au23.globalbd
                                                having sum( case when chgaction in (1,4) then 1 else 0 end ) > 0
                                                    or (min(chgaction) = 0 and coalesce(max(dazs),to_date(''01/01/1900'',''dd/mm/yyyy'')) <= max(dt2))
                                               )
                          group by acc
                        )
       ) u,
       bars.specparam_cp_ob s1
 where acc.acc = u.acc
   and acc.acc = s1.acc(+)');

 Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (1102, l_clob, 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, 'Счета банка', '7.9');

end;
/




-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (102);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (102);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 1, 'ACC', 'Внутренний номер счета', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 2, 'KF', 'Код филиала', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 3, 'NLS', 'Номер лицевого счета (внешний)', 'VARCHAR2', 14, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 4, 'KV', 'Код валюты', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 5, 'BRANCH', 'Код отделения', 'VARCHAR2', 22, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 6, 'NBS', 'Номер балансового счета', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 7, 'DAOS', 'Дата открытия счета', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'N', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 8, 'NMS', 'Наименование счета', 'VARCHAR2', 70, NULL, NULL, NULL, 'N', NULL, '09,13,10|32,32,32', 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 9, 'LIM', 'Лимит', 'NUMBER', 24, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 10, 'PAP', 'Признак актива/пассива', 'NUMBER', 1, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 11, 'TIP', 'Тип счета', 'CHAR', 3, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 12, 'VID', 'Код вида счета', 'NUMBER', 2, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 13, 'DAZS', 'Дата закрытия счета', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 14, 'ACCC', 'Внутренний номер счета', 'NUMBER', 22, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 15, 'BLKD', 'Код блокировки дебет', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 16, 'BLKK', 'Код блокировки кредит', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 17, 'RNK', 'Регистрационный номер клиента', 'NUMBER', 15, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 18, 'OB22', 'ОБ22', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 19, 'MDATE', 'Дата погашения задолжености', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 20, 'INITCODE', 'Код инициатора', 'CHAR', 2, NULL, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 21, 'EFFECTDATE', 'Локальна банківська дата внесення змін', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 22, 'GLOBALDATE', 'Глобальна банківська дата внесення змін', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values   (102, 23, 'NBS_HIST', 'Номер балансового счета из исторической таблицы', 'CHAR', 4, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);




-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (102);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'acc(BLKD)_$_lock_acc(RANG)', 2, 129);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'acc(BLKK)_$_lock_acc(RANG)', 2, 129);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(ACCC,KF)_$_account(ACC,KF)', 1, 102);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(BRANCH)_$_branch(BRANCH)', 1, 103);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(KF)_$_banks(MFO)', 2, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(KV)_$_tabval(KV)', 3, 296);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(NBS)_$_klr020(R020)', 2, 107);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(NBS,OB22)_$_ob22(R020,OB22)', 2, 322);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(PAP)_$_pap(PAP)', 3, 409);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(RNK,KF)_$_custmer(RNK,KF)', 1, 121);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(TIP)_$_tips(TIP)', 1, 418);
--new
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (102, 'account(NBSH)_$_klr020(R020)', 2, 107);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (102);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'acc(BLKD)_$_lock_acc(RANG)', 1, 'BLKD');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'acc(BLKK)_$_lock_acc(RANG)', 1, 'BLKK');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(ACCC,KF)_$_account(ACC,KF)', 1, 'ACCC');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(ACCC,KF)_$_account(ACC,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(BRANCH)_$_branch(BRANCH)', 1, 'BRANCH');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(KV)_$_tabval(KV)', 1, 'KV');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(NBS)_$_klr020(R020)', 1, 'NBS');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(NBS,OB22)_$_ob22(R020,OB22)', 1, 'NBS');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(NBS,OB22)_$_ob22(R020,OB22)', 2, 'OB22');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(PAP)_$_pap(PAP)', 1, 'PAP');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(RNK,KF)_$_custmer(RNK,KF)', 1, 'RNK');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(RNK,KF)_$_custmer(RNK,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(TIP)_$_tips(TIP)', 1, 'TIP');
--new
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (102, 'account(NBSH)_$_klr020(R020)', 1, 'NBS_HIST');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (102);

/*
begin
    if  barsupl.bars_upload_utl.is_mmfo > 1 then
         -- ************* MMFO *************
    else
         -- ************* RU *************
    end if;
end;
/
*/
