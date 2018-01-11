PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ CCK ***
declare
  l_mod  varchar2(3) := 'CCK';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '��������� ������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������� ������ ��������� ��������� cck_dop.get_acc_isp. ���� �� ���������� ������ ���� �� ������.', '', 1, 'INCORRECT_CCKDOP_GETACCISP_PAR');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������ ����� ��������� ��������� cck_dop.get_acc_isp. ���� � ��������� ������� ���� ��������.', '', 1, 'INCORRECT_CCKDOP_GETACCISP_PAR');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '��� ���������� ��� %s (%s) �� �������� ���������� "�i����i�����i ��������i �� ������� ��� �����. �������� � ��" ��� ��������� ����������� ��������� �� ��������� ��� �� ������������������ ��� �����. �����������.', '', 1, 'ACCISP_BY_USER_NOTFOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '��� ��������� ��� %s (%s) �� ������� ������� "�i����i�����i ��������i �� ������� ��� �����. �������� � ��" ��� �������� ���������� ����������� ���� ��������� ��� �� ���������������� �� ���. ����������', '', 1, 'ACCISP_BY_USER_NOTFOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��� ��������� %s �� �������� ���������� "�i����i�����i ��������i �� ������� ��� �����. �������� � ��" ��� ��������� ����������� ��������� �� ��������� ��� �� ������������������ ��� �����. �����������.', '', 1, 'ACCISP_BY_BRANCH_NOTFOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '��� �������� %s �� ������� ������� "�i����i�����i ��������i �� ������� ��� �����. �������� � ��" ��� �������� ���������� ����������� ���� ��������� ��� �� ���������������� �� ���. ����������.', '', 1, 'ACCISP_BY_BRANCH_NOTFOUND');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '������ ����������� ����������, �.�. ��� ������ �������� ��� ����������� ������������� ���������� ���� ���� %s.', '', 1, 'AUTH_ERROR_CANNT_OPEN_ACC');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '����� �����i���i� ����������, ���� �� ��� ������� �������� ���� ���������i ����������� ��������� ������� ���� %s.', '', 1, 'AUTH_ERROR_CANNT_OPEN_ACC');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ���=%s �� ������ %s', '', 1, 'ND_NOTFOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� ���=%s �� �������� %s', '', 1, 'ND_NOTFOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�� ���=%s �� ��.������� %s', '', 1, 'FREE_SG');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�� ���=%s �� ���.��������� %s', '', 1, 'FREE_SG');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '�� ���=%s ���� �������.��������.=%s', '', 1, 'YES_SP');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '�� ���=%s � �������.����������.=%s', '', 1, 'YES_SP');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '�� ���=%s ��. %s �� �������/����� %s', '', 1, 'ACC_NOTFOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '�� ���=%s ���.%s �� ��������/����i %s', '', 1, 'ACC_NOTFOUND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '�� ���=%s ��.����� ����.�����=%s', '', 1, 'SUM_POG');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '�� ���=%s ���.���� �����.�����=%s', '', 1, 'SUM_POG');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ���=%s ��������� ����', '', 1, 'LAST_DATE');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '�� ���=%s ������� ����', '', 1, 'LAST_DATE');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ���=%s ����.����� 1-�� ��', '', 1, 'PREV_PL');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '�� ���=%s �������.���� 1-�� ��', '', 1, 'PREV_PL');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '�� ���=%s ����������� ��������� ��� �� %s', '', 1, 'NO_MODI_GPK');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '�� ���=%s �i�����i ��i�� ��� �� %s', '', 1, 'NO_MODI_GPK');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '�� ���=%s ���� ��=����, ���� %s', '', 1, 'PLAN#FAKT');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '�� ���=%s ���� ��=����, ���. %s', '', 1, 'PLAN#FAKT');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ���=%s ��������� ��� �� %s ��� ���������', '', 1, 'YES_MODI_GPK');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�� ���=%s ��i�� ��� �� %s ��� �������i', '', 1, 'YES_MODI_GPK');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '�� �������� �������� %s "%s"', '', 1, 'NOT_FILLED_PARAM ');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '�� ��������� ��������� %s "%s"', '', 1, 'NOT_FILLED_PARAM ');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '��� ������������ �������� "��������� ��������" - "���", �� �������� ���.�������� "������������ ��������"', '', 1, 'NOT_PARAM_PARTNER_ID');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '��� ������������� ������� "�������� ��������" - "���", �� ��������� ���.������� "������������ ��������"', '', 1, 'NOT_PARAM_PARTNER_ID');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 
