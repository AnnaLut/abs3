-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_TABLES');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - ��������� �� ��� � �� ��������� ��������/����� ��� IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, ������� ������ (INTRT), �������� ��������.�������� (ND_REST) � ���������������� �������������
-- ��������� ������ ���� ��� ������������
-- ======================================================================================

delete 
  from barsupl.upl_tag_tables 
 where tag_table in ('CP_TAGS');

Insert into barsupl.upl_tag_tables (tag_table, descript) Values ('CP_TAGS', '�������� �������� ���� ��');

