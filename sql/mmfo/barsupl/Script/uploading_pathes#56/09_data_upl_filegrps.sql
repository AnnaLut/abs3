-- ***************************************************************************
set verify off
-- sgroup_id идентификатор группы выгрузки
define sgroup_id = 99

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload group: &&sgroup_id');
end;
/

-- ======================================================================================
-- ETL-20206 UPL - initial upload - 99 группа uploading_pathes#56
-- Для исправления данных необходим initial по следующим файлам:
-- 1. accvals в части тега "DATEOFKK";
-- 2. deposits (исправление признака онлайн депозитов).
-- 3. collatndn (для тестирования качества данных)
-- 4. collatndo (для тестирования качества данных)
-- 5. cusvals инишинал по тегам DDBO и SDBO
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = &&sgroup_id;

  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (&&sgroup_id, 118, 2118); --accvals
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (&&sgroup_id, 210, 210);  --collatndn
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (&&sgroup_id, 211, 211);  --collatndo
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (&&sgroup_id, 221, 221);  --deposits
  if  barsupl.bars_upload_utl.is_mmfo > 1 then
       -- ************* MMFO *************
      Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (&&sgroup_id, 116, 5116); --cusvals
  else
      -- ************* RU *************
      Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (&&sgroup_id, 116, 2116); --cusvals
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