PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_IMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ IMP ***
declare
  l_mod  varchar2(3) := 'IMP';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '� ����������� ���������� ������ ��� ������� ������� %s �� ����������', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '� �������� ���������� ������� ��� ������� ������� %s �� ��������', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '������������ �������� MODE (%s)', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '������������ �������� MODE (%s)', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '�� ������� ����������', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '�� ������� ���������', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�� ������� ������� ��� �������', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�� ������� ������� ��� �������', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '���� $(FN) ($(FDAT) ��� ��������������!)', '', 1, 'FILE_ALREADY_IMPORT');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '���� $(FN) ($(FDAT) ��� ������������!', '', 1, 'FILE_ALREADY_IMPORT');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '$(MSG)', '', 1, 'CLIENT_IN_BLOCKLIST');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '$(MSG)', '', 1, 'CLIENT_IN_BLOCKLIST');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '������������ � ���.� $(TABN) �� ������ � ���!', '', 1, 'USER_NOT_FOUND');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '����������� � ���.� $(TABN) �� �������� � ���!', '', 1, 'USER_NOT_FOUND');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '��������� $(BRANCH) �� �������!', '', 1, 'BRANCH_NOT_FOUND');
    bars_error.add_message(l_mod, 8, l_exc, l_ukr, 'ϳ������ $(BRANCH) �� ��������!', '', 1, 'BRANCH_NOT_FOUND');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '� ����� �� ������� �������������!', '', 1, 'BRANCH_NOT_SET');
    bars_error.add_message(l_mod, 9, l_exc, l_ukr, '� ���� �� ������� �������!', '', 1, 'BRANCH_NOT_SET');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '������������ � ���.� $(TABN) �� ����������� ��������� $(BRANCH)', '', 1, 'USER_NOT_FOUND_IN_BRANCH');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '���������� � ���.� $(TABN) �� �������� �������� $(BRANCH)', '', 1, 'USER_NOT_FOUND_IN_BRANCH');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '����� ������������������ ���� �� ��������� 10-�� ($(OKPO))', '', 1, 'WRONG_OKPO_LENGTH');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������� ����������������� ���� �� ������� 10-�� ($(OKPO))', '', 1, 'WRONG_OKPO_LENGTH');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '�������� �������� �� ����� ���� ���������������(dk ������ 1 ��� 0) ��� ��� � %s, ���� %s, ���� %s', '', 1, 'CASH_NOINFODK');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '����� �������� �� ������ ����� ��������������(dk ������� ����  1 ��� 0) ��� ��� � %s, ���� %s, ���� %s', '', 1, 'CASH_NOINFODK');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '�������������� ������ �������� ���� ��� �� �������������� ��� ��� � %s, ���� %s, ���� %s', '', 1, 'NO_DK3');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '������������� ������ ������ ���� �� �� ����������� ��� ��� � %s, ���� %s, ���� %s', '', 1, 'NO_DK3');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�������� ��� ��� ������� ���. ����: %s', '', 1, 'YET_PAYED');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, '�������� ��� ���� �������� ���. ����: %s', '', 1, 'YET_PAYED');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_IMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 
