PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_FMN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ FMN ***
declare
  l_mod  varchar2(3) := 'FMN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '���.����������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�� ���������� �������� $(PAR)', '', 1, 'FM_PARAM_NOT_SET');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�� ����������� �������� $(PAR)', '', 1, 'FM_PARAM_NOT_SET');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '����������� �������� $(PAR) ��� �������', '', 1, 'FM_PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '���?����� �������� $(PAR) ��� �������', '', 1, 'FM_PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��������� �������������� ��������� ���� �������� ������ ������, ����� �������������!', '', 1, 'FM_PARAM_NOT_EDIT');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '���������� ����������� �������� ���� ������� ������ ������, ����� �������������!', '', 1, 'FM_PARAM_NOT_EDIT');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '���������, �� ��������� ���� ����� �������������!', '', 1, 'FM_PARAM_NOT_FILLED_DT');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '��������, �� ��������� ���� ����� �������������!', '', 1, 'FM_PARAM_NOT_FILLED_DT');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '���������, �������� ����� ������������� ������ ���� ������ ��� ����� ���� �������� �������� ������� � ������ ���� ���������� ��������� ������ �����, � �� ������ 01.01.2012 �.', '', 1, 'FM_PARAM_INCORREC_DATE');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��������, �������� ����� ������������� �� ���� ������ ��� ����� ���� ��������� ������ �볺��� �� ������ ���� �������� ���� ���� ������, �� �� ������������ 01.01.2012 �.', '', 1, 'FM_PARAM_INCORREC_DATE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_FMN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
