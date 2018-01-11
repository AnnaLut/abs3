PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SVC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ SVC ***
declare
  l_mod  varchar2(3) := 'SVC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '��������� � ����������� ��������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� %s �� ������.', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�������� %s �� ��������.', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������ ���������� �������: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��������� ������: %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'Error: %s sending on pipe', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'Error: %s sending on pipe', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'Invalid currency code', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'Invalid currency code', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������� ������� ������', '', 1, 'BASEVAL_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� �������� ������ ������', '', 1, 'BASEVAL_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ������ ���� acc=%s', '', 1, 'ACC_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� �������� ������� acc=%s', '', 1, 'ACC_NOT_FOUND');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '���������� ����������� ��������� ���������!', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '��������� ����������� ��������� ����������!', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�������� ����������� ��������� ���������!', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '��������� ����������� ��������� ����������!', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '����������� ��������� �������� ��� ���������� ��� ����������!', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '����������� ��������� �������� ��� ���� �� ����������!', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '����������� ���������� �������� ��� ���������� ��� ���������!', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '����������� ���������� �������� ��� ���� �� ��������!', '', 1, '13');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '������� ����� �������� 1 (��� �������)', '', 1, '20');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '������ ������� �������� 1 (��''� �������)', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '������� ����� �������� 2 (��� ������� ����� �������)', '', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '������ ������� �������� 2 (��''� ���� ����� �������)', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '������� ����� �������� 3 (��� ������� � LOB-��������)', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '������ ������� �������� 3 (��''� ���� � LOB-��''�����)', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '������ ���� ����� ���� �� ���������� 4 ��� 5', '', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '������� ������ ���� � ��������� 4 �� 5', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '������� ����� �������� 8 (���������� �������� 0/1)', '', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '������ ������� �������� 8 (�������� �������� 0/1)', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '���������� ��������� ����� ������� ��� ���������������� �������', '', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '��������� ����������� ����� ������� ��� ������ �����������', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '�������� ������ ��������� "������� �������������� �����"', '', 1, 'ROLEAUTH_PARAM_FORMAT');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '�������� ������ ��������� "������� �������������� �����"', '', 1, 'ROLEAUTH_PARAM_FORMAT');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '������������ �������� ��������� "������� �������������� �����"', '', 1, 'ROLEAUTH_PARAM_VALUE');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '����������� �������� ��������� "������� �������������� �����"', '', 1, 'ROLEAUTH_PARAM_VALUE');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '�������� ����� ������� ��������� ���� [%s]', '', 1, 'ROLEAUTH_INVALID_CALL');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '���������� ������ ������� ������������ ��� [%s]', '', 1, 'ROLEAUTH_INVALID_CALL');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '���� %s �� ������� ��� �� �������', '', 1, 'ROLE_NOT_FOUND');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '���� %s �� �������� ��� �� �������', '', 1, 'ROLE_NOT_FOUND');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '���� %s ������� ���������� ���������', '', 1, 'ROLEAUTH_REQUIRED');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '���� %s ������� �������� ���������', '', 1, 'ROLEAUTH_REQUIRED');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '���� %s ������� ��������� �����������', '', 1, 'APPAUTH_REQUIRED');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '���� %s ������� ��������� ��������', '', 1, 'APPAUTH_REQUIRED');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '������� ������ ����������� �� ������������ � ������� �� ��� ���������', '', 1, 'PAYDOCFULL_INVALID_BRANCH');
    bars_error.add_message(l_mod, 40, l_exc, l_ukr, '������� ������ ����������� �� ������������ � ������� �� ��� ���������', '', 1, 'PAYDOCFULL_INVALID_BRANCH');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '������ ��� ������� ��������� (���. %s): %s', '', 1, 'PAYDOCFULL_DOC_ERROR');
    bars_error.add_message(l_mod, 41, l_exc, l_ukr, '������ ��� ������� ��������� (���. %s): %s', '', 1, 'PAYDOCFULL_DOC_ERROR');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '������� ��������� (���. %s) �������� ��-�� ������', '', 1, 'PAYDOCFULL_DOC_SKIP');
    bars_error.add_message(l_mod, 42, l_exc, l_ukr, '������� ��������� (���. %s) �������� ��-�� ������', '', 1, 'PAYDOCFULL_DOC_SKIP');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '�������� ���������� �������������� ��������� ��������� (���. ���. %s)', '', 1, 'PAYDOCFULL_EXTDOC_DEBIT');
    bars_error.add_message(l_mod, 43, l_exc, l_ukr, '�������� ���������� �������������� ��������� ��������� (���. ���. %s)', '', 1, 'PAYDOCFULL_EXTDOC_DEBIT');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '�������� ���������� ��������� � TransMaster ��������� (���. ���. %s)', '', 1, 'PAYDOCFULL_TRANSMASTER_DEBIT');
    bars_error.add_message(l_mod, 44, l_exc, l_ukr, '�������� ���������� ��������� � TransMaster ��������� (���. ���. %s)', '', 1, 'PAYDOCFULL_TRANSMASTER_DEBIT');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '���������� ���������� ������� ��������� ��� ������ (���. ���. %s)', '', 1, 'PAYDOCFULL_PAYSIDE_ERROR');
    bars_error.add_message(l_mod, 45, l_exc, l_ukr, '���������� ���������� ������� ��������� ��� ������ (���. ���. %s)', '', 1, 'PAYDOCFULL_PAYSIDE_ERROR');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '���������� ���������� ���� �� ������������� ��������� (���. ���. %s)', '', 1, 'PAYDOCFULL_BRANCH_ERROR');
    bars_error.add_message(l_mod, 46, l_exc, l_ukr, '���������� ���������� ���� �� ������������� ��������� (���. ���. %s)', '', 1, 'PAYDOCFULL_BRANCH_ERROR');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '�������� ��. %s �� ������', '', 1, 'DPZTBARS_DOC_NOTFOUND');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�������� ��. %s �� ������', '', 1, 'DPZTBARS_DOC_NOTFOUND');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '�������� ��. %s ��� �������� �� ������� �������', '', 1, 'DPZTBARS_DOC_ISPAYED');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '�������� ��. %s ��� �������� �� ������� �������', '', 1, 'DPZTBARS_DOC_ISPAYED');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '�������� ��. %s �� � ��������� "����������"', '', 1, 'DPZTBARS_INVALID_DOCSTATE');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '�������� ��. %s �� � ��������� "����������"', '', 1, 'DPZTBARS_INVALID_DOCSTATE');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '�������� ��. %s (�� ��. %s) �� ����� ���� ������', '', 1, 'DPZTBARS_INVALID_EXTDOCSTATE');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '�������� ��. %s (�� ��. %s) �� ����� ���� ������', '', 1, 'DPZTBARS_INVALID_EXTDOCSTATE');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '���������� ������������ ��� ���������� ����� (%s)', '', 1, 'DPZTBARS_ACCLCK_INVALIDCODE');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '���������� ������������ ��� ���������� ����� (%s)', '', 1, 'DPZTBARS_ACCLCK_INVALIDCODE');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '������ �������� ����. �������� �� ��������� %s � ���: %s', '', 1, 'DPZTBARS_DOC2ODB_ERRSEND');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '������ �������� ����. �������� �� ��������� %s � ���: %s', '', 1, 'DPZTBARS_DOC2ODB_ERRSEND');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, '��������� �������� �� ��������� ��. %s ���������� � ���, �������� �����������', '', 1, 'DPZTBARS_DOC2ODB_INCONSEXPTX');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '��������� �������� �� ��������� ��. %s ���������� � ���, �������� �����������', '', 1, 'DPZTBARS_DOC2ODB_INCONSEXPTX');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, '�� ����� ���������� �������� %s', '', 1, 'ODB_PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 67, l_exc, l_ukr, '�� ������� ���������� �������� %s', '', 1, 'ODB_PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, '������ ������������� ������ dpzt_odb_init_ver � ����������� (%s, %s)', '', 1, 'ODB_INIT_FAILED');
    bars_error.add_message(l_mod, 68, l_exc, l_ukr, '������� ����������� ������ dpzt_odb_init_ver � ����������� (%s, %s)', '', 1, 'ODB_INIT_FAILED');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, '�� ������ �������� ���������� ���� � ��� Oracle', '', 1, 'ODB_BANKDATE_NOT_FOUND');
    bars_error.add_message(l_mod, 69, l_exc, l_ukr, '�� �������� ������� ����.���� � ��� Oracle', '', 1, 'ODB_BANKDATE_NOT_FOUND');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, '���������� ���� %s ������', '', 1, 'DPZTBARS_BANKDATE_CLOSED');
    bars_error.add_message(l_mod, 70, l_exc, l_ukr, '���������� ���� %s ������', '', 1, 'DPZTBARS_BANKDATE_CLOSED');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, '���������� ���� %s �� ������', '', 1, 'DPZTBARS_BANKDATE_NOTFOUND');
    bars_error.add_message(l_mod, 71, l_exc, l_ukr, '���������� ���� %s �� ��������', '', 1, 'DPZTBARS_BANKDATE_NOTFOUND');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, '���������� ������������� ��������� %s �� ���', '', 1, 'DPZTBARS_ERROR_IMPORTDOC');
    bars_error.add_message(l_mod, 72, l_exc, l_ukr, '��������� �������� ������ ��������� %s � ���', '', 1, 'DPZTBARS_ERROR_IMPORTDOC');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, '��������� � ���: ������ ������������� ���-�� ������: %s', '', 1, 'DPZTBARS_BANKSYNC_FAILED');
    bars_error.add_message(l_mod, 73, l_exc, l_ukr, '��������� � ���: ������� ������������ �������� �����: %s', '', 1, 'DPZTBARS_BANKSYNC_FAILED');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, '��������� � ���: ������ ������������� ���-�� �����: %s', '', 1, 'DPZTBARS_CURRSYNC_FAILED');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, '��������� � ���: ������� ������������ �������� �����: %s', '', 1, 'DPZTBARS_CURRSYNC_FAILED');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, '��������� � ���: ������ ������������� ������ �����: %s', '', 1, 'DPZTBARS_RATESYNC_FAILED');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, '��������� � ���: ������� ������������ ����� �����: %s', '', 1, 'DPZTBARS_RATESYNC_FAILED');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, '��������� � ���: ������ ������������� ���-�� ������������� �����: %s', '', 1, 'DPZTBARS_BRANCHSYNC_FAILED');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, '��������� � ���: ������� ������������ �������� �������� �����: %s', '', 1, 'DPZTBARS_BRANCHSYNC_FAILED');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '�������� ����������� �������� ���������', '', 1, 'LICENSE_INCORRECT');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '�������� ����������� �������� ���������', '', 1, 'LICENSE_INCORRECT');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '���� �������� �������� ��������� �����', '', 1, 'LICENSE_EXPIRED');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '���� �������� �������� ��������� �����', '', 1, 'LICENSE_EXPIRED');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '���� �������� �������� ��������� �������� ����� %s ����', '', 1, 'LICENSE_GREYTIME');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '���� �������� �������� ��������� �������� ����� %s ����', '', 1, 'LICENSE_GREYTIME');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '�������� ����������� ������������ ���������� ������������ "%s"', '', 1, 'LICENSE_USER_INCORRECT');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '�������� ����������� ������������ ���������� ������������ "%s"', '', 1, 'LICENSE_USER_INCORRECT');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, '������� ����� ��������� ������������� ��������� "%s"', '', 1, 'LICENSE_USER_DELETED');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, '������� ����� ��������� ������������� ��������� "%s"', '', 1, 'LICENSE_USER_DELETED');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '���� �������� ��������� ������� ������ "%s" �����', '', 1, 'LICENSE_USER_EXPIRED');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, '���� �������� ��������� ������� ������ "%s" �����', '', 1, 'LICENSE_USER_EXPIRED');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, '���������� ����������� ������������ ���������� ������������ "%s" - ��������� ���������� ��������', '', 1, 'LICENSE_USER_EXCEEDLIMIT');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, '���������� ����������� ������������ ���������� ������������ "%s" - ��������� ���������� ��������', '', 1, 'LICENSE_USER_EXCEEDLIMIT');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, '�������� ����������� ��������� ������� "%s"', '', 1, 'LICENSE_USER_EXPIREPARAM');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, '�������� ����������� ��������� ������� "%s"', '', 1, 'LICENSE_USER_EXPIREPARAM');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, '���������� ����������� ������������ ���������� ������������ "%s" - ��������� ���������� ��������� ������� �������', '', 1, 'LICENSE_USER_TEMPLIMITEXCEED');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, '���������� ����������� ������������ ���������� ������������ "%s" - ��������� ���������� ��������� ������� �������', '', 1, 'LICENSE_USER_TEMPLIMITEXCEED');

    bars_error.add_message(l_mod, 110, l_exc, l_rus, '������� ������ ��� ������������ ���������������� ��������: %s', '', 1, 'LICENSE_REVALIDATE_USER_ERRORS');
    bars_error.add_message(l_mod, 110, l_exc, l_ukr, '������� ������ ��� ������������ ���������������� ��������: %s', '', 1, 'LICENSE_REVALIDATE_USER_ERRORS');

    bars_error.add_message(l_mod, 130, l_exc, l_rus, '�� ������� ������� ������ ������������ "%s"', '', 1, 'LICENSE_USERNAME_NOT_FOUND');
    bars_error.add_message(l_mod, 130, l_exc, l_ukr, '�� ������� ������� ������ ������������ "%s"', '', 1, 'LICENSE_USERNAME_NOT_FOUND');

    bars_error.add_message(l_mod, 131, l_exc, l_rus, '������� ������ ���������� ������������ "%s" ������� � ��', '', 1, 'LICENSE_USERACCOUNT_EXISTS');
    bars_error.add_message(l_mod, 131, l_exc, l_ukr, '������� ������ ���������� ������������ "%s" ������� � ��', '', 1, 'LICENSE_USERACCOUNT_EXISTS');

    bars_error.add_message(l_mod, 132, l_exc, l_rus, '��� ������ %s ������ ���� �����������', '', 1, '132');
    bars_error.add_message(l_mod, 132, l_exc, l_ukr, '��� ������ %s ������� ���� ����������', '', 1, '132');

    bars_error.add_message(l_mod, 133, l_exc, l_rus, '���� %s �� ����������. �������� ������� ������ ����', '', 1, '133');
    bars_error.add_message(l_mod, 133, l_exc, l_ukr, '���� %s �� ����. ������� �������� ����� ����', '', 1, '133');

    bars_error.add_message(l_mod, 134, l_exc, l_rus, '������� ��� ������� %s �� ����������', '', 1, '134');
    bars_error.add_message(l_mod, 134, l_exc, l_ukr, '������� �� ������� %s �� ����', '', 1, '134');

    bars_error.add_message(l_mod, 135, l_exc, l_rus, '���������� ������ ���� %s ������������ %s', '', 1, '135');
    bars_error.add_message(l_mod, 135, l_exc, l_ukr, '��������� ������ ���� %s ����������� %s', '', 1, '135');

    bars_error.add_message(l_mod, 151, l_exc, l_rus, '�������� ������������� %s �� ������ (������������� %s)', '', 1, 'BRANCHPARAM_NOTEXISTS');
    bars_error.add_message(l_mod, 151, l_exc, l_ukr, '�������� ������������� %s �� ������ (������������� %s)', '', 1, 'BRANCHPARAM_NOTEXISTS');

    bars_error.add_message(l_mod, 171, l_exc, l_rus, '���������� �������������� ��������� ���������', '', 1, 'INPDOC_LOCAL_INFDOC_DENY');
    bars_error.add_message(l_mod, 171, l_exc, l_ukr, '������� ����������� ��������� ���������', '', 1, 'INPDOC_LOCAL_INFDOC_DENY');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SVC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
