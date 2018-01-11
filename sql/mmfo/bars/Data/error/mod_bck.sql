PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ BCK ***
declare
  l_mod  varchar2(3) := 'BCK';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������������� � ��������� ����', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� %s �� ������', '', 1, 'PARAM_NOTFOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�������� %s �� ��������', '', 1, 'PARAM_NOTFOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '� ����������� ��������� ���� �� ������� ������ � ��������������� %s', '', 1, 'BCK_NOTFOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '� �������� ��������� ���� �� �������� ����� � ��������������� %s', '', 1, 'BCK_NOTFOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������ ���������� ������: %s', '', 1, 'ERROR_STORE_REPORT');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������� ���������� ����: %s', '', 1, 'ERROR_STORE_REPORT');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�� ������ ����� � ��������������� %s', '', 1, 'REPORT_NOT_FOUND');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '��� � ��������������� %s �� ��������', '', 1, 'REPORT_NOT_FOUND');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '����������� ����� XML-����� %s', '', 1, 'XMLBLOCK_NOT_FOUND');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�������� ����� XML-����� %s', '', 1, 'XMLBLOCK_NOT_FOUND');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '����������� ��� XML %s � ����� %s ������ %s', '', 1, 'XMLTAG_NOT_FOUND');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '�������� ��� XML %s � ����� %s ���� %s', '', 1, 'XMLTAG_NOT_FOUND');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������ ���������� ���������� ������� XML, �����=%s, ����=%s, ���=%s ( %s )', '', 1, 'RESULT_STORE_ERROR');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '������� ���������� ���������� ������� XML, ���=%s, ����=%s, ���=%s ( %s )', '', 1, 'RESULT_STORE_ERROR');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '������ ����� ��� ���������: %s', '', 1, 'REPORT_ALREADY_PARSED');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, '����� ��� ��� ����������: %s', '', 1, 'REPORT_ALREADY_PARSED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BCK.sql =========*** Run *** ==
PROMPT ===================================================================================== 
