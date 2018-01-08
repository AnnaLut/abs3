PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_RKO.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ RKO ***
declare
  l_mod  varchar2(3) := 'RKO';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, 'RKO', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�� ��������� ���� "��� ���������"!', '', 1, 'NOT_FOUND_BRANCH');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�� ��������� ���� "��� ��������"!', '', 1, 'NOT_FOUND_BRANCH');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�� ��������� ���� "��� ������������"!', '', 1, 'NOT_FOUND_USERID');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�� ��������� ����  "��� �����������"!', '', 1, 'NOT_FOUND_USERID');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '��������� ������������� ������ �� ������ ���������!', '', 1, 'PROHIBITED_EDIT');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '���������� ���������� ��� �� ����� ��������!', '', 1, 'PROHIBITED_EDIT');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '��������� ������� ������ �� ������ ���������!', '', 1, 'PROHIBITED_DELETE');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '���������� �������� ��� �� ����� ��������!', '', 1, 'PROHIBITED_DELETE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_RKO.sql =========*** Run *** ==
PROMPT ===================================================================================== 
