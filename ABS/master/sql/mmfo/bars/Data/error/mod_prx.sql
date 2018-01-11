PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_PRX.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ PRX ***
declare
  l_mod  varchar2(3) := 'PRX';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '��� �������� ���������� �� ����� � TransMaster ���=%s �� ������ ���.�������� %s - ����� ������������ ���������� �����!', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '��� �������� ���������� �� ����� � TransMaster ���=%s �� �������� ���.������� %s - ����� ��������� ���������� �������!', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�������� ���� �������� � OPER �� ��������� � ������ �������� � OPLDOK!', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�������� ���� �������� � OPER �� ������� � ����� �������� � OPLDOK!', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�������� ��� ������ � OPER �� ��������� � ����� � OPLDOK!', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '��������� ��� ������ � OPER �� ������� � ����� � OPLDOK!', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '����������� �������� %s - ���������� ���� � ��� Oracle ��� ���������� � TransMaster!', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '³������ �������� %s - ���������� ������� � ��� Oracle ��� ���������� � TransMaster!', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�������� �� ��������������! �������� �������� �� ��������� �� ������� � ������ �����!', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�������� �� ������������! ������� �������� �� ��������� �� ������ � ������ �����!', '', 1, '5');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�������� � ���������� ���, ������� ��� ���������� ���� ��� Oracle, ���������!', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '��������� � ����������� ��, ������� �� ���������� ���� ��� Oracle, ����������!', '', 1, '10');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_PRX.sql =========*** Run *** ==
PROMPT ===================================================================================== 
