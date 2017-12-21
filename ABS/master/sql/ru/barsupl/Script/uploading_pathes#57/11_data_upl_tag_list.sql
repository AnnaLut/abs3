-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - ��������� �� ��� � �� ��������� ��������/����� ��� IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, ������� ������ (INTRT), �������� ��������.�������� (ND_REST) � ���������������� �������������
-- ��������� ������ ���� ��� ������������
-- ======================================================================================

delete 
  from barsupl.upl_tag_lists 
 where tag_table in ('CP_TAGS')
   and tag in ('VSTRO', 'PORTF');

delete 
  from barsupl.upl_tag_lists 
 where tag       in ('BUS_MOD', 'SPPI', 'IFRS', 'INTRT', 'ND_REST');



--������� ��, �� * �������� ������ * �������� ���� * ���������� �������� (����) * �������� "���� �����������" (������)
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'BUS_MOD', 1, 1);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'SPPI',    1, 2);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'IFRS',    1, 3);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'INTRT',   1, 0);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CC_TAGS', 'ND_REST', 1, 0);

--������� ��� 
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('BPK_TAGS', 'BUS_MOD', 1, 1);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('BPK_TAGS', 'SPPI',    1, 2);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('BPK_TAGS', 'IFRS',    1, 3);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('BPK_TAGS', 'INTRT',   1, 0);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('BPK_TAGS', 'ND_REST', 1, 0);

--�������� ��
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CP_TAGS', 'BUS_MOD', 1, 1);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CP_TAGS', 'SPPI',    1, 2);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CP_TAGS', 'IFRS',    1, 3);

--��������� �������� ����� CP (���� �� �������� - ��� �����)
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CP_TAGS', 'VSTRO',   1, 0);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('CP_TAGS', 'PORTF',   1, 0);

--�������� ������, �������� ����, ���������� �������� (����), �������� "���� �����������" (������)
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('ACC_FIELD', 'BUS_MOD', 1, 1);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('ACC_FIELD', 'SPPI',    1, 2);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('ACC_FIELD', 'IFRS',    1, 3);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('ACC_FIELD', 'INTRT',   1, 0);
insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE, REF_ID) values('ACC_FIELD', 'ND_REST', 1, 0);



update  barsupl.upl_tag_lists
   set REF_ID = 0
 where REF_ID is null;
