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
-- TSK-0001468   UPL - добавить в 99 группу инишиал по файлам
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (99);
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (99, 116, 5116); -- CUSVALS  tag='EMAIL'
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (99, 147, 2147); -- CCVALS   tag= NUMKF 
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (99, 174, 2174); -- CCVALSR  tag= flags
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (99, 442,  442); -- BRN2 - История изменений % ставок пени (разовый)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (99, 443,  443); -- INTRATN2 - Счета, с установленными ставками пени (разовый)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID) Values (99, 105,  105); -- ACRA  ( в связи с добавлением поля S)
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