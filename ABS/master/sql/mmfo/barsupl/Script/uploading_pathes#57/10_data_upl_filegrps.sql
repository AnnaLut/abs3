-- ***************************************************************************
set verify off
-- sgroup_id идентификатор группы выгрузки
define sgroup_id = 99,98

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload group: &&sgroup_id');
end;
/

-- ======================================================================================
-- ETL-21205 UPL - initial upload - 99 группа, поставка BARS_UPL-57
--
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (&&sgroup_id);

--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 153, 153); --ccprol     - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 161, 161); --credkz     - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 162, 162); --arracc0    - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 281, 281); --shedule    - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 501, 501); --transh     - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 201, 201); --credits    - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 108, 108); --kazna      - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 242, 242); --collat     - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 210, 210); --collatndn  - убрать из поставки в прод (нужен был для теста)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 159, 159); --arracc1    - убрать из поставки в прод (нужен был для теста)

  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 133,  133); --cprefwr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 173,  173); --accvalr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 174,  174); --ccvalsr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 147, 2147); --ccvals (INTRT, ND_REST)
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 118, 2118); --accvals (DATEOFKK, INTRT, ND_REST)
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 329,  329); --acc_pkprct (PK_PRCT)
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 113,  113); --receivables

  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 265, 265); --korbal     - (будет запрашиваться по требованию)

  if  barsupl.bars_upload_utl.is_mmfo > 1 then
       -- ************* MMFO *************
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (99, 158, 4158); --arracc2 Дельта+Full по ФДЗ ММФО
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (98, 158, 4158); --arracc2 Дельта+Full по ФДЗ ММФО
  else
      -- ************* RU *************
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (99, 158, 5158); --arracc2 Дельта+Full по ФДЗ РУ
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (98, 158, 5158); --arracc2 Дельта+Full по ФДЗ РУ
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

