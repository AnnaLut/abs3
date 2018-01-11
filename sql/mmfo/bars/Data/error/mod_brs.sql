PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_BRS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ BRS ***
declare
  l_mod  varchar2(3) := 'BRS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '�����', 1);

    bars_error.add_message(l_mod, 100, l_exc, l_eng, '%s', '', 1, 'NO_DATA_FOUND');
    bars_error.add_message(l_mod, 100, l_exc, l_geo, '%s', '', 1, 'NO_DATA_FOUND');
    bars_error.add_message(l_mod, 100, l_exc, l_rus, '����� �� �������: %s', '', 1, 'NO_DATA_FOUND');
    bars_error.add_message(l_mod, 100, l_exc, l_ukr, '���i �� ��������: %s', '', 1, 'NO_DATA_FOUND');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '�������� ������������� ��� �49 �� 06.02.2014 (��.���.:%s, ���.���.:%s)', '', 1, 'BROKEN_ACT_NBU49');
    bars_error.add_message(l_mod, 101, l_exc, l_ukr, '�������� ��������� ��� �49 �i� 06.02.2014 (���.���.:%s, ���.���.:%s)', '', 1, 'BROKEN_ACT_NBU49');

    bars_error.add_message(l_mod, 200, l_exc, l_geo, 'Impossible send to SEP. Error : %s', '', 1, '200');
    bars_error.add_message(l_mod, 200, l_exc, l_rus, '���������� �������� � ���. ������ : %s', '', 1, '200');
    bars_error.add_message(l_mod, 200, l_exc, l_ukr, '��������� �������� � ���. ������� : %s', '', 1, '200');

    bars_error.add_message(l_mod, 201, l_exc, l_geo, 'SEP document with inf.messages section. Last visa should be puted in head bank.', '', 1, '201');
    bars_error.add_message(l_mod, 201, l_exc, l_rus, '��� �������� � ������ ������. ���������. ��������� ���� ������������� � ��.', '', 1, '201');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, '��� �������� � ������ i�����. ���i�������. ������� ��� ����������� � ��.', '', 1, '201');

    bars_error.add_message(l_mod, 202, l_exc, l_eng, 'Modification of table %s allowed in head bank only', '', 1, 'UPDATE_IN_CENTER_ONLY');
    bars_error.add_message(l_mod, 202, l_exc, l_geo, 'Modification of table %s allowed in head bank only', '', 1, 'UPDATE_IN_CENTER_ONLY');
    bars_error.add_message(l_mod, 202, l_exc, l_rus, '����������� ������ ������� %s ��������� ������ � �������� �����', '', 1, 'UPDATE_IN_CENTER_ONLY');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, '�����i���i� ����� ������i %s ��������� �i���� � ��������� �����', '', 1, 'UPDATE_IN_CENTER_ONLY');

    bars_error.add_message(l_mod, 203, l_exc, l_eng, 'Modification of object "%s" disabled', '', 1, 'MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 203, l_exc, l_geo, 'Modification of object "%s" disabled', '', 1, 'MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 203, l_exc, l_rus, '����������� ������ ������� "%s" ���������', '', 1, 'MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, '�����i���i� ����� ��''���� "%s" ����������', '', 1, 'MODIFICATION_DISABLED');

    bars_error.add_message(l_mod, 204, l_exc, l_eng, 'MFO-user does not have privilege to modify root data of an object "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 204, l_exc, l_geo, 'MFO-user does not have privilege to modify root data of an object "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 204, l_exc, l_rus, '������������ ��� ��������� ����������� �������� ������ ������� "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, '����������� ��� ���������� ����������� ��������� ����� ��''���� "%s"', '', 1, 'ROOT_MODIFICATION_DISABLED');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, '������ ������: %s', '', 1, 'NOT_PAY_150');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, '������� ������: %s', '', 1, 'NOT_PAY_150');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, '�������� ���� �������� �� �������', '', 1, 'TRANSFER_TIMEOUT');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, '���������� ����� ���������� �� �������', '', 1, 'TRANSFER_TIMEOUT');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, '��� ���������� � ��������', '', 1, 'MISSING_CONNECTION');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, '³����� �''������� � ��������', '', 1, 'MISSING_CONNECTION');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, '��������� ����� 500000. ��������� ��� �354', '', 1, 'POSTANOVA_449');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, '���������� ���� 500000. ��������� ��� �354', '', 1, 'POSTANOVA_449');

    bars_error.add_message(l_mod, 209, l_exc, l_rus, '� ����� ������������� %s ������������ ���� �������� �� ������� �������� ����������� ������, � ����� � ����������� ����� ����������� � 15 ���.!', '', 1, 'CHECK_TIME_VISA_TT');
    bars_error.add_message(l_mod, 209, l_exc, l_ukr, '� ������ ������� %s ����������� �������� �������� � ������� �������� �������� ������, � ��''���� � ������������ ������ �������� � 15 ��.!', '', 1, 'CHECK_TIME_VISA_TT');

    bars_error.add_message(l_mod, 210, l_exc, l_rus, '������ ����������� ���������� ������ 30 ����!', '', 1, 'LOCK_CHK_30DAY');
    bars_error.add_message(l_mod, 210, l_exc, l_ukr, '�������� ������� ��������� ������ 30 ���!', '', 1, 'LOCK_CHK_30DAY');

    bars_error.add_message(l_mod, 211, l_exc, l_rus, '�������� "LCSDE - �������� ����������", ������ ���� ���������!', '', 1, 'MUST_FILL_PROP_LCSDE');
    bars_error.add_message(l_mod, 211, l_exc, l_ukr, '������� "LCSDE - ���� �������", �� ���� ����������!', '', 1, 'MUST_FILL_PROP_LCSDE');

    bars_error.add_message(l_mod, 212, l_exc, l_rus, '���������� ��������� ������ �� ������� ��������. ������� ����� � ���������� ������� ������������ ����������������', '', 1, 'PASSP_MUST_BE_DESTROYED');
    bars_error.add_message(l_mod, 212, l_exc, l_ukr, '��������� �������� �������� �� ����� ���������. ������� ������ � ���������� ���� ������� �������������', '', 1, 'PASSP_MUST_BE_DESTROYED');

    bars_error.add_message(l_mod, 666, l_exc, l_rus, '%s', '', 1, 'GENERAL_ERROR_CODE');
    bars_error.add_message(l_mod, 666, l_exc, l_ukr, '%s', '', 1, 'GENERAL_ERROR_CODE');

    bars_error.add_message(l_mod, 18001, l_exc, l_geo, 'Currencies rates not loaded for bank date %s', '', 1, '18001');
    bars_error.add_message(l_mod, 18001, l_exc, l_rus, '�� ��������� ����� ����� ��� ���������� ���� %s', '', 1, '18001');
    bars_error.add_message(l_mod, 18001, l_exc, l_ukr, '�� ���������� ����� ����� ��� ��������� ���� %s', '', 1, '18001');

    bars_error.add_message(l_mod, 18002, l_exc, l_geo, 'Rate for currency %s not found. Date %s, Branch %s', '', 1, '18002');
    bars_error.add_message(l_mod, 18002, l_exc, l_rus, '�� ������ ���� ������ %s. ���� %s, ������������� %s', '', 1, '18002');
    bars_error.add_message(l_mod, 18002, l_exc, l_ukr, '�� �������� ���� ������ %s. ���� %s, ������� %s', '', 1, '18002');

    bars_error.add_message(l_mod, 18003, l_exc, l_geo, 'Impossible change currencies rates for paternal branches', '', 1, '18003');
    bars_error.add_message(l_mod, 18003, l_exc, l_rus, '������ �������� ����� ����� ������������ �������������', '', 1, '18003');
    bars_error.add_message(l_mod, 18003, l_exc, l_ukr, '���� ����� ����� ����������� �������� ����������', '', 1, '18003');

    bars_error.add_message(l_mod, 18004, l_exc, l_geo, 'Impossible visa currencies rates for paternal branches', '', 1, '18004');
    bars_error.add_message(l_mod, 18004, l_exc, l_rus, '������ ���������� ����� ����� ������������ �������������', '', 1, '18004');
    bars_error.add_message(l_mod, 18004, l_exc, l_ukr, '³������� ����� ����� ����������� �������� ����������', '', 1, '18004');

    bars_error.add_message(l_mod, 18005, l_exc, l_geo, 'Document not found, ref = %s', '', 1, '18005');
    bars_error.add_message(l_mod, 18005, l_exc, l_rus, '�������� �� ������, ref = %s', '', 1, '18005');
    bars_error.add_message(l_mod, 18005, l_exc, l_ukr, '�������� �� ��������, ref = %s', '', 1, '18005');

    bars_error.add_message(l_mod, 18006, l_exc, l_geo, 'Row deleting is improper', '', 1, '18006');
    bars_error.add_message(l_mod, 18006, l_exc, l_rus, '�������� ������ ���������!', '', 1, '18006');
    bars_error.add_message(l_mod, 18006, l_exc, l_ukr, '��������� ������ ����������!', '', 1, '18006');

    bars_error.add_message(l_mod, 99800, l_exc, l_geo, 'System error %s', 'You will appeal to system administrator', 1, '99800');
    bars_error.add_message(l_mod, 99800, l_exc, l_rus, '��������� ������ %s', '���������� � �������������� �������', 1, '99800');
    bars_error.add_message(l_mod, 99800, l_exc, l_ukr, '�������� ������� %s', '��������� �� ������������ �������', 1, '99800');

    bars_error.add_message(l_mod, 99801, l_exc, l_geo, 'Undefined error %s', 'Error description is absent in error reference', 1, '99801');
    bars_error.add_message(l_mod, 99801, l_exc, l_rus, '������ %s �� ����������', '����������� �������� ������ ������ � ����������� ������ ���������', 1, '99801');
    bars_error.add_message(l_mod, 99801, l_exc, l_ukr, '������� %s �� ���������', '³������ ���� ���� ������� � �������� ������� ���������', 1, '99801');

    bars_error.add_message(l_mod, 99802, l_exc, l_geo, 'Incorrect error code format %s', 'Passed error code and/or module code fall short used format', 1, '99802');
    bars_error.add_message(l_mod, 99802, l_exc, l_rus, '�������� ������ ���� ������ %s', '���������� ��� ������ �/��� ��� ������ �� ������������� ������������� �������', 1, '99802');
    bars_error.add_message(l_mod, 99802, l_exc, l_ukr, '������� ������ ���� ������� %s', '��������� ��� ������� ��/��� ��� ������ �� ���������� ����������������� �������', 1, '99802');

    bars_error.add_message(l_mod, 99803, l_exc, l_geo, 'Environment development error', '', 1, '99803');
    bars_error.add_message(l_mod, 99803, l_exc, l_rus, '������ ����� ����������', '', 1, '99803');
    bars_error.add_message(l_mod, 99803, l_exc, l_ukr, '������� ���������� ��������', '', 1, '99803');

    bars_error.add_message(l_mod, 99804, l_exc, l_geo, 'Module tuning for user %s is denied', '', 1, '99804');
    bars_error.add_message(l_mod, 99804, l_exc, l_rus, '������������ %s �� ��������� ��������� ������', '', 1, '99804');
    bars_error.add_message(l_mod, 99804, l_exc, l_ukr, '����������� %s �� ��������� ������������ ������', '', 1, '99804');

    bars_error.add_message(l_mod, 99805, l_exc, l_geo, 'Lang with code %s not described', '', 1, '99805');
    bars_error.add_message(l_mod, 99805, l_exc, l_rus, '���� � ����� %s �� ������', '', 1, '99805');
    bars_error.add_message(l_mod, 99805, l_exc, l_ukr, '���� � ����� %s �� �������', '', 1, '99805');

    bars_error.add_message(l_mod, 99806, l_exc, l_geo, 'Error %s not defined in module %s', '', 1, '99806');
    bars_error.add_message(l_mod, 99806, l_exc, l_rus, '������ %s �� ���������� � ������ %s', '', 1, '99806');
    bars_error.add_message(l_mod, 99806, l_exc, l_ukr, '������� %s �� ��������� � ����� %s', '', 1, '99806');

    bars_error.add_message(l_mod, 99807, l_exc, l_geo, 'Incorrecr error name format %s', '', 1, '99807');
    bars_error.add_message(l_mod, 99807, l_exc, l_rus, '�������� ������ ����� ������ %s', '', 1, '99807');
    bars_error.add_message(l_mod, 99807, l_exc, l_ukr, '������� ������ ���� ������� %s', '', 1, '99807');

    bars_error.add_message(l_mod, 99808, l_exc, l_geo, 'Duplicated error name %s', '', 1, '99808');
    bars_error.add_message(l_mod, 99808, l_exc, l_rus, '����������� ��� ������ %s', '', 1, '99808');
    bars_error.add_message(l_mod, 99808, l_exc, l_ukr, '���������� ��''� ������� %s', '', 1, '99808');

    bars_error.add_message(l_mod, 99999, l_exc, l_geo, 'Internal error %s %s %s %s', '', 1, '99999');
    bars_error.add_message(l_mod, 99999, l_exc, l_rus, '���������� ������ %s %s %s %s', '', 1, '99999');
    bars_error.add_message(l_mod, 99999, l_exc, l_ukr, '�������� ������� %s %s %s %s', '', 1, '99999');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_BRS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
