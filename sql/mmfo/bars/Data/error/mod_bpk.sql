PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ BPK ***
declare
  l_mod  varchar2(3) := 'BPK';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '���', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� ��� ����� ��� ���������� �����', '', 1, 'INCORRECT_BPK_TIP');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� ��� ������� ��� ���������� �������', '', 1, 'INCORRECT_BPK_TIP');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '����� ��� �������� ����������� ������� ��������������. ��������� ��������� ��� ���.', '', 1, 'LOCKED_ACCOUNT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��� �������� �������� ������ �������������. ��������� ��������� �� ���.', '', 1, 'LOCKED_ACCOUNT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������ ������ ���������: %s', '', 1, 'PAY_ERORR');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������� ������ ���������: %s', '', 1, 'PAY_ERORR');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '����������� ���� ��� �������: %s', '', 1, 'UNKNOWN_FILE_TO_IMPORT');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�������� ���� ��� �������: %s', '', 1, 'UNKNOWN_FILE_TO_IMPORT');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������ ���������� ���� ��� ��������� %s ��� ���������� ��������', '', 1, 'TRCASH_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� �������� ���������� ������� ��� �������� %s ��� ��������� ��������', '', 1, 'TRCASH_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ������� ������ ����������� ���� ��� �������� ��������!', '', 1, 'CHK_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� ������� ����� ������� ��� ��� �������� ��������!', '', 1, 'CHK_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '��� �������������� �������� �� ���������� %s ��������� ������ ����� %s ������!', '', 1, 'ONLY_67_IN_TRANSIT');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '��� ��������� �������� �� ���������� %s �������� ����� ������� %s �����!', '', 1, 'ONLY_67_IN_TRANSIT');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '���������� ������ ���� 2924 ��� ��������!', '', 1, 'ONLY_2924_IN_TRANSIT');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '��������� ������ ������� 2924 ��� ��������!', '', 1, 'ONLY_2924_IN_TRANSIT');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '��������� �������� ������������� %s ������ �����������!', '', 1, 'BPK_CHK');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '���������� �������� ������������ %s ����� ��������!', '', 1, 'BPK_CHK');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ������ ���������� ���� ��� �������� %s', '', 1, 'TRANSITACC_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '�� ������� ���������� ������� ��� �������� %s', '', 1, 'TRANSITACC_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� �������� ������������ �������� �����: %s', '', 1, 'XML_TAG_EMPTY');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�� ��������� ����''������� ������� �����: %s', '', 1, 'XML_TAG_EMPTY');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '���� �� ������: %s (%s)', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '������� �� ��������: %s (%s)', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '���� %s (%s) ��������������� �� ������� ������� (��� %s)', '', 1, 'ACC_REG_RNK');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '������� %s (%s) ������������ �� ������ �볺��� (��� %s)', '', 1, 'ACC_REG_RNK');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '������� ������ �� ��� ���������� ����� (%s)', '', 1, 'INCORRECT_NBS_OVR');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '������ ������� �� ��� ���������� ������� (%s)', '', 1, 'INCORRECT_NBS_OVR');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '������� ������ �� ��� ����� �����. ������ (%s)', '', 1, 'INCORRECT_NBS_9129');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '������ ������� �� ��� ������� ��������������� ���� (%s)', '', 1, 'INCORRECT_NBS_9129');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '������� ������ �� ��� ����� ���.���������� (%s)', '', 1, 'INCORRECT_NBS_TOVR');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '������ ������� �� ��� ������� ���.���������� (%s)', '', 1, 'INCORRECT_NBS_TOVR');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '������� ������ �� ��� ����� �������� (%s)', '', 1, 'INCORRECT_NBS_3570');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '������ ������� �� ��� ������� ���� (%s)', '', 1, 'INCORRECT_NBS_3570');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '������� ������ �� ��� ����� ���.���. �� ������ (%s)', '', 1, 'INCORRECT_NBS_2208');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '������ ������� �� ��� ������� �����.���.�� ������ (%s)', '', 1, 'INCORRECT_NBS_2208');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '�� �������� �������� <������������ ��������>', '', 1, 'NAME_NOT_SET');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '�� ��������� �������� <����� ��������>', '', 1, 'NAME_NOT_SET');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� �������� �������� <��� ��������>', '', 1, 'TYPE_NOT_SET');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�� ��������� �������� <��� ������>', '', 1, 'TYPE_NOT_SET');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '�� �������� �������� <������>', '', 1, 'KV_NOT_SET');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '�� ��������� �������� <������>', '', 1, 'KV_NOT_SET');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '�� �������� �������� <��������� �������>', '', 1, 'KK_NOT_SET');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '�� ��������� �������� <�������� �볺���>', '', 1, 'KK_NOT_SET');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '�� �������� �������� <��� ������� �����>', '', 1, 'CONDSET_NOT_SET');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '�� ��������� �������� <��� ����� �������>', '', 1, 'CONDSET_NOT_SET');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '�� �������� �������� <���������� ����>', '', 1, 'NBS_NOT_SET');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '�� ��������� �������� <���������� �������>', '', 1, 'NBS_NOT_SET');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '�� �������� �������� <��22>', '', 1, 'OB22_NOT_SET');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '�� ��������� �������� <��22>', '', 1, 'OB22_NOT_SET');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '�� ������� ��������� �������', '', 1, 'CARDTYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '�� �������� �������� �������', '', 1, 'CARDTYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '��� �������� %s ��� ���� ������� %s', '', 1, 'CONDSET_CARDTYPE_INCORRECT');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '��� ������ %s �� ���� ���� ����� %s', '', 1, 'CONDSET_CARDTYPE_INCORRECT');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '��� �������� %s � ���� ������� %s �� ������������� ��� ������ %s', '', 1, 'CONDSET_KV_INCORRECT');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '��� ������ %s � ���� ����� %s �� ������� ��� ������ %s', '', 1, 'CONDSET_KV_INCORRECT');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '��� �������� %s ��� ���� ������� %s', '', 1, 'CONDSET_NOT_FOUND');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '��� ������ %s �� ���� ���� ����� %s', '', 1, 'CONDSET_NOT_FOUND');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '������� � ��������� ����������� ��� ����������', '', 1, 'DUBL_PRODUCT');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '������� � ��������� ����������� ��� ����', '', 1, 'DUBL_PRODUCT');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '������������ ��������� %s ��������� ��������� ������ �������', '', 1, 'EXEC_FUNCTION_DENIED');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '����������� �������� %s ���������� ���������� ���� �������', '', 1, 'EXEC_FUNCTION_DENIED');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '������ ������� ����� %s: %s', '', 1, 'REF_IMPORT_ERROR');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '������� ������� ����� %s: %s', '', 1, 'REF_IMPORT_ERROR');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '�������������� ���� ������� � ���������� ��������', '', 1, 'CTYPE_ERROR');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '������������ ���� �볺��� � ��������� ��������', '', 1, 'CTYPE_ERROR');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '������� %s �� ������', '', 1, 'DEAL_NOT_FOUND');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '����� %s �� ��������', '', 1, 'DEAL_NOT_FOUND');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '������� ������ �� ��� ����� ������������ ������������� (%s)', '', 1, 'INCORRECT_NBS_DEBT');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '������ ������� �� ��� ������� ����������� ������������� (%s)', '', 1, 'INCORRECT_NBS_DEBT');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '�������������� ��������� ���������� ���������!!!', '', 1, 'ALTBPK_EDIT_ERROR');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '����������� ��������� ��������� ����������!!! ', '', 1, 'ALTBPK_EDIT_ERROR');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '�������� ��������� ���������� ���������!!!', '', 1, 'ALTBPK_DEL_ERROR');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '��������� ��������� ��������� ����������!!!', '', 1, 'ALTBPK_DEL_ERROR');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '����� ���������� ������� �������� 160 ��������, ����� ����� 14!!!', '', 1, 'ALTBPK_INS_ERROR');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '������� ����������� ������� �������� 160 �������, ������� ������� 14!!!', '', 1, 'ALTBPK_INS_ERROR');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '���� ACC=%s �� ������ � �������� ���-Way4', '', 1, 'W4ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '������� ACC=%s �� �������� � ������� ���-Way4', '', 1, 'W4ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '��� ������ %s �� ������ ���� ACC=%s', '', 1, 'MODEANDACC_NOT_FOUND');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '��� ������ %s �� �������� ������� ACC=%s', '', 1, 'MODEANDACC_NOT_FOUND');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '����������� ����� ����� %s', '', 1, 'UNKNOWN_MODE');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '�������� ����� ������� %s', '', 1, 'UNKNOWN_MODE');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '����������� ��� �������� %s', '', 1, 'CARDCODE_NOT_FOUND');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '�������� ��� ������ %s', '', 1, 'CARDCODE_NOT_FOUND');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� ��������� ������������ ��������� ������� (��� %s) / ��������: %s', '', 1, 'CUSTOMERPARAMS_ERROR');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� ��������� ����`����� �������� �볺��� (��� %s) / ������: %s', '', 1, 'CUSTOMERPARAMS_ERROR');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '�� ������ ������ RNK=%s', '', 1, 'CUSTOMER_NOT_FOUND');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '�� �������� �볺��� RNK=%s', '', 1, 'CUSTOMER_NOT_FOUND');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '������ %s �� ������', '', 1, 'REQUEST_NOT_FOUND');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '����� %s �� ��������', '', 1, 'REQUEST_NOT_FOUND');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '������ %s �� �������� %s: ���������������� ����������', '', 1, 'REQUEST_REFORM_IMPOSSIBLE');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '����� %s � �������� %s: �������������� ���������', '', 1, 'REQUEST_REFORM_IMPOSSIBLE');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '�� ������ %s ��� ��������� �������������� ������ %s', '', 1, 'REQUEST_YET_FORM');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '�� ����� %s ��� ���������� ��������� ����� %s', '', 1, 'REQUEST_YET_FORM');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '�� ������ �/� ������ � ����� %s', '', 1, 'PROECT_NOT_FOUND');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '�� �������� �/� ������ � ����� %s', '', 1, 'PROECT_NOT_FOUND');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '������ %s �� �������� %s: �������� ����������', '', 1, 'REQUEST_DELETE_IMPOSSIBLE');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '����� %s � �������� %s: ��������� ���������', '', 1, 'REQUEST_DELETE_IMPOSSIBLE');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '������������ ����� ���������', '', 1, 'PASSP_SERIES_ERROR');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '���������� ���� ���������', '', 1, 'PASSP_SERIES_ERROR');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '������������ ����� ���������', '', 1, 'PASSP_NUM_ERROR');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '����������� ����� ���������', '', 1, 'PASSP_NUM_ERROR');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '���� %s/%s ������', '', 1, 'ACC_CLOSED');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '������� %s/%s �������', '', 1, 'ACC_CLOSED');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '�������� ��� �� ������������', '', 1, 'CARD_NOT_REOPEN_YET');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '������ �� �� ������������', '', 1, 'CARD_NOT_REOPEN_YET');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '�� ��������� ������ ������ ������� � ������ ��', '', 1, 'KV_PKW4_ERROR');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '�� ���������� ������ ������� ������� � ������ ��', '', 1, 'KV_PKW4_ERROR');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '�������� %s/%s ��� ������������', '', 1, 'CARD_ALREADY_REOPEN');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '������ %s/%s ��� ������������', '', 1, 'CARD_ALREADY_REOPEN');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '�� ����� ��������� ���� �������, �������� �������� %s/%s ����������', '', 1, 'DEBTACC_OST');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '�� ������� ���������� � �������, ������� ������ %s/%s ���������', '', 1, 'DEBTACC_OST');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, '������ �� ����� %s � ����� %s ��� �������� � �������� � CardMake %s', '', 1, 'REQUEST_OPERTYPE1');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '����� �� ������� %s � ����� %s ��� ������ �� �������� � CardMake %s', '', 1, 'REQUEST_OPERTYPE1');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, '������ �� ����� %s � ����� %s ��� �������������� � CardMake %s', '', 1, 'REQUEST_OPERTYPE2');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, '����� �� ������� %s � ����� %s ��� ������������ � CardMake %s', '', 1, 'REQUEST_OPERTYPE2');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, '������ �� ����� %s � ����� %s ��� ������� ��������� � CardMake %s', '', 1, 'REQUEST_OPERTYPE3');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, '����� �� ������� %s � ����� %s ��� ������ ��������� %s', '', 1, 'REQUEST_OPERTYPE3');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, '�������� ������� �������� �������� ����� Way4', '', 1, 'W4LC_0');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, '����������� ������� ��������� ������ ����� Way4', '', 1, 'W4LC_0');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, '�������� ������� �������� �������� ����� CardMake', '', 1, 'W4LC_1');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, '����������� ������� ��������� ������ ����� CardMake', '', 1, 'W4LC_1');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, '�������� �� ��������� ������: ��������� ���������� ��������', '', 1, 'CHECK_DEBIT_BALANCE');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, '�������� �� �������� ������: ���������� ���������� ��������', '', 1, 'CHECK_DEBIT_BALANCE');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, '��������� ���� �������� ����� �� ������������� ���� ����� ��� ��������', '', 1, 'TERM_ERROR');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, '�������� ���� 䳿 ������ �� ������� ���� ������ �� ��������', '', 1, 'TERM_ERROR');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, '������ ����� �� ��������� � ������� ��������', '', 1, 'KVACC_KVCARD_ERROR');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, '������ ������� �� ������� � ������� ������', '', 1, 'KVACC_KVCARD_ERROR');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, '�� �� ��������� � �� ��������', '', 1, 'NBSACC_NBSCARD_ERROR');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, '�� �� ������� � �� ������', '', 1, 'NBSACC_NBSCARD_ERROR');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, '������������ ������ ���� ��� ���� <%s> (��� %s)', '', 1, 'FORMAT_DATE_ERROR');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, '����������� ������ ���� ��� ���� <%s> (��� %s)', '', 1, 'FORMAT_DATE_ERROR');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, '������������ ��� ����� %s ��� �/� ������� %s/%s/%s', '', 1, 'UNCURRECT_SALARY_CARD');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, '������������ ��� ����� %s ��� �/� ������� %s/%s/%s', '', 1, 'UNCURRECT_SALARY_CARD');

    bars_error.add_message(l_mod, 77, l_exc, l_rus, '��� ����� Instant �� ��������� � ����� �����', '', 1, 'SUBCARDACC_SUBCARDCARD_ERROR');
    bars_error.add_message(l_mod, 77, l_exc, l_ukr, '��� ����� Instant �� ������� � ����� ������', '', 1, 'SUBCARDACC_SUBCARDCARD_ERROR');

    bars_error.add_message(l_mod, 78, l_exc, l_rus, '����������� ���� ������ ����� ��������� �� ����� %s', '', 1, 'IDAT_NOT_FOUND');
    bars_error.add_message(l_mod, 78, l_exc, l_ukr, '³������ ���� ������ ����� ��������� �� ������� %s', '', 1, 'IDAT_NOT_FOUND');

    bars_error.add_message(l_mod, 79, l_exc, l_rus, '�� ������� ����� %s', '', 1, 'CARD_NOT_FOUND');
    bars_error.add_message(l_mod, 79, l_exc, l_ukr, '�� �������� ����� %s', '', 1, 'CARD_NOT_FOUND');

    bars_error.add_message(l_mod, 80, l_exc, l_rus, '������� � ������� %s ��� ���������������', '', 1, 'AGR_DUPVAL');
    bars_error.add_message(l_mod, 80, l_exc, l_ukr, '����� � ������� %s ��� ������������', '', 1, 'AGR_DUPVAL');

    bars_error.add_message(l_mod, 81, l_exc, l_rus, '������ �������� ��� ������� SMS ������ ���� � ������� +380ZZXXXYYPP', '', 1, 'SMS_PHONE_INVALID');
    bars_error.add_message(l_mod, 81, l_exc, l_ukr, '����� �������� ��� �������� SMS ������� ���� � ������ +380ZZXXXYYPP', '', 1, 'SMS_PHONE_INVALID');

    bars_error.add_message(l_mod, 82, l_exc, l_rus, '�� ��������� ���', '', 1, 'FNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 82, l_exc, l_ukr, '�� ��������� ��"�', '', 1, 'FNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 83, l_exc, l_rus, '�� ��������� �������', '', 1, 'LNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 83, l_exc, l_ukr, '�� ��������� �������', '', 1, 'LNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 84, l_exc, l_rus, '�� ��������� ��������', '', 1, 'MNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 84, l_exc, l_ukr, '�� ��������� ��-�������', '', 1, 'MNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 85, l_exc, l_rus, '�� ��������� ��� ���������', '', 1, 'FNAME_LAT_NOT_FOUND');
    bars_error.add_message(l_mod, 85, l_exc, l_ukr, '�� ��������� ��"� ���������', '', 1, 'FNAME_LAT_NOT_FOUND');

    bars_error.add_message(l_mod, 86, l_exc, l_rus, '�� ��������� ������� ���������', '', 1, 'LNAME_LAT_NOT_FOUND');
    bars_error.add_message(l_mod, 86, l_exc, l_ukr, '�� ��������� ������� ���������', '', 1, 'LNAME_LAT_NOT_FOUND');

    bars_error.add_message(l_mod, 87, l_exc, l_rus, '�� ��������� ����', '', 1, 'OKPO_NOT_FOUND');
    bars_error.add_message(l_mod, 87, l_exc, l_ukr, '�� ��������� ����', '', 1, 'OKPO_NOT_FOUND');

    bars_error.add_message(l_mod, 88, l_exc, l_rus, '�� ��������� ��� ���������', '', 1, 'DOCTYPE_NOT_FOUND');
    bars_error.add_message(l_mod, 88, l_exc, l_ukr, '�� ��������� ��� ���������', '', 1, 'DOCTYPE_NOT_FOUND');

    bars_error.add_message(l_mod, 89, l_exc, l_rus, '�� ��������� ����� ���������', '', 1, 'PASP_SER_NOT_FOUND');
    bars_error.add_message(l_mod, 89, l_exc, l_ukr, '�� ��������� ���� ���������', '', 1, 'PASP_SER_NOT_FOUND');

    bars_error.add_message(l_mod, 90, l_exc, l_rus, '�� ��������� ����� ���������', '', 1, 'PASP_NUM_NOT_FOUND');
    bars_error.add_message(l_mod, 90, l_exc, l_ukr, '�� ��������� ����� ���������', '', 1, 'PASP_NUM_NOT_FOUND');

    bars_error.add_message(l_mod, 91, l_exc, l_rus, '�� ��������� ����� ������� ����� ��������', '', 1, 'PASP_ORG_NOT_FOUND');
    bars_error.add_message(l_mod, 91, l_exc, l_ukr, '�� ��������� ����� �� ����� ��������', '', 1, 'PASP_ORG_NOT_FOUND');

    bars_error.add_message(l_mod, 92, l_exc, l_rus, '�� ��������� ���� ������ ���������', '', 1, 'PASP_DATE_NOT_FOUND');
    bars_error.add_message(l_mod, 92, l_exc, l_ukr, '�� ��������� ���� ������ ���������', '', 1, 'PASP_DATE_NOT_FOUND');

    bars_error.add_message(l_mod, 93, l_exc, l_rus, '�� ��������� ���� ��������', '', 1, 'BDAY_NOT_FOUND');
    bars_error.add_message(l_mod, 93, l_exc, l_ukr, '�� ��������� ���� ����������', '', 1, 'BDAY_NOT_FOUND');

    bars_error.add_message(l_mod, 94, l_exc, l_rus, '�� ��������� ����� ��������', '', 1, 'BPLACE_NOT_FOUND');
    bars_error.add_message(l_mod, 94, l_exc, l_ukr, '�� ��������� ���� ����������', '', 1, 'BPLACE_NOT_FOUND');

    bars_error.add_message(l_mod, 95, l_exc, l_rus, '�� ��������� ������', '', 1, 'ADRCODE_NOT_FOUND');
    bars_error.add_message(l_mod, 95, l_exc, l_ukr, '�� ��������� ������', '', 1, 'ADRCODE_NOT_FOUND');

    bars_error.add_message(l_mod, 96, l_exc, l_rus, '�� ��������� �������', '', 1, 'ADRDOMAIN_NOT_FOUND');
    bars_error.add_message(l_mod, 96, l_exc, l_ukr, '�� ��������� �������', '', 1, 'ADRDOMAIN_NOT_FOUND');

    bars_error.add_message(l_mod, 97, l_exc, l_rus, '�� ��������� �����', '', 1, 'ADRREGION_NOT_FOUND');
    bars_error.add_message(l_mod, 97, l_exc, l_ukr, '�� ��������� �����', '', 1, 'ADRREGION_NOT_FOUND');

    bars_error.add_message(l_mod, 98, l_exc, l_rus, '�� ��������� ���������� �����', '', 1, 'ADRCITY_NOT_FOUND');
    bars_error.add_message(l_mod, 98, l_exc, l_ukr, '�� ��������� ��������� �����', '', 1, 'ADRCITY_NOT_FOUND');

    bars_error.add_message(l_mod, 99, l_exc, l_rus, '�� ��������� �����,���,��������', '', 1, 'ADRSTREET_NOT_FOUND');
    bars_error.add_message(l_mod, 99, l_exc, l_ukr, '�� ��������� ������, �������, ��������', '', 1, 'ADRSTREET_NOT_FOUND');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '������ %s �� ����� Instant: ������������ ������� ������� ���� ����������', '', 1, 'REQUEST_INSTREFORM_IMPOSSIBLE');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '����� %s �� ������� Instant: ���������� ������ ������ ���� ���������', '', 1, 'REQUEST_INSTREFORM_IMPOSSIBLE');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '������ %s �� ����� Instant: �������� ����������', '', 1, 'REQUEST_INSTDELETE_IMPOSSIBLE');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '����� %s �� ������� Instant: ��������� ���������', '', 1, 'REQUEST_INSTDELETE_IMPOSSIBLE');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '�� ����� %s ���� �������������� ������, ���������� ���������� ����� ��������� ������', '', 1, 'REQUEST_STATUS2');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '�� ������� %s � ����������� ������, ��� ����������� ����������� ���������� ����� ������� ������', '', 1, 'REQUEST_STATUS2');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, '���������� ������� ���� %s: ���� ���������� ��������� �� �����.', '', 1, 'IMPOSSIBLE_DELETE_FILE');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, '��������� �������� ���� %s: � ������� ��������� �� �����.', '', 1, 'IMPOSSIBLE_DELETE_FILE');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '������ ��� ����� ���������� ������ ���������� �� ������ �����', '', 1, 'KK_SECRET_WORD_PIND_ERROR');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '����� ����� ��� ������ ������� �� ���������� �� ������� ����� ������', '', 1, 'KK_SECRET_WORD_PIND_ERROR');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, '�������� ������ ������� ���� �� ����������� %s', '', 1, 'FLAGINSTANT_ERROR');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, '���������� ������ ������� ������ �� ����������� %s', '', 1, 'FLAGINSTANT_ERROR');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '��������� ���������� �������� �� ������ ��������� ����������!', '', 1, 'ERROR_NLS2625D_PAY');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, '���������� ��������� �������� �� �������� �������� ����������!', '', 1, 'ERROR_NLS2625D_PAY');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, '��������� ����������� ������ � ����� %s ��� ���� %s', '', 1, 'REQUEST_TYPE_IMPOSSIBLE');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, '���������� ��������� ����� � ����� %s ��� ���� %s', '', 1, 'REQUEST_TYPE_IMPOSSIBLE');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, '������� ��� %s ��� ������� ����� ����������', '', 1, 'KK_ALREADY_OPEN');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, '�볺��� ��� %s ��� ������� ����� �������', '', 1, 'KK_ALREADY_OPEN');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, '%s �������� ������� ������������ ��: %s', '', 1, 'KK_FORBIDDEN_CHARACTERS');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, '%s ������ ������� ����� ��: %s', '', 1, 'KK_FORBIDDEN_CHARACTERS');

    bars_error.add_message(l_mod, 200, l_exc, l_rus, '�� ������ ����', '', 1, 'FILE_NOT_FOUND');
    bars_error.add_message(l_mod, 200, l_exc, l_ukr, '�� ��������� ����', '', 1, 'FILE_NOT_FOUND');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BPK.sql =========*** Run *** ==
PROMPT ===================================================================================== 
