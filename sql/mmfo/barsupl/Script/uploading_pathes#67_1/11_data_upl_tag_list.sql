-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

-- ======================================================================================
-- TSK-0001183 ANL - ������ �������� ���������� ����� ����
-- TSK-0003096 UPL - ������� ������������ �������� ����������� ��� (�������), �������� ������� �� �� ��������� �� ������ ������ �������� ����
--     ��������� ������ ��� TAG ��� ������� SMB_ATTRIBUTE :
--     SMB_DEPOSIT_TRANCHE_INTEREST_RATE
--     SMB_DEPOSIT_ON_DEMAND_INTEREST_RATE
-- ======================================================================================

delete
  from barsupl.upl_tag_lists 
 where trim(tag_table) in ('SMB_TRANCHE', 'SMB_ON_DEMAND');

--delete
--  from barsupl.upl_tag_ref 
-- where ref_id in (5, 6);

--����������� ������ ����������� 
--Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (5, 000, '���������� ��������� ���� (������ ���� ���)');
--Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (6, 000, '���� ����� ���� (������ ���� ���)');

-- ��������� ��������� ���������
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_NUMBER', 0, 0, '����� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_CUSTOMER', 0, 0, '������������� ����������� �� ������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_PRODUCT', 0, 0, '������������� �������� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_START_DATE', 0, 0, '���� ������� 䳿 �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_EXPIRY_DATE', 0, 0, '���� ���������� 䳿 �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_CLOSE_DATE', 0, 0, '���� �������� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'OBJECT_STATE', 0, 0, '���� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_BRANCH', 0, 0, 'Գ��� �����, �� ����������� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_CURATOR', 0, 0, '���������� �����, ���� ���� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_VNCRP', 0, 0, '��������� �������� ��������� �������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_VNCRR', 0, 0, '�������� �������� ��������� �������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_FIN_CONDITION', 0, 0, '���� ������������ (���.����)');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_OVERDUE_DAYS', 0, 0, 'ʳ������ ��� ���������� �� ������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_PORTFOL_RESERVE_FLAG', 0, 0, '������ ������������ ������ ������������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_PORTFOL_RESERVE_GRP', 0, 0, '����� ������ ������������ ������ ������������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_FIN_CONDITION_23', 0, 0, '���� ������������ ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_DEBT_SERV_CLASS_23', 0, 0, '���� �������������� ����� ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_FIN_QUALITY_CATEGORY_23', 0, 0, '�������i� �����i �� �������� ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_RISK_RATE_23', 0, 0, '���������� ������ ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEAL_BALANCE_GROUP', 0, 0, '����� ���� � ���� ������� ���');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_NAME', 0, 0, '������������ ��������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_SEGMENT_OF_BUSINESS', 0, 0, '�������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_VALID_FROM', 0, 0, '���� ������� 䳿');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_VALID_THROUGH', 0, 0, '���� ��������� 䳿');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'PROD_PARENT_PRODUCT', 0, 0, 'ID ������������ ��������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_PRIMARY_ACCOUNT', 0, 0, '������� ����� ���� ��������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_INTEREST_ACCOUNT', 0, 0, '������� ����������� ������� �� ���������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT', 0, 0, '������� ������ ����������� �������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT', 0, 0, '������� ������ ��� ����������� ��� (�����)');
insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'SMB_DEPOSIT_TRANCHE_INTEREST_RATE', 1, 0, '��������� ������ �� ���������� ������� ����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_TRANCHE', 'SMB_DEPOSIT_TRANCHE_PENALTY_INTEREST_RATE', 0, 0, '������� ��������� ������ �� ���������� ������� ����');

-- ��������� ��������� �� �������������
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_NUMBER', 0, 0, '����� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_CUSTOMER', 0, 0, '������������� ����������� �� ������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_PRODUCT', 0, 0, '������������� �������� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_START_DATE', 0, 0, '���� ������� 䳿 �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_EXPIRY_DATE', 0, 0, '���� ���������� 䳿 �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_CLOSE_DATE', 0, 0, '���� �������� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'OBJECT_STATE', 0, 0, '���� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_BRANCH', 0, 0, 'Գ��� �����, �� ����������� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_CURATOR', 0, 0, '���������� �����, ���� ���� �����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_VNCRP', 0, 0, '��������� �������� ��������� �������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_VNCRR', 0, 0, '�������� �������� ��������� �������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_FIN_CONDITION', 0, 0, '���� ������������ (���.����)');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_OVERDUE_DAYS', 0, 0, 'ʳ������ ��� ���������� �� ������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_PORTFOL_RESERVE_FLAG', 0, 0, '������ ������������ ������ ������������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_PORTFOL_RESERVE_GRP', 0, 0, '����� ������ ������������ ������ ������������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_FIN_CONDITION_23', 0, 0, '���� ������������ ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_DEBT_SERV_CLASS_23', 0, 0, '���� �������������� ����� ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_FIN_QUALITY_CATEGORY_23', 0, 0, '�������i� �����i �� �������� ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_RISK_RATE_23', 0, 0, '���������� ������ ����� ��������� ��� �23');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEAL_BALANCE_GROUP', 0, 0, '����� ���� � ���� ������� ���');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_NAME', 0, 0, '������������ ��������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_SEGMENT_OF_BUSINESS', 0, 0, '�������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_VALID_FROM', 0, 0, '���� ������� 䳿');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_VALID_THROUGH', 0, 0, '���� ��������� 䳿');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'PROD_PARENT_PRODUCT', 0, 0, 'ID ������������ ��������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_PRIMARY_ACCOUNT', 0, 0, '������� ����� ���� ��������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_INTEREST_ACCOUNT', 0, 0, '������� ����������� ������� �� ���������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_INTEREST_EXPENSE_ACCOUNT', 0, 0, '������� ������ ����������� �������');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT', 0, 0, '������� ������ ��� ����������� ��� (�����)');
insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'SMB_DEPOSIT_ON_DEMAND_INTEREST_RATE', 1, 0, '��������� ������ �� ���������� �� ������ ����');
--insert into barsupl.upl_tag_lists (TAG_TABLE, TAG,ISUSE, REF_ID, DESCRIPTION) values('SMB_ON_DEMAND', 'SMB_DEPOSIT_ON_DEMAND_CALCULATION_TYPE', 0, 0, '��� ����������� % �� ���������� �� ������ ����');


