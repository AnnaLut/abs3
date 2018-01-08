PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_INS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ INS ***
declare
  l_mod  varchar2(3) := 'INS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� �����������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�������� ���� �������', '', 1, 'INVALID_PAYMENT_DATE');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������ ���� �������', '', 1, 'INVALID_PAYMENT_DATE');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������������ ������ �� (%s)', '', 1, 'INVALID_DEAL_STATE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������������ ������ �� (%s)', '', 1, 'INVALID_DEAL_STATE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '������ ������� �� �� ������ ����� ������ ��', '', 1, 'RENEW_NEEDED');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '������� ������� �� �� �������� ����� ������ ��', '', 1, 'RENEW_NEEDED');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�������� ��� ��������', '', 1, 'ATTR_WRONG_TYPE');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '������� ��� ��������', '', 1, 'ATTR_WRONG_TYPE');

    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��������� �������� ��, �������� ������ �����.', '', 1, 'CNNT_DEL_PARTNER');

    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '��������� �������� ��� ��, �������� ������ �����.', '', 1, 'CNNT_DEL_PARTNER_TYPE');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_INS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
