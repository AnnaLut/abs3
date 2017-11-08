-- ===================================================================================
-- Module : UPL
-- Date   : 08.09.2017
-- ===================================================================================

-- ETL-19905  UPL - ���������� �������� � ���� cusvals �������� ���� DDBO (������ ��������� �������� ����)
-- ETL-20409  UPL - ��������� ����� ��� SDBO � ����� cusvals (��������� �������� ���� ��� ��������)

delete 
  from barsupl.upl_tag_lists 
 where tag_table in ('CUST_FIELD')
   and tag       in ('DDBO', 'SDBO');


insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE)
 values('CUST_FIELD', 'DDBO',1);

insert into barsupl.upl_tag_lists (TAG_TABLE,TAG,ISUSE)
 values('CUST_FIELD', 'SDBO',1);