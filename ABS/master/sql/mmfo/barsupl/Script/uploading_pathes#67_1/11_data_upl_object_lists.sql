-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_OBJECT_LISTS');
end;
/

-- ======================================================================================
-- �������� ����
-- TSK-0001183 ANL - ������ �������� ���������� ����� ����
-- TSK-0003096 UPL - ������� ������������ �������� ����������� ��� (�������), �������� ������� �� �� ��������� �� ������ ������ �������� ����
-- ======================================================================================

delete 
  from barsupl.upl_object_lists 
 where trim(type_code) in ('SMB_DEPOSIT_TRANCHE', 'SMB_DEPOSIT_ON_DEMAND');


-- ��������� ��������� ���������
insert into barsupl.upl_object_lists (TYPE_ID, TYPE_CODE, TYPE_NAME, IS_ACTIVE) values(24, 'SMB_DEPOSIT_TRANCHE', '�������� ������ ����', 'Y');
insert into barsupl.upl_object_lists (TYPE_ID, TYPE_CODE, TYPE_NAME, IS_ACTIVE) values(25, 'SMB_DEPOSIT_ON_DEMAND', '������ �� ������ ����', 'Y');
