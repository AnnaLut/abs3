-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- TSK-0000786 UPL - ��������� ������ �� ���� NUMKF � ������� SRC_CCVALS i �������� � ����� 99
-- TSK-0001458 UPL - ��������� ��� ����� ��������� �� � �������� � ����� 5
-- ���������� ������� � ������ ��� ���������: ���� ��������� �������, flags
-- ======================================================================================

delete 
  from barsupl.upl_tag_lists 
 where trim(tag_table) in ('CC_TAGS')
   and trim(tag) in ('NUMKF', 'FLAGS');

delete 
  from barsupl.upl_tag_ref 
 where ref_id = 4;

--����������� ������ ����������� 
Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (4, 180, '�����-��������� ���');

-- NUMKF --� �������� ������ � ������ ��������� ������� 
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'NUMKF', 1, 0);

-- FLAGS --�����-��������� ���
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'FLAGS', 1, 4);

