SET DEFINE OFF;

exec bc.home;

delete from NBUR_DCT_F6KX_EKP;

Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K001', '��������� ����� ������������ ������� ������ � �����', '1', 'A6K006', NULL, 
    NULL, NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K002', '������ �������� ������� �������� ����� � �����', '1', 'A6K007', NULL, 
    NULL, NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K003', '������ �������� ����������� �������� ����� � �����', '1', 'A6K008', NULL, 
    NULL, NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K004', '������ ���������� ������ �������� ����� � �����', '1', NULL, NULL, 
    'A6K002 - LEAST(A6K003, 0.75 * A6K002)', NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K005', '���������� �������� �������� (LCR) � �����', '1', NULL, NULL, 
    'AE6001/AE6004', NULL, NULL, NULL, '1');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K006', '��������� ����� ������������ ������� ������ (�� ���� ��������)', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K007', '������ �������� ������� �������� ����� (�� ���� ��������)', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K008', '������ �������� ����������� �������� ����� (�� ���� ��������)', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K009', '������ ���������� ������ �������� ����� (�� ���� ��������)', '0', NULL, NULL, 
    'A6K007 - LEAST(A6K008, 0.75 * A6K007)', NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K010', '���������� �������� �������� (LCR) �� ���� �������� (LCR��)', '0', NULL, NULL, 
    'AE6006/AE6009', NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K011', '���� �� ���������� ��������� �������� ������ (����) � ������� ��������� ����� 30 ���', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K012', '���� �� ���������� ��������� �������� ������ (����) � ������� ��������� �� 30 ���', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K013', '���� �� ���������� �������� �������� ������ � �������� ����� � ������� ��������� �� 30 ���', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K014', '���� �� ���������� �������� �������� ������ � �������� ����� � ������� ��������� ����� 30 ���', '1', 'A6K001', NULL, 
    NULL, 85, 85, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K015', '���� �� ��������� ������� �������� ���������� ���������� ����������/��������� ������ ���� G-7 � ���������� �������� ������� ����������� ������� �� ����� "��-"/"��3"', '1', 'A6K001', 0, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K016', '����� � �������� ����� �� ����������������� �������� � ������ � ��������� �� ����� �������������� �����', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K017', '���� ��������������� ������� � �������� ����� �� �������� ������ � ������ � ��������� �� ����� ����������-���� �����', '1', 'A6K001', 0, 
    NULL, -100, -100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K001', '�������� �� ������', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K002', '������� �� ���������� �������, �������� ���� �������������', '1', 'A6K001', NULL, 
    NULL, -100, -100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K003', '����� �� ������������������ ������� � ������������� ����� ������', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K024', '���� �� ��������� ������� ��������, ���������� ����������� ������� ��������', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K025', '���� �� ����������� ������������� ������������� ����� ������', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K026', '���� �� ���������� � ������������� ����� ������ �� 1 ��� ', '1', 'A6K001', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K018', '���� ��������� ������ �������� ���, �� ����� � ������� �������� �� ������ �������� �������� 30 ���', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K019', '���� ��������� ������ �������� ���, �� �� ���� ��������� ��������� �� ������������� �������� 30 ���', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K020', '���� ������ �������� ���, �� ����� �������� ����������� ��� �� ���������� (������ �� ������ �� ������� ������)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K021', '���� ����� ��������� ������ �������� ���, �� ����� � ������� ��������, ������ ���� �������� �������� 30 ���', '1', 'A6K002', NULL, 
    NULL, 10, 10, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K022', '���� ��������� ������ ��ᒺ��� ������������ ��������, �� ����� � ������� �������� �� ������ �������� �������� 30 ���', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K023', '���� ��������� ������ ��ᒺ��� ������������ ��������, �� �� ���� ��������� ��������� �� �������������
', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K024', '���� ��������� ������ ��ᒺ��� ������������ ��������, �� ����� �������� ����������� ��� �� ���������� (������ �� ������ �� ������� ������)
', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K025', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� �������� ���''���� ������������ �������� (���)', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K026', '���� �� ���� ���������, �� �� ������� �� ���������� ������������ ������� ������ (���)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K027', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ���������� ����� ����� �� �� ���������� ���������, �� ������� �� ����� �����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K028', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ������� ��������� �������', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K029', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ������� ������������ ���������� �������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K030', '������ ������������ ���������� �������, �� ����� �������� ����������� ��� �� ���������� (������ �� ������ �� ������� ������)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K031', '���� ���������� ����������� ������� �������� 30 ��� �� ���������� ������� ������������� ����� ������', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K032', '���� ���������� ����������� ������ �������� 30 ��� �� ��������� �� ���������� ����� ��������', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K033', '���� ���������� ����������� ������ �������� 30 ��� ��������� �� ����� ���������� ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K034', '���� ���������� ����������� ������� �������� 30 ��� �� ���������� �������� (�����������) �������������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K035', '���� ���������� ����������� ������ �������� 30 ��� �� ������ ������� �������� �������� �����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K036', '���� ���������� ����������� ������ �������� 30 ��� �� �������������� ������ ', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K037', '���� �� ������������� �����''�������� � ������������, �� �����  �������� ������', '1', 'A6K002', NULL, 
    NULL, 5, 5, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K038', '���� �� ������������� �����''�������� � ������������, �� ����� ���''����� ������������ ��������, ������� �������� �����, ������� �������� �������������� �� ���������� ���������� ����������� ', '1', 'A6K002', NULL, 
    NULL, 10, 10, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K039', '���� �� ������������� �����''�������� � ������������, �� ����� ����� ���������� ���������', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K040', '���� ���������� ����������� ������� �������� 30 ��� �� ����������, ���������� � �������� ������������� (������, ����������)
', '1', 'A6K002', NULL, 
    NULL, 30, 30, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K041', '���� ���������� ����������� ������ �������� 30 ��� �� ������ ����������� �� ��������������� �����''��������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K042', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� � ������������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K043', '���� ���������� ����������� ������ �������� 30 ��� �� ������������� ������������� � ��������� �� ������� �������� ������ �� ������� �����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K044', '���� ���������� ����������� ������ �������� 30 ��� �� ������������� �������������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K046', '���� ���������� ����������� ������ �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� ������������ �������� �������� (���)', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K047', '���� ���������� ����������� ������ �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� �� ������������ �������� �������� (���)', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K048', '���� ����������� ������������� �� ��������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K066', '����� ����� � �����������, �� � ������������� �� ��������� �������������� ������������� ����� ������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K005', '����� �������� ��� �� ������', '1', 'A6K002', NULL, 
    NULL, 20, 20, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K006', '��������� ������� �� ������� �������� ���', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K007', '����� ���''���� ������������ �������� �� ������', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K008', '����� � ����������� ����� �����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K009', '��������� ������� �� ������� �����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K010', '������ ������� ���������  �������', '1', 'A6K002', NULL, 
    NULL, 100, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K011', '��������� ������� �� ������� ���������  �������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K012', '����� �������� ����� �� ����� �����������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K013', '����� �� ������ ������������ ���������� �������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K014', '��������� ������� �� ������� ������������ ���������� �������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K015', '����� ������������� ����� ������ �� ������ ', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K016', '��������� ������� �� ������� ������������� ����� ������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K017', '��������� ������� �� ��������� �� ���������� ����� �������� �� ����� ����������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K018', '��������� ������� �� ������� �������� �������� �����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K019', '��������� ������� �� �������������� ������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K020', '���������� �����''������ � ������������, �� ����� ������', '1', 'A6K002', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K021', '³����� �� ����������� �� ����������� ���������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K023', '��������� ������� �� ������� ���''���� ������������ ��������', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K027', '��������� ������� �� ��������� ������������� ����� ������ �� ������� ���������� �� ���������� ����', '1', 'A6K002', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K049', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �������� ��� �� ������ �������', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K050', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ��������� �������� ���', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K051', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ������� (�������) �������� ���', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K052', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �������� ���, �� ����� �� ����������� ���������', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K053', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� �������� ���', '1', 'A6K003', NULL, 
    NULL, 50, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K054', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ���''����� ������������ �������� � ������� ��������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K055', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ��������� ���''����� ������������ ��������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K056', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ������� (�������) ���''����� ������������ ��������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K057', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ���������� �� ���''������ ������������ ��������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K058', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ���''����� ������������ ��������, �� ����� �� ����������� ���������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K059', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� ���''����� ������������ ��������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K060', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ������� �������� ����� �� �������� ��������������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K061', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ��������� ������� �������� ����� �� �������� ��������������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K062', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� ������� �������� ����� �� �������� ��������������', '1', 'A6K003', NULL, 
    NULL, 50, 50, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K063', '���� �� ���������� � ������������� ����� ������, ��� �� �������� �� ������������ ������� ������, �� ��������� ������ �� ����', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K064', '���� �� ������ ���������, ��� �� �������� �� ������������ ������� ������ (���)', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K065', '���� ��������������� ������� �� �������� ������, ��� �� �������� �� ������������ ������� ������ (���)', '1', 'A6K003', 0, 
    NULL, -100, -100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K067', '���� ���������� ����������� ���������� �������� 30 ��� �� �������� (����������) � ����� ������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K068', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �� ���������� ������� (�������) ������� ����� ������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K069', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� (����������), �� ����� (�������) �� ������ ��������������� ����� ', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K070', '���� ������������� ������� ������������ ��������� ��� ��� ���������� ��������, �������� ������������ ������', '1', 'A6K003', NULL, 
    NULL, 40, 40, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K071', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ������� � ����� ������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K072', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ������� ��������, �� �� ������� �� ������������ ������� ������ (���), �� ������������ �������� �� ����', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K073', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ����������� ���� ��� �������� ����� ��������/������������� �� ������������ �������� �� ���� ', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K074', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ����������� ���� � ��������� ����� ��������/�������������, ������������� �� ������������� �������� ��������, �� ������������ �������� �� ���� ', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K075', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ����������� ���� � ��������� ����� ��������/�������������, ������������� ������������� �������� ��������, �� ������������ �������� �� ����', '1', 'A6K003', NULL, 
    NULL, NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K076', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� � ������������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K077', '���� ���������� ����������� ���������� �������� 30 ��� �� ����������� ������������� � ��������� �� ������� �������� ������ �� ������� �����', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, '2');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K078', '���� ���������� ����������� ���������� �������� 30 ��� �� ����������� ������������� �� ���������� � ������� �� �볺�����', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('B6K022', '����������� �� ����������� � ����������� ���������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K080', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� ���������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K081', '�������� ������������������� �������� ����������� �������� �������� (LCR) �� ���� �������� (LCR��)', '0', NULL, 0, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K082', '�������� ������������������� �������� ����������� �������� �������� (LCR) � �������� ����� (LCR��)', '0', NULL, 0, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K083', '��������� ����� ������������ ������� ������ � �������� �����', '0', 'A6K006', NULL, 
    NULL, NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K084', '������ �������� ������� �������� ����� � �������� �����', '0', 'A6K007', NULL, 
    NULL, NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K085', '������ �������� ����������� �������� ����� � �������� �����', '0', 'A6K008', NULL, 
    NULL, NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K086', '������ ���������� ������ �������� ����� � �������� �����', '0', NULL, NULL, 
    'A6K084 - LEAST(A6K085, 0.75 * A6K084)', NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K087', '���������� �������� �������� (LCR) � �������� ����� (LCR��)', '0', NULL, NULL, 
    'AE6083/AE6086', NULL, NULL, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K088', '����� ����� � ����������� (��� ���, �� � ������������� �� ��������� �������������� ������������� ����� ������)', '1', NULL, 0, 
    NULL, 100, 100, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K089', '����� � �������� ����� �� ����������������� �������� � ������, �� ������������ LCR�� �� LCR�� �� �� ������� �� ������� �����������������', '1', NULL, 0, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K090', '��� ��������������� ������� � �������� ����� �� �������� ������ � ������, �� ������������ LCR�� �� LCR�� �� �� ������� �� ������� �����������������', '1', NULL, 0, 
    NULL, 100, 100, NULL, '0');
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K045', '���� ���������� ����������� ������ �������� 30 ��� �� ���������, �� ������� �� ������������� ����� ������', '1', 'A6K002', NULL, 
    NULL, 0, 0, NULL, NULL);
Insert into BARS.NBUR_DCT_F6KX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980, INCL_980)
 Values
   ('A6K079', '������ ��������� �������, �� ����� ���� �������� ����������� ��� �� ����������', '1', 'A6K003', NULL, 
    NULL, 100, 100, NULL, NULL);
COMMIT;
