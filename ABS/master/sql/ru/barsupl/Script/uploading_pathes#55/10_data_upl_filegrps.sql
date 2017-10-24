-- ======================================================================================
-- Module : UPL
-- Date   : 20.07.2017
-- ======================================================================================
-- ����� ������������ ����� ����� ��� DWH
-- ======================================================================================

/*
--**********************************
prompt ������������ ����� 535 agrmchg0
prompt ������ ��� �����
delete from BARSUPL.UPL_FILEGROUPS_RLN where file_id in ( 7535 );

insert into barsupl.UPL_FILEGROUPS_RLN (GROUP_ID, FILE_ID, SQL_ID)
 select GROUP_ID, 7535, 7535
   from barsupl.UPL_FILEGROUPS_RLN
  where file_id = 535;
--**********************************
*/
delete from BARSUPL.UPL_FILEGROUPS_RLN
    where file_id in ( 7535, 566 , 567);

prompt 566 �������� �7
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (18, 566, 566);

 prompt 567 file name for  �7
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (18, 567, 567);

--
-- ����� 99 �� ������� ������������
--  UPL - initial upload - 99 ������
begin
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     -- ************* MMFO *************
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 113, 113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 158, 4158);
  else
     -- ************* RU *************
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 113, 113);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 158, 5158);
  end if;
end;
/

COMMIT;

