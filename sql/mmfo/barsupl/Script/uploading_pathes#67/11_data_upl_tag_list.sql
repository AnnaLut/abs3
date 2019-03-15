-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for UPL_TAG_LISTS');
end;
/

delete
  from barsupl.upl_tag_ref 
 where ref_id in (5);
--����������� ������ ����������� 
Insert into barsupl.upl_tag_ref  (REF_ID, FILE_ID, DESCRIPTION) Values (5, 391, '���: ������ ������������_ �� ������ �_�����');


-- ======================================================================================
-- TSK-0003171 UPL - �������� ������������ � ��� ���.������� ��������� ��������� (DOCVALS - TAG='REF92'  - ���. ���������� ���������)
-- ����������� ����� ��� 'REF92'. ��� ��������� ����������� ��������.
-- ======================================================================================
delete
  from barsupl.upl_tag_lists
 where trim(tag_table) in ('OP_FIELD');

Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'REF92', 1, 0, '���. ���������� ���������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'PASPN', 1, 0, '���� � ����� ���������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'CP_IN', 1, 0, '�Ͳֲ����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'OW_DS', 1, 0, 'OW. ���� ��������� Way4');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'OW_SC', 1, 0, 'OW. ��� ���������� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'SOCTP', 1, 0, '��� �����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'D#73 ', 1, 0, '�������� ��� �����  #73');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'TAROB', 1, 0, '��� ������ �� ���.6110');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'TARON', 1, 0, '����� ����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__C', 1, 0, '��� ������/������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__K', 1, 0, 'ʳ������ ������/�����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__R', 1, 0, 'ֳ�� ������/������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'DATN ', 1, 0, '���� ����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'MTSC ', 1, 0, 'Money transfer system code');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'KTAR ', 1, 0, '��� ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM_22', 1, 0, '��22 ��� ������_� � _�����.��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM_CM', 1, 0, '��� ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'BM__Z', 1, 0, '���i�i�');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'W4MSG', 1, 0, 'Way4. ��� ����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWATN', 1, 0, '������������� �������� (EWA)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWCOM', 1, 0, '����� �� �������� �����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWAML', 1, 0, 'Email ���-��, �� �����. ���(EWA)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('OP_FIELD', 'EWEXT', 1, 0, '����. �����. ���. �������� (EWA)');


-- ======================================================================================
-- TSK-0003337 UPL - �������� ������������ ��������� K 140
--      ����������� ����� ��� 'K140'. ��� ��������� ����������� ��������.
--      ���������� ������� ����� ���� �������� cusvalsr
--      �������� ��������� ����������� klk140 (�������� ���� REF_ID)
-- ======================================================================================


