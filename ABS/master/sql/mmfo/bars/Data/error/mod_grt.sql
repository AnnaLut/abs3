PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_GRT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ GRT ***
declare
  l_mod  varchar2(3) := 'GRT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������� ������ �� ������ (%s)', '', 1, 'DEAL_NOTFOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������ ������� �� �������� (%s)', '', 1, 'DEAL_NOTFOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������ ��� ���������� �������� ������ (%s)', '', 1, 'DEAL_LOCKERR');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������� ��� ��������� �������� ������� (%s)', '', 1, 'DEAL_LOCKERR');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������� ������ �� ������ � ��������� ��������� (%s)', '', 1, 'DEAL_NOTLINKED');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������ ������� �� ���''����� � ������ ��������� ��������� (%s)', '', 1, 'DEAL_NOTLINKED');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '���������������� ������ ������� (%s)', '', 1, 'UNSUPPORTED_FREQ');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������������ ����� ���� (%s)', '', 1, 'UNSUPPORTED_FREQ');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '���������������� ��� ������� (%s)', '', 1, 'UNSUPPORTED_TYPE');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '������������ ��� ��䳿 (%s)', '', 1, 'UNSUPPORTED_TYPE');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '��� �������� ������ �%s �� ����� ������ ��� �����������', '', 1, 'DEAL_GRTTYPE_NOTFOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '��� ��������� ������� �%s �� ���� ������� ��� ������������', '', 1, 'DEAL_GRTTYPE_NOTFOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������� ������ �%s �� ������ � ��������� ���������', '', 1, 'DEAL_NOT_LINKED');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '������ ������������ �%s �� ���`����� � ��������� ���������', '', 1, 'DEAL_NOT_LINKED');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '������� �%s �� �������������', '', 1, 'DEAL_NOTAUTH');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '������ �%s �� ������������', '', 1, 'DEAL_NOTAUTH');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_GRT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
