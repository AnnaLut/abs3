PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ACM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ ACM ***
declare
  l_mod  varchar2(3) := 'ACM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '���������� ������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������� ����� ����� ���������� (%s)', '', 1, 'INVALID_SNAPMODE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� ����� ����� ���������� (%s)', '', 1, 'INVALID_SNAPMODE');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�� ������� ���������� ���� ����������', '', 1, 'UNDEFINED_SNAP_BANKDATE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�� ������� ���������� ���� ����������', '', 1, 'UNDEFINED_SNAP_BANKDATE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��������� ���� �� �������� ���������� (%s)', '', 1, 'BANKDATE_NOT_FOUND');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '��������� ���� �� �������� ���������� (%s)', '', 1, 'BANKDATE_NOT_FOUND');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '������� ����� ��� �������������', '', 1, 'INVALID_SYNCMODE');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '������� ����� ��� �������������', '', 1, 'INVALID_SYNCMODE');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '����������� ������ %s (���: %s)', '', 1, 'INVALID_OBJECT_NAME');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '����������� ������ %s (���: %s)', '', 1, 'INVALID_OBJECT_NAME');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '�� ���������� ��������� ���� � ���������', '', 1, 'CALENDAR_FIRSTDATE_NOTDEFINED');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '�� ���������� ��������� ���� � ���������', '', 1, 'CALENDAR_FIRSTDATE_NOTDEFINED');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '�� ������� ���� �� ��� (�����������, ����������, ��������)', '', 1, 'CALENDAR_DATES_NOTDEFINED');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '�� ������� ���� �� ��� (�����������, ����������, ��������)', '', 1, 'CALENDAR_DATES_NOTDEFINED');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, '���� #%s �� ������', '', 1, 'ACCOUNT_BYID_NOTFOUND');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, '������� #%s �� ��������', '', 1, 'ACCOUNT_BYID_NOTFOUND');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, '���������� ���� �� ������� �� �������������� #%s', '', 1, 'BANKDATE_BYID_NOTFOUND');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, '��������� ���� �� �������� �� �������������� #%s', '', 1, 'BANKDATE_BYID_NOTFOUND');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, '�� ������� ������������� ���� %s �� %s ������. ����������� �����.', '', 1, 'WAIT_TIMEOUT_EXPIRED');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, '�� ������� ����������� ������� %s �� %s ������. ��������� �����.', '', 1, 'WAIT_TIMEOUT_EXPIRED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ACM.sql =========*** Run *** ==
PROMPT ===================================================================================== 
