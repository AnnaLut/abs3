-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 578
--define ssql_id  = 578

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 578');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (578))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 578');
end;
/
-- ***************************************************************************
-- TSK-0001183 ANL - ������ �������� ���������� ����� ����
-- TSK-0003096 UPL - ������� ������������ �������� ����������� ��� (�������), �������� ������� �� �� ��������� �� ������ ������ �������� ����
-- ����� ������� ���� ���������
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (578);

Insert into BARSUPL.UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (578, 'select id, attribute_code, attribute_name from bars.attribute_kind',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, '������� ���� ���������', '1.0');

-- ***********************
-- UPL_FILES
-- ***********************
delete from BARSUPL.UPL_FILES where FILE_ID IN (578);

Insert into BARSUPL.UPL_FILES
   (file_id, sql_id, file_code, filename_prfx, eqvspace, delimm, dec_delimm, endline, head_line, descript, order_id,
    nullval, data_type, domain_code, isactive, seq_cashe, gk_indicator, master_ckgk, critical_flg, partitioned)
 Values
   (578, 578, 'ATTRIBUTE_TYPE', 'attributetype', 0, '09', NULL, '10', 0, '������� ���� ���������', 578, 'null', 'WHOLE', 'EVENT', 1, NULL, 1, 'attributetype', 1, 0);

-- ***********************
-- UPL_COLUMNS
-- ***********************

delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (578);

Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (578, 1, 'ID', '���������� ����', 'NUMBER', 38, 0, NULL, NULL, 'N', NULL, NULL, '0', NULL, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (578, 2, 'ATTRIBUTE_CODE', '��� ��������', 'VARCHAR2', 100, NULL, NULL, 'Y', 'N', NULL, NULL, 'N/A', 1, NULL);
Insert into BARSUPL.UPL_COLUMNS (file_id, col_id, col_name, col_desc, col_type, col_length, col_scale, col_format, pk_constr, nullable, null_values, repl_chars_with, skeleton_values, pk_constr_id, prefun)
 Values (578, 3, 'ATTRIBUTE_NAME', '������������ ��������', 'VARCHAR2', 300, NULL, NULL, NULL, 'N', NULL, NULL, 'N/A', NULL, NULL);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (578);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (578);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************

delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (578);

Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id) Values (5, 578, 578);
