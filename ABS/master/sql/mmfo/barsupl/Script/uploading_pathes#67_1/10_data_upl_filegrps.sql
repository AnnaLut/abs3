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
-- TSK-0003557   UPL - створити 99 групу для инишиал вивантаження по депозитам ММСБ
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (99);
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 261, 261); --ARR_TYPES (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 571, 571); --SMB_DEPOSIT
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 572, 572); --SMB_LONGATION
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 573, 573); --SMB_REGISTER
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 574, 574); --SMB_ATTRIBUTE
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 575, 575); --ARRACC8
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 576, 576); --DEAL_PRODUCT (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 577, 577); --REGISTER_TYPE (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 578, 578); --ATTRIBUTE_TYPE (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 579, 579); --OBJECT_STATE (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 580, 580); --SMB_RATES

  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (98);
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 261,  261); --ARR_TYPES (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 571, 1571); --SMB_DEPOSIT
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 572, 1572); --SMB_LONGATION
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 573, 1573); --SMB_REGISTER
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 574, 1574); --SMB_ATTRIBUTE
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 575, 1575); --ARRACC8
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 576,  576); --DEAL_PRODUCT (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 577,  577); --REGISTER_TYPE (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 578,  578); --ATTRIBUTE_TYPE (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 579,  579); --OBJECT_STATE (ref)
  Insert into BARSUPL.UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 580,  580); --SMB_RATES
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