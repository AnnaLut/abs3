PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CAC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ CAC ***
declare
  l_mod  varchar2(3) := 'CAC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������� � �����', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Improper client type - %s', '', 1, 'INCORRECT_CUSTTYPE');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������������ ��� ������� - %s', '', 1, 'INCORRECT_CUSTTYPE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������������� ��� ��i���� -%s', '', 1, 'INCORRECT_CUSTTYPE');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Account in module! Impossible re-register on other contragent', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, '��������� ����! ���������� ������������������ �� ������� �����������', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '��������� �������! ��������� �������������� �� i����� �����������', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Group accounts update is denied!', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��������� ��������� ���������� ������!', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '���������� ������� ���������� ������i�!', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Group clients update is denied!', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, '��������� ��������� ���������� ��������!', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '���������� ������� ���������� ����������i�!', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Impossible change attributes closed account N%s', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, '���������� �������� ��������� ��������� ����� �%s', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��������� ��i���� ����i���� ��������� ������� �%s', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Improper balance account - %s', '', 1, 'INVALID_R020');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, '������������ ���������� ���� - %s', '', 1, 'INVALID_R020');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '������������� ���������� ������� - %s', '', 1, 'INVALID_R020');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Accounts parameters change other user. ACC=%s', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, '��������� ����� ���������� ������ �������������. ACC=%s', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '��������� ������� ��i������� i���� ������������. ACC=%s', '', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_geo, 'Improper currency code - %s', '', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_rus, '������������ ��� ������ - %s', '', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '������������� ��� ������ - %s', '', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_geo, 'Unsuccessful opening/change account attributes (ACCOUNTS) N%s', '', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_rus, '���������� ��������/��������� ���������� ����� (ACCOUNTS) �%s', '', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '�����i��� �i�������/���������� ����i���i� ������� (ACCOUNTS) �%s', '', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_geo, 'Unsuccessful account link (ND_ACC) to deal N%s', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_rus, '���������� �������� ����� (ND_ACC) � ������ �%s', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '�����i��� ����''���� ������� (ND_ACC) �� ����� �%s', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_geo, 'Unsuccessful account of providing opening (PAWN_ACC) N%s', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_rus, '���������� �������� ����� ����������� (PAWN_ACC) �%s', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�����i��� �i������� ������� ������������ (PAWN_ACC) �%s', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_geo, 'Overdraft account already open (ACC_OVER) for account ACC=%s', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_rus, '��� ������ ���� ���������� (ACC_OVER) ��� ����� ACC=%s', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '��� �i������ ������� ���������� (ACC_OVER) ��� ������� ACC=%s', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_geo, 'Unsuccessfuk overdraft account opening (ACC_OVER) for account ACC=%s', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_rus, '���������� ������� ����� ���������� (ACC_OVER) ��� ����� ACC=%s', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '�����i��� �i������� ������� ���������� (ACC_OVER) ��� ������� ACC=%s', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_geo, 'Unsuccessful account link (BANK_ACC) to MFO %s', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_rus, '���������� �������� ����� (BANK_ACC) � ��� %s', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�����i��� ����''���� ������� (BANK_ACC) �� ��� %s', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_geo, 'Account %s link to few MFO', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_rus, '���� �%s �������� � ���������� ���', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '������� �%s ����''����� �� ���_���� ���', '', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_geo, 'Unknown account opening mode - %s', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_rus, '����������� ����� �������� ����� - %s', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '���i����� ����� �i������� ������� - %s', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '�� ������� ������������� � ����� %s!', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '�� �������� �i�����i�� � ����� %s!', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '���������� ���������� ���������������� �������. %s!', '', 1, '18');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '��������� ���������� i������i������ �i�����. %s!', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, 'SYNC_OPEN: ���� ������ %s!', '', 1, '19');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, 'SYNC_OPEN: ������� ������� %s!', '', 1, '19');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, 'SYNC_OPEN: ���� %s ��������������� �� ��.�������.!', '', 1, '20');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, 'SYNC_OPEN: ������� %s ������������ �� i��.�i�����.!', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '����������� �������� ���-� ���������� ��� �������. %s!', '', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '���������� ��������� ���i���� ��������i� ��� �i�����. %s!', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������ ���������� ��� �������. %s!', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�� �������� ����������� ��� �i�����. %s!', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '���������� ���������� ���������������� ����������� ��� �������. %s!', '', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '��������� ���������� i������i������ ����������� ��� �i�����. %s!', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '������ � �����.������� ����� %s ���: %s!', '', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '������� � �����.������i ������� %s ���: %s!', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '��������� ������ (%s) �� ������� ��� �������!', '', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '������� ������ (%s) �� �������� �� �������!', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '������ �������������� ��� ������������� �����', '', 1, 'UPDATE_ACCOUNTS_BRANCH');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '��������� �����i������ ��� �i�����i�� �������', '', 1, 'UPDATE_ACCOUNTS_BRANCH');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '��������� ��������� ����� �� ��������� ���', '', 1, 'OPEN_ROOT_ACCOUNT');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '���������� �i�������� ������� �� ������ ���', '', 1, 'OPEN_ROOT_ACCOUNT');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '��������� �������� ������������� ������� ��� �� ����������', '', 1, 'SPECPARAM_CLOSED');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '������� �������� ������������� ������� �� �� i���', '', 1, 'SPECPARAM_CLOSED');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '��� ������� ����������� ����� ���������� ��������� �������������� ����', '', 1, 'ACCOUNT_NBS_MUST_NLSALT');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '��� ��������� ����������� ������� ��������� ��������� �������������� �������', '', 1, 'ACCOUNT_NBS_MUST_NLSALT');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '���������� ��������������� ����������� ����� ��� ������� ����� ���������', '', 1, 'ACCOUNT_NBS_NOT_NLSALT');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '���������� ��������������� ������� ��� ����� ������� ����������', '', 1, 'ACCOUNT_NBS_NOT_NLSALT');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '��������� ���������� ���� � ������ ���', '', 1, 'UPDATE_ACCOUNTS_KF');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '���������� ���������� ������� � ���� ���', '', 1, 'UPDATE_ACCOUNTS_KF');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '����� �������� �� ������', '', 1, 'PASSPORT_SERIAL_NULL');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '���� �������� �� ������', '', 1, 'PASSPORT_SERIAL_NULL');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '�������� ����� ����� ��������', '', 1, 'PASSPORT_SERIAL_LENGTH');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '������ ������� ��� ��������', '', 1, 'PASSPORT_SERIAL_LENGTH');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '������������ ������� � ����� ��������', '', 1, 'PASSPORT_SERIAL_ERROR');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '���������� ������� � ��� ��������', '', 1, 'PASSPORT_SERIAL_ERROR');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '����� �������� �� �����', '', 1, 'PASSPORT_NUMBER_NULL');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '����� �������� �� ������', '', 1, 'PASSPORT_NUMBER_NULL');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '�������� ����� ������ ��������', '', 1, 'PASSPORT_NUMBER_LENGTH');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '������ ������� ������ ��������', '', 1, 'PASSPORT_NUMBER_LENGTH');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '������������ ������� � ������ ��������', '', 1, 'PASSPORT_NUMBER_ERROR');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '���������� ������� � ����� ��������', '', 1, 'PASSPORT_NUMBER_ERROR');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '���������� ������ � ����: %s', '', 1, 'NON_NUMERIC_OKPO');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '���������� ������ � ����: %s', '', 1, 'NON_NUMERIC_OKPO');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '��� ��������������� ������ � ���� %s', '', 1, 'CUSTOMER_WITH_OKPO');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '��� ������������ �볺��� � ���� %s', '', 1, 'CUSTOMER_WITH_OKPO');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '��� ��������������� ������-��� � ���� %s', '', 1, 'CUSTOMER_SPD_WITH_OKPO');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '�� ������������ �볺���-��� � ���� %s', '', 1, 'CUSTOMER_SPD_WITH_OKPO');

    bars_error.add_message(l_mod, 41, l_exc, l_geo, 'Impossible open account / change accounts attributes - customer RNK %s closed', '', 1, '41');
    bars_error.add_message(l_mod, 41, l_exc, l_rus, '���������� ������� ���� / �������� ��������� ����� - ������ ��� %s ������', '', 1, '41');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '��������� ������� ������� / ��i���� ����i���� ������� - �볺��� ��� %s �������', '', 1, '41');

    bars_error.add_message(l_mod, 42, l_exc, l_geo, 'Customer RNK %s not found', '', 1, '42');
    bars_error.add_message(l_mod, 42, l_exc, l_rus, '������ ��� %s �� ������', '', 1, '42');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '�볺��� ��� %s �� ��������', '', 1, '42');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '������ � ��� %s ��� ����������', '', 1, 'RNK_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '�볺�� � ��� %s ��� ����', '', 1, 'RNK_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '���� %s �� ������', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '������� %s �� ��������', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '���� �������� ����� %s ������ ���� ���������� �������� %s', '', 1, 'ACC_DAOS_DAPP');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '���� �������� ������� %s ����� ���� ���������� ���� %s', '', 1, 'ACC_DAOS_DAPP');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '���������� �������������/�������������� ���� ����� �� ������ �������������', '', 1, 'ACCOUNT_BLK_FM_ERROR');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '��������� �����������/������������ ������� ����� �� ����� ������������', '', 1, 'ACCOUNT_BLK_FM_ERROR');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '��������� �����������/�������������� ���� ����� ''�� ������ � ��������''', '', 1, 'ACCOUNT_BLK_ACT_ERROR');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '���������� ���������/������������ ������� ����� ''�� ������� � ��''', '', 1, 'ACCOUNT_BLK_ACT_ERROR');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '������������ �������� ��������� <��������� �������>', '', 1, 'MPNO_ERROR_FORMAT');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '���������� �������� �������� <�������� �������>', '', 1, 'MPNO_ERROR_FORMAT');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '��������� �������������� ���� �� ��������� ��������� � ���������� ����� �� ���', '', 1, 'ACCOUNT_BLK_DPA_ERROR');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '���������� ������������ ������� �� ��������� ����������� ��� ��������� ������� � ���', '', 1, 'ACCOUNT_BLK_DPA_ERROR');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '������ ���������� ��������� "����� ������� ���� ���������(� ���i����)"', '', 1, 'ACCOUNTSW_LIESUM_ERROR');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '������� ���������� ����i���� "����� ������� ���� ���������(� ���i����)"', '', 1, 'ACCOUNTSW_LIESUM_ERROR');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '��������� ������ �������, ��� �110 (��� ��. ������������)=N9420 ������ ������������� �������� �050 (���.-�������� �-�� ���.)=830, 835, 180 � 440', '', 1, 'K110_N9420_CORRESPONDS_K050');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '�������� ��� �볺���, ��� �110 (��� ��. ��������)=N9420 �������� ������� �������� �050 (���.-������� �-�� ����.)=830, 835, 180 �� 440', '', 1, 'K110_N9420_CORRESPONDS_K050');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '� �������� ������� �� �������� ��� ������� �������� ��������� �������', '', 1, 'ERROR_MPNO');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '� ������ �볺��� �� ��������� ��� ������ ��������� �������� �������', '', 1, 'ERROR_MPNO');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '��� ���������� 11. ���������� ��������� ���� "̳�������� �������"', '', 1, 'ERR_BLKD11');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '��� ���������� 11. ��������� ��������� ���� "̳�������� �������"', '', 1, 'ERR_BLKD11');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '��� ���������� 11. �� ������� ���������� �������� ����������� �����', '', 1, 'ERR_BLKD11_DPT');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '��� ���������� 11. �� �������� ��������� ������ ����������� �������', '', 1, 'ERR_BLKD11_DPT');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '��� ���������� 11. �� ������� ���������� �������� ������ � ���������� �������� ����� �� ���������� ������', '', 1, 'ERR_BLKD11_DPT_PR');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '��� ���������� 11. �� �������� �������� �������� ������ � ��������� ������ ������� �� ���������� ������', '', 1, 'ERR_BLKD11_DPT_PR');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '�� �������� �������� �� "���������� ���"', '', 1, 'ERR_EMPTY_PEP');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '�� ��������� ������� �� "����� ���"', '', 1, 'ERR_EMPTY_PEP');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '��������� ��� ����� "����������" ���������, ����������� ������������ ����������������� �������� ���. ���', '', 1, 'ERR_REL_FAMILY');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '������������ ���� ��`���� "�����" ����������, ������������ ���������� ������������� �볺��� ���. ���', '', 1, 'ERR_REL_FAMILY');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '� 01.01.2017 ������ �� ������������ ���������� ������������� �������� ��������� �������������, ��� ������������ ���� ����������', '', 1, 'KL_PASSP_15');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '� 01.01.2017 �������� � �������� ��������� ������������� �볺��� ��������� ����������, �� ��������� ����� �����������', '', 1, 'KL_PASSP_15');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '� ������� ���� ���������� �����: %s', '', 1, 'OPEN_ACCOUNTS_EXISTS');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '� �볺��� � �������� �������: %s', '', 1, 'OPEN_ACCOUNTS_EXISTS');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '<b>��������� �������� ���� ��� </b><br/><br/>', '', 1, 'INCORRECT_VED');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '<b>��������� �������� ���� ��� </b><br/><br/>', '', 1, 'INCORRECT_VED');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '<b>��������� �������� ���� ������� ��������</b><br/><br/>', '', 1, 'INCORRECT_ISE');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '<b>��������� �������� ���� ������� ��������</b><br/><br/>', '', 1, 'INCORRECT_ISE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CAC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
