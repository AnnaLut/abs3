-- ***************************************************************************
set verify off
--set define on
-- sgroup_id идентификатор группы выгрузки
--define sgroup_id = 99

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload group: 99');
end;
/

-- ======================================================================================
-- ETL-23220  UPL - добавить в выгрузку 99 группы
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (99);
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 331, 331); --ow_atrn_hist

  --if  barsupl.bars_upload_utl.is_mmfo > 1 then
  --     -- ************* MMFO *************
  --else
  --    -- ************* RU *************
  --end if;
end;
/

-- ======================================================================================
-- LOG INFORMATION
-- ======================================================================================
begin
   dbms_output.put_line('Group 99 containt:');
   for i in (select f.file_id, f.file_code, f.filename_prfx, f.descript, g.sql_id
               from BARSUPL.UPL_FILES f, BARSUPL.UPL_FILEGROUPS_RLN g
              where f.file_id = g.file_id and g.group_id in (99))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript || ' SQL_ID (' || i.sql_id || ')');
   end loop;
end;
/