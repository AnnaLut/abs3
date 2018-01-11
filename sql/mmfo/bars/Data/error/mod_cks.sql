PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_CKS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ CKS ***
declare
  l_mod  varchar2(3) := 'CKS';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '����������� ��������� �������', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�� �������� ������ ��� ������', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�� �������� ���i� ��� ������', '', 1, '1');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '�� ������ �� � �������� ���', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '�� �������� ��. � �������� ���', '', 1, '5');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '������� �� ������.', '', 1, '10');
    bars_error.add_message(l_mod, 10, l_exc, l_ukr, '������ �� ��������.', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '����c� ��������� ������ ���������c� ������ ������������� ���������.', '', 1, '11');
    bars_error.add_message(l_mod, 11, l_exc, l_ukr, '������ ��������� ������� ������������ ����� ������������ ��������.', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '�����c �� ������.', '', 1, '12');
    bars_error.add_message(l_mod, 12, l_exc, l_ukr, '����� �� ��������.', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '� ������� �������������������� ���������� ���������.', '', 1, '13');
    bars_error.add_message(l_mod, 13, l_exc, l_ukr, '����� �� ������������ ���������� ����.', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '��.��� �� �� �����. ���� ��������.', '', 1, '14');
    bars_error.add_message(l_mod, 14, l_exc, l_ukr, 'I�.��� �� �� �i����. ���i ����������.', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '������������� ������.', '', 1, '15');
    bars_error.add_message(l_mod, 15, l_exc, l_ukr, '��������� ��i���.', '', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '���������� ������� ��������.', '', 1, '16');
    bars_error.add_message(l_mod, 16, l_exc, l_ukr, '���������� �i� ������������.', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '���������� ����� �.�. >=0', '', 1, '17');
    bars_error.add_message(l_mod, 17, l_exc, l_ukr, '�i���i��� �i��� �� ���� >=0', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '���������� ���� ����������', '', 1, '18');
    bars_error.add_message(l_mod, 18, l_exc, l_ukr, '���������� ����i� ����������', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '���������� ���� �����.', '', 1, '19');
    bars_error.add_message(l_mod, 19, l_exc, l_ukr, '���������� ����i� �����.', '', 1, '19');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '��������� ����� ������� �.�. >0.', '', 1, '20');
    bars_error.add_message(l_mod, 20, l_exc, l_ukr, '��������� ���� ������� �� ���� >0.', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, 'C���� ������� (���) ������ MAX-����������.', '', 1, '21');
    bars_error.add_message(l_mod, 21, l_exc, l_ukr, 'C��� ������� (���) �i���� MAX-���������.', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '���������� ���� �������.', '', 1, '22');
    bars_error.add_message(l_mod, 22, l_exc, l_ukr, '���������� ����i� �������.', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '���� ������� ������ MAX-�����������.', '', 1, '23');
    bars_error.add_message(l_mod, 23, l_exc, l_ukr, '����i� ������� �i���� MAX-�����������.', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '������ ����� <= 0.', '', 1, '24');
    bars_error.add_message(l_mod, 24, l_exc, l_ukr, '������ ���i� <= 0.', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '������������ ���.', '', 1, '25');
    bars_error.add_message(l_mod, 25, l_exc, l_ukr, '���������� �I�.', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '������������ ��������� ���.', '', 1, '26');
    bars_error.add_message(l_mod, 26, l_exc, l_ukr, '���������i ��������� ���.', '', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '��.�������:��.����.', '', 1, '27');
    bars_error.add_message(l_mod, 27, l_exc, l_ukr, '��.i������:���.����.', '', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '��.�������:��.���.', '', 1, '28');
    bars_error.add_message(l_mod, 28, l_exc, l_ukr, '��.i������:���.���.', '', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '��.�������:��.����.', '', 1, '29');
    bars_error.add_message(l_mod, 29, l_exc, l_ukr, '��.i������:���.���.', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '��.��� ������.', '', 1, '30');
    bars_error.add_message(l_mod, 30, l_exc, l_ukr, '������.��� ������.', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '��.�������� �������� ZAL', '', 1, '31');
    bars_error.add_message(l_mod, 31, l_exc, l_ukr, '������� ����� ������i� ZAL', '', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '��.�������:��.����������.', '', 1, '32');
    bars_error.add_message(l_mod, 32, l_exc, l_ukr, '��.i������:���.���������.', '', 1, '32');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_CKS.sql =========*** Run *** ==
PROMPT ===================================================================================== 
