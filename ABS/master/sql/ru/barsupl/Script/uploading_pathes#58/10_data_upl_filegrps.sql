-- ***************************************************************************
set verify off
set define on
-- sgroup_id идентификатор группы выгрузки
define sgroup_id = 99

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload group: &&sgroup_id');
end;
/

-- ======================================================================================
-- ETL-22015  UPL - initial upload - 99 группа
--
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (&&sgroup_id);

  --Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 133,  133); --cprefwr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 173, 173); --accvalr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 174, 174); --ccvalsr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 210,  210); --collatndn
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 211,  211); --collatndo

  if barsupl.bars_upload_utl.is_mmfo > 1 then
     -- ************* MMFO *************
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 158, 4158); --arracc2
  else
     -- ************* RU *************
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 158, 5158); --arracc2
  end if;
end;
/

-- ======================================================================================
-- LOG INFORMATION
-- ======================================================================================
begin
   dbms_output.put_line('Group &&sgroup_id containt:');
   for i in (select f.file_id, f.file_code, f.filename_prfx, f.descript, g.sql_id
               from BARSUPL.UPL_FILES f, BARSUPL.UPL_FILEGROUPS_RLN g
              where f.file_id = g.file_id and g.group_id in (&&sgroup_id))
   loop
      dbms_output.put_line(':   FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript || ' SQL_ID (' || i.sql_id || ')');
   end loop;
end;
/

