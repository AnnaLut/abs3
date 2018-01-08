PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_ASN.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ ASN ***
declare
  l_mod  varchar2(3) := 'ASN';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������ ����������� ��������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������ � ������ ASYNC: %s', '', 1, 'ASYNC_ERR');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������ � ������ ASYNC: %s', '', 1, 'ASYNC_ERR');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '�������� ACTION_CODE = "%s" �� �������', '', 1, 'ACTION_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '�������� ACTION_CODE = "%s" �� �������', '', 1, 'ACTION_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������ %s ��� ��������', '', 1, 'EXCLUSION_ERROR');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������ %s ��� ���������', '', 1, 'EXCLUSION_ERROR');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_ASN.sql =========*** Run *** ==
PROMPT ===================================================================================== 
