PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CPN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ CPN ***
declare
  l_mod  varchar2(3) := 'CPN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������ �i���� �����i� ���', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '��� ������ ������ %s �� ������', '', 1, 'NO_SUCH_IDCP');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '��� �_����� ������ %s �� ��������', '', 1, 'NO_SUCH_IDCP');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '��� ������ ������ %s ���� %s ��� ����������� ��� ������� ��� ������� %s', '', 1, 'DATE_WAS_USED');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '��� ������� ������ %s ���� %s ��� ����������� ��� ������� �� ������� %s', '', 1, 'DATE_WAS_USED');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��� ������ ������ %s �� ������ ��������� ����� ������� %s. ��� ������� %s', '', 1, 'NO_PREVIOUS_NPP');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '��� ������� ������ %s �� �������� �������� ����� ������� %s. ���� �������� %s', '', 1, 'NO_PREVIOUS_NPP');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '��� ������ ������ %s ������� �������� ��� ������� %s ���� ������ %s, ������� ����������� ��� ������  %s', '', 1, 'SUCH_DATE_INOTHERNPP');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '��� ������� ������ %s ������ ������ �� ������� %s ���� ������ %s, ��� ��� ����������� ��� ������ %s', '', 1, 'SUCH_DATE_INOTHERNPP');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '������ ������ � ����� %s ��� ���������� � �����������', '', 1, 'YET_EXISTS');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�i���� �����  � ����� %s  ��� i��� � ���i�����', '', 1, 'YET_EXISTS');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '������� ������������ ��� ������ (������ ���� 1-�����,2-�������): %s', '', 1, 'NOT_CORRECT_PAYTYPE');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�������� ���������� ��� ������ 9������� ���� 1-�����,2-�������): %s', '', 1, 'NOT_CORRECT_PAYTYPE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CPN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
