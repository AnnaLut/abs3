-- ***************************************************************************
set verify off
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������)
define sfile_id = 230
define ssql_id  = 230

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
-- ETL-20519 UPL - ���������� �������� ����� SKRYTIP ������ �� ������� ������ ������� �� � ����
-- SKRYNKA_TIP
-- �������� �������� �� KF
-- ***********************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (&&ssql_id);

Insert into BARSUPL.UPL_SQL   (SQL_ID, SQL_TEXT, BEFORE_PROC, AFTER_PROC, DESCRIPT, VERS)
 Values
   (230, 'with kf as (select /*+ materialize */
                   coalesce( bars_upload.get_param(''KF''),
                            (select kf from barsupl.upl_regions where CODE_CHR = bars_upload.get_param(''REGION_PRFX''))
                           ) kf
              from dual)
select o_sk, name, s*100 s, branch, s.kf, etalon_id, cell_count
  from bars.skrynka_tip  s,kf
  where kf.kf = s.kf', 'begin execute immediate ''begin barsupl.bars_upload_usr.suda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', 
  'begin barsupl.bars_upload_usr.tuda(null); end;', '���� ���������� ������', '1.2');

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



