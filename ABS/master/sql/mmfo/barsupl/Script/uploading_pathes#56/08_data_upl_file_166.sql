-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������)
define sfile_id = 166
define ssql_id  = 166,1166,2166

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: &&sfile_id');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (&&sfile_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # &&ssql_id');
end;
/
-- ***************************************************************************

-- ***********************
-- ETL-19318 BR - ������ ����� �� � ��� �������, � �� �� ������
-- ETL-19904 UPL - ���������� ���������� ��������� � �������� ��������� �� ������ ������� � ����� � ��������� ������������ �� � ����
--- ������� ����� � customer
--- ��������� ������� ��� �� � ����
-- ***********************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);
--����
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (1166, 'select unique k.rnk, k.kf, k.id, k.emi
  from BARS.cp_kod k join bars.customer c on (k.rnk = c.rnk)
 where k.rnk is not null', 'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
 NULL, '������� ��������� ��� �� (����)', '1.3');

--��
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (2166,    'select unique k.rnk, bars.gl.kf kf, k.id, k.emi
  from BARS.cp_kod k join bars.customer c on (k.rnk = c.rnk)',
  'begin execute immediate ''begin barsupl.bars_upload_usr.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;',
  NULL, '������� ��������� ��� ��', '1.3');

/* -- ������ �������
Insert into BARSUPL.UPL_SQL (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values  (166, 'select 0 rnk, ''x'' kf, 0 id, 0 emi from dual where 1=0', NULL, NULL, '������� ��������� ��� ��', '1.1');
*/


-- ***********************
-- UPL_FILES
-- ***********************

-- ***********************
-- UPL_COLUMNS
-- ***********************

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (&&sfile_id);

declare
    mmfo number;
begin
    mmfo := barsupl.bars_upload_utl.is_mmfo;
    if  mmfo > 1 then
         -- ************* MMFO *************
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 166, 1166);
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 166, 1166);
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 166, 1166);
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 166, 1166);
    else
         -- ************* RU *************
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 166, 2166);
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 166, 2166);
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 166, 2166);
         Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 166, 2166);
    end if;
end;
/

