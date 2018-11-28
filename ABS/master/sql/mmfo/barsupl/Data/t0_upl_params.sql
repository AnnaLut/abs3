
declare
     procedure insert_data(p_param_id in number, p_param_name in varchar2, p_param_desc in varchar2, p_object_id in number) as
     begin
        Insert into T0_UPLOAD_PARAMS   (param_id, param_name, param_desc, object_id) Values   (p_param_id,  p_param_name, p_param_desc, p_object_id);
     exception
        when dup_val_on_index then null;
        when others then rollback; raise;
     end;
begin
     insert_data(1,  'VED', '��� ������� ��������', 1);
     insert_data (2,  'ISE', '������������� ������ �������� (K070)', 1);
     insert_data (3,  'FS', '����� �������� (K081)', 1);
     insert_data (4,  'COUNTRY', '��� ����� �볺���', 1);
     insert_data (5,  'VIDD', '��� ���� ���������� ��������', 2);
     insert_data (6,  'WDATE', '���� ��������� 䳿 ��������', 2);
     insert_data (7,  'KAT23', '�������i� �����i �� �������� �� ���-23', 2);
     insert_data (8,  'CPROD', '��� ��������', 2);
     insert_data (9,  'VNCRR', '�����i��i� ��������� ����i��', 2);
     insert_data (10, 'OB22', '�������� ��22', 3);
     insert_data (11, 'IR', '��������� ��������� ������', 2);
     insert_data (11, 'IR', '��������� ��������� ������', 3);
     insert_data (12, 'EIR', '��������� ��������� ������', 2);
     insert_data (12, 'EIR', '��������� ��������� ������', 3);
     insert_data (13, 'R013', '�������� R013', 3);
     insert_data (14, 'BUS_MOD', '������-������ (BUS_MOD)', 2);
     insert_data (15, 'SPPI', '������� SPPI (SPPI)', 2);
     insert_data (16, 'IFRS', '������������ ���� (IFRS)', 2);
     insert_data (17, 'INTRT', '������� ������ (INTRT)', 2);
     insert_data (18, 'ND_REST', '��������� �� �������� ��������.�������� (ND_REST)', 2);
     insert_data (19, 'BUS_MOD', '������-������ (BUS_MOD)', 3);
     insert_data (20, 'SPPI', '������� SPPI (SPPI)', 3);
     insert_data (21, 'IFRS', '������������ ���� (IFRS)', 3);
     insert_data (22, 'INTRT', '������� ������ (INTRT)', 3);
     insert_data (23, 'ND_REST', '��������� �� �������� ��������.�������� (ND_REST)', 3);
     COMMIT;
end;
/

