-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 241
--define ssql_id  = 241,1241

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 241');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (241))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 241,1241');
end;
/
-- ***************************************************************************
-- TSK-0001143 UPL - изменить выгрузку BARS.W4_ACC_update: 
-- Добавить поля: PASS_DATE  (DATE)  -    Дата передачі справи
-- PASS_STATE  (NUMBER (10)) -    Стан передачі справ до Бек-офісу  
-- (1-передано, 2-перевірено, 3-повернуто на доопрацювання (Null - не передавалось))
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (241,1241);

--------------------------- NEW VERSION -------------------------------------------------------
Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (241, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select 4 type, b.nd, bars.gl.kf,
       s.demand_kk project_id, 0 product_id, a.kv, a.rnk,
       a.branch,
       a.daos as DATE_BEGIN,
       add_months(a.daos, 12) as DATE_END,
       a.dazs as DATE_CLOSE,
       b.fin23, b.obs23, b.kat23, b.k23, a.tip, null as pass_date, null as pass_state
  from bars.bpk_acc_update b,
       bars.specparam_int  s,
       bars.accounts       a
 where b.acc_pk = s.acc(+)
   and a.acc    = b.acc_pk
   and b.idupd  = ( select max (u.idupd)
                      from bars.bpk_acc_update u, dt
                     where u.nd = b.nd
                       and u.effectdate <= dt.dt2)
 union all
select 4 type, b.nd, bars.gl.kf, p.grp_code project_id, 0 product_id, a.kv, a.rnk,
       a.branch,
       b.dat_begin as DATE_BEGIN,
       b.dat_end   as DATE_END,
       b.dat_close as DATE_CLOSE,
       b.fin23, b.obs23, b.kat23, b.k23, p.sub_code, b.pass_date, b.pass_state
  from bars.w4_acc_update b,
       bars.accounts a,
       bars.accountsw w,
       (select c0.code,  p0.grp_code,  c0.sub_code
          from bars.w4_card c0,
               bars.w4_product p0
         where c0.product_code = p0.code) p
 where b.card_code = p.code(+)
   and b.acc_pk = a.acc
   and b.acc_pk = w.acc(+)
   and w.tag(+) = ''PK_TERM''
   and b.idupd  = ( select max (u.idupd)
                      from bars.w4_acc_update u, dt
                     where u.nd = b.nd
                       and u.effectdate <= dt.dt2)', 
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
 NULL, 'Карточные договора (full)', '5.9');

Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1241, 'with dt as ( select bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2 from dual )
select 4 type, b.nd, bars.gl.kf,
       s.demand_kk project_id, 0 product_id, a.kv, a.rnk,
       a.branch,
       a.daos as DATE_BEGIN,
       add_months(a.daos, 12) as DATE_END,
       a.dazs as DATE_CLOSE,
       b.fin23, b.obs23, b.kat23, b.k23, a.tip, null as pass_date, null as pass_state
  from bars.bpk_acc_update b,
       bars.specparam_int  s,
       bars.accounts       a
 where b.acc_pk = s.acc(+)
   and a.acc    = b.acc_pk
   and b.idupd  = ( select max (u.idupd)
                      from bars.bpk_acc_update u, dt
                     where u.nd = b.nd
                       and u.effectdate <= dt.dt2
                       and u.global_bdate >= dt.dt1)
 union all
select 4 type, b.nd, bars.gl.kf, p.grp_code project_id, 0 product_id, a.kv, a.rnk,
       a.branch,
       b.dat_begin as DATE_BEGIN,
       b.dat_end   as DATE_END,
       b.dat_close as DATE_CLOSE,
       b.fin23, b.obs23, b.kat23, b.k23, p.sub_code, b.pass_date, b.pass_state
  from bars.w4_acc_update b,
       bars.accounts a,
       bars.accountsw w,
       (select c0.code,  p0.grp_code,  c0.sub_code
          from bars.w4_card c0,
               bars.w4_product p0
         where c0.product_code = p0.code) p
 where b.card_code = p.code(+)
   and b.acc_pk = a.acc
   and b.acc_pk = w.acc(+)
   and w.tag(+) = ''PK_TERM''
   and b.idupd  = ( select max (u.idupd)
                      from bars.w4_acc_update u, dt
                     where u.nd = b.nd
                       and u.effectdate <= dt.dt2
                       and u.global_bdate >= dt.dt1)', 
 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
 NULL, 'Карточные договора (part)', '5.8');

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (241);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (241);

Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 0, 'TYPE', 'Вид угоди', 'NUMBER', 2, 0, NULL, 'Y', 'N', NULL, NULL, '0', 0, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 1, 'ND', 'Внутрішній код угоди за карткою', 'NUMBER', 10, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 2, 'KF', 'Код філіалу', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 3, 'PROJECT_ID', 'Код карткового проекту', 'VARCHAR2', 32, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 4, 'PRODUCT_ID', 'Код карткового продукту', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 5, 'KV', 'Код валюти', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 6, 'RNK', 'Реєстраційний номер клієнта', 'NUMBER', 15, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, 'TRUNC_E2');
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 7, 'BRANCH', 'Код відділення', 'VARCHAR2', 22, NULL, NULL, NULL, 'Y', NULL, NULL, 'N/A', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 8, 'DAOS', 'DATE_BEGIN - Дата початку дії угоди', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '01.01.0001', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 9, 'DAZS', 'DATE_END - Дата закінчення дії угоди', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 10, 'DATE_CLOSE', 'Дата закриття угоди', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 11, 'FIN23', 'Фінансовий стан згідно постанови №23', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 12, 'OBS23', 'Обслуговування боргу 23', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 13, 'KAT23', 'Категорія якості 23', 'NUMBER', 5, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 14, 'K23', 'Коефіцієнт ризику 23', 'NUMBER', 22, 10, '999999999990D0000000000', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 15, 'CARDTYPE', 'Вид карткового субпродукту', 'CHAR', 32, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 16, 'PASS_DATE', 'Дата передачі справи', 'DATE', 8, NULL, 'ddmmyyyy', NULL, 'Y', NULL, NULL, '31.12.9999', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (FILE_ID, COL_ID, COL_NAME, COL_DESC, COL_TYPE, COL_LENGTH, COL_SCALE, COL_FORMAT, PK_CONSTR, NULLABLE, NULL_VALUES, REPL_CHARS_WITH, SKELETON_VALUES, PK_CONSTR_ID, PREFUN)
 Values (241, 17, 'PASS_STATE', 'Стан передачі справ до Бек-офісу', 'NUMBER', 10, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (241);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (241);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (241);

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
