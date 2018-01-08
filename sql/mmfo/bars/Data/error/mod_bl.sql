PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BL.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ BL ***
declare
  l_mod  varchar2(3) := 'BL';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������ ������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '������ �� ����������! %s ', '', 1, 'BL_ERROR_UNKNOWN');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '������� �� ���������! %s ', '', 1, 'BL_ERROR_UNKNOWN');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '��� ������� ������ ���� ���������� ������ � ���������� ���������������! %s %s ', '', 1, 'BL_ERROR_SEQUENCE');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '��� ������� ����� ��� ��������� ����� � ���������� ���������������! %s %s', '', 1, 'BL_ERROR_SEQUENCE');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������ ������������� %s!', '', 1, 'BL_ERROR_PRIMARY_KEY');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� ������ ������������� %s!', '', 1, 'BL_ERROR_PRIMARY_KEY');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� �������� ������������� ��� �������� �������� ��������� ������! %s ', '', 1, 'BL_ERROR_OUT_PRIMARY_KEY');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� ������ ������������� ��� ������� ���������� ������� �����! %s ', '', 1, 'BL_ERROR_OUT_PRIMARY_KEY');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '��� ���� � ����� ������ � %s  �� ��������� �������!', '', 1, 'BL_PRFM_NULL');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '��� ����� � ����� ������ � %s  �� ��������� ��������!', '', 1, 'BL_PRFM_NULL');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '��� ���� � ����� ������ � %s  �� ��������� ���!', '', 1, 'BL_PRIM_NULL');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '��� ����� � ����� ������ � %s  �� ��������� I�`�!', '', 1, 'BL_PRIM_NULL');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '�� ��������� ������ ����� ��������! %s', '', 1, 'BL_PASS_SER_POOR');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '������ ��������� ���i� ��������! %s', '', 1, 'BL_PASS_SER_POOR');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '�� ��������� ����� ����� ��������! %s', '', 1, 'BL_PASS_NUM_POOR');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������ �������� ����� ��������! %s', '', 1, 'BL_PASS_NUM_POOR');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '��� ���� � ����� ������ � %s  �� ��������� "���� ��������"!', '', 1, 'BL_BDAY_NULL');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '��� ����� � ����� ������ � %s  �� ��������� "���� ����������"!', '', 1, 'BL_BDAY_NULL');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '��� ���� � ����� ������ � %s ����������� ������  "���� ��������"!', '', 1, 'BL_BDAY_CHANGE');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '��� ����� � ����� ������ � %s ���������� ������ "���� ����������"!', '', 1, 'BL_BDAY_CHANGE');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '��� %s %s %s ������ �������� ��� ������ � %s !', '', 1, 'BL_BAD_OKPO');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '��� %s %s %s �������� ���������� ��� ������ � %s !', '', 1, 'BL_BAD_OKPO');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '�� ��������� �������!', '', 1, 'BL_PRFM_NULL_SHOT');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '�� ��������� ��������!', '', 1, 'BL_PRFM_NULL_SHOT');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ��������� ���!', '', 1, 'BL_PRIM_NULL_SHOT');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, '�� ��������� I�`�!', '', 1, 'BL_PRIM_NULL_SHOT');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ��������� ������ ����� ��������! %s', '', 1, 'BL_PASS_SER_POOR_SHOT');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '������ ��������� ���i� ��������! %s', '', 1, 'BL_PASS_SER_POOR_SHOT');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '�� ��������� ����� ����� ��������! %s', '', 1, 'BL_PASS_NUM_POOR_SHOT');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '������ �������� ����� ��������! %s', '', 1, 'BL_PASS_NUM_POOR_SHOT');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '�� ��������� "���� ��������"!', '', 1, 'BL_BDAY_NULL_SHOT');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '�� ��������� "���� ����������"!', '', 1, 'BL_BDAY_NULL_SHOT');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '����������� ������  "���� ��������"!', '', 1, 'BL_BDAY_CHANGE_SHOT');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '���������� ������ "���� ����������"!', '', 1, 'BL_BDAY_CHANGE_SHOT');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '������ �������� ��� ������ � %s !', '', 1, 'BL_BAD_OKPO_SHOT');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '�������� ���������� ��� ������ � %s !', '', 1, 'BL_BAD_OKPO_SHOT');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '��� ���������� ���� � ���� ����, ������� ������������� ��������� ����:  %s !', '', 1, 'BL_NULL_FIELDS');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '��� ���������� ����� � ���� ���� , ������� ���������� ������� ����: %s !', '', 1, 'BL_NULL_FIELDS');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BL.sql =========*** Run *** ===
PROMPT ===================================================================================== 
