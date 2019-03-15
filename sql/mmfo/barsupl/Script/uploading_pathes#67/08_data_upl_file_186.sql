-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 186
--define ssql_id  = 186,1186

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 186');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (186))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 186,1186');
end;
/
-- ***************************************************************************
-- TSK-0003337 UPL - здійснити вивантаження параметру K 140
--      добавляется новый тег 'K140'. Для остальных заполняется описание.
--      Необходимо создать новый файл выгрузки cusvalsr
--      Изменить структуру справочника klk140 (добавить поле REF_ID)
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (186,1186);

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (186, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2, bars.gl.kf as kf from dual ),
     tg as ( select /* materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) != 0 and isuse = 1)
select u1.rnk, u1.kf, u1.tag, u1.value, u1.chgaction, u1.ref_id
  from ( select /* index (u XAI_CUSTOMERWUPD_EFFDAT)*/
                u.rnk, dt.kf, u.tag, u.value, decode(u.chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction, tg.ref_id,
                max(u.idupd) over (partition by u.rnk, u.tag) mx, idupd
           from bars.customerw_update u,
                tg, dt
          where tg.tag = u.tag
            and u.kf = dt.kf
            and u.effectdate  <= dt.dt2
         ) u1
 where u1.mx = u1.idupd', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Значення додаткових реквізитів клієнта (з довідником)', '1.0');

Insert into BARSUPL.UPL_SQL(SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1186, 'with dt as ( select /*+ materialize */ bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1, to_date (:param1, ''dd/mm/yyyy'') dt2, bars.gl.kf as kf from dual ),
     tg as ( select /* materialize */ tag, ref_id from BARSUPL.UPL_TAG_LISTS where tag_table = ''CUST_FIELD'' and coalesce(ref_id, 0) != 0 and isuse = 1)
select u1.rnk, u1.kf, u1.tag, u1.value, u1.chgaction, u1.ref_id
  from ( select /* index (u XAI_CUSTOMERWUPD_EFFDAT)*/
                u.rnk, dt.kf, u.tag, u.value, decode(u.chgaction, 2, ''U'', 3, ''D'', ''I'') chgaction, tg.ref_id,
                max(u.idupd) over (partition by u.rnk, u.tag) mx, idupd
           from bars.customerw_update u,
                tg, dt
          where tg.tag = u.tag
            and u.kf = dt.kf
            and u.effectdate >= dt.dt1
            and u.effectdate <= dt.dt2
         ) u1
 where u1.mx = u1.idupd', 
'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
NULL, 'Значення додаткових реквізитів клієнта (з довідником)', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (186);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (186, 186, 'CUSVALSR', 'cusvalsr', 0, '09', NULL, '10', 0, 'Значения доп. реквизитов клиентов (со справочником)', 86, 'null', 'DELTA', 'IP', 1, NULL, 1, 'cusvalsr', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (186);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (186, 1, 'RNK', 'Код клиента', 'NUMBER', 15, 0, NULL, 'Y', 'N', NULL, NULL, '0', 1, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (186, 2, 'KF', 'Код филиала', 'CHAR', 6, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 2, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (186, 3, 'TAG', 'Код доп. реквизита', 'CHAR', 5, NULL, NULL, 'Y', 'N', NULL, NULL, '-', 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (186, 5, 'VALUE', 'Значение доп. реквизита', 'CHAR', 500, NULL, NULL, NULL, 'Y', NULL, '09,13,10|32,32,32', '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (186, 6, 'CHGACTION', 'Код обновления (I/U/D)', 'CHAR', 1, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (186, 7, 'REF_ID', 'ID справочника', 'NUMBER', 3, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (186);

Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (186, 'cusvalr(KF)_$_banks(KF)', 1, 402);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (186, 'cusvalr(RNK,KF)_$_customer(RNK,KF)', 1, 121);
Insert into UPL_CONSTRAINTS (file_id, constr_name, priority, fk_fileid) Values (186, 'cusvalr(REF_ID,VALUE)_$klk140(REF_ID,K140)', 1, 391);


-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (186);

Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (186, 'cusvalr(KF)_$_banks(KF)', 1, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (186, 'cusvalr(RNK,KF)_$_customer(RNK,KF)', 2, 'KF');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (186, 'cusvalr(RNK,KF)_$_customer(RNK,KF)', 1, 'RNK');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (186, 'cusvalr(REF_ID,VALUE)_$klk140(REF_ID,K140)', 1, 'REF_ID');
Insert into UPL_CONS_COLUMNS (file_id, constr_name, fk_colid, fk_colname) Values (186, 'cusvalr(REF_ID,VALUE)_$klk140(REF_ID,K140)', 2, 'VALUE');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (186);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (1,  186, 186);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (2,  186, 1186);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (3,  186, 186);
Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (4,  186, 1186);
