PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_SKR.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ SKR ***
declare
  l_mod  varchar2(3) := 'SKR';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�������� ��������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, 'skrn.p_tariff: ��������� ���� ������ (������: %s, ���������: %s).', '', 1, 'RENT_DATE_INCORRECT');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, 'skrn.p_tariff: �������� ���� ������ (�������: %s, ����������: %s).', '', 1, 'RENT_DATE_INCORRECT');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, 'skrn.p_tariff: ����� (��� = %s) �� ������ (����������� � �����������, ���� ����� ������ �������, ����������� ��������).', '', 1, 'TARIF_NOT_FOUND');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, 'skrn.p_tariff: ����� (��� = %s) �� �������� (������� � ��������, ���� ����� ����� �� �������, ���������� ����������)', '', 1, 'TARIF_NOT_FOUND');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, 'skrn.p_oper_zalog: ������� ����� ������ �� ����� ����. � = %s.', '', 1, 'ZERO_BAIL_SUM');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, 'skrn.p_oper_zalog: ������� ���� ������� �� ����� ����. � = %s.', '', 1, 'ZERO_BAIL_SUM');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, 'skrn.p_oper_zalog: ���� ����� �� ����� ����. � = %s.', '', 1, 'KEY_GIVEN');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, 'skrn.p_oper_zalog: ���� ������� �� ����� ����. � = %s.', '', 1, 'KEY_GIVEN');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, 'skrn.p_oper_zalog: ���� ��������� �� ����� ����. � = %s.', '', 1, 'KEY_RETURNED');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, 'skrn.p_oper_zalog: ���� ��� ��������� �� ����� ����. � = %s.', '', 1, 'KEY_RETURNED');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, 'skrn.p_oper_arenda: ������� �������� ����� �� �������� ����. � = %s.', '', 1, 'ZERO_RENT');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, 'skrn.p_oper_arenda: ������� ������� ����� �� �������� ����. � = %s.', '', 1, 'ZERO_RENT');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, 'skrn.p_oper_arenda_period: ������� �������� ����� �� �������� ���� ����. � = %s.', '', 1, 'ZERO_RENT_SKR');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, 'skrn.p_oper_arenda_period: ������� ������� ����� �� �������� ���� ����. � = %s.', '', 1, 'ZERO_RENT_SKR');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, 'skrn.p_dep_skrn: ���������� ����. � = %s �� ������� ��� ��� �������.', '', 1, 'DEAL_CLOSED_ND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'skrn.p_dep_skrn: ����� ����. � = %s �� �������� ��� ��� �������.', '', 1, 'DEAL_CLOSED_ND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, 'skrn.p_dep_skrn: �� ������� �������� ���������� �� ����� ����. � = %s.', '', 1, 'DEAL_CLOSED_NSK');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, 'skrn.p_dep_skrn: �� �������� �������� ���� �� ����� ����. � = %s.', '', 1, 'DEAL_CLOSED_NSK');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, 'skrn.p_dep_skrn: �� ������� ���� ����. � = %s.', '', 1, 'SAFE_NOT_FOUND');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, 'skrn.p_dep_skrn: �� �������� ���� ����. � = %s.', '', 1, 'SAFE_NOT_FOUND');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, 'skrn.p_dep_skrn: �� ������ ���� %s.', '', 1, 'ACCOUNT_NOT_FOUND');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, 'skrn.p_dep_skrn: �� �������� ������� %s.', '', 1, 'ACCOUNT_NOT_FOUND');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, 'skrn.p_dep_skrn: ���� ����. � %s ��������� ������. ���� ������� �� ����� ������.', '', 1, 'BAIL_NOT_EMPTY');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, 'skrn.p_dep_skrn: ���� ����. � %s ��������� �� �����. � ������� �� ������� �������.', '', 1, 'BAIL_NOT_EMPTY');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, 'skrn.p_dep_skrn: ���������� ������� ���������� �� ����� ����. � %s. ���� �� ��� ���������.', '', 1, 'KEY_NOT_RETURNED');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, 'skrn.p_dep_skrn: ��������� ������� ����� �� ����� ����. � %s. ������� ��������� ����.', '', 1, 'KEY_NOT_RETURNED');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, 'skrn.p_dep_skrn: ��� �������� %s �����������.', '', 1, 'MOD_NOT_FOUND');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'skrn.p_dep_skrn: ��� �������� %s ������������.', '', 1, 'MOD_NOT_FOUND');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, 'skrn.init: �������� %s �� ������.', '', 1, 'PARAM_NOT_FOUND');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, 'skrn.init: �������� %s �� ��������.', '', 1, 'PARAM_NOT_FOUND');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '���������� ������� ���� 3600* �� �������� (���� ����. �%s). � ���� ��������� ������� ��� ���� ���������� �������� �� ������ ������� ���������� ����.', '', 1, 'CANNOT_CLOSE_ACCOUNT_SKRN');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '��������� ������� ������� 3600* �� �������� (���� ����. �%s). � ����� �������� ������� ��� ���� ���������� ���� �� ����� ������� ���������� �����.', '', 1, 'CANNOT_CLOSE_ACCOUNT_SKRN');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '�������� ���� ����������� �� �������� �%s', '', 1, 'PROLONG_DATES_ERROR');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '��������� ���� ����������� �� �������� �%s', '', 1, 'PROLONG_DATES_ERROR');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '������������ �������� �� ��������������� �������� �%s', '', 1, 'IMPORTED_MODE_ERROR');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '����������� �������� �� ������������� �������� �%s', '', 1, 'IMPORTED_MODE_ERROR');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '���� ������� �� ��������� ��� ��������� ������� ��� �������� �%s', '', 1, 'NOT_NLK_CLIENT');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '������� �볺��� �� ��������� ��� ��������� �� ���� ��� �������� �%s', '', 1, 'NOT_NLK_CLIENT');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '���� �%s ��� ����������!', '', 1, 'SKRYNKA_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '�������� �%s ��� ����!', '', 1, 'SKRYNKA_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '�� ����� �%s ���������� �������� ������� �%s!', '', 1, 'SKRYNKA_HAS_ND');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '�� ����� �%s ���� �������� ������ �%s!', '', 1, 'SKRYNKA_HAS_ND');

    bars_error.add_message(l_mod, 103, l_exc, l_rus, '���������� ������� ���� acc = %s. � ���� ��������� ������� ��� ���� ���������� �������� �� ������ ������� ���������� ����.', '', 1, 'CANNOT_CLOSE_ACCOUNT');
    bars_error.add_message(l_mod, 103, l_exc, l_ukr, '��������� ������� ������� acc = %s. � ����� �������� ������� ��� ���� ���������� ���� �� ����� ������� ���������� �����.', '', 1, 'CANNOT_CLOSE_ACCOUNT');

    bars_error.add_message(l_mod, 104, l_exc, l_rus, '���������� ������� ���� �%s. �� ���� ���� �������� ��������!', '', 1, 'THERE_ARE_CLOSED_ND');
    bars_error.add_message(l_mod, 104, l_exc, l_ukr, '��������� �������� ���� �%s. �� ����� � ������ ��������!', '', 1, 'THERE_ARE_CLOSED_ND');

    bars_error.add_message(l_mod, 105, l_exc, l_rus, '�� ������� ������� ������� �� ����� �%s!', '', 1, 'DEAL_NOT_CREATED');
    bars_error.add_message(l_mod, 105, l_exc, l_ukr, '�� ������� ������� ������ �� ����� �%s!', '', 1, 'DEAL_NOT_CREATED');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '���� %s(980) ��� ����������!', '', 1, 'ACCOUNT_ALREADY_EXISTS');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, '������� %s(980) ��� ����!!', '', 1, 'ACCOUNT_ALREADY_EXISTS');

    bars_error.add_message(l_mod, 107, l_exc, l_rus, '��� ���������� ���������� ������� �%s (������ %s )!', '', 1, 'DOC_SIGNED');
    bars_error.add_message(l_mod, 107, l_exc, l_ukr, '��� ���� ��������� ������ �%s (������ %s )!!', '', 1, 'DOC_SIGNED');

    bars_error.add_message(l_mod, 108, l_exc, l_rus, '��� ���������� ���������������� ������� �%s !', '', 1, 'PROLONGED_CONTRACT');
    bars_error.add_message(l_mod, 108, l_exc, l_ukr, '��� ���� ������������� ������ �%s !!', '', 1, 'PROLONGED_CONTRACT');

    bars_error.add_message(l_mod, 109, l_exc, l_rus, '�� ������ ����� �������� ������� �� ����� �%s!', '', 1, 'NOT_PHONE_CLIENT');
    bars_error.add_message(l_mod, 109, l_exc, l_ukr, '�� �������� ����� �������� ������ �� ����� �%s!', '', 1, 'NOT_PHONE_CLIENT');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_SKR.sql =========*** Run *** ==
PROMPT ===================================================================================== 