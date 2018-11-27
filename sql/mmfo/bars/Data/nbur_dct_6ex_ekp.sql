SET DEFINE OFF;

exec bc.home;

delete from NBUR_DCT_F6EX_EKP;

Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E001', '��������� ����� ������������ ������� ������ (���)', '1', 'A6E006', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E002', '������ �������� ������ �������� �����', '1', 'A6E007', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E003', '������ �������� ����������� �������� �����', '1', 'A6E008', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E004', '������ ���������� ���� �������� �����', '1', NULL, NULL, 
    'A6E002 - LEAST(A6E003, 0.75 * A6E002)', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E005', '���������� �������� ��������', '1', NULL, NULL, 
    'AE6001/AE6004', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E006', '��������� ����� ������������ ������� ������ (���) ', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E007', '������ �������� ������ �������� �����', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E008', '������ �������� ����������� �������� �����', '0', NULL, NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E009', '������ ���������� ���� �������� �����', '0', NULL, NULL, 
    'A6E007 - LEAST(A6E008, 0.75 * A6E007)', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E010', '���������� �������� �������� (LCR)', '0', NULL, NULL, 
    'AE6006/AE6009', NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E011', '���� �� ���������� ��������� �������� ������ (����) � ������� ��������� ����� 30 ���', '1', 'A6E001', NULL, 
    NULL, 100, 100, '1');
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E012', '���� �� ���������� ��������� �������� ������ (����) � ������� ��������� �� 30 ���', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E013', '���� �� ���������� �������� �������� ������ (����) � ������� ��������� �� 30 ���', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E014', '���� �� ���������� �������� �������� ������ (����) � ������� ��������� ����� 30 ��� ', '1', 'A6E001', NULL, 
    NULL, 85, 85, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E015', '���� �� ��������� ������� �������� ���������� ���������� ����������/��������� ������ ���� G-7 � ���������� �������� ������� ����������� ������� �� ����� "��-"/"��3"', '1', 'A6E001', 0, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E016', '����� �� ����������������� �������� � ������ � ��������� �� ����� �������������� �����', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E017', '���� ��������������� ������� �� �������� ������ � ������ � ��������� �� ����� �������������� �����', '1', 'A6E001', 0, 
    NULL, -100, -100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E001', '�������� �� ������', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E002', '������� �� ���������� �������, �������� ���� � �������������� ', '1', 'A6E001', NULL, 
    NULL, -100, -100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E003', '����� �� ������������������ ������� � ������������� ����� ������', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E024', '���� �� ��������� ������� ��������, ���������� ����������� ������� ��������', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E025', '���� �� ����������� ������������� ������������� ����� ������', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E026', '���� �� ���������� � ������������� ����� ������ �� 1 ��� ', '1', 'A6E001', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E018', '���� ��������� ������ �������� ���, �� ����� � ������� ��������, �� ������ ���� �������� �������� 30 ���', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E019', '���� ��������� ������ �������� ���, �� �� ���� ��������� ��������� �� ������������� �������� 30 ���', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E020', '���� ��������� ������ �������� ���, �� ����� �������� ������������ ��� �� ����������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E021', '���� ����� ��������� ������ �������� ���, �� ����� � ������� ��������, ������ ���� �������� �������� 30 ���', '1', 'A6E002', NULL, 
    NULL, 10, 10, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E022', '���� ��������� ������ ���''���� ������������ �������� (���), �� ����� � ������� ��������, �� ������ ���� �������� �������� 30 ���', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E023', '���� ��������� ������ ���''���� ������������ �������� (���) �� �� ���� ��������� ��������� �� ������������� �������� 30 ���', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E024', '���� ��������� ������ ���''���� ������������ �������� (���) �� ����� �������� ������������ ��� �� ���������� ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E025', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� �������� ���''���� ������������ �������� (���)', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E026', '���� �� ���� ���������, �� �� ������� �� ���������� ������������ ������� ������ (���)', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E027', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ���������� ����� ����� �� �� ���������� ���������, �� ������� �� ����� �����', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E028', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ������� ��������� �������', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E029', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ������� ������������ ���������� �������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E030', '������ ������������ ���������� ������� �� ����� ���� �������� ������������ ��� �� ����������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E031', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� ����� ������������� ����� ������ ', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E032', '���� ���������� ����������� ������ �������� 30 ��� �� ��������� �� ���������� ����� ��������', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E033', '���� ���������� ����������� ������ �������� 30 ��� ��������� �� ����� ���������� ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E034', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� �������� (�����������) ������������� � ������� �� 30 ���', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E035', '���� ���������� ����������� ������ �������� 30 ��� �� ������ ������� �������� �������� �����', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E036', '���� ���������� ����������� ������ �������� 30 ��� �� �������������� ������ ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E037', '���� �� ������������� �����''�������� � ������������, �� �����  �������� ������', '1', 'A6E002', NULL, 
    NULL, 5, 5, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E038', '���� �� ������������� �����''�������� � ������������, �� ����� ���''����� ������������ ��������, ������� �������� �����, ������� �������� �������������� �� ���������� ���������� ����������� ', '1', 'A6E002', NULL, 
    NULL, 10, 10, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E039', '���� �� ������������� �����''�������� � ������������, �� ����� ����� ���������� ���������', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E040', '���� ���������� ����������� ������ �������� 30 ��� �� ����������, ���''������� � �������� ������������� (����������, ������)', '1', 'A6E002', NULL, 
    NULL, 30, 30, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E041', '���� ���������� ����������� ������ �������� 30 ��� �� ������ ����������� �� ��������������� �����''��������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E042', '���� ���������� ����������� ������ �������� 30 ��� �� ���������� � ������������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E043', '���� ���������� ����������� ������ �������� 30 ��� �� ������������� ������������� � ��������� �� ������� �������� ������ �� ������� �����', '1', 'A6E007', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E044', '���� ���������� ����������� ������ �������� 30 ��� �� ������������� �������������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E045', '���� ���������� ����������� ������ �������� 30 ��� �� ���������, �� ������� �� ������������� ����� ������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E046', '���� ���������� ����������� ������ �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� ������������ �������� �������� (���)', '1', 'A6E002', NULL, 
    NULL, 0, 0, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E047', '���� ���������� ����������� ������ �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� �� ������������ �������� �������� (���)', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E048', '���� ����������� ������������� �� ��������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E066', '����� ����� � �����������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E005', '����� �������� ��� �� ������', '1', 'A6E002', NULL, 
    NULL, 20, 20, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E006', '��������� ������� �� �������� �������� ���', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E007', '����� ���''���� ������������ �������� �� ������', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E008', '����� � ����������� ����� �����', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E009', '��������� ������� �� ������� �����', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E010', '������ ������� ���������  �������', '1', 'A6E002', NULL, 
    NULL, 100, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E011', '��������� ������� �� ��������� ���������  ������� ', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E012', '����� �������� ����� �� ����� �����������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E013', '����� �� ������ ������������ ���������� �������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E014', '��������� ������� �� ������� ������������ ���������� �������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E015', '����� ������������� ����� ������ �� ������ ', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E016', '��������� ������� �� ������� ������������� ����� ������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E017', '��������� ������� �� ��������� �� ���������� ����� �������� �� ����� ������������ ����������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E018', '��������� ������� �� ������� �������� �������� �����', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E019', '��������� ������� �� �������������� ������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E020', '���������� �����''������ � ������������, �� ����� ������', '1', 'A6E002', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E021', '³����� �� ����������� �� ����������� ���������', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E023', '���� �� ������������ ��������� �� �������� ���''���� ������������ �������� (���)', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E027', '���� ����������� ������ �� ��������� ������������� ����� �� ������� ���������� �� ���������� ����', '1', 'A6E002', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E049', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �������� ��� �� ������ �������', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E050', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ��������� �������� ���', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E051', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ������� (������) �������� ���', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E052', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �������� ���, �� ����� �� ����������� ���������', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E053', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� �������� ���', '1', 'A6E003', NULL, 
    NULL, 50, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E054', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ���''����� ������������ �������� � ������� ��������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E055', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ��������� ���''����� ������������ ��������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E056', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ������� (������) ���''����� ������������ ��������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E057', '���� ���������� ����������� ���������� �������� 30 ��� �� �������������� ���������� �� ���''������ ������������ ��������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E058', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ���''����� ������������ ��������, �� ����� �� ����������� ���������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E059', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� ���''����� ������������ ��������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E060', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ������� �������� ����� �� �������� ��������������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E061', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ��������� ������� �������� ����� �� �������� ��������������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E062', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ��������� ������� �������� ����� �� �������� ��������������', '1', 'A6E003', NULL, 
    NULL, 50, 50, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E063', '���� �� ���������� � ������������� ����� ������, �� �� ������� �� ������������ ������� ������ (���), �� ��������� ������ �� ����', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E064', '���� �� ������ ���������, ��� �� �������� �� ������������ ������� ������ (���)', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E065', '���� ��������������� ������� �� �������� ������, ��� �� �������� �� ������������ ������� ������ (���)', '1', 'A6E003', 0, 
    NULL, -100, -100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E067', '���� ���������� ����������� ���������� �������� 30 ��� �� �������� (����������) � ����� ������', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E068', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �� ���������� ������� ������� ����� ������', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E069', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� �� ����������, �� ����� (�������) �� ������ ��������������� ����� ', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E070', '���� ������������� ������� ������������ ��������� ��� ��� ���������� ��������, �������� ������������ ������', '1', 'A6E003', NULL, 
    NULL, 40, 40, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E071', '���� ���������� ����������� ���������� �������� 30 ��� �� ������������ �������� �� ������� � ����� ������', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E072', '���� ���������� ����������� ���������� �������� 30 ��� �� ��������� ������� ��������, �� �� ������� �� ������������ ������� ������ (���), �� ������������ �������� �� ����', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E073', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ����������� ���� ��� �������� ����� ��������/������������� �� ������������ �������� �� ���� ', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E074', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ����������� ���� � ��������� ����� ��������/�������������, ������������� �� ������������� �������� ��������, �� ������������ �������� �� ���� ', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E075', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� ����������� ���� � ��������� ����� ��������/�������������, ������������� ������������� �������� ��������, �� ������������ �������� �� ����', '1', 'A6E003', NULL, 
    NULL, NULL, NULL, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E076', '���� ���������� ����������� ���������� �������� 30 ��� �� ���������� � ������������', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E077', '���� ���������� ����������� ���������� �������� 30 ��� �� ����������� ������������� � ��������� �� ������� �������� ������ �� ������� �����', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E078', '���� ���������� ����������� ���������� �������� 30 ��� �� ����������� ������������� �� ���������� � ������� �� �볺�����', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('B6E022', '����������� �� ����������� � ����������� ���������', '1', 'A6E003', NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E080', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� �������� ��� �� ������ ������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E081', '�������� ���� �������� �� ������� ���������� ��������� �������� ��� �� ������ �������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E082', '�������� ���� �������� �� ������� ����������  ��������� �������� ��� �� ������ �������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E083', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� �������� ��� �� ������ ������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E084', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ��������� �������� ��� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E085', '�������� ���� �������� �� ������� ���������� ���������� ��������� �������� ���, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E086', '�������� ���� �������� �� ������� ���������� ���������� ��������� �������� ���, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E087', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ��������� �������� ��� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E088', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ������� (������) �������� ��� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E089', '�������� ���� �������� �� ������� ��������� ���������� ������� (������) �������� ���, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E090', '�������� ���� �������� �� ������� ��������� ���������� ������� (������) �������� ���, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E091', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ������� (������) �������� ��� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E092', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� �������� ���, �� ����� �� ����������� ���������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E093', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ������������ �������� �� ��������� �������� ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E094', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� ���''����� ������������ �������� � ������� ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E095', '�������� ���� �������� �� ������� ���������� ��������� ���''����� ������������ �������� � ������� ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E096', '�������� ���� �������� �� ������� ���������� ��������� ���''����� ������������ �������� � ������� ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E097', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� ���''����� ������������ �������� � ������� ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E098', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ��������� ���''����� ������������ �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E099', '�������� ���� �������� �� ������� ����������  ���������� ���������  ���''����� ������������ ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E100', '�������� ���� �������� �� ������� ����������  ���������� ��������� ���''����� ������������ ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E101', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ��������� ���''����� ������������ �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E102', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ������� (������) ���''����� ������������ �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E103', '�������� ���� �������� �� ������� ��������� ���������� ������� (������) ���''����� ������������ ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E104', '�������� ���� �������� �� ������� ��������� ���������� ������� (������) ���''����� ������������ ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E105', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� �������(������) ���''����� ������������ �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E106', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� ���''����� ������������ ��������, �� ����� �� ����������� ���������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E107', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ������������ �������� �� ��������� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E108', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� �������������� ���������� �� ���''����� ������������ �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E109', '�������� ���� �������� �������� ���������� �� �������������� ���������� �� ���''����� ������������ ��������, �� ����������� �������� 30 ��� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E110', '�������� ���� �������� �������� ���������� �� �������������� ���������� �� ���''����� ������������ ��������, �� ����������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E111', '���� ��������� ����� ����������� ���������� �������� ����� �������� 30 ��� �� �������������� ����������  �� ���''����� ������������ �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E112', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ������������ �������� �� ��������� ������ �������� ����� �� ��������������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E113', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� ������ �������� ����� �� ������ �������� ��������������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E114', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ���������� ��������� ������ �������� ����� �� ������ �������� ��������������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E115', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ��������� �� ����������� �������, ������� ����� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E116', '���� ��������� ����������� ���������� �������� ����� �������� 30 �� �� ��������� �� ����������, �� ����� (�������) �� ������ ��������������� ����� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E117', '���� ��������� ����������� ���������� �������� ����� �������� 30 ��� �� ������������ �������� � ����� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E118', '���� ��������� ����������� ����������, �� �����������, �������� 30 ��� �� ��������� ������� ��������, �� �� ������� �� ������������ ������� ������ (���), �� ������������ �������� �� ����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E119', '���� ��������� ����������� ����������, �� ����������� �������� 30 ��� �� ���������� � ������������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E120', '���� ��������� ����������� ����������, �� ����������� �������� 30 ���, �� ����������� ������������� � ��������� �� ������� �������� ������ �� ������� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E121', '���� ��������� ����������� ����������, �� ����������� �������� 30 ���, �� ����������� ������������� �� ���������� � ������� �� �볺�����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E122', '���� ��������� ����������� ����������, �� ����������� �������� 30 ���, �� ���������� ����������� ���� ��� �������� ����� ��������/������������� �� ������������ �������� �� ���� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E123', '���� ��������� ����������� ����������, �� ����������� �������� 30 ���, �� ���������� ����������� ���� � ��������� ����� ��������/�������������, ������������� �� ������������� �������� ��������, �� ������������ �������� �� ���� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E124', '���� ��������� ����������� ����������, �� ����������� �������� 30 ���, �� ���������� ����������� ���� � ��������� ����� ��������/�������������, ������������� ������������� �������� ��������, �� ������������ �������� �� ���� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E125', '���� ��������� ������ �� ��������� ��������� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E126', '���� ������������ �����''����� ����� �� ��������� ��������� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E127', '���� ��������� �����''����� ����� �� ��������� ��������� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E128', '���� ��������� ������ �� ��������� ��������� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E129', '���� ������������ �����''����� ����� �� ��������� ��������� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E130', '���� ��������� �����''����� ����� �� ��������� ��������� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E131', '���� ��������� ������ �� ��������� ��������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E132', '���� ������������  �����''����� ����� �� ��������� ��������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E133', '���� ���������  �����''����� ����� �� ��������� ��������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E134', '���� ��������� ������ �� ���������� ����� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E135', '���� ������������ �����''����� ����� �� ���������� ����� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E136', '���� ��������� �����''����� ����� �� ���������� ����� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E137', '���� ��������� ������ �� ���������� ����� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E138', '���� ������������ �����''����� ����� �� ���������� ����� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E139', '���� ��������� �����''����� ����� �� ���������� ����� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E140', '���� ��������� ������ �� ���������� ����� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E141', '���� ��������� �����''����� ����� �� ���������� ����� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E142', '���� ������������ �����''����� ����� �� ���������� ����� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E143', '���� ��������� ������ �� ���������-������ �������� ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E144', '���� ������� �� ���������-������ �������� ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E145', '���� ��������� ������ �� ���������-������ ���''���� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E146', '���� ������� �� ���������-������ ���''���� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E147', '���� ��������� ������ �� ��������� - ������ �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E148', '���� ������� �� ���������-������ �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E149', '���� ��������� ���������� �� ��������� ��������� �������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E150', '���� ��������� ���������� �� ��������� ��������� ���''����� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E151', '���� ��������� ���������� �� ��������� ��������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E152', '���� ��������� �������� ������ �������� 30 ��� �� ���������� �������� �������� ���, �� ���� �������� ����� � ��������� ������������ ��� �� ����������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E153', '���� ��������� �������� ������ �������� 30 ��� �� ���������� �������� �������� ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E154', '���� ������������� �� �������� ���������� ��������/��������� ��  ���������� �������� �������� ���, �� ����� � ������� �������� ���� ����  �������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E155', '���� �� ������ ����������/����������� �� ���������� �������� �������� ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E156', '���� ��������� �������� ������ �������� 30 ��� �� �� ���������� �������� ���''���� ������������ ��������, �� ���� �������� ����� � ��������� ������������ ��� �� ����������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E157', '���� ��������� �������� ������ �������� 30 ��� �� ���������� �������� ���''���� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E158', '���� ������������� �� �������� ���������� ��������/��������� ��  ���������� �������� ���''���� ������������ ��������, �� ����� � ������� ��������, ���� ����  �������� �������� 30 ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E159', '���� �� ������ ����������/����������� �� ���������� �������� ���''���� ������������ ��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E160', '���� ��������� �������� ������ �������� 30 ��� �� ���������� ���������� ����� ����� �� �� ���������� ���������, �� ������� �� ����� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E161', '���� ��������� �������� ������ �������� 30 ��� �� �������� ��������� �������, �� ���� �������� ����� � ��������� ������������ ��� �� ����������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E162', '���� ��������� �������� ������ �������� 30 ��� �� ���������� ������� ��������� ������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E163', '���� ��������� �������� ������ �������� 30 ��� �� ���������� ������� ������������ ���������� �������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E164', '���� ��������� �������� ������ �������� 30 ��� �� �������� ������������ ���������� �������, �� ���� �������� �������� �� ���������� ����������� ��� �� ���������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E165', '���� ��������� �������� ������ �������� 30 ��� �� ��������� �� ���������� ����� �������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E166', '���� ��������� �������� ������ �������� 30 ��� �� ��������� �� ����� ����������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E167', '���� ��������� �������� ������ �������� 30 ��� �� ���������� �������� (�����������) ������������� � ������� �� 30 ��� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E168', '���� ��������� �������� ������ �������� 30 ��� �� ������ ������� �������� �������� ����� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E169', '���� ��������� �������� ������ �������� 30 ��� �� �������������� ������ ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E170', '���� ��������� �������� ������ �� ������������� �����''�������� � ������������, �� ����� ����� ���������� ���������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E171', '���� ��������� �������� ������ �������� 30 ��� �� ����������, ���''������� � �������� ������������� (����������, ������)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E172', '���� ��������� �������� ������ �������� 30 ��� �� ������ ����������� �� ��������������� �����''��������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E173', '���� ��������� �������� ������ �������� 30 ��� �� ���������� � ������������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E174', '���� ��������� �������� ������ �������� 30 ��� �� ������������� ������������� � ��������� �� ������� �������� ������ �� ������� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E175', '���� ��������� �������� ������ �������� 30 ��� �� ������������� �������������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E176', '���� ��������� �������� ������ �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� ������������ �������� �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E177', '���� ������������� �� �������� ���������� ��������/��������� �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� ������������ �������� �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E178', '���� �� ������ ����������/����������� �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� ������������ �������� �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E179', '���� ��������� �������� ������ �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� �� ������������ �������� �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E180', '���� ������������� ��������/��������� �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� �� ������������ �������� �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E181', '���� ����� ��������/��������� �������� 30 ��� �� �������, �� ������� �� ���������� ���� �� ���������� �� ������������ �������� �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E182', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ���   �� �������� �������� ���', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E183', '���� ��������� �������� ������ �������� 30 ��� �� �������� ��������� ����� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E184', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ���  �� ������� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E185', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ���   �� ��������� ���������  ������� ', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E186', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ��� �� ������� ������������ ���������� �������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E187', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ��� �� ��������� �� ���������� ����� �������� �� ����� ������������ ����������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E188', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ���   �� ������� �������� �������� �����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E189', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ��� �� �������������� ������', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E190', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ��� �� �������� ���''���� ������������ �������� (���)', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
Insert into BARS.NBUR_DCT_F6EX_EKP
   (EKP, EKP_NAME, GRP_R030, AGGR_EKP, CONSTANT_VALUE, 
    FORMULA, LCY_PCT, FCY_PCT, R030_980)
 Values
   ('A6E191', '���� ��������� �������� ������ �� ������������ ��������� �������� 30 ��� �� ��������� ������������� ����� �� ������� ���������� �� ���������� ����', '1', NULL, NULL, 
    NULL, 100, 100, NULL);
COMMIT;
