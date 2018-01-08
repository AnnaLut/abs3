PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SRV.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ SRV ***
declare
  l_mod  varchar2(3) := 'SRV';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������ ��������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '����������� ���������� ������ � %s �������� � ��� = %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������������ ���������� ������ � %s �볺���� � ��� = %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '����������� ����� ���� ������ �� ������������� (%s)', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '���������� ������� ���� ������ �� ����������� (%s)', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'SURVEY(start_session): %s', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'SURVEY(start_session): %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�� ������� ������ ������������� �%s', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�� �������� ���� ����������� �%s', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������ ������ �%s', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� �������� ������� �%s', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�������������� ����� ��� ������ � �������', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '������������ ����� ��� ��� � �������', '', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ ��������� �� �������������', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '�볺�� ��������� �� �����������', '', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '�� ������ ������� ������ � %s �� ������ �%s', '', 1, '8');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '�� �������� ������ ������ � %s �� ������� �%s', '', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '�� ��������� ���������� ������������� ������ �� ������ �%s', '', 1, '9');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '�� ��������� ������ ������������ ������ �� ������� �%s', '', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '������ ������ ������ �� ������ �%s : %s', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '������� ������ ������ �� ������� �%s : %s', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '������ � %s �� ���������� ��� �� ������������� ������ � %s', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������� � %s �� ���� ��� �� ������� ����� � %s', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '����������� ����� ������ ������������� ������� � %s', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '���������� ������ ������ ������������� ������ � %s', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '����� � %s �� ���������� ��� �� ������������� ������� � %s', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '³������ � %s �� ���� ��� �� ������� ������� � %s', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '������ � %s ��� �������', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '���� � %s ��� �������', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '������ ��� �������� ������ � %s', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '������� ��� ������� ��� � %s', '', 1, '15');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SRV.sql =========*** Run *** ==
PROMPT ===================================================================================== 
