PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CIG.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ CIG ***
declare
  l_mod  varchar2(3) := 'CIG';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������������� � ����� (��������� ����)', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� ���� "�������� ���� ��������" �� ������� � ����������� D02', '', 1, 'PARENT_KEY_NOT_ROLEID');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�������� ���� "���� ��� ������" �� �������� � �������� D02', '', 1, 'PARENT_KEY_NOT_ROLEID');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�������� ���� "�������� ���� ��������" �� ����� ���� ������', '', 1, 'CIG_ROLEID_NULL');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�������� ���� "���� ��� ������" �� ���� ���� ������', '', 1, 'CIG_ROLEID_NULL');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�������� ���� "���" �� ����� ���� ������', '', 1, 'CIG_FIRST_NAME_NULL');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�������� ���� "��"�" �� ���� ���� ������', '', 1, 'CIG_FIRST_NAME_NULL');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�������� ���� "�������" �� ����� ���� ������', '', 1, 'CIG_SURNAME_NULL');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�������� ���� "�������" �� ���� ���� ������', '', 1, 'CIG_SURNAME_NULL');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�������� ���� "������������ ��������" �� ������� � ����������� D01', '', 1, 'PARENT_KEY_NOT_CLASSIF');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�������� ���� "������������  ������" �� �������� � �������� D01', '', 1, 'PARENT_KEY_NOT_CLASSIF');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�������� ���� "������������ ��������" �� ����� ���� ������', '', 1, 'CIG_CLASSIFICATION_NULL');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�������� ���� "������������  ������" �� ���� ���� ������', '', 1, 'CIG_CLASSIFICATION_NULL');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '�������� ���� "���� ��������" �� ����� ���� ������', '', 1, 'CIG_DATEBIRTH_NULL');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '�������� ���� "���� ����������" �� ���� ���� ������', '', 1, 'CIG_DATEBIRTH_NULL');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '�������� ���� "��������" �� ������� � ����������� D03', '', 1, 'PARENT_KEY_NOT_RESIDENCY');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '�������� ���� "��������" �� �������� � �������� D03', '', 1, 'PARENT_KEY_NOT_RESIDENCY');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '�������� ���� "��������" �� ����� ���� ������', '', 1, 'CIG_RESIDENCY_NULL');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '�������� ���� "��������" �� ���� ���� ������', '', 1, 'CIG_RESIDENCY_NULL');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�������� ���� "�����������" �� ������� � ����������� KL_K040', '', 1, 'PARENT_KEY_NOT_CITIZENSHIP');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '�������� ���� "������������" �� �������� � �������� KL_K040', '', 1, 'PARENT_KEY_NOT_CITIZENSHIP');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�������� ���� "�����������" �� ����� ���� ������', '', 1, 'CIG_CITIZENSHIP_NULL');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�������� ���� "������������" �� ���� ���� ������', '', 1, 'CIG_CITIZENSHIP_NULL');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '�������� ���� "���������� ������" �� ������� � ����������� D05', '', 1, 'PARENT_KEY_NOT_NEG_STATUS');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '�������� ���� "���������� ������" �� �������� � �������� D05', '', 1, 'PARENT_KEY_NOT_NEG_STATUS');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '�������� ���� "������ ��������� ����" �� ����� ���� ������', '', 1, 'CIG_POSITION_NULL');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '�������� ���� "������ ��������� �����" �� ���� ���� ������', '', 1, 'CIG_POSITION_NULL');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�������� ���� "����������������� ���" �� ����� ���� ������', '', 1, 'CIG_CUST_CODE_NULL');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�������� ���� "���������������� ���" �� ���� ���� ������', '', 1, 'CIG_CUST_CODE_NULL');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '�������� ���� "������������ ���� ("���" + "�������" + "���� �������� ")" �� ����� ���� ������', '', 1, 'CIG_CUST_KEY_NULL');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '�������� ���� "��������� ���� ("���" + "�������" + "���� ����������") �� ���� ���� ������', '', 1, 'CIG_CUST_KEY_NULL');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '�������� ���� "����� ��������" �� ����� ���� ������', '', 1, 'CIG_PASSP_SER_NULL');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '�������� ���� "���� ��������" �� ���� ���� ������', '', 1, 'CIG_PASSP_SER_NULL');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '�������� ���� "����� ��������" �� ����� ���� ������', '', 1, 'CIG_PASSP_NUM_NULL');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '�������� ���� "����� ��������" �� ���� ���� ������', '', 1, 'CIG_PASSP_NUM_NULL');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '�������� ���� "���� ������ ��������" �� ����� ���� ������', '', 1, 'CIG_PASSP_ISS_NULL');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '�������� ���� "���� ������ ��������" �� ���� ���� ������', '', 1, 'CIG_PASSP_ISS_NULL');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '�������� ���� "��� ����� ��������" �� ����� ���� ������', '', 1, 'CIG_PASSP_ORGAN_NULL');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '�������� ���� "��� ������ ��������" �� ���� ���� ������', '', 1, 'CIG_PASSP_ORGAN_NULL');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '�������� ���� "��� ����������� ������ (����. �����)" �� ����� ���� ������', '', 1, 'CIG_FACT_TERRIT_NULL');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '�������� ���� "��� ���������� ������ (�������� ������)" �� ���� ���� ������', '', 1, 'CIG_FACT_TERRIT_NULL');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '�������� ���� "�����, � ����, ����� ����, ���� (����. �����)" �� ����� ���� ������', '', 1, 'CIG_FACT_STREET_NULL');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '�������� ���� "������, � �������, ����� �������, ������ (�������� ������)" �� ���� ���� ������', '', 1, 'CIG_FACT_STREET_NULL');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�������� ���� "�����������" �� ������� � ����������� D07', '', 1, 'PARENT_KEY_NOT_EDUCATION');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�������� ���� "�����" �� �������� � �������� D07', '', 1, 'PARENT_KEY_NOT_EDUCATION');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '�������� ���� "�������� ���������" �� ������� � ����������� D08', '', 1, 'PARENT_KEY_NOT_MARITAL');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '�������� ���� "ѳ������ ����" �� �������� � �������� D08', '', 1, 'PARENT_KEY_NOT_MARITAL');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '�������� ���� "������ ��������� ����" �� ������� � ����������� D09', '', 1, 'PARENT_KEY_NOT_POSITION');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '�������� ���� "������ ��������� �����" �� �������� � �������� D09', '', 1, 'PARENT_KEY_NOT_POSITION');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '�������� ���� "��� ����������� ������" �� ������� � ����������� Territory', '', 1, 'PARENT_KEY_NOT_FACT_TERRIT');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '�������� ���� "��� ���������� ������" �� �������� � �������� Territory', '', 1, 'PARENT_KEY_NOT_FACT_TERRIT');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '������ � ����� ��� ��� ����������', '', 1, 'PK_DUPL_RNK');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '����� � ����� ��� ��� ����', '', 1, 'PK_DUPL_RNK');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '�������� ���� "������ ������������" �� ����� ���� ������', '', 1, 'CIG_STATUSID_NULL');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '�������� ���� "������ ��������" �� ���� ���� ������', '', 1, 'CIG_STATUSID_NULL');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '�������� ���� "���� ��������� ������� ������������ �����������" �� ����� ���� ������', '', 1, 'CIG_LANGNAME_NULL');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '�������� ���� "���� ��������� ������� ������������ ���������� " �� ���� ���� ������', '', 1, 'CIG_LANGNAME_NULL');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�������� ���� "������ ������������ �����������" �� ����� ���� ������', '', 1, 'CIG_NAME_NULL');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�������� ���� "����� ����� ���������� " �� ���� ���� ������', '', 1, 'CIG_NAME_NULL');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '�������� ���� "���� ��������� ������������ ������������ �����������" �� ����� ���� ������', '', 1, 'CIG_LANGABBREV_NULL');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '�������� ���� "���� ��������� ����������� ������������ ����������" �� ���� ���� ������', '', 1, 'CIG_LANGABBREV_NULL');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '�������� ���� "����������� ������������ �����������" �� ����� ���� ������', '', 1, 'CIG_ABBREV_NULL');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '�������� ���� "��������� ����� ����������" �� ���� ���� ������', '', 1, 'CIG_ABBREV_NULL');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '�������� ���� "����� �������������" �� ����� ���� ������', '', 1, 'CIG_OWNERSHIP_NULL');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '�������� ���� "����� ��������" �� ���� ���� ������', '', 1, 'CIG_OWNERSHIP_NULL');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '�������� ���� "���� ��������������� �����������" �� ����� ���� ������', '', 1, 'CIG_REGISTRDATE_NULL');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '�������� ���� "���� ��������  ���������" �� ���� ���� ������', '', 1, 'CIG_REGISTRDATE_NULL');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '�������� ���� "�����, � ����, ����� ����, ����(��. �����)" �� ����� ���� ������', '', 1, 'CIG_REG_STREET_NULL');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '�������� ���� "������, � �������, ����� �������, ������(�������� ������)" �� ���� ���� ������', '', 1, 'CIG_REG_STREET_NULL');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '�������� ���� "����� �������������" �� ������� � ����������� D10', '', 1, 'PARENT_KEY_NOT_OWNER');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '�������� ���� "����� ��������" �� �������� � �������� D10', '', 1, 'PARENT_KEY_NOT_OWNER');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '�������� ���� "������������� ������������� ������������" �� ������� � ����������� D11', '', 1, 'PARENT_KEY_NOT_ECONACTIV');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '�������� ���� "������������ ��������� ��������" �� �������� � �������� D11', '', 1, 'PARENT_KEY_NOT_ECONACTIV');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '�������� ���� "������ ������������" �� ������� � ����������� D12', '', 1, 'PARENT_KEY_NOT_STATUSID');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '�������� ���� "������ ��������" �� �������� � �������� D12', '', 1, 'PARENT_KEY_NOT_STATUSID');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '�������� ���� "���������� ����������" �� ������� � ����������� D22', '', 1, 'PARENT_KEY_NOT_EMPCOUNT');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '�������� ���� "ʳ������ ���������" �� �������� � �������� D22', '', 1, 'PARENT_KEY_NOT_EMPCOUNT');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '�������� ���� "��� ����������� ������(��. �����)" �� ������� � ����������� Territory', '', 1, 'PARENT_KEY_NOT_REG_TERRIT');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '�������� ���� "��� ���������� ������(��. ������)" �� �������� � �������� Territory', '', 1, 'PARENT_KEY_NOT_REG_TERRIT');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '�������������� ������', '', 1, 'ERR_NOT_DEFINED');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '������� �� ���������', '', 1, 'ERR_NOT_DEFINED');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '�� ������ �������� cig_15 - ���� ��������', '', 1, 'CIGDOG_PHASEID_NULL');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '�� ������� ������� cig_15 - ���� ��������', '', 1, 'CIGDOG_PHASEID_NULL');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '�� ������� ���� ���������� ��������', '', 1, 'CIGDOG_SDATE_NULL');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '�� ������� ���� ��������� ��������', '', 1, 'CIGDOG_SDATE_NULL');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '�� ������� ���� ������ �������� ��������', '', 1, 'CIGDOG_BDATE_NULL');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '�� ������� ���� ������� 䳿 ��������', '', 1, 'CIGDOG_BDATE_NULL');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '�� ������� ������ ��������', '', 1, 'CIGDOG_CURRENCY_NULL');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '�� ������� ������ ��������', '', 1, 'CIGDOG_CURRENCY_NULL');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '�� ������� ���� ���������� ��������� �������� ��������', '', 1, 'CIGDOG_ENDDATE_NULL');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '�� ������� ���� ����������� ��������� ��������', '', 1, 'CIGDOG_ENDDATE_NULL');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '�� ������ ��� �������', '', 1, 'CIG_GENDER_NULL');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '�� ������� ����� �볺���', '', 1, 'CIG_GENDER_NULL');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '��� �������� %s �� ������ ���� � ����� LIM', '', 1, 'CIG_ACCLIM_NOTFOUND');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '��� �������� %s �� �������� ������� � ����� LIM', '', 1, 'CIG_ACCLIM_NOTFOUND');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '������ �� ������� %s �����������', '', 1, 'CIG_CUST_NOTFOUND');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '��� �� �볺��� %s ������', '', 1, 'CIG_CUST_NOTFOUND');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '�� ������ �������� cig_18 - ������������� ��������', '', 1, 'CIGDOG_PAYPERIODID_NULL');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '�� ������� ������� cig_18 - ����������� �������', '', 1, 'CIGDOG_PAYPERIODID_NULL');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '�� ������ �������� cig_14 - ���� ��������������', '', 1, 'CIGDOG_CREDITPURPOSE_NULL');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '�� ������� ������� cig_14 - ��� ������������', '', 1, 'CIGDOG_CREDITPURPOSE_NULL');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '�� ����� ������ ��� ���. ����', '', 1, 'PARENT_KEY_NOT_GENDER');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '�� ���� ������� ����� ��� �����', '', 1, 'PARENT_KEY_NOT_GENDER');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '�������� ���� "��� ����������� ������(��. �����)" �� ����� ���� ������', '', 1, 'CIG_REG_TERRIT_NULL');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�������� ���� "��� ���������� ������(�������� ������)" �� ���� ���� ������', '', 1, 'CIG_REG_TERRIT_NULL');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '�������� ���� "��� ����������� ������ (����. �����)" �� ����� ���� ������, ���� ��������� ���� "�����, � ����, ����� ����, ���� (����. �����)"', '', 1, 'CIG_FACT_TER_N_STR_NN');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '�������� ���� "��� ���������� ������ (�������� ������)" �� ���� ���� ������, ���� ��������� ���� "������, � �������, ����� �������, ������ (�������� ������)"', '', 1, 'CIG_FACT_TER_N_STR_NN');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '�������� ���� "�����, � ����, ����� ����, ���� (����. �����)" �� ����� ���� ������, ���� ��������� ���� "��� ����������� ������ (����. �����)"', '', 1, 'CIG_FACT_TER_NN_STR_N');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '�������� ���� "������, � �������, ����� �������, ������ (�������� ������)" �� ���� ���� ������, ���� ��������� ���� "��� ���������� ������ (�������� ������)"', '', 1, 'CIG_FACT_TER_NN_STR_N');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '�������� ���� "���� ��������" �� ����� ���� ������ 01.01.1900 ��� ������ 01.01.2098', '', 1, 'CIG_BDATE_VAL');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '�������� ���� "���� ����������" �� ���� ���� ����� 01.01.1900 ��� ����� 01.01.2098', '', 1, 'CIG_BDATE_VAL');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '�� ����� ������ ��� ��������� ������� (��. �����)', '', 1, 'CIG_REG_POST_INDEX_VAL');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '�� ���� ������� ��� ��������� ������� (�������� ������)', '', 1, 'CIG_REG_POST_INDEX_VAL');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '�� ����� ������ ��� ��������� ������� (����. �����)', '', 1, 'CIG_FACT_POST_INDEX_VAL');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '�� ���� ������� ��� ��������� ������� (�������� ������)', '', 1, 'CIG_FACT_POST_INDEX_VAL');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '�������� ���� "���� ���������� ��������" �� ����� ���� ������ 01.01.1900 ��� ������ 01.01.2098', '', 1, 'CIG_STARTDT_VAL');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '�������� ���� "���� ��������� ��������" �� ���� ���� ����� 01.01.1900 ��� ����� 01.01.2098', '', 1, 'CIG_STARTDT_VAL');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '�������� ���� "���� ������ �������� ��������" �� ����� ���� ������ 01.01.1900 ��� ������ 01.01.2098', '', 1, 'CIG_BDT_VAL');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '�������� ���� "���� ������� 䳿 ��������" �� ���� ���� ����� 01.01.1900 ��� ����� 01.01.2098', '', 1, 'CIG_BDT_VAL');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '�������� ���� "��������� ���� ��������� ��������" �� ����� ���� ������ 01.01.1900 ��� ������ 01.01.2098', '', 1, 'CIG_ENDDT_VAL');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�������� ���� "��������� ���� ��������� ��������" �� ���� ���� ����� 01.01.1900 ��� ����� 01.01.2098', '', 1, 'CIG_ENDDT_VAL');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '�������� ���� "���� ������������ ��������� �������� ��������" �� ����� ���� ������ 01.01.1900 ��� ������ 01.01.2098', '', 1, 'CIG_DAZS_VAL');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '�������� ���� "���� ���������� ��������� 䳿 ��������" �� ���� ���� ����� 01.01.1900 ��� ����� 01.01.2098', '', 1, 'CIG_DAZS_VAL');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '�������� ���� "���� ���. �����������" �� ����� ���� ������ 01.01.1900 ��� ������ 01.01.2098', '', 1, 'CIG_REGDT_VAL');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '�������� ���� "���� ��������  ���������" �� ���� ���� ����� 01.01.1900 ��� ����� 01.01.2098', '', 1, 'CIG_REGDT_VAL');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CIG.sql =========*** Run *** ==
PROMPT ===================================================================================== 
