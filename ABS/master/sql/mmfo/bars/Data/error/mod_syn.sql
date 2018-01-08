PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SYN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ SYN ***
declare
  l_mod  varchar2(3) := 'SYN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������������� ������������', 1);

    bars_error.add_message(l_mod, 18001, l_exc, l_rus, '��������� %s �� ������', '', 1, '18001');
    bars_error.add_message(l_mod, 18001, l_exc, l_ukr, '���������� %s �� ��������', '', 1, '18001');

    bars_error.add_message(l_mod, 18002, l_exc, l_rus, '������� %s �� ������� � ������ ������ ��� �������������', '', 1, '18002');
    bars_error.add_message(l_mod, 18002, l_exc, l_ukr, '������� %s �� �������� � ������ ������� ��� ������������', '', 1, '18002');

    bars_error.add_message(l_mod, 18003, l_exc, l_rus, '������ ���������� ������� %s', '', 1, '18003');
    bars_error.add_message(l_mod, 18003, l_exc, l_ukr, '������� ��������� ��`���� %s', '', 1, '18003');

    bars_error.add_message(l_mod, 18004, l_exc, l_rus, '������� %s ��� ���������� � ������ ������ ��� �������������', '', 1, '18004');
    bars_error.add_message(l_mod, 18004, l_exc, l_ukr, '������� %s ��� ���� � ������ ������� ��� ������������', '', 1, '18004');

    bars_error.add_message(l_mod, 18005, l_exc, l_rus, '������ ������� ������ �� ��������� ������� %s ', '', 1, '18005');
    bars_error.add_message(l_mod, 18005, l_exc, l_ukr, '������� ��� �������� ����� � ��������� ������� %s ', '', 1, '18005');

    bars_error.add_message(l_mod, 18006, l_exc, l_rus, '������� %s �������� �� �������������� ���� ����� (CLOB, BLOB, BFILE)', '', 1, '18006');
    bars_error.add_message(l_mod, 18006, l_exc, l_ukr, '������� %s ������ �������, ���� ���� �� ������������ (CLOB, BLOB, BFILE)', '', 1, '18006');

    bars_error.add_message(l_mod, 18007, l_exc, l_rus, '��� ������(��������) �������� ��������� �������� "STOP" ��� "START"', '', 1, '18007');
    bars_error.add_message(l_mod, 18007, l_exc, l_ukr, '��� ������(��������) ������� ������������ �������� "STOP" ��� "START"', '', 1, '18007');

    bars_error.add_message(l_mod, 18008, l_exc, l_rus, '������� %s �� ������� � ������ ����������������', '', 1, '18008');
    bars_error.add_message(l_mod, 18008, l_exc, l_ukr, '������� %s �� ������� � ������ �������������', '', 1, '18008');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SYN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
