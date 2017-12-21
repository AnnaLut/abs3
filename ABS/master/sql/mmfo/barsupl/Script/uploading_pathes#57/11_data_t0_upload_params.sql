-- ***************************************************************************
set verify off

begin
   dbms_output.put_line(to_char(sysdate(), 'dd.mm.yyyy hh24:mi:ss') ||': Process for T0_UPLOAD_PARAMS');
end;
/

-- ======================================================================================
-- ETL-20823 -UPL - ��������� �� ��� � �� ��������� ��������/����� ��� IFRS9: BUSINESS_MODEL, IFRS_CATEGORY, SPPI, ������� ������ (INTRT), �������� ��������.�������� (ND_REST) � ���������������� �������������
-- ����������� ���� � ���������� ����������� � �0
-- ======================================================================================

delete 
  from barsupl.t0_upload_params 
 where param_name in ('BUS_MOD', 'SPPI', 'IFRS', 'INTRT', 'ND_REST');


-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (1,  'VED', '��� ������� ��������', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (2,  'ISE', '������������� ������ �������� (K070)', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (3,  'FS', '����� �������� (K081)', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (4,  'COUNTRY', '��� ����� �볺���', 1);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (5,  'VIDD', '��� ���� ���������� ��������', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (6,  'WDATE', '���� ��������� 䳿 ��������', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (7,  'KAT23', '�������i� �����i �� �������� �� ���-23', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (8,  'CPROD', '��� ��������', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (9,  'VNCRR', '�����i��i� ��������� ����i��', 2);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (10, 'OB22', '�������� ��22', 3);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (11, 'IR', '��������� ��������� ������', 3);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (12, 'EIR', '��������� ��������� ������', 3);
-- Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (13, 'R013', '�������� R013', 3);

--��������� ��� ���������
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (14, 'BUS_MOD', '������-������ (BUS_MOD)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (15, 'SPPI', '������� SPPI (SPPI)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (16, 'IFRS', '������������ ���� (IFRS)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (17, 'INTRT', '������� ������ (INTRT)', 2);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (18, 'ND_REST', '��������� �� �������� ��������.�������� (ND_REST)', 2);

--��������� ��� ������
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (19, 'BUS_MOD', '������-������ (BUS_MOD)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (20, 'SPPI', '������� SPPI (SPPI)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (21, 'IFRS', '������������ ���� (IFRS)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (22, 'INTRT', '������� ������ (INTRT)', 3);
Insert into BARSUPL.T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (23, 'ND_REST', '��������� �� �������� ��������.�������� (ND_REST)', 3);

