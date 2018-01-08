PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ADM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ ADM ***
declare
  l_mod  varchar2(3) := 'ADM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�����������������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Profile %s not found', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������� %s �� ������', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� %s �� ����', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Incorrect profiles synchronization type', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�������� ��� ������������� ��������', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��� ������������ �������', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Incorrect profiles synchronization action type', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�������� ��� �������� ������������� ��������', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������� ��� 䳿 ������������ �������', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Profile %s already exists', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, '������� %s ��� ����������', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������� %s ��� ����', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Password authentification function %s not found', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, '������� �������� ������ %s �� �������', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '������� �������� ������ %s �� ��������', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_geo, 'Impossible drop remote database user', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_rus, '������ ������� ������������ ��������� ���� ������', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '��������� �������� ����������� �������� ���� �����', '', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_geo, 'Record not found!', '', 1, 'RECORD_NOT_FOUND');
    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ �� �������!', '', 1, 'RECORD_NOT_FOUND');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '����� �� ��������!', '', 1, 'RECORD_NOT_FOUND');

    bars_error.add_message(l_mod, 8, l_exc, l_geo, 'User with ID %s not found', '', 1, 'USER_NOT_FOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_rus, '������������ � ��. %s �� ������', '', 1, 'USER_NOT_FOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '����������� � ��. %s �� ��������', '', 1, 'USER_NOT_FOUND');

    bars_error.add_message(l_mod, 9, l_exc, l_geo, 'User not account manager', '', 1, 'USER_NOT_ACCOWN');
    bars_error.add_message(l_mod, 9, l_exc, l_rus, '������������ �� �������� �����.������������', '', 1, 'USER_NOT_ACCOWN');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '���������� �� � �����. ����������', '', 1, 'USER_NOT_ACCOWN');

    bars_error.add_message(l_mod, 10, l_exc, l_geo, 'Impossible drop user %s', '', 1, 'NO_DELETE_THIS_USER');
    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�������� ������������ %s ����������', '', 1, 'NO_DELETE_THIS_USER');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '��������� ����������� %s ���������', '', 1, 'NO_DELETE_THIS_USER');

    bars_error.add_message(l_mod, 11, l_exc, l_geo, 'Impossible drop remote branch user', '', 1, 'DELETE_REMOTE_BRANCH_USER');
    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�������� ������������ ���������� ��������� ����������', '', 1, 'DELETE_REMOTE_BRANCH_USER');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '��������� ����������� ���������� �������� ���������', '', 1, 'DELETE_REMOTE_BRANCH_USER');

    bars_error.add_message(l_mod, 12, l_exc, l_geo, 'Sign "account manager" set incorrectly', '', 1, 'INVALID_USERTYPE_PARAMETER');
    bars_error.add_message(l_mod, 12, l_exc, l_rus, '������� ����� ������� �����. �����������', '', 1, 'INVALID_USERTYPE_PARAMETER');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������ ������ ������ �����. ���������', '', 1, 'INVALID_USERTYPE_PARAMETER');

    bars_error.add_message(l_mod, 13, l_exc, l_geo, 'Sign "settle"/"forbid" set incorrectly', '', 1, 'INVALID_GRANT_PARAM');
    bars_error.add_message(l_mod, 13, l_exc, l_rus, '������� ������ ������� ���������/���������', '', 1, 'INVALID_GRANT_PARAM');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������ ������� ������ ���������/����������', '', 1, 'INVALID_GRANT_PARAM');

    bars_error.add_message(l_mod, 14, l_exc, l_geo, 'Droping user %s is denied', '', 1, 'CANT_DELETE_SPECIAL_USER');
    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�������� ������������ %s ���������', '', 1, 'CANT_DELETE_SPECIAL_USER');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '��������� ����������� %s ����������', '', 1, 'CANT_DELETE_SPECIAL_USER');

    bars_error.add_message(l_mod, 15, l_exc, l_geo, 'Impossible create user - licenses limit is attained', '', 1, 'USERLIMIT_EXCEED');
    bars_error.add_message(l_mod, 15, l_exc, l_rus, '���������� ������� ������������ - ��������� ������ ��������', '', 1, 'USERLIMIT_EXCEED');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '��������� �������� ����������� - ��������� ��� ������', '', 1, 'USERLIMIT_EXCEED');

    bars_error.add_message(l_mod, 16, l_exc, l_geo, 'User with ID %s already exists', '', 1, 'USER_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 16, l_exc, l_rus, '������������ � ��. %s ��� ����������', '', 1, 'USER_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '���������� � ��. %s ��� ����', '', 1, 'USER_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 17, l_exc, l_geo, '�urrent user not permitted to do this, granting or revoking was done by this account', '', 1, 'NOTPERMITED_WITH_THIS_USER');
    bars_error.add_message(l_mod, 17, l_exc, l_rus, '����� �������� �� ����� ���� ��������� ������� �������������, ��������� �� ��� ����� ���� ��������� ������/�������������� ������� �������', '', 1, 'NOTPERMITED_WITH_THIS_USER');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '���� �� �� ���� ���� �������� �������� ������������, ������� �� ���� ���� ���� �������� ������/����������� ������� �������', '', 1, 'NOTPERMITED_WITH_THIS_USER');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '������������ ��� ������ %s ��� ��������� %s. ������ ���� �� ����������� meta_coltypes', '', 1, 'NOT_CORRECT_PARAM_TYPE');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '����������� ��� ����� %s ��� ��������� %s. �������� ���� �� �������� meta_coltypes', '', 1, 'NOT_CORRECT_PARAM_TYPE');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '������������ �������� ��������� ������� <�������������> ��� ��������� %s. ������ ���� 1 ��� 0', '', 1, 'NOT_CORRECT_EDITABLE_VALUE');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '���������� �������� ��������� ������� <�����������> ��� ��������� %s. ������� ���� 1 ��� 0', '', 1, 'NOT_CORRECT_EDITABLE_VALUE');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '������������ �������� ��������� ������� <��� ���������> ��� ��������� %s. ������ ���� 1 ��� 0', '', 1, 'NOT_CORRECT_ARCH_VALUE');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '���������� �������� ��������� ������� <��� ���������> ��� ��������� %s. ������� ���� 1 ��� 0', '', 1, 'NOT_CORRECT_ARCH_VALUE');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ���������� ���-� � ����� %s.', '', 1, 'NO_SUCH_ARM');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '�� ���� ������ ���-� � �����  %s. ', '', 1, 'NO_SUCH_ARM');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ���������� ������� � ����� %s.', '', 1, 'NO_SUCH_FUNCID');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '�� ���� ���� ������� � �����  %s. ', '', 1, 'NO_SUCH_FUNCID');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ADM.sql =========*** Run *** ==
PROMPT ===================================================================================== 
