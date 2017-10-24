-- ======================================================================================
-- Module : UPL
-- Date   : 20.07.2017
-- ======================================================================================
-- ����� ������������ ����� ����� ��� DWH
-- ======================================================================================

delete from BARSUPL.UPL_FILEGROUPS_RLN
    where file_id in ( 158, 171, 172, 356, 547, 7171, 566 );

--- ETL-19131 - ANL - �������� ��������� �� ������������� ����������� �������������
--- XOZ_REF(171) ��������� ��������� (������� �� ������� ��� ���.���)
--- ����� ����
prompt 171 �������� ��� XOZ_REF
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 171,  171);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 171,  171);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 171,  171);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 171,  171);
prompt 7171 �������� ��� XOZ_REF0
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (7, 7171, 7171);
prompt 566 �������� �7
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (18, 566, 566);

--- ETL-19131 - ANL - �������� ��������� �� ������������� ����������� �������������
--- XOZ_PRG(172) ������� �������
--- ����� ����
prompt 172 ���������� XOZ_PRG
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (5, 172, 172);

--- ETL-19474 - UPL - �������� � �������� ��� T0 �������������� �������� �� ��������� ���.��������� ��������� ������ (�� �������� � MIR.SRC_PRFTADJTXN0)
--- ����� ����
prompt 547 ������������� �� ������ XOZ
Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (7, 547, 547);

---- ETL-19167
---- UPL - ���������� �������� ������ � ����� inspaymentssc - FACT_DATE ������ ���� � ��������� �� ���������� ���������� ���� (�� �������) � ����� �������� ������������
prompt 356 inspaymentssc
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 356,  356);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 356,  1356);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 356,  356);
 Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 356,  1356);


-- ��� ���� � �� ������ �����
begin
  if barsupl.bars_upload_utl.is_mmfo > 1 then
     -- ************* MMFO *************
     -- 158 (arracc2) ETL-XXX UPL - ����������� �������� �� (�� �� ������� �������� ����� ACCR3, ACCUNREC �� ����)
     -- ��������� �������� ��� ��
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 3158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 2158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 3158);
  else
     -- ************* RU *************
     -- 158 (arracc2) ETL-XXX UPL - ����������� �������� �� (�� �� ������� �������� ����� ACCR3, ACCUNREC �� ����)
     -- ��������� �������� ��� ��
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (1, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (2, 158, 1158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (3, 158, 158);
     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (4, 158, 1158);
  end if;
end;
/


--
-- ����� 99 �� ������� ������������
--  UPL - initial upload - 99 ������
begin
  delete from BARSUPL.UPL_FILEGROUPS_RLN where group_id = 99;
  Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 221, 221 ); --deposit
--  if barsupl.bars_upload_utl.is_mmfo > 1 then
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 5116);
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 201, 99201);
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 159, 99159);
--  else
--     Insert into BARSUPL.UPL_FILEGROUPS_RLN (group_id, file_id, sql_id)  Values (99, 116, 2116);
--  end if;
end;
/

COMMIT;

