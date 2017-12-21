-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_REF');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - ��������� �� ��� � �� ��������� ��������/����� ��� IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, ������� ������ (INTRT), �������� ��������.�������� (ND_REST) � ���������������� �������������
-- ����� ������� "����������� � ��������� �����"
-- ======================================================================================

delete 
  from barsupl.upl_tag_ref 
 where ref_id in (0, 1, 2, 3);

Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (0, null, '��� �����������');
Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (1, 177, '������-������ (BUS_MOD)');
Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (2, 178, '������� SPPI (SPPI)');
Insert into barsupl.upl_tag_ref (ref_id, file_id, description) Values (3, 179, '������������ ���� (IFRS)');
--Insert into barsupl.upl_tag_ref (ref_id, description) Values (4, '������� ������ (INTRT)');
--Insert into barsupl.upl_tag_ref (ref_id, description) Values (5, '��������� �� �������� ��������.�������� (ND_REST)');

