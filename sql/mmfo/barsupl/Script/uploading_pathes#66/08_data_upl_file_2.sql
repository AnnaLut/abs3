-- ***************************************************************************
set verify off
--set define on
-- sfile_id ������������� ����� ��������
-- ssql_id �������������� �������� ��� ����� �������� (������ ����� �������, ��� ��������)
--define sfile_id = 2
--define ssql_id  = 2

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload file: 2');
   for i in (select file_id, file_code, filename_prfx, descript from BARSUPL.UPL_FILES where file_id in (2))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript);
   end loop;
   dbms_output.put_line(':   SQL # 2');
end;
/
-- ***************************************************************************
-- TSK-0001202 � ����� UPLSTAT  (�������� �� 11 �������)  ������ ������ � ������ ����� PARAMS
-- 
-- ***************************************************************************

-- ***********************
-- UPL_SQL
-- ***********************
delete from BARSUPL.UPL_SQL where SQL_ID IN (2);

Insert into UPL_SQL (sql_id, sql_text, before_proc, after_proc, descript, vers)
 Values
   (2, 'select   distinct v.id,
         bars.gl.kf kf,
         v.group_id,
         v.file_id,
         v.sql_id,
         v.file_code,
         v.start_time,
         v.stop_time,
         v.upl_time_min,
         v.status_code,
         v.rows_uploaded,
         v.params,
         v.upl_errors,
         v.START_ARC_TIME,
         v.STOP_ARC_TIME,
         v.ARC_TIME_MIN,
         v.ARC_LOGMESS,
         v.START_FTP_TIME,
         v.STOP_FTP_TIME,
         v.FTP_TIME_MIN,
         v.FTP_LOGMESS,
         ''relese: ''||p.value||'' packvrs: ''||v.vers as vers
  from v_upl_stats v, upl_params p
 where v.upl_bankdate = to_date (:param1, ''dd/mm/yyyy'')
   and p.param = ''RELEASE''
   and v.params is not null',
   'begin execute immediate ''begin bars.tuda; end;''; exception when others then if sqlcode = -6550 then null; else raise; end if; end;', NULL, '����������', '4.5');

--declare l_clob clob;
--begin
--l_clob:= to_clob();
--end;
--/

-- ***********************
-- UPL_FILES
-- ***********************
--delete from BARSUPL.UPL_FILES where FILE_ID IN (2);

-- ***********************
-- UPL_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_COLUMNS where FILE_ID IN (2);

-- ***********************
-- UPL_CONSTRAINTS
-- ***********************
--delete from BARSUPL.UPL_CONSTRAINTS where FILE_ID IN (2);

-- ***********************
-- UPL_CONS_COLUMNS
-- ***********************
--delete from BARSUPL.UPL_CONS_COLUMNS where FILE_ID IN (2);

-- ***********************
-- UPL_FILEGROUPS_RLN
-- ***********************
--delete from BARSUPL.UPL_FILEGROUPS_RLN where FILE_ID IN (2);

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

begin 
 execute immediate 'grant select, update, delete on barsupl.upl_sql to UPLD'; 
exception when others then null; 
end;
/
