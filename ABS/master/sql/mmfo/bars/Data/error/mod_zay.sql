PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ZAY.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ ZAY ***
declare
  l_mod  varchar2(3) := 'ZAY';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ��������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�� ������� �������� %s', '', 1, 'TT_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�� �������� �������� %s', '', 1, 'TT_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�� ������ ���������� ���� �����-����� (2900)', '', 1, 'ACC29_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�� �������� ���������� ������� �����-����� (2900)', '', 1, 'ACC29_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������ ���������� ���� ���-����� (1819)', '', 1, 'ACC18_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� �������� ���������� ������� ���-����� (1819)', '', 1, 'ACC18_NOT_FOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '���� %s / %s �� ���������� ��� ������', '', 1, 'ACC_DOESNT_EXIST');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������� %s / %s �� ���� ��� ��������', '', 1, 'ACC_DOESNT_EXIST');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������� �����.����� 2900/1819', '', 1, 'TRANSIT_ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� ������� �����.���. 2900/1819', '', 1, 'TRANSIT_ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ������� ������ � %s', '', 1, 'ZAY_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� �������� ������ � %s', '', 1, 'ZAY_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '��������� ������������ ������ ���������� �� ������ � %s(������ ������ %s)', '', 1, 'INVALID_STATUS');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '���������� ���������� ������ ��������� �� ������ � %s (������ ������ %s)', '', 1, 'INVALID_STATUS');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '��������� ������������ ������ ���������� �� ���������� ������ � %s(���� �������.%s)', '', 1, 'INVALID_VALUEDATE');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '���������� ���������� ������ ��������� �� ��������� ������ � %s(���� �������.%s)', '', 1, 'INVALID_VALUEDATE');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '�� ������� ������ � ����� %s', '', 1, 'CUR_NOT_FOUND');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '�� �������� ������ � ����� %s', '', 1, 'CUR_NOT_FOUND');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ������ ���������������� ���� �� �������� �������� %s � ������ %s', '', 1, 'TTSACC_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '�� ��������� �������������.������� � ������ �������� %s � ����� %s', '', 1, 'TTSACC_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '��� ������ � %s �� ������ �������� ���� ������� � ������ %s (acc = %s)', '', 1, 'CUST_TRDACC_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '��� ������ � %s �� ��������� �������� ������� �볺��� � ����� %s (acc = %s)', '', 1, 'CUST_TRDACC_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '��� ������ � %s �� ������ ��������� ���� ������� � ������ %s (acc = %s)', '', 1, 'CUST_CURTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '��� ������ � %s �� ��������� ���������.������� �볺��� � ����� %s (acc = %s)', '', 1, 'CUST_CURTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '��� ������ � %s �� ������ �����.���� ������� %s � ���. ���. ��� ���������� � ����.����', '', 1, 'CUST_TAXTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '��� ������ � %s �� ��������� �����.������� �볺��� %s � ���.���.��� ����������� � ����.����', '', 1, 'CUST_TAXTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '��� ������ � %s �� ������ ���� ������� ��� �������� �������� (nls = %s)', '', 1, 'CUST_CMSTACC_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '��� ������ � %s �� ��������� ������� �볺��� ��� �������� ���� (nls = %s)', '', 1, 'CUST_CMSTACC_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '������ ������ ��������� (����� %s ������ %s �� ����� %s/%s, ��� �������� %s): %s', '', 1, 'PAYDOC_FAILED');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '������� ������ ��������� (����� %s ������ %s �� ���� %s/%s, ��� �������� %s): %s', '', 1, 'PAYDOC_FAILED');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '������ ������ ���.��������� %s ��� ��������� %s: %s', '', 1, 'INS_DOCPARAM_FAILED');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '������� ������ ���.�������� %s ��� ��������� %s: %s', '', 1, 'INS_DOCPARAM_FAILED');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '������ ������������ ������ ���������� ��� ������ �� ������� ������ � %s: %s', '', 1, 'PAYBUY_FAILED');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '������� ���������� ������ ��������� ��� ������ �� ������ ������ � %s: %s', '', 1, 'PAYBUY_FAILED');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '������ ������������ ������ ���������� ��� ������ �� ������� ������ � %s: %s', '', 1, 'PAYSEL_FAILED');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '������� ���������� ������ ��������� ��� ������ �� ������� ������ � %s: %s', '', 1, 'PAYSEL_FAILED');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '������ ��� �������� ������: %s', '', 1, 'CREATE_REQUEST_FAILED');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '������� ��� �������� ������: %s', '', 1, 'CREATE_REQUEST_FAILED');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '������ %s ������������� �������', '', 1, 'KV_BLOCKED');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '������ %s ����������� �������', '', 1, 'KV_BLOCKED');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ������� ����� ������ %s', '', 1, 'SUM_NULL');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '�� ������� ���� ������ %s', '', 1, 'SUM_NULL');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������� ���� ������ %s', '', 1, 'DAT_NULL');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�� ������� ���� ������ %s', '', 1, 'DAT_NULL');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '�� ������ ���� ������ %s', '', 1, 'RATE_NULL');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '�� �������� ���� ������ %s', '', 1, 'RATE_NULL');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '������ ���� �� ���������� � ����� ������ %s', '', 1, 'SUM_NOT_S2');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '������ %s ���������. ���� ��������� ���������!', '', 1, 'UPD_FAILED_VIZA');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '�� ��������� �������� ������� %s �볺��� � ������ �����!', '', 1, 'UPD_FAILED_TR');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '�� ��������� ������������� ������� %s �볺��� � ����� %s!', '', 1, 'UPD_FAILED_RR');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '���� ������ %s ��������!', '', 1, 'CREATE_REQUEST_OLDDAT');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '������� ������� %s ��� ��� %s', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '�� ���������� ������� �볺��� %s', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '�� ������� ������� �������� ��� ���� ��� �������� %s', '', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '�� ������� ���� ������ %s', '', 1, 'META_NULL');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '�� ������� ���� ������ %s', '', 1, 'META_NULL');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '�� ������� ��������� ������� ������ %s', '', 1, 'BASIS_NULL');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '�� ������� ������� ����� ������ %s', '', 1, 'BASIS_NULL');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '�� ������� ��� �������� ������ ������ %s', '', 1, 'PROD_NULL');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '�� ������� ��� ������� ����� ������ %s', '', 1, 'PROD_NULL');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '��� ������ � %s �� ������ ���� 3570 �������', '', 1, 'CUST_3570ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '��� ������ � %s �� ��������� ������� 3570 �볺���', '', 1, 'CUST_3570ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '��� ������ � %s �� ������ ���� 3570 ������� ��� �/� %s(%s)', '', 1, 'CUST_3570ACC_NOT_REGISTERED');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '��� ������ � %s �� �������� ������� 3570 �볺��� ��� �/� %s(%s)', '', 1, 'CUST_3570ACC_NOT_REGISTERED');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '��� ������ � %s ����������� ������ ���� 3570 ������� ��� �/� %s(%s)', '', 1, 'CUST_3570ACC_ERR_REGISTERED');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '��� ������ � %s ���������� �������� ������� 3570 �볺��� ��� �/� %s(%s)', '', 1, 'CUST_3570ACC_ERR_REGISTERED');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '��� ������ � %s �� ������ ���� 3578 �������', '', 1, 'CUST_3578ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '��� ������ � %s �� ��������� ������� 3578 �볺���', '', 1, 'CUST_3578ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '��� ������ � %s �� ������ ���������� ���� 3578 �������', '', 1, 'CUST_3578ACC_ONE_NOT_FOUND');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '��� ������ � %s �� ��������� ������ ������� 3578 �볺���', '', 1, 'CUST_3578ACC_ONE_NOT_FOUND');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '������ ������� � ������� ������ �� ��������� %s ���������!', '', 1, 'CURVAL_IDENT');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '������ ����� �� ������� ������ �� �������� %s ����������!', '', 1, 'CURVAL_IDENT');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '��� ������ � %s �� ������ ����������� � ���������� ���� ������� ��� �������� � �� (nls = %s)', '', 1, 'CUST_PFACC_NOT_FOUND');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '��� ������ � %s �� ��������� ���������� � ���������� ������� �볺��� ��� �������� � �� (nls = %s)', '', 1, 'CUST_PFACC_NOT_FOUND');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '��������� ������������ ��������� �������� �� ������ � %s', '', 1, 'INVALID_STATUS_SPS');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '���������� ���������� ��������� �������� �� ������ � %s', '', 1, 'INVALID_STATUS_SPS');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '������������ �������� ���� ����� �� �������� (#2C) %s ��� ������ %s', '', 1, 'ERROR_CODE_2C');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '������������ �������� ���� ����� �� �������� (#2C) %s ��� ������ %s', '', 1, 'ERROR_CODE_2C');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '��������! � ������� ��������� �������! (������ %s)', '', 1, 'KL_SANCTION');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '�����! �� �볺��� ����������� �������! (������ %s)', '', 1, 'KL_SANCTION');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '����������� �������������� ��������� � �����!', '', 1, 'ERROR_SUP_DOCS');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '³����� ������������ ��������� � �����!', '', 1, 'ERROR_SUP_DOCS');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '�� ������ � ��������� ������ %s', '', 1, 'CONTRACT_NULL');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '�� ������� � ��������� ������ %s', '', 1, 'CONTRACT_NULL');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '�� ������� ���� ��������� ������ %s', '', 1, 'DAT2_VMD_NULL');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '�� ������� ���� ��������� ������ %s', '', 1, 'DAT2_VMD_NULL');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '�� ������� ������ ������������ ������ ������ %s', '', 1, 'COUNTRY_NULL');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '�� ������� ������� ������������� ������ ������ %s', '', 1, 'COUNTRY_NULL');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '�� ������� ������ ����������� ������ %s', '', 1, 'BENEFCOUNTRY_NULL');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '�� ������� ������� ����������� ������ %s', '', 1, 'BENEFCOUNTRY_NULL');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '�� ������ ��� ������������ ����� ������ %s', '', 1, 'BANK_CODE_NULL');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '�� ������� ��� ���������� ����� ������ %s', '', 1, 'BANK_CODE_NULL');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '�� ������� ������������ ������������ ����� ������ %s', '', 1, 'BANK_NAME_NULL');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '�� ������� ����� ���������� ����� ������ %s', '', 1, 'BANK_NAME_NULL');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� ������ ��� ������� �� �������� #2C ������ %s', '', 1, 'CODE_2C_NULL');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� ������� ��� ����� �� �������� #2C ������ %s', '', 1, 'CODE_2C_NULL');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '�� ������� ������ �������� #2C ������ %s', '', 1, 'P12_2C_NULL');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '�� ������� ������ �������� #2C ������ %s', '', 1, 'P12_2C_NULL');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '��������� ������������� ������ � ��!', '', 1, 'FAILED_SET_SOS');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '���������� ������������ ������ � ��!', '', 1, 'FAILED_SET_SOS');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '�� �������� ����������� ���� ������ ��� ���� ������������� ������ %s', '', 1, 'FAILED_KURSF_OR_VDATE');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '�� ������� ��������� ���� ������ ��� ���� ����������� ������ %s', '', 1, 'FAILED_KURSF_OR_VDATE');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '������ �������������� ������ �������, ������ %s ���������� ������������!', '', 1, 'PRIORVERIFY_FAILED');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '������� ������������ ������ �������, ������ %s ��������� ���������!', '', 1, 'PRIORVERIFY_FAILED');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '�������� ���� - D1#70 ������ ��������������� ���� �� ����������� ����� �������-������� ������', '', 1, 'FK_ZAYAVKA_ZAYAIMS');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�������� ���� - D1#70 ������� ��������� ���� �� �������� ����� �������-������� ������', '', 1, 'FK_ZAYAVKA_ZAYAIMS');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '�������� ����� - D6#70/D8#70 ������ ��������������� ���� �� ����������� �����-��������� �����', '', 1, 'XFK_ZAYAVKA_COUNTRY');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '�������� ���� - D6#70/D8#70 ������� ��������� ���� �� �������� ����-������� ������', '', 1, 'XFK_ZAYAVKA_COUNTRY');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '�������� ���� - DB#70 ������ ��������������� ���� �� ����������� ����� �������� �����', '', 1, 'FK_ZAYAVKA_PRODUCT_GROUP');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '�������� ���� - DB#70 ������� ��������� ���� �� �������� ���� �������� ����', '', 1, 'FK_ZAYAVKA_PRODUCT_GROUP');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '������ � %s �� ������������ �������. �������� ������� ����������!','');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '������ � %s �� ��������� ������. �������� ����� ���������!','');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '�� ������ � %s �������� ������� ����������� (�������� REF=%s). ��������� �������� ������� ���������!','');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '�� ������ � %s �������� ����� �������� (�������� REF=%s). �������� �������� ����� ����������!','');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '%s %s - ���������� ���� !', '', 1 );
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '%s %s - ���������� ���� ! ', '', 1);   

    bars_error.add_message(l_mod, 66, l_exc, l_rus, '%s %s - ���������� ���� !', '', 1 );
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '%s %s - ���������� ���� ! ', '', 1);   

    bars_error.add_message(l_mod, 67, l_exc, l_rus, '��������� ����� ������ � ������ ������� �������� ������ �� ������� ������ !', '', 1 );
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, '�������� ���� ������ � ���� ������� ������� ���� �� �������� ���!', '', 1);   

    bars_error.add_message(l_mod, 68, l_exc, l_rus, '������� �������� ������� � ������� !', '', 1 );
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, '³������ ���� �������� ���������!', '', 1);   

  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ZAY.sql =========*** Run *** ==
PROMPT ===================================================================================== 
