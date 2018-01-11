PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_OTC.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ OTC ***
declare
  l_mod  varchar2(3) := 'OTC';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '���������� ���', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_geo, 'Query not found: %s: %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������ �� ������: %s: %s', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '����� �� ��������: %s: %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_geo, 'Error during getting parameter %s: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������ ��� ��������� ��������� %s: %s', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��������� ��������� %s: %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_geo, 'Table %s not found', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������� ������� %s', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� �������� ������� %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_geo, 'Incorrect query SELECT for report', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_rus, '����������� ��������� ������ SELECT ��� ������', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '���������� ������ ����� SELECT ��� ��i��', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_geo, 'Subsequent query is not allowed', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_rus, '��������� ������������ ������ ���������', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�������� ���������� ���� ����������', '', 1, '5');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_OTC.sql =========*** Run *** ==
PROMPT ===================================================================================== 
