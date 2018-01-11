PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_INT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ INT ***
declare
  l_mod  varchar2(3) := 'INT';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '���������� ���������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '��������� ��������� ���� ������� ������ � %s (��������� �������)', '', 1, 'BRTYPE_MODIF_DENIED');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '���������� ���� ���� ������ ������ � %s(��������� �����)', '', 1, 'BRTYPE_MODIF_DENIED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_INT.sql =========*** Run *** ==
PROMPT ===================================================================================== 