delete
  from barsupl.upl_tag_lists
 where trim(tag_table) in ('CUST_FIELD');

Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'K140' , 1, 5, '��� ������ ���''���� �������������� (K140)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ADRP' , 1, 0, '������� ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'BUSSL', 1, 0, '������-��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'BUSSS', 1, 0, '������-������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'CHORN', 1, 0, '�������i� ��������, ��i ����������� �����i��� ������.����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'CIGPO', 1, 0, '������ ��������� �����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DATVR', 1, 0, '���� �������� ������� �������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DATZ' , 1, 0, '���� ���������� ���������� ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DDBO' , 1, 0, '���� ���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'DR'   , 1, 0, '̳��� �������� ���������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ELT_D', 1, 0, 'ELT: ���� �������� �볺��-���� � �.�.');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ELT_N', 1, 0, 'ELT: � �������� �볺��-���� � �.�.');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'EMAIL', 1, 0, '������ ���������� �����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FADR' , 1, 0, '������ ����������� ����������� (��-����������)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGADR', 1, 0, '����~��������������.~�����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGDST', 1, 0, '����~��������������.~�����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGIDX', 1, 0, '�����: ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGOBL', 1, 0, '����~��������������.~�������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FGTWN', 1, 0, '����~��������������.~���������� �����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FIN23', 1, 0, 'Գ����� ��������� ��� 23');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FSKPR', 1, 0, '������ �i�.�����: �i������ ������� ����i����i�');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'FSOVR', 1, 0, '������ �i�.�����: ����� ������� �� ������� ���������� ��');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'HIST' , 1, 0, '������ ��������(���. ��� �����-�, ����, ���.�������� �� �������.)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDDPD', 1, 0, '���� �������� �� ������ ������� ���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDDPL', 1, 0, '���� ������� i������i���i�');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDDPR', 1, 0, '���� ��������� i������i���i�/��������� ����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDPIB', 1, 0, 'ϲ� �� ���. ����������, ����������. �� �����-��� � �������� �볺���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'IDPPD', 1, 0, '�I� �� ��� ����i�����, �� ��� �� ������ ������ ����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'INZAS', 1, 0, 'I��i ����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'ISP'  , 1, 0, '���������, ���� ������� ������ ��� �������� �������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'K013' , 1, 0, '��� ������������� �������� ����. �볺���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'KVPKK', 1, 0, '��� ���� ��i����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'LINKG', 1, 0, '��� ����� ���''�������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'LINKK', 1, 0, '��� ����� ���''�������-�����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MPNO' , 1, 0, '�������� ������� (��� SMS)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_FS', 1, 0, '��-�.05 ���-����.����� �������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_GR', 1, 0, '��-�.53 �������������� � ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_KL', 1, 0, '��-�.08 ����������� ��� �������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'MS_VD', 1, 0, '��-�.50 ���.��� ����.��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_REE', 1, 0, '��� ����� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_RPD', 1, 0, '���i ��� �������i� �� �������� ��� (�����, ����, �����)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_RPN', 1, 0, '����� ��������� ��-�����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_RPP', 1, 0, '���� ��������� �� �������� ������� �� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_SVD', 1, 0, '����� ��������� �� �������� ������� �� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_SVI', 1, 0, '��� ��� ��������� �� �������� ������� �� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'N_SVO', 1, 0, '���� ��������� ��-�����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'NDBO' , 1, 0, '�������� �������� ��� ��������� ��-�����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'NPDV' , 1, 0, '����� ��������� ��-�����������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'OSN'  , 1, 0, '���������� ��� ����������, �������� ����� ��. �����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'OSOBA', 1, 0, '���. ��� �����, ��� ������� ������� �� ��''� �볺���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'PLPPR', 1, 0, '��� ��� ��������� �� �������� ������� �� �������� ');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'PODR' , 1, 0, '�i���������i �i�����i�� �������� �����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'PODR2', 1, 0, '�i���������i �i�����i�� �������� �����(�������)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'RCOMM', 1, 0, '����������� ��� ���������� ����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'SDBO',  1, 0, '³����� ������ ���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'SUBS' , 1, 0, '�������� �����䳿');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'SUTD' , 1, 0, '�������������� ��� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UADR' , 1, 0, '̳�������������� �������� ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UPFO' , 1, 0, '�i������i ��� �i�.��i�, ������������� �i��� �i� i���i �볺���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UUCG' , 1, 0, '����� ������� ������ �� ����������� ��, �� ���������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'UUDV' , 1, 0, '������ �������� ��������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VIDKL', 1, 0, '��� �볺���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VIP_K', 1, 0, '������� VIP-�������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VNCRP', 1, 0, '��������� ���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VNCRR', 1, 0, '�������� ���');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VPD'  , 1, 0, '��� ������������ �������� (��)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'VYDPP', 1, 0, '��� ���������� (������������)');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'WORK' , 1, 0, '̳��� ������, ������');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'WORKB', 1, 0, '���������i��� �� ����i����i� �����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'WORKU', 1, 0, '������ ���i�����');
Insert into barsupl.upl_tag_lists (tag_table, tag, isuse, ref_id, description) Values ('CUST_FIELD', 'Y_ELT', 1, 0, '���� ��������� ������ ��������� (�� �����= Y)');




