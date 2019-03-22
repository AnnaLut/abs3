declare
  l_mod  varchar2(3) := 'DOC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������ ����������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Document not found: REF=%s', '', 1, 'REF_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� �� ������: REF=%s', '', 1, 'REF_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�������� �� ��������: REF=%s', '', 1, 'REF_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Day closed! Impossible execute operation!', '', 1, 'DAY_IS_CLOSED');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, '���� ������! ���������� ��������� ��������!', '', 1, 'DAY_IS_CLOSED');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '���������� ���� �������! ��������� �������� ��������!', '', 1, 'DAY_IS_CLOSED');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Document on closed bank date: DAT=%s', '', 1, 'DOC_CLOSED_DAY');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�������� �� �������� ���������� ����: DAT=%s', '', 1, 'DOC_CLOSED_DAY');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�������� �� ������� ��������� ����: DAT=%s', '', 1, 'DOC_CLOSED_DAY');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Impossible BACK document: sent from bank in file %s', '', 1, 'BACK_FNB');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, '������ ������ ��������: ��������� �� ����� � ����� %s', '', 1, 'BACK_FNB');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '��������� �������� ��������: ���������� � ����� � ���� %s', '', 1, 'BACK_FNB');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Impossible BACK document: sent to ODB', '', 1, 'BACK_ODB');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, '������ ������ ��������: ������� � ���', '', 1, 'BACK_ODB');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��������� ��������: �������� � ���', '', 1, 'BACK_ODB');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Impossible BACK subdocument REF=%s', '', 1, 'BACK_REFL');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, '������ ������ �������� �������� REF=%s', '', 1, 'BACK_REFL');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '��������� �������� ������� �������� REF=%s', '', 1, 'BACK_REFL');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Impossible BACK document: REF=%s - sent on ANELIC', '', 1, 'BACK_ANELIC');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ ������ ��������: REF=%s - ��������� �� ������', '', 1, 'BACK_ANELIC');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '��������� �������� ��������: REF=%s - ���������� �� ������', '', 1, 'BACK_ANELIC');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '����������� ��������� ND (����� ���������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_ND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '����������� �������� ND (����� ���������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_ND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '����������� ��������� DATD (���� ���������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_DATD');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '����������� �������� DATD (���� ���������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_DATD');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '����������� ��������� VOB (��� ���������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_VOB');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '����������� �������� VOB (��� ���������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_VOB');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '����������� ��������� DK (������� �����/������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_DK');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '����������� �������� DK (������ �����/������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_DK');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '����������� ��������� MFOA (��� �����������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_MFOA');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '����������� �������� MFOA (��� ����������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_MFOA');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '����������� ��������� NLSA (���� �����������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_NLSA');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '����������� �������� NLSA (������� ����������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_NLSA');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '����������� ��������� KV (������ �) ��������� ��������. �������� ��������.', '', 1, 'GUARD_KV');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '����������� �������� KV (������ �) ���������� ��������. �������� ��������.', '', 1, 'GUARD_KV');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '����������� ��������� S (�����) ��������� ��������. �������� ��������.', '', 1, 'GUARD_S');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '����������� �������� S (����) ���������� ��������. �������� ��������.', '', 1, 'GUARD_S');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '����������� ��������� MFOB (��� ����������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_MFOB');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '����������� �������� MFOB (��� ����������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_MFOB');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '����������� ��������� NLSB (���� ����������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_NLSB');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '����������� �������� NLSB (������� ����������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_NLSB');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '����������� ��������� KV2 (������ �) ��������� ��������. �������� ��������.', '', 1, 'GUARD_KV2');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '����������� �������� KV2 (������ �) ���������� ��������. �������� ��������.', '', 1, 'GUARD_KV2');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '����������� ��������� S2 (����� 2) ��������� ��������. �������� ��������.', '', 1, 'GUARD_S2');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '����������� �������� S2 (���� 2) ���������� ��������. �������� ��������.', '', 1, 'GUARD_S2');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '����������� ��������� NAZN (���������� �������) ��������� ��������. �������� ��������.', '', 1, 'GUARD_NAZN');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '����������� �������� NAZN (����������� �������) ���������� ��������. �������� ��������.', '', 1, 'GUARD_NAZN');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '���������� ����������: ������ ��������� %s) ��������������!', '', 1, 'FM_STOPVISA');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'Բ�������� ��Ͳ������: ������ ��������� %s ���������!', '', 1, 'FM_STOPVISA');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, 'EVAL_OP_FIELD: ���. �������� %s � �������� %s �����������!', '', 1, 'OP_RULES_NOT_FOUND');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, 'EVAL_OP_FIELD: ���. ������� %s � �������� %s �������!', '', 1, 'OP_RULES_NOT_FOUND');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, 'EVAL_OP_FIELD: ���. �������� %s �� ������!', '', 1, 'OP_FIELD_NOT_FOUND');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, 'EVAL_OP_FIELD: ���. ������� %s �� ��������!', '', 1, 'OP_FIELD_NOT_FOUND');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, 'EVAL_OP_FIELD: �� ����� �������� ��� ���������� �������� ���. ��������� %s � �������� %s!', '', 1, 'PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, 'EVAL_OP_FIELD: �� ������ �������� ��� ���������� �������� ���. �������� %s � �������� %s!', '', 1, 'PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, 'EVAL_OP_FIELD: �� ������� �������� ���. ��������� %s � �������� %s!', '', 1, 'OP_FIELD_NO_DATA_FOUND');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, 'EVAL_OP_FIELD: �� �������� �������� ���. �������� %s � �������� %s!', '', 1, 'OP_FIELD_NO_DATA_FOUND');

    bars_error.add_message(l_mod, 26, l_exc, l_eng, 'Transaction ''%s'' does not exist', 'Contact to administrator', 1, 'TRANSACTION_DOES_NOT_EXIST');
    bars_error.add_message(l_mod, 26, l_exc, l_geo, 'Transaction ''%s'' does not exist', 'Contact to administrator', 1, 'TRANSACTION_DOES_NOT_EXIST');
    bars_error.add_message(l_mod, 26, l_exc, l_rus, '�������� ''%s'' �� ����������', '���������� � �������������� ���', 1, 'TRANSACTION_DOES_NOT_EXIST');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '�������� ''%s'' �� ����', '��������� �� ������������ ���', 1, 'TRANSACTION_DOES_NOT_EXIST');

    bars_error.add_message(l_mod, 27, l_exc, l_eng, 'Transaction ''%s'' not allowed', 'Contact to administrator', 1, 'TRANSACTION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 27, l_exc, l_geo, 'Transaction ''%s'' not allowed', 'Contact to administrator', 1, 'TRANSACTION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 27, l_exc, l_rus, '�������� ''%s'' �� ���������', '���������� � �������������� ���', 1, 'TRANSACTION_NOT_ALLOWED');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '�������� ''%s'' �� ���������', '��������� �� ������������ ���', 1, 'TRANSACTION_NOT_ALLOWED');

    bars_error.add_message(l_mod, 28, l_exc, l_eng, 'Tag ''%s'' not allowed', 'Contact to administrator', 1, 'TAG_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_geo, 'Tag ''%s'' not allowed', 'Contact to administrator', 1, 'TAG_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_rus, '��� ''%s'' �� ������', '���������� � �������������� ���', 1, 'TAG_NOT_FOUND');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '��� ''%s'' �� ��������', '��������� �� ������������ ���', 1, 'TAG_NOT_FOUND');

    bars_error.add_message(l_mod, 29, l_exc, l_eng, 'The value of tag ''%s'' is incorrect', 'Type correct tag value', 1, 'TAG_INVALID_VALUE');
    bars_error.add_message(l_mod, 29, l_exc, l_geo, 'The value of tag ''%s'' is incorrect', 'Type correct tag value', 1, 'TAG_INVALID_VALUE');
    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�������� ��������� ''%s'' ������� �����������', '������� ���������� �������� ���������', 1, 'TAG_INVALID_VALUE');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '�������� �������� ''%s'' ������� ����������', '������ �������� �������� ��������', 1, 'TAG_INVALID_VALUE');

    bars_error.add_message(l_mod, 30, l_exc, l_eng, 'Cleared pay of SEP transaction ''%s'' without visa is denied', 'Contact to administrator', 1, 'SEP_TRANS_VISA_REQ');
    bars_error.add_message(l_mod, 30, l_exc, l_geo, 'Cleared pay of SEP transaction ''%s'' without visa is denied', 'Contact to administrator', 1, 'SEP_TRANS_VISA_REQ');
    bars_error.add_message(l_mod, 30, l_exc, l_rus, '����������� ������ �������� ��� ''%s'' ��� ��� ���������', '���������� � �������������� ���', 1, 'SEP_TRANS_VISA_REQ');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '�������� ������ �������� ��� ''%s'' ��� �� ����������', '��������� �� ������������ ���', 1, 'SEP_TRANS_VISA_REQ');

    bars_error.add_message(l_mod, 31, l_exc, l_eng, 'Mandatory tag ''%s'' is absent for transaction ''%s''', 'Contact to administrator', 1, 'MANDATORY_TAG_ABSENT');
    bars_error.add_message(l_mod, 31, l_exc, l_geo, 'Mandatory tag ''%s'' is absent for transaction ''%s''', 'Contact to administrator', 1, 'MANDATORY_TAG_ABSENT');
    bars_error.add_message(l_mod, 31, l_exc, l_rus, '����������� ������������ �������� ''%s'' ��� �������� ''%s''', '���������� � �������������� ���', 1, 'MANDATORY_TAG_ABSENT');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '³������ ����''������� ������� ''%s'' ��� �������� ''%s''', '��������� �� ������������ ���', 1, 'MANDATORY_TAG_ABSENT');

    bars_error.add_message(l_mod, 32, l_exc, l_eng, 'Card account is incorrect!', '', 1, 'UNCORRECT_CARD_ACCT');
    bars_error.add_message(l_mod, 32, l_exc, l_rus, '������� ������ ����������� ����!', '', 1, 'UNCORRECT_CARD_ACCT');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '������ ������� �������� �������!', '', 1, 'UNCORRECT_CARD_ACCT');

    bars_error.add_message(l_mod, 33, l_exc, l_geo, 'Unable to back backed document ref# %s', '', 1, 'BACK_BACK');
    bars_error.add_message(l_mod, 33, l_exc, l_rus, '������� ��������� �������� ������ ��� � %s', '', 1, 'BACK_BACK');
    bars_error.add_message(l_mod, 33, l_exc, l_ukr, '������ ���������� ������ ��� � %s', '', 1, 'BACK_BACK');

    bars_error.add_message(l_mod, 34, l_exc, l_geo, 'Unable to back document on past bank day', '', 1, 'PAST_DAY');
    bars_error.add_message(l_mod, 34, l_exc, l_rus, '���������� ������������ �������� ������� ���������� �����', '', 1, 'PAST_DAY');
    bars_error.add_message(l_mod, 34, l_exc, l_ukr, '��������� ���������� �������� ���������� �����, �� ������', '', 1, 'PAST_DAY');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '�������� �������� ���.��������� %s - ������ ���� �����', '', 1, 'VALUE_NOT_NUMBER');
    bars_error.add_message(l_mod, 35, l_exc, l_ukr, '������ �������� ���.�������� %s - ������� ���� �����', '', 1, 'VALUE_NOT_NUMBER');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '�������� �������� ���.��������� %s - ������ ���� ����', '', 1, 'VALUE_NOT_DATE');
    bars_error.add_message(l_mod, 36, l_exc, l_ukr, '������ �������� ���.�������� %s - ������� ���� ����', '', 1, 'VALUE_NOT_DATE');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '�������� ����� ������������ ������ �������������, ������� ��� ����!', '', 1, 'REF_STORNOUSER');
    bars_error.add_message(l_mod, 37, l_exc, l_ukr, '�������� ����� ���������� ����� ������������, �� ���� ���!', '', 1, 'REF_STORNOUSER');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '�������� �������� ���.��������� %s - ������ ���� DECIMAL', '', 1, 'VALUE_NOT_DECIMAL');
    bars_error.add_message(l_mod, 38, l_exc, l_ukr, '������ �������� ���.�������� %s - ������� ���� DECIMAL', '', 1, 'VALUE_NOT_DECIMAL');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '������ ������ �������� %s ������� �� ������, ����������� ������� ��������������� �������', '', 1, 'BACK_LOM');
    bars_error.add_message(l_mod, 39, l_exc, l_ukr, '��������� �������� �������� %s ������� �� ������, �������������� ������� ������������� �������', '', 1, 'BACK_LOM');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '����������� ���. �������� PFU!!!', '', 1, 'PFU_NOT_FOUND');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '³������ ���. ������� PFU!!!', '', 1, 'PFU_NOT_FOUND');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '���. �������� PFU ������!!!', '', 1, 'PFU_IS_NULL');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '���. ������� PFU ������!!!', '', 1, 'PFU_IS_NULL');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '��������� ����� ������� �������� ��������� �� ������������ ���� (���������� ����� 150 ���. ���.)!', '', 1, 'SUM_IS_GREATER');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '���������� ���� ������� �������� ������� �� ����������� ����(��������� ����� 150 ���. ���.)!', '', 1, 'SUM_IS_GREATER');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '���������� ����������: ��������� ��������� ������� � %s �� %s ��� ��������� %s', '', 1, 'FM_ERROR_STATUS');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, 'Բ�������� ��Ͳ������: ���������� ���� ������� � %s �� %s ��� ��������� %s', '', 1, 'FM_ERROR_STATUS');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '���. �������� <������������ ��������� � ������������� ��������> ������!!!', '', 1, 'NDREZ_IS_NULL');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '���. ������� <������������ ��������� ��� ���������� ������> ������!!!', '', 1, 'NDREZ_IS_NULL');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '������������� "���� ���������" � "�������� ������������"', '', 1, 'NAMED_REZ');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '������������ "���� ���������" �� "������ �����������"', '', 1, 'NAMED_REZ');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '������������ ������ ����� �\��� ������ ���������', '', 1, 'DOC_FORMAT');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '������������ ������ ���賿 �\�� ������ ���������', '', 1, 'DOC_FORMAT');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '%s. ', '', 1, 'INSIDE_ERRR');
    bars_error.add_message(l_mod, 47, l_exc, l_ukr, '%s. ', '', 1, 'INSIDE_ERRR');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '���� %s �� ���������! ', '', 1, 'FIELD_ERRR');
    bars_error.add_message(l_mod, 48, l_exc, l_ukr, '���� %s �� ���������! ', '', 1, 'FIELD_ERRR');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '������ ������! ', '', 1, 'DATA_ERRR');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '������� �����! ', '', 1, 'DATA_ERRR');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '��������� ������� �������� %s �� ������ ������������ � ����!', '', 1, 'BACK_IMM');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '���������� �������� �������� %s �� �����, �� ������� �� ����!', '', 1, 'BACK_IMM');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '������������� ����� %s (���� ��������� �������� ������ ��������� ���� ��������)', '', 1, 'TARIF_DAT');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '����� %s �� � ����� (���� ���������� 䳿 ������ �������� ���� ��������)!', '', 1, 'TARIF_DAT');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� �������� �������� %s ', '', 1, 'DJNR_NOT_FOUND');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� �������� �������� %s ', '', 1, 'DJNR_NOT_FOUND');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '�������������� �������� "�������������" ��������� (��� %s, rezid %s) �� ������������� ������������� ������� %s: %s', '', 1, 'CHECK_REZID_DOC_FAILED');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '���������� ������� "������������" ��������� (��� %s, rezid %s) �� ������� ������������ �볺��� %s: %s', '', 1, 'CHECK_REZID_DOC_FAILED');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '��������� ���������� ������� ���������� �� ������ ���', '', 1, 'CASH_MFO');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '���������� ���������� ������� ��������� �� ��� ���', '', 1, 'CASH_MFO');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '������ ������� � ������ �������� ����2 %s. ������: %s', '', 1, 'ERROR_AUTO_PAY');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '������� ������ ��������� ����2  ����2 %s. �������: %s ', '', 1, 'ERROR_AUTO_PAY');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '������ ������� ��������� ����2 � arc_rrp: %s. ��� EXT_REF=%s, REF=%s', '', 1, 'SDO_AUTO_PAY_INSEP_ERROR');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '������� �������� ��������� ����2 � arc_rrp: %s. ��� EXT_REF=%s, REF=%s', '', 1, 'SDO_AUTO_PAY_INSEP_ERROR');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '������ ������ ������� %s ��� ������������ ������� ��� �� ������������: %s', '', 1, 'ERROR_COMPILE');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '������� �������� ������� %s ��� ������������ ������� ��� �� ������������: %s', '', 1, 'ERROR_COMPILE');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '������ ������� ������ ��� �%s ��� ���������� ref=%s', '', 1, 'ERROR_IN_PUT_BIS');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '������� ������� ������ �� �%s ��� ���������� ref=%s', '', 1, 'ERROR_IN_PUT_BIS');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '������� ������ ������ �� ������� %s: %s', '', 1, 'ERROR_GRANT');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '������� ������ ������ �� ������� %s: %s', '', 1, 'ERROR_GRANT');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '�������� EXT_REF=%s, REF=%s � ������� ����� ������������� %s, ����� ��������� � ���� �������������', '', 1, 'FUTURE_VALUE_DATE');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�������� EXT_REF=%s, REF=%s � ���������� ����� ����������� %s, ���� ��������� � ���� �����������', '', 1, 'FUTURE_VALUE_DATE');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '�������� EXT_REF=%s, REF=%s �� �������� �� �����', '', 1, 'FAILED_TO_PAY_BY_FACT');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '�������� EXT_REF=%s, REF=%s �� �������� �� �����', '', 1, 'FAILED_TO_PAY_BY_FACT');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '�������� REF=%s ��� ���� ����������', '', 1, 'HAS_BEEN_BACKED_YET');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '�������� REF=%s ��� ���� ����������', '', 1, 'HAS_BEEN_BACKED_YET');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '�������� REF=%s �� ������� ���������� � ������� ��������� ��� %s', '', 1, 'BAK_IN_CLOSED_DAY');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '�������� REF=%s �� ������� ���������� � ������� ��������� ��� %s', '', 1, 'BAK_IN_CLOSED_DAY');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '�������� REF=%s �� ������� ���������� � ������ ��������� ��� %s', '', 1, 'BAK_IN_PAST');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '�������� REF=%s �� ������� ���������� � ������ ��������� ��� %s', '', 1, 'BAK_IN_PAST');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, '�������� ���/��� REF=%s �� ������� ����������, ���������� � ���� %s', '', 1, 'BAK_SEP_IN_FILE');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '�������� ���/��� REF=%s �� ������� ����������, ���������� � ���� %s', '', 1, 'BAK_SEP_IN_FILE');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, '�������� REF=%s �� ������� ����������, ����������� � ������ ��������� �������', '', 1, 'BAK_IMMOBILE_DOC');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, ����������� � ������ ��������� �������', '', 1, 'BAK_IMMOBILE_DOC');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, '�������� REF=%s �� ������� ����������, ���� ���������� �� ��������� � ���� %s', '', 1, 'BAK_PC_DOC');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, ���� ���������� �� ��������� � ���� %s', '', 1, 'BAK_PC_DOC');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, '�������� REF=%s �� ������� ����������, ���� ���������� �� ���������� ��� � ���� %s', '', 1, 'BAK_NBU_DCP_DOC');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, ���� ���������� �� ���������� ��� � ���� %s', '', 1, 'BAK_NBU_DCP_DOC');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, '�������� REF=%s �� ������� ����������, �������� � ������� �� ����-�� ��� = %s', '', 1, 'BAK_CHILD_DOC');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, �������� � ������� �� ����-�� ��� = %s', '', 1, 'BAK_CHILD_DOC');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, '�������� �� REF=%s �� ������� ����������, ������� ��������� ����������� ������ %s', '', 1, 'BAK_CPDEACTIVATE_ERROR');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, '�������� �� REF=%s �� ������� ����������, ������� ��������� ����������� ������ = %s', '', 1, 'BAK_CPDEACTIVATE_ERROR');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, '�������� REF=%s �� ������� ����������, ������� ��������� ������ ���������� �� ����������� ��������: %s', '', 1, 'BAK_INTRECONINGS_ERROR');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, ������� ��������� ������ ���������� �� ����������� ��������: %s', '', 1, 'BAK_INTRECONINGS_ERROR');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, '�������� REF=%s �� ������� ����������, ������� ��������� ������ ���������� �� ����������� ��������: %s', '', 1, 'BAK_ACRDOCS_ERROR');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, ������� ��������� ������ ���������� �� ����������� ��������: %s', '', 1, 'BAK_ACRDOCS_ERROR');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, '�������� REF=%s �� ������� ����������, �������� ������������ �������� BAK (���� 38 ������� ������ � �������� 0)', '', 1, 'BAK_CAN_MAKE_REDSALDO');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, �������� ������������ �������� BAK (���� 38 ������� ������ � �������� 0)', '', 1, 'BAK_CAN_MAKE_REDSALDO');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, '�������� REF=%s �� ������� ����������, ����������� ����� �� ������� %s', '', 1, 'BAK_BROKEN_LIMIT');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, '�������� REF=%s �� ������� ����������, ����������� ����� �� ������� %s', '', 1, 'BAK_BROKEN_LIMIT');



  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_DOC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
