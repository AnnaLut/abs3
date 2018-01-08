PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BMD.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ BMD ***
declare
  l_mod  varchar2(3) := 'BMD';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�MD', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '��������� ������ (��� %s) �� �������', '', 1, 'TABLE_NOT_FOUND');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� ������� (��� %s) �� ��������', '', 1, 'TABLE_NOT_FOUND');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '��������� ��� ������������ (��� %s) �� ������', '', 1, 'REF_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�������� ��� �������� (��� %s) �� ��������', '', 1, 'REF_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������� %s �� ������� � ���', '', 1, 'TABLE_NOT_BMD');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������� %s �� ������� � ���', '', 1, 'TABLE_NOT_BMD');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BMD.sql =========*** Run *** ==
PROMPT ===================================================================================== 
