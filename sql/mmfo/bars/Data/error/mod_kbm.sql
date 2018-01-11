PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_KBM.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ KBM ***
declare
  l_mod  varchar2(3) := 'KBM';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '2.����+����� ������ = %s ����  � � � � � �  �� �������� ����+����� %s', '', 1, 'SYSDATE_AGAIN');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '2.����+��� ����i� = %s �  � � � � � �  �� ������� ����+��� %s', '', 1, 'SYSDATE_AGAIN');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '1.����+����� ��������� ������ = %s ����  � � � � � � �� ���� ������ ������ =  %s', '', 1, 'LAST_DAY');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '1.����+��� ���������  ����i� = %s �  � � � � � �  �� ���� ������ ����i� =  %s', '', 1, 'LAST_DAY');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '����� ��������� ��������! ������� �������� ��� ���.', '', 1, 'FALSE_COURSE');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '����� ��������� ������! ������ �������� �� ���.', '', 1, 'FALSE_COURSE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_KBM.sql =========*** Run *** ==
PROMPT ===================================================================================== 
