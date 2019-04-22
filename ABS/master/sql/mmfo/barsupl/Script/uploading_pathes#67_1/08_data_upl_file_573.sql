-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 573
--define ssql_id  = 573,1573

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 573');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (573))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 573,1573');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- 04_REGISTER_v01
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************

delete from BARSUPL.UPL_SQL where SQL_ID IN (573,1573);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf
               from dual )
select l.nd_type,
       l.nd,
       l.kf,
       l.currency_id as kv,
       l.register_type_id,
       l.plan_value,
       l.actual_value
  from ( select o.type_id  as nd_type,
                r.object_id as nd,
                o.kf,
                r.register_type_id,
                r.plan_value,
                r.actual_value,
                r.currency_id,
                rank() over (partition by r.register_value_id order by r.id desc) rn
           from dt,
                barsupl.tmp_upl_dm_objects o
           join bars.register_value v on (v.object_id = o.object_id)
           join bars.register_log r on (r.register_value_id = v.id)
          where r.register_history_id is null
            and r.local_bank_date  <= dt.dt2
            --and r.global_bank_date >= dt.dt1
            and (dt.kf = o.kf or dt.kf is null)
            and o.type_id in (24, 25)
            ) l
 where l.rn = 1');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (573, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Регистры депозитов ММСБ', '1.0');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf
               from dual )
select l.nd_type,
       l.nd,
       l.kf,
       l.currency_id as kv,
       l.register_type_id,
       l.plan_value,
       l.actual_value
  from ( select o.type_id  as nd_type,
                r.object_id as nd,
                o.kf,
                r.register_type_id,
                r.plan_value,
                r.actual_value,
                r.currency_id,
                rank() over (partition by r.register_value_id order by r.id desc) rn
           from dt,
                barsupl.tmp_upl_dm_objects o
           join bars.register_value v on (v.object_id = o.object_id)
           join bars.register_log r on (r.register_value_id = v.id)
          where r.register_history_id is null
            and r.local_bank_date  <= dt.dt2
            and r.global_bank_date >= dt.dt1
            and (dt.kf = o.kf or dt.kf is null)
            and o.type_id in (24, 25)
            ) l
 where l.rn = 1');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (1573, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Регистры депозитов ММСБ', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************

delete from BARSUPL.UPL_FILES where FILE_ID IN (573);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (573, 573, 'SMB_REGISTER', 'smb_register', 0, '09', NULL, '10', 0, 'Регистры депозитов ММСБ', 573, 'null', 'DELTA', 'EVENT', 1, NULL, 1, 'SMB_REGISTER', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (573);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 2, 'ND', 'Ідентифікатор угоди', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 3, 'KF', 'Код філіалу', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 4, 'KV', 'Валюта угиди', 'NUMBER', 3, 0, NULL, NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 5, 'REGISTER_TYPE_ID', 'Код регістру', 'NUMBER', 22, 0, NULL, 'Y', 'N', NULL, NULL, '0', 4, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 6, 'PLAN_VALUE', 'Планове значення регістру', 'NUMBER', 38, 24, 'fm99999999999999999999999999999999999990D999999999999999999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (573, 7, 'ACTUAL_VALUE', 'Актуальне значення регістру', 'NUMBER', 38, 24, 'fm99999999999999999999999999999999999990D999999999999999999999999', NULL, 'Y', NULL, NULL, '0', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (573);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (573, 'smbregister(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (573, 'smbregister(KV)_$_tabval(KV)', 1, 296);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (573, 'smbregister(REGISTER_TYPE_ID)_$_registertype(ID)', 1, 577);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (573, 'smbregister(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 1, 571);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (573);
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (573, 'smbregister(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (573, 'smbregister(KV)_$_tabval(KV)', 1, 'KV');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (573, 'smbregister(REGISTER_TYPE_ID)_$_registertype(ID)', 1, 'REGISTER_TYPE_ID');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (573, 'smbregister(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (573, 'smbregister(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (573, 'smbregister(ND_TYPE,ND,KF)_$_smbdepo(ND_TYPE,ND,KF)', 3, 'KF');

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (573);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (1, 573,  573);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (2, 573, 1573);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (3, 573,  573);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (4, 573, 1573);
