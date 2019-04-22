-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_TABLES');
end;
/

-- ======================================================================================
-- �������� ����
-- TSK-0001183 ANL - ������ �������� ���������� ����� ����
-- TSK-0003096 UPL - ������� ������������ �������� ����������� ��� (�������), �������� ������� �� �� ��������� �� ������ ������ �������� ����
-- ======================================================================================

delete
  from barsupl.upl_tag_tables
 where tag_table in ('SMB_TRANCHE', 'SMB_ON_DEMAND');

Insert into UPL_TAG_TABLES   (tag_table, descript) Values   ('SMB_TRANCHE', '�������� ���� �������');
Insert into UPL_TAG_TABLES   (tag_table, descript) Values   ('SMB_ON_DEMAND', '�������� ���� �� ������');
