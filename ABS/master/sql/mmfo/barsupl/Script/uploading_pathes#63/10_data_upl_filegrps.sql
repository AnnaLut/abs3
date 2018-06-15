-- ***************************************************************************
set verify off
--set define on
-- sgroup_id идентификатор группы выгрузки
--define sgroup_id = ## --99

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload group: 99');
end;
/

-- ======================================================================================
-- ETL-24972   UPL - добавить в выгрузку групп 99 и 98
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (99);
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 267,  267); --monbals9
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 102, 6102); --accounts Счета банка от глобальной БД -3 дня до глобальной БД (для IFRS9)

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (98); -- and file_id in (555);
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 555,  2555); --nbu23rez

  if  barsupl.bars_upload_utl.is_mmfo > 1 then
       -- ************* MMFO *************
      Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 568,  4568); --rez_cr
  else
      -- ************* RU *************
      Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 568,  5568); --rez_cr
  end if;
end;
/

-- ======================================================================================
-- LOG INFORMATION
-- ======================================================================================
begin
   dbms_output.put_line('Groups 98, 99 containt:');
   for i in (select g.group_id, f.file_id, f.file_code, f.filename_prfx, f.descript, g.sql_id
               from BARSUPL.UPL_FILES f, BARSUPL.UPL_FILEGROUPS_RLN g
              where f.file_id = g.file_id and g.group_id in (98, 99)
              order by g.group_id, f.file_id)
   loop
      dbms_output.put_line(':   GROUP #' || i.group_id || ' :FILE #' || i.file_id || ' ' || i.file_code || '(' || i.filename_prfx ||') ' || i.descript || ' SQL_ID (' || i.sql_id || ')');
   end loop;
end;
/