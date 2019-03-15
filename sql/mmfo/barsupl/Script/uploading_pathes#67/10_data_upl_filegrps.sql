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
-- TSK-0001914 Сформувати 99 групу для вивантаження initial
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (99);
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 105, 105); --ACRA
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 186, 186); --CUSVALSR
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