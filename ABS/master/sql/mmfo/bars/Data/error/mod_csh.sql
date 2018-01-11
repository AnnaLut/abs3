PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CSH.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ CSH ***
declare
  l_mod  varchar2(3) := 'CSH';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '����� - ������������ ����', 1);

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '��������� �������� ������������ ���� %s ������ ������� ���� �� ������� %s. �������� ������������ ��������� ����.', '', 1, 'NO_VALID_OPERDAY');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '������_� �_������� ������_���� ���� %s �_���� �� ������� ���� �� ������_ %s. �����_��� �������_��� �������� ����', '', 1, 'NO_VALID_OPERDAY');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '��������! �������� �������� ������������ �����, ��������� ������ �����', '', 1, 'OPENING_OPERDAY');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '�����! ��������� �i������� ���������� ����, �������� ������ �����', '', 1, 'OPENING_OPERDAY');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '�� ��������� ���� %s � ����� ����� %s - �� ���������� ���������� � ������ �����', '', 1, 'NO_OPER_DAY');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '�� ������� ���� %s � ����� ���� %s - �� ���� ���������� ��� ������ ����', '', 1, 'NO_OPER_DAY');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, '����� %s �� �������� � ������, ���������� ������ ��� (�����) ��������� ��� ������ �����', '', 1, 'NO_CASH');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, '����� %s �� ������ � �����, ������ �������� ���(�����) �������� ��� ������ �������', '', 1, 'NO_CASH');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '������ ������������ ��� ��������� ������ %s', '', 1, 'NOT_CASH_REPORT');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '������� ����������� ��� �������� ��i�� %s', '', 1, 'NOT_CASH_REPORT');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CSH.sql =========*** Run *** ==
PROMPT ===================================================================================== 
