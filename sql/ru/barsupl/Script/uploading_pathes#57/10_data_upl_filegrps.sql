-- ***************************************************************************
set verify off
-- sgroup_id ������������� ������ ��������
define sgroup_id = 99,98

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for upload group: &&sgroup_id');
end;
/

-- ======================================================================================
-- ETL-21205 UPL - initial upload - 99 ������, �������� BARS_UPL-57
--
-- ======================================================================================

begin
  dbms_output.put_line(':   REMOVE all value');
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id in (&&sgroup_id);

--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 153, 153); --ccprol     - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 161, 161); --credkz     - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 162, 162); --arracc0    - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 281, 281); --shedule    - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 501, 501); --transh     - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 201, 201); --credits    - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 108, 108); --kazna      - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 242, 242); --collat     - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 210, 210); --collatndn  - ������ �� �������� � ���� (����� ��� ��� �����)
--  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 159, 159); --arracc1    - ������ �� �������� � ���� (����� ��� ��� �����)

  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 133,  133); --cprefwr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 173,  173); --accvalr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 174,  174); --ccvalsr
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 147, 2147); --ccvals (INTRT, ND_REST)
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 118, 2118); --accvals (DATEOFKK, INTRT, ND_REST)
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 329,  329); --acc_pkprct (PK_PRCT)
  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (99, 113,  113); --receivables

  Insert into UPL_FILEGROUPS_RLN   (GROUP_ID, FILE_ID, SQL_ID) Values   (98, 265, 265); --korbal     - (����� ������������� �� ����������)

  if  barsupl.bars_upload_utl.is_mmfo > 1 then
       -- ************* MMFO *************
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (99, 158, 4158); --arracc2 ������+Full �� ��� ����
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (98, 158, 4158); --arracc2 ������+Full �� ��� ����
  else
      -- ************* RU *************
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (99, 158, 5158); --arracc2 ������+Full �� ��� ��
      Insert into UPL_FILEGROUPS_RLN   (group_id, file_id, sql_id) Values   (98, 158, 5158); --arracc2 ������+Full �� ��� ��
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

