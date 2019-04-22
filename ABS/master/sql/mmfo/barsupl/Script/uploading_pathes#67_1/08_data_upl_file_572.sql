-- ***************************************************************************
set verify off
--set define on
-- sfile_id идентификатор файла выгрузки
-- ssql_id идентификаторы запросов для файла выгрузки (список через запятую, без пробелов)
--define sfile_id = 572
--define ssql_id  = 572,1572

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 572');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (572))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 572,1572');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - анализ выгрузки депозитных линий ММСБ
-- TSK-0003096 UPL - зробити вивантаження договорів депозитиних ліній (траншів), поточних рахунків та їх параметрів із нового модуля депозитів ММСБ
-- 03_SMD_PROLONGATION_v02
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************

delete from BARSUPL.UPL_SQL where SQL_ID IN (572,1572);

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf
                  --bars.process_utl.get_proc_type_id(''TRANCHE_PROLONGATION'', ''SMBD'') as prolong_proc_type_id
              from dual )
select o.type_id as nd_type,
       o.object_id as nd,
       o.kf,
       translate(s.process_data, chr(9)||chr(10)||chr(13), ''   '') as process_data
  from dt,
       barsupl.tmp_upl_dm_objects o
--join bars.process p on (p.object_id = o.object_id)
--left join bars.smb_deposit_log s on (s.object_id = o.object_id and s.process_id = p.id )
  left join bars.smb_deposit_log s on (s.object_id = o.object_id )
--join bars.smb_deposit tt on (tt.id = o.object_id)
 where (s.local_bank_date  <= dt.dt2)
 --and (s.global_bank_date >= dt.dt1) --FOR DELTA
   and (dt.kf= o.kf or dt.kf is null)
   and lower(s.process_data) like ''%smbdepositprolongation%'' -- можно так
   and o.type_id in (24, 25)
 --and p.process_type_id = dt.prolong_proc_type_id -- или так');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (572, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Пролонгации депозитов ММСБ', '1.0');

end;
/

declare l_clob clob;
begin
l_clob:= to_clob('with dt as ( select /*+ materialize */
                    bars_upload_usr.get_last_work_date(to_date (:param1, ''dd/mm/yyyy'')) + 1 dt1,
                    to_date (:param1, ''dd/mm/yyyy'') dt2,
                    bars.gl.kf
                  --bars.process_utl.get_proc_type_id(''TRANCHE_PROLONGATION'', ''SMBD'') as prolong_proc_type_id
              from dual )
select o.type_id as nd_type,
       o.object_id as nd,
       o.kf,
       translate(s.process_data, chr(9)||chr(10)||chr(13), ''   '') as process_data
  from dt,
       barsupl.tmp_upl_dm_objects o
--join bars.process p on (p.object_id = o.object_id)
--left join bars.smb_deposit_log s on (s.object_id = o.object_id and s.process_id = p.id )
  left join bars.smb_deposit_log s on (s.object_id = o.object_id )
--join bars.smb_deposit tt on (tt.id = o.object_id)
 where (s.local_bank_date  <= dt.dt2)
   and (s.global_bank_date >= dt.dt1) --FOR DELTA
   and (dt.kf= o.kf or dt.kf is null)
   and lower(s.process_data) like ''%smbdepositprolongation%'' -- можно так
   and o.type_id in (24, 25)
 --and p.process_type_id = dt.prolong_proc_type_id -- или так');

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values (1572, l_clob, 'begin
     begin
       execute immediate ''begin barsupl.bars_upload_usr.tuda; end;'';
     exception
       when others then if sqlcode = -6550 then null; else raise; end if;
     end;
     -- заполнение витрины
     barsupl.fill_upl_dm_objects(p_bank_date => to_date(:param1,''dd/mm/yyyy''), p_clear_data => ''N'');
end;', NULL, 'Пролонгации депозитов ММСБ', '1.0');

end;
/

-- ***********************
-- UPL_FILES
-- ***********************

delete from BARSUPL.UPL_FILES where FILE_ID IN (572);

Insert into UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id, nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (572, 572, 'SMB_LONGATION', 'smb_longation', 0, '09', NULL, '10', 0, 'Пролонгации депозитов ММСБ', 572, 'null', 'DELTA', 'ARR', 1, NULL, 1, 'AR', 1, 1);

-- ***********************
-- UPL_COLUMNS
-- ***********************
delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (572);

Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (572, 1, 'ND_TYPE', 'Вид угоди', 'NUMBER', 5, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 1, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (572, 2, 'ND', 'Ідентифікатор угоди', 'NUMBER', 38, 0, NULL, 'Y', 'N', NULL, NULL, NULL, 2, 'TRUNC_E2');
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (572, 3, 'KF', 'Код філіалу', 'VARCHAR2', 6, NULL, NULL, 'Y', 'N', NULL, NULL, NULL, 3, NULL);
Insert into UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (572, 14, 'PROCESS_DATA', 'XML', 'VARCHAR2', 4000, NULL, NULL, NULL, 'Y', NULL, NULL, '-', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (572);

Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (572, 'smblongation(KF)_$_banks(MFO)', 1, 402);
Insert into UPL_CONSTRAINTS   (file_id, constr_name, priority, fk_fileid) Values   (572, 'smblongation(ND_TYPE,ND,KF)_$_banks(ND_TYPE,ND,KF)', 1, 571);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (572);

Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (572, 'smblongation(KF)_$_banks(MFO)', 1, 'KF');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (572, 'smblongation(ND_TYPE,ND,KF)_$_banks(ND_TYPE,ND,KF)', 1, 'ND_TYPE');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (572, 'smblongation(ND_TYPE,ND,KF)_$_banks(ND_TYPE,ND,KF)', 2, 'ND');
Insert into UPL_CONS_COLUMNS   (file_id, constr_name, fk_colid, fk_colname) Values   (572, 'smblongation(ND_TYPE,ND,KF)_$_banks(ND_TYPE,ND,KF)', 3, 'KF');


-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (572);

Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (1, 572,  572);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (2, 572, 1572);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (3, 572,  572);
Insert into BARSUPL.UPL_FILEGROUPS_RLN(GROUP_ID, FILE_ID, SQL_ID) Values (4, 572, 1572);


