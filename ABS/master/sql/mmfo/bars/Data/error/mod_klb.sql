PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/Bars/Data/Err/mod_KLB.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create/replace ERR ������ KLB ***
declare
  l_mod  varchar2(3) := 'KLB';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_eng  varchar2(3) := 'ENG';
  l_geo  varchar2(3) := 'GEO';
  l_exc  number      := -20000;
begin
    bars_error.add_module(l_mod, '������-����', 1);

    bars_error.add_message(l_mod, 1, l_exc, l_rus, '�� ������ ��� ��������� %s ', '', 1, '1');
    bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�� �������� ��� ���i�������� %s', '', 1, '1');

    bars_error.add_message(l_mod, 2, l_exc, l_rus, '� ����������� kl_customer_params ���� �������� ��� �������  %s ', '', 1, '2');
    bars_error.add_message(l_mod, 2, l_exc, l_ukr, '� ���i����� kl_customer_params ���������� ���� ��� ��i����  %s', '', 1, '2');

    bars_error.add_message(l_mod, 3, l_exc, l_rus, '����������� ��� ���������  %s ', '', 1, '3');
    bars_error.add_message(l_mod, 3, l_exc, l_ukr, '���i����� ��� ���i��������  %s', '', 1, '3');

    bars_error.add_message(l_mod, 4, l_exc, l_rus, '�������� branch ��� sab %s ', '', 1, '4');
    bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�� �������� branch ��� sab %s', '', 1, '4');

    bars_error.add_message(l_mod, 5, l_exc, l_rus, '��� ������� %s �� ���������� �������� SAB', '', 1, '5');
    bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��� �i�i� %s �� �������� �������� SAB', '', 1, '5');

    bars_error.add_message(l_mod, 6, l_exc, l_rus, '�������� ����� ���������', '', 1, '6');
    bars_error.add_message(l_mod, 6, l_exc, l_ukr, '���������� ����� ���������', '', 1, '6');

    bars_error.add_message(l_mod, 7, l_exc, l_rus, '���������� ���� ���������', '', 1, '7');
    bars_error.add_message(l_mod, 7, l_exc, l_ukr, '�i������ ���� ���������', '', 1, '7');

    bars_error.add_message(l_mod, 8, l_exc, l_rus, '�� ������� ��i��������� �i���������', '', 1, '8');

    bars_error.add_message(l_mod, 9, l_exc, l_rus, '�� ������� ��� ����� �i���������', '', 1, '9');

    bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ������� �i���������', '', 1, '10');

    bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ������� ���� �i���������', '', 1, '11');

    bars_error.add_message(l_mod, 12, l_exc, l_rus, '�� ������� ��i��������� ����������', '', 1, '12');

    bars_error.add_message(l_mod, 13, l_exc, l_rus, '�� ������� ��� ����� ����������', '', 1, '13');

    bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ������� ����������', '', 1, '14');

    bars_error.add_message(l_mod, 15, l_exc, l_rus, '�� ������� ���� ����������', '', 1, '15');

    bars_error.add_message(l_mod, 16, l_exc, l_rus, '�� ������� ���� ���������', '', 1, '16');

    bars_error.add_message(l_mod, 17, l_exc, l_rus, '�� ������� ������ ���������', '', 1, '17');

    bars_error.add_message(l_mod, 18, l_exc, l_rus, '�� ������� ���� �����������', '', 1, '18');

    bars_error.add_message(l_mod, 19, l_exc, l_rus, '�� ������� ��� ���������(vob)', '', 1, '19');

    bars_error.add_message(l_mod, 20, l_exc, l_rus, '����������� ������� ������� ���� ������ 3-� �������', '', 1, '20');

    bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ������� ��� ������i�', '', 1, '21');

    bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������� ������� ���./����.', '', 1, '22');

    bars_error.add_message(l_mod, 23, l_exc, l_rus, '�� ������� ��� ������ �', '', 1, '23');

    bars_error.add_message(l_mod, 24, l_exc, l_rus, '�� ������� ���� � ����i �', '', 1, '24');

    bars_error.add_message(l_mod, 25, l_exc, l_rus, '����� ������ ���. ����� �� �������� - %s', '', 1, '25');

    bars_error.add_message(l_mod, 26, l_exc, l_rus, '���������� ������� ������� �������� ��� %s', '', 1, '26');

    bars_error.add_message(l_mod, 27, l_exc, l_rus, '�� ������ �������� ���������� ����������', '', 1, '27');

    bars_error.add_message(l_mod, 28, l_exc, l_rus, '³������ ����� ����� ������. ���������', '', 1, '28');

    bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ������ �������� ����� ������. ���������', '', 1, '29');

    bars_error.add_message(l_mod, 30, l_exc, l_rus, '������� %s(%s) �� ��������', '', 1, '30');

    bars_error.add_message(l_mod, 31, l_exc, l_rus, '���. ����i��� %s �� i��� � �����', '', 1, '31');

    bars_error.add_message(l_mod, 32, l_exc, l_rus, '�����(���) ���. ����i���� - ����� ��������', '', 1, '32');

    bars_error.add_message(l_mod, 33, l_exc, l_rus, '������� ��������� �������� i���� ��������i��', '', 1, '33');

    bars_error.add_message(l_mod, 34, l_exc, l_rus, '������� ������ ���������:
%s', '', 1, '34');

    bars_error.add_message(l_mod, 35, l_exc, l_rus, '%s', '', 1, '35');

    bars_error.add_message(l_mod, 36, l_exc, l_rus, '������� �i�����: %s: %s', '', 1, '36');

    bars_error.add_message(l_mod, 37, l_exc, l_rus, '������� ��� �����i in_sep - %s', '', 1, '37');

    bars_error.add_message(l_mod, 38, l_exc, l_rus, '������i� %s, �� ������ � ������� - �� ������� � �����', '', 1, '38');

    bars_error.add_message(l_mod, 39, l_exc, l_rus, '��� ��������� %s - �� ������� � �����', '', 1, '39');

    bars_error.add_message(l_mod, 40, l_exc, l_rus, '�� �������i�����j ��������� <������� ����> � ������. �������� �������-%s, � �����-%s', '', 1, '40');

    bars_error.add_message(l_mod, 41, l_exc, l_rus, '���������� ������ ���� � ��� %s', '', 1, '41');

    bars_error.add_message(l_mod, 42, l_exc, l_rus, '����i����� ���� %s �������. ������ ���������.', '', 1, '42');

    bars_error.add_message(l_mod, 43, l_exc, l_rus, '��� ��� %s �� ������� �������� RRPDAY � params$base', '', 1, '43');

    bars_error.add_message(l_mod, 44, l_exc, l_rus, '� �������� ��� ������� ����������� ���������� ���� � �������� ��� Body', '', 1, '44');

    bars_error.add_message(l_mod, 45, l_exc, l_rus, '��� ��������� % �� ����������� ������� �������', '', 1, '45');

    bars_error.add_message(l_mod, 46, l_exc, l_rus, '��� ����������� % �������� ��� % ', '', 1, '46');

    bars_error.add_message(l_mod, 47, l_exc, l_rus, '������ �������� ��� ���� ����������� % ������� ���� �����, ����� �������� - %', '', 1, '47');

    bars_error.add_message(l_mod, 48, l_exc, l_rus, '��� ���� ������������ �� ������� ����� ������', '', 1, '48');

    bars_error.add_message(l_mod, 49, l_exc, l_rus, '�� ������ ��� ������� %s ', '', 1, '49');
    bars_error.add_message(l_mod, 49, l_exc, l_ukr, '�� �������� ��� ����i�� %s', '', 1, '49');

    bars_error.add_message(l_mod, 50, l_exc, l_rus, '����� ��� ������ ������� %s ��� �������� %s �� ������', '', 1, '50');
    bars_error.add_message(l_mod, 50, l_exc, l_ukr, '³������ ��� ������ ������ %s ��� �������� %s �� ��������', '', 1, '50');

    bars_error.add_message(l_mod, 51, l_exc, l_rus, '������ ���. ��������� %s ��� ������� �������� ���� %s - %s', '', 1, '51');
    bars_error.add_message(l_mod, 51, l_exc, l_ukr, '������� ��� �����. ��������� %s ��� ������� �������� ���� %s - %s', '', 1, '51');

    bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� ������ ����� �������� - %s', '', 1, '52');
    bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� �������� ����� �������� - %s', '', 1, '52');

    bars_error.add_message(l_mod, 53, l_exc, l_rus, '� ���������� ��� ������ �� ������ �������� TRDPT (������� ��� ���������� ���������)', '', 1, '53');
    bars_error.add_message(l_mod, 53, l_exc, l_ukr, '� ���������� ��� ������ �� ������� �������� TRDPT (������� ��� ���������� ��������)', '', 1, '53');

    bars_error.add_message(l_mod, 54, l_exc, l_rus, '�� ���������� ����������� ����� %s ��� ���������� ���. ������� � ����', '', 1, '54');
    bars_error.add_message(l_mod, 54, l_exc, l_ukr, '�� ���� ����������� ������� %s ��� ���������� ���.������ � ����', '', 1, '54');

    bars_error.add_message(l_mod, 55, l_exc, l_rus, '��� ������� �������� �� ������ ���. �������� ����� �������� � ���� (CNTR)', '', 1, '55');
    bars_error.add_message(l_mod, 55, l_exc, l_ukr, '��� ������� �������� �� �������� ���.������� ����� ����� � ���� (CNTR)', '', 1, '55');

    bars_error.add_message(l_mod, 56, l_exc, l_rus, '�� ������ ����� �������� %s ��� ������ %s', '', 1, '56');
    bars_error.add_message(l_mod, 56, l_exc, l_ukr, '�� �������� ����� �������� %s ��� ������ %s', '', 1, '56');

    bars_error.add_message(l_mod, 57, l_exc, l_rus, '�� ������� ������ � int_accn ��� ����� � ��� = %s', '', 1, '57');
    bars_error.add_message(l_mod, 57, l_exc, l_ukr, '�� �������� ����� � ������� int_accn ��� ������� � ��� = %s', '', 1, '57');

    bars_error.add_message(l_mod, 58, l_exc, l_rus, '�� ������ ���� %s, ������������ ���������� GetTOBOParam(''TRDPT'') ��� ������ %s', '', 1, '58');
    bars_error.add_message(l_mod, 58, l_exc, l_ukr, '�� �������� ������� %s, �� ����������� ���������� GetTOBOParam(''TRDPT'') ��� ������ %s', '', 1, '58');

    bars_error.add_message(l_mod, 59, l_exc, l_rus, '����� �������� %s ��� ���������', '', 1, '59');
    bars_error.add_message(l_mod, 59, l_exc, l_ukr, '����� �������� %s ��� ����', '', 1, '59');

    bars_error.add_message(l_mod, 60, l_exc, l_rus, '�� ����� ������� ���� ������� �� ��� = %s', '', 1, '60');
    bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�� �������� ������� ������ �� ��� = %s', '', 1, '60');

    bars_error.add_message(l_mod, 61, l_exc, l_rus, '�� ����� ������� ���� ����������� %% �� ��� = %s', '', 1, '61');
    bars_error.add_message(l_mod, 61, l_exc, l_ukr, '�� �������� ������� ����������� %%  �� ��� = %s', '', 1, '61');

    bars_error.add_message(l_mod, 62, l_exc, l_rus, '���. �������� %s ��� ���. %s ��� ����������', '', 1, '62');
    bars_error.add_message(l_mod, 62, l_exc, l_ukr, '���. ������� %s ��� ���. %s ��� ����', '', 1, '62');

    bars_error.add_message(l_mod, 63, l_exc, l_rus, '��� ���-�� ����������� ���. �������� %s ', '', 1, '63');
    bars_error.add_message(l_mod, 63, l_exc, l_ukr, '��� ���-�� ������� ���. ������� %s', '', 1, '63');

    bars_error.add_message(l_mod, 64, l_exc, l_rus, '������ � ����� %s ������ ��������� ���� ���� ������', '', 1, '64');
    bars_error.add_message(l_mod, 64, l_exc, l_ukr, '����� � ����� %s ������� ������� ���� ���� �����', '', 1, '64');

    bars_error.add_message(l_mod, 65, l_exc, l_rus, '���. �������� %s �� ������ ���������', '', 1, '65');
    bars_error.add_message(l_mod, 65, l_exc, l_ukr, '���. ������� %s �� ������ ��������', '', 1, '65');

    bars_error.add_message(l_mod, 66, l_exc, l_rus, '�������� ���������� �� ������ - ������', '', 1, '66');
    bars_error.add_message(l_mod, 66, l_exc, l_ukr, '������ ���������� �� ������ - �����', '', 1, '66');

    bars_error.add_message(l_mod, 67, l_exc, l_rus, '��� ���. %s(%s) �� �������� ��� ��� ������ ���. �� �������� ���� �i���������(���.392-405)', '', 1, '67');

    bars_error.add_message(l_mod, 68, l_exc, l_rus, '��� ���. %s(%s) �� �������� ��� ��� ������ ���. �� �������� ��� �i���������', '', 1, '68');

    bars_error.add_message(l_mod, 69, l_exc, l_rus, '��� ���. %s(%s) �� �������� ��� ��� ������ ���. �� ������� ������������ �i���������', '', 1, '69');

    bars_error.add_message(l_mod, 70, l_exc, l_rus, '��� �������� %s(���������) �� �����������  ���.������� DPTOP(��� ��������)', '', 1, '70');

    bars_error.add_message(l_mod, 71, l_exc, l_rus, '��� �������� %s(���������) �� ����������� �������� ���.�������� DPTOP ��-������������', '', 1, '71');

    bars_error.add_message(l_mod, 72, l_exc, l_rus, '��� ������������ � ���� �������� %s � ������ SELECT_STMT ������ ���� ACTION', '', 1, '72');

    bars_error.add_message(l_mod, 73, l_exc, l_rus, '������� %s �� ������� � ����.  xml_reflist ��� �� �������� � �������������', '', 1, '73');

    bars_error.add_message(l_mod, 74, l_exc, l_rus, '��� ������ ��� ������������ ���-�� � ��� = %s �� ������ ���. �������� CNTR', '', 1, '74');
    bars_error.add_message(l_mod, 74, l_exc, l_ukr, '��� ������ ��� ������������ ���-�� � ��� = %s �� ������ ���. �������� CNTR', '', 1, '74');

    bars_error.add_message(l_mod, 75, l_exc, l_rus, '������� %s ���� �������, ��� ����� �� ��������� ����� �� ���� ������������ � xml_reaque', '', 1, '75');
    bars_error.add_message(l_mod, 75, l_exc, l_ukr, '������� %s ��� ������, �� ������ �� ��������� ����� �� ��� ��������������� � �������  xml_refque', '', 1, '75');

    bars_error.add_message(l_mod, 76, l_exc, l_rus, '������������ �������� ����������� % ��� ������������� (������ �������� ��� ��������� ����. � ��������������� � ORACLE STREAMS)', '', 1, '76');
    bars_error.add_message(l_mod, 76, l_exc, l_ukr, '������������ �������� ����������� % ��� ������������� (������ �������� ��� ��������� ����. � ��������������� � ORACLE STREAMS', '', 1, '76');

    bars_error.add_message(l_mod, 77, l_exc, l_rus, '��� ���������(������) %s �� ������ �������� RNK � branch_parameters', '', 1, '77');
    bars_error.add_message(l_mod, 77, l_exc, l_ukr, '��� ��������(������) %s �� ������� �������� RNK � branch_parameters', '', 1, '77');

    bars_error.add_message(l_mod, 78, l_exc, l_rus, '������ � RNK = %s �� ������ ��� �������� ������� ', '', 1, '78');
    bars_error.add_message(l_mod, 78, l_exc, l_ukr, '�볺�� � RNK = %s �� ������� �� �������� �������', '', 1, '78');

    bars_error.add_message(l_mod, 79, l_exc, l_rus, '�� ��� ������ ����������� xml_reflist_reqv �� �������� ��� ��������� %s ', '', 1, '79');
    bars_error.add_message(l_mod, 79, l_exc, l_ukr, '�� ��� ������ ����������� xml_reflist_reqv �� �������� ��� ��������� %s', '', 1, '79');

    bars_error.add_message(l_mod, 80, l_exc, l_rus, '������������ %s �� ������ ��� ������������ ��� � staff$base', '', 1, '80');
    bars_error.add_message(l_mod, 80, l_exc, l_ukr, '������������ %s �� ������ ��� ������������ ��� � staff$base', '', 1, '80');

    bars_error.add_message(l_mod, 81, l_exc, l_rus, '���������� ����� ������� � ��� %s', '', 1, '81');
    bars_error.add_message(l_mod, 81, l_exc, l_ukr, '���������� ����� ������� � ��� %s', '', 1, '81');

    bars_error.add_message(l_mod, 82, l_exc, l_rus, '��� ������� � ��� %s �� ������ ���', '', 1, '82');
    bars_error.add_message(l_mod, 82, l_exc, l_ukr, '��� ������� � ��� %s �� ������ ���', '', 1, '82');

    bars_error.add_message(l_mod, 83, l_exc, l_rus, '���� "%s" ��� ��� ������������ %s.', '', 1, 'FILE_ALREADY_IMPORTED');
    bars_error.add_message(l_mod, 83, l_exc, l_ukr, '���� "%s" ��� ���� ����������� %s.', '', 1, 'FILE_ALREADY_IMPORTED');

    bars_error.add_message(l_mod, 84, l_exc, l_rus, '������ ��������� %s �� ����������', '', 1, '84');
    bars_error.add_message(l_mod, 84, l_exc, l_ukr, '������ �������� %s �� ic��', '', 1, '84');

    bars_error.add_message(l_mod, 85, l_exc, l_rus, '�������� �����.������ ��� ����� ����������� %s', '', 1, '85');
    bars_error.add_message(l_mod, 85, l_exc, l_ukr, '����������� �����.������ ��� ���. �i���������  %s ', '', 1, '85');

    bars_error.add_message(l_mod, 86, l_exc, l_rus, '�������� �����.������ ��� ����� ���������� %s', '', 1, '86');
    bars_error.add_message(l_mod, 86, l_exc, l_ukr, '����������� �����.������ ��� ���. ����������  %s ', '', 1, '86');

    bars_error.add_message(l_mod, 87, l_exc, l_rus, '������������ �������� ���� ����������� %s', '', 1, '87');
    bars_error.add_message(l_mod, 87, l_exc, l_ukr, '���������� �������� ���� �i��������� %s', '', 1, '87');

    bars_error.add_message(l_mod, 88, l_exc, l_rus, '�������� ���� ����������� %s �� �������� ���', '', 1, '88');
    bars_error.add_message(l_mod, 88, l_exc, l_ukr, '�������� ���� �i��������� %s �� �������� ���', '', 1, '88');

    bars_error.add_message(l_mod, 89, l_exc, l_rus, '������ ���� ����������� %s ������ �� 8 ��������', '', 1, '89');
    bars_error.add_message(l_mod, 89, l_exc, l_ukr, '������� ���� �i��������� %s ����� �� 8 ������i�', '', 1, '89');

    bars_error.add_message(l_mod, 90, l_exc, l_rus, '��� ������������ %s �� ����������', '', 1, '90');
    bars_error.add_message(l_mod, 90, l_exc, l_ukr, '��� �i��������� %s �� i����', '', 1, '90');

    bars_error.add_message(l_mod, 91, l_exc, l_rus, '��� ������������ %s �����������', '', 1, '91');
    bars_error.add_message(l_mod, 91, l_exc, l_ukr, '��� �i��������� %s ���������', '', 1, '91');

    bars_error.add_message(l_mod, 92, l_exc, l_rus, '�������� ���� ���������� %s �� �������� ���', '', 1, '92');
    bars_error.add_message(l_mod, 92, l_exc, l_ukr, '�������� ���� ���������� %s �� �������� ���', '', 1, '92');

    bars_error.add_message(l_mod, 93, l_exc, l_rus, '������ ���� ���������� %s ������ �� 8 ��������', '', 1, '93');
    bars_error.add_message(l_mod, 93, l_exc, l_ukr, '������� ���� ���������� %s ����� �� 8 ������i�', '', 1, '93');

    bars_error.add_message(l_mod, 94, l_exc, l_rus, '������������ �������� ���� ���������� %s', '', 1, '94');
    bars_error.add_message(l_mod, 94, l_exc, l_ukr, '���������� �������� ���� ���������� %s', '', 1, '94');

    bars_error.add_message(l_mod, 95, l_exc, l_rus, '��� ���������� %s �����������', '', 1, '95');
    bars_error.add_message(l_mod, 95, l_exc, l_ukr, '��� ���������� %s ���������', '', 1, '95');

    bars_error.add_message(l_mod, 96, l_exc, l_rus, '��� ���������� %s �� ����������', '', 1, '96');
    bars_error.add_message(l_mod, 96, l_exc, l_ukr, '��� ���������� %s �� i����', '', 1, '96');

    bars_error.add_message(l_mod, 97, l_exc, l_rus, '��� ������� ����� �������� ������ ���.����� %s (������� ���� 2-39)', '', 1, '97');
    bars_error.add_message(l_mod, 97, l_exc, l_ukr, '��� ����i�� ���� ���i���� ������ %s ���.����� (�������� ���� 2-39)', '', 1, '97');

    bars_error.add_message(l_mod, 98, l_exc, l_rus, '��� ������� ����� �������� ������ ���.����� %s (������� ���� 40-73)', '', 1, '98');
    bars_error.add_message(l_mod, 98, l_exc, l_ukr, '��� ������� ���� ���i���� ������ %s ���.����� (�������� ���� 40-73)', '', 1, '98');

    bars_error.add_message(l_mod, 99, l_exc, l_rus, '�� ������� ���� ����������', '', 1, '99');

    bars_error.add_message(l_mod, 100, l_exc, l_rus, '�� ������� ��� ����������', '', 1, '100');

    bars_error.add_message(l_mod, 101, l_exc, l_rus, '�� ������� ��i��������� ����������', '', 1, '101');

    bars_error.add_message(l_mod, 102, l_exc, l_rus, '%s', '', 1, '102');
    bars_error.add_message(l_mod, 102, l_exc, l_ukr, '%s', '', 1, '102');

    bars_error.add_message(l_mod, 106, l_exc, l_rus, '�������� ����������� �����������', '', 1, '106');
    bars_error.add_message(l_mod, 106, l_exc, l_ukr, '��_���� �������� ���������', '', 1, '106');

    bars_error.add_message(l_mod, 111, l_exc, l_rus, '��� ��������� �� ������ � ������� ����� %s ', '', 1, '111');
    bars_error.add_message(l_mod, 111, l_exc, l_ukr, '��� ���_�������� �� ������� � ��������� ����� %s', '', 1, '111');

    bars_error.add_message(l_mod, 112, l_exc, l_rus, '����������� ��� ����� �������������� %s ', '', 1, '112');
    bars_error.add_message(l_mod, 112, l_exc, l_ukr, '���_����� ��� ������ �������������� %s', '', 1, '112');

    bars_error.add_message(l_mod, 113, l_exc, l_rus, '����������� ���������� ��� ������������� %s ', '', 1, '113');
    bars_error.add_message(l_mod, 113, l_exc, l_ukr, '���i����� ���_���� ��� �������_���_� %s', '', 1, '113');

    bars_error.add_message(l_mod, 114, l_exc, l_rus, '����������� ���������� ��� ������������� %s ', '', 1, '114');
    bars_error.add_message(l_mod, 114, l_exc, l_ukr, '���i����� ���_���� ��� �������_���_� %s', '', 1, '114');

    bars_error.add_message(l_mod, 150, l_exc, l_rus, '%s', '', 1, '150');

    bars_error.add_message(l_mod, 151, l_exc, l_rus, '����������� ������ ���� � ��� ���� ��������� - %s', '', 1, '151');

    bars_error.add_message(l_mod, 152, l_exc, l_rus, '����������� ������ ���� ������� - %s', '', 1, '152');

    bars_error.add_message(l_mod, 153, l_exc, l_rus, '��������� �������� �� ����� �������� ���� ������ � - %s', '', 1, '153');

    bars_error.add_message(l_mod, 154, l_exc, l_rus, '����������� ������ ���� ����������� - %s', '', 1, '154');

    bars_error.add_message(l_mod, 155, l_exc, l_rus, '��������� �������� �� ����� �������� ���� ������� - %s', '', 1, '155');

    bars_error.add_message(l_mod, 156, l_exc, l_rus, '��������� �������� �� ����� �������� ����.�������� - %s', '', 1, '156');

    bars_error.add_message(l_mod, 157, l_exc, l_rus, '��������� �������� �� ����� �������� �� - %s', '', 1, '157');

    bars_error.add_message(l_mod, 158, l_exc, l_rus, '��������� �������� �� ����� �������� ���� ������ � - %s', '', 1, '158');

    bars_error.add_message(l_mod, 159, l_exc, l_rus, '����������� ������ ���� � ������� - %s', '', 1, '159');

    bars_error.add_message(l_mod, 160, l_exc, l_rus, '����������� ������ ���� ������� - %s', '', 1, '160');

    bars_error.add_message(l_mod, 161, l_exc, l_rus, '��� �������� %s �� ������� ��� ��������� vob', '', 1, '161');

    bars_error.add_message(l_mod, 162, l_exc, l_rus, '������������ �������� � ���.������� %s �� ��������', '', 1, '162');

    bars_error.add_message(l_mod, 163, l_exc, l_rus, '�������� ���. ����i���� %s - �����', '', 1, '163');

    bars_error.add_message(l_mod, 164, l_exc, l_rus, '���� %s �� ���� %s �� ��� ���i�����������', '', 1, '164');

    bars_error.add_message(l_mod, 165, l_exc, l_rus, '�� ������ ������ ���.�����', '', 1, '165');

    bars_error.add_message(l_mod, 166, l_exc, l_rus, '��������� �������� ��� ��������� ��� ��������� ��������', '', 1, '166');

    bars_error.add_message(l_mod, 167, l_exc, l_rus, '��������� ������ �������� ��� ���������� ��� ���������� ���������', '', 1, '167');

    bars_error.add_message(l_mod, 168, l_exc, l_rus, '������� ���������� %s �� ���� � ������ �����', '', 1, '168');

    bars_error.add_message(l_mod, 169, l_exc, l_rus, '������� ���������� %s �� ���� � ������ �����', '', 1, '169');

    bars_error.add_message(l_mod, 170, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������� �������� SNCLOCAL - ����� �������(��������) ��� ������������ offline', '', 1, '170');

    bars_error.add_message(l_mod, 171, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������� �������� SNCPARNT - ����� �������(���� �� �����) ��� ������������ offline', '', 1, '171');

    bars_error.add_message(l_mod, 172, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������� �������� SNCGLBL - ����� �������(���������) ��� ������������ offline', '', 1, '172');

    bars_error.add_message(l_mod, 173, l_exc, l_rus, '�������� ������� � ���� �������� ������� �', '', 1, '173');

    bars_error.add_message(l_mod, 174, l_exc, l_rus, '����� �������� ��� ������ ��� ��������� %s', '', 1, '174');

    bars_error.add_message(l_mod, 175, l_exc, l_rus, '������� %s - �� ����', '', 1, '175');

    bars_error.add_message(l_mod, 176, l_exc, l_rus, '������� %s ��� ���� ��� ������ ���������', '', 1, '176');

    bars_error.add_message(l_mod, 177, l_exc, l_rus, '��� ������� �� �������� � %s (�������� %s ) �� ������� ��� �������� (���. ������� DPTPR)', '', 1, '177');

    bars_error.add_message(l_mod, 178, l_exc, l_rus, '��� ������� �� �������� � %s �� ������� ��� ������� ����������� ��� �������� DPTPR (������ ���� DPT1 ��� DPT2)', '', 1, '178');

    bars_error.add_message(l_mod, 179, l_exc, l_rus, '�� �������� ���i �� ����i�����: %s', '', 1, '179');

    bars_error.add_message(l_mod, 180, l_exc, l_rus, '�� �������� ��� %s', '', 1, '180');

    bars_error.add_message(l_mod, 181, l_exc, l_rus, '��� ����������� %s �� ������������ ��� ���������� ���. ����', '', 1, '181');

    bars_error.add_message(l_mod, 182, l_exc, l_rus, '����� �����(��������� ����� ��������� �����) %s �� �������� � ��������� ����� ', '', 1, '182');

    bars_error.add_message(l_mod, 183, l_exc, l_rus, '���� ������ ��������� %s, ����� �� ���� ���������� %s', '', 1, '183');

    bars_error.add_message(l_mod, 184, l_exc, l_rus, '���-�� ������� � ������� ��������� aq_refsync_tbl ��������� 10000. �������������� ������ ����� ����� �� ����������. �������� ������� ��� ����������� ������ ��� JBOSS �������', '', 1, '184');
    bars_error.add_message(l_mod, 184, l_exc, l_ukr, '���-�� ������� � ������� ��������� aq_refsync_tbl ��������� 10000. �������������� ������ ����� ����� �� ����������. �������� ������� ��� ����������� ������ ��� JBOSS �������', '', 1, '184');

    bars_error.add_message(l_mod, 185, l_exc, l_rus, '������ ������ ����� ��� %s �� ����� ��������� 14-�� ��������', '', 1, '185');
    bars_error.add_message(l_mod, 185, l_exc, l_ukr, '������� ������ ������� ��� %s �� ���� ������������ 14-�� �������', '', 1, '185');

    bars_error.add_message(l_mod, 186, l_exc, l_rus, '������ ������������ �������: %s �� ������ ��������� 38-�� ��������', '', 1, '186');
    bars_error.add_message(l_mod, 186, l_exc, l_ukr, '������� ����� �볺���: %s �� ������� ������������ 38-�� �������', '', 1, '186');

    bars_error.add_message(l_mod, 187, l_exc, l_rus, '������ ���������� ������� �� ������ ��������� 160 ��������(��� ����������� ����������� ������� �������������� ���. �������� �)', '', 1, '187');
    bars_error.add_message(l_mod, 187, l_exc, l_ukr, '������� ����������� ������� �� ������� ������������ 160-�� �������(��� ����������� ����������� ������� �������������� ���.�������� �)', '', 1, '187');

    bars_error.add_message(l_mod, 188, l_exc, l_rus, '����� �������� %s �� ������������� ����� xxxxxx/N (xxxxxx-��� ���., N-�������� � ���.) ', '', 1, '188');
    bars_error.add_message(l_mod, 188, l_exc, l_ukr, '����� �������� %s �� ������� ����� xxxxxx/N (xxxxxx-��� ����., N-�������� � ���.)', '', 1, '188');

    bars_error.add_message(l_mod, 189, l_exc, l_rus, '�������� DPTNUM ��� %s - ������ ���� ������, � ��� �������� ������ ����� %s ', '', 1, '189');
    bars_error.add_message(l_mod, 189, l_exc, l_ukr, '�������� DPTNUM ��� %s - ������� ���� ������, � ���� �������� ����� ������� %s', '', 1, '189');

    bars_error.add_message(l_mod, 190, l_exc, l_rus, '������������ ����� ��������: %s. ������� ���� ������� �� ����� ���������� ��������', '', 1, '190');
    bars_error.add_message(l_mod, 190, l_exc, l_ukr, '������������ ����� ��������: %s. ������� ����� �� ����� ���������� ��������', '', 1, '190');

    bars_error.add_message(l_mod, 191, l_exc, l_rus, '��� �������� � ��������� %s - �� ������� ��������������� �������� ��� ������ ���������', '', 1, 'NOTEXISTS_OFFLINE_TT');
    bars_error.add_message(l_mod, 191, l_exc, l_ukr, '��� �������� � ��������� %s - �� ������� �������� �������� ��� ������ ��������', '', 1, 'NOTEXISTS_OFFLINE_TT');

    bars_error.add_message(l_mod, 192, l_exc, l_rus, '��������� �������� ��� %s �� �������', '', 1, 'NO_SUCH_RNK');
    bars_error.add_message(l_mod, 192, l_exc, l_ukr, '������� ��������  ��� %s �� �������', '', 1, 'NO_SUCH_RNK');

    bars_error.add_message(l_mod, 193, l_exc, l_rus, '��������� �������� ������ %s �� �������', '', 1, 'NO_SUCH_BRANCH');
    bars_error.add_message(l_mod, 193, l_exc, l_ukr, '������� ��������  ������ %s �� �������', '', 1, 'NO_SUCH_BRANCH');

    bars_error.add_message(l_mod, 194, l_exc, l_rus, '�� ������� �������� ������ ��� ���������', '', 1, 'NO_BRANCH');
    bars_error.add_message(l_mod, 194, l_exc, l_ukr, '�� ������� �������� ������ ��� ��������', '', 1, 'NO_BRANCH');

    bars_error.add_message(l_mod, 195, l_exc, l_rus, '�� ������� �������� ������������ ��������������(���) ��� %s', '', 1, 'NO_SAB');
    bars_error.add_message(l_mod, 195, l_exc, l_ukr, '�� ������� �������� ������������ ��������������(���) ��� %s', '', 1, 'NO_SAB');

    bars_error.add_message(l_mod, 196, l_exc, l_rus, '�� ������� �������� ����� ��������� ��� %s', '', 1, 'NO_TECHKEY');
    bars_error.add_message(l_mod, 196, l_exc, l_ukr, '�� ������� �������� ����� ��������� ��� %s', '', 1, 'NO_TECHKEY');

    bars_error.add_message(l_mod, 197, l_exc, l_rus, '��� ���������� ��� %s, �� ������� ����� %s, � ��� ���� ���������� ����� %s', '', 1, 'NOT_CORRECT_BRANCH');
    bars_error.add_message(l_mod, 197, l_exc, l_ukr, '��� ��������� ��� %s, �� ������� ����� %s, � ��� ����� ����������� ����� %s', '', 1, 'NOT_CORRECT_BRANCH');

    bars_error.add_message(l_mod, 198, l_exc, l_rus, '�������� ����� %s ������ ���� ������� ��� �������� ������', '', 1, 'NOT_CORRECT_BRANCH2');
    bars_error.add_message(l_mod, 198, l_exc, l_ukr, '�������� ����� %s ������� ���� ������� ��� �������� ����', '', 1, 'NOT_CORRECT_BRANCH2');

    bars_error.add_message(l_mod, 199, l_exc, l_rus, '����������� �������������(���) %s ��� ��������� %s ������ �������� �� 6-�� ��������', '', 1, 'NOT_CORRECT_SAB');
    bars_error.add_message(l_mod, 199, l_exc, l_ukr, '����������� �������������(���) %s ��� �������� %s ������� ������ 6-�� �������', '', 1, 'NOT_CORRECT_SAB');

    bars_error.add_message(l_mod, 200, l_exc, l_rus, '����������� �������������(���) ����� %s ��� ��������� %s ������ �������� �� 6-�� ��������', '', 1, 'NOT_CORRECT_FILESAB');
    bars_error.add_message(l_mod, 200, l_exc, l_ukr, '����������� �������������(���) ����� %s ��� �������� %s ������� ������ 6-�� �������', '', 1, 'NOT_CORRECT_FILESAB');

    bars_error.add_message(l_mod, 201, l_exc, l_rus, '���� ��������� %s ��� ��������� %s ������ �������� �� 5-�� ��������', '', 1, 'NOT_CORRECT_TECHKEY');
    bars_error.add_message(l_mod, 201, l_exc, l_ukr, '���� ��������� %s ��� �������� %s ������� ������ 5-�� �������', '', 1, 'NOT_CORRECT_TECHKEY');

    bars_error.add_message(l_mod, 202, l_exc, l_rus, '��������� ��� %s ��� ���������� � ������� �������', '', 1, 'SUCH_SAB_EXISTS');
    bars_error.add_message(l_mod, 202, l_exc, l_ukr, '�������� ��� %s ��� ���� � ������ �볺���', '', 1, 'SUCH_SAB_EXISTS');

    bars_error.add_message(l_mod, 203, l_exc, l_rus, '������ ������� %s, ��������� �������� %s, ������� ��� ���� � staff$base', '', 1, 'BROKEN_SEQUENCE');
    bars_error.add_message(l_mod, 203, l_exc, l_ukr, '������ ������� %s, ��������� �������� %s, ������� ��� ���� � staff$base', '', 1, 'BROKEN_SEQUENCE');

    bars_error.add_message(l_mod, 204, l_exc, l_rus, '���.�������� <��� �������� � ���������> (DPTOP) - ���������� �������� %s', '', 1, 'PTOP_NOT_NUMBER');
    bars_error.add_message(l_mod, 204, l_exc, l_ukr, '���.������� <��� �������� � ���������> (DPTOP) - �� ������� �������� %s', '', 1, 'PTOP_NOT_NUMBER');

    bars_error.add_message(l_mod, 205, l_exc, l_rus, '���� ������������� ������ ��� ������ ����.���� �� 1 ����� %s', '', 1, 'NOT_CORRECT_PAYDATE');
    bars_error.add_message(l_mod, 205, l_exc, l_ukr, '���� ����������� ����� ��� ����� �� ����.���� �� 1 ����� %s', '', 1, 'NOT_CORRECT_PAYDATE');

    bars_error.add_message(l_mod, 206, l_exc, l_rus, '��� ���. ���������� %s �� ��������������', '', 1, 'NOT_AGREEMENT_TYPE');
    bars_error.add_message(l_mod, 206, l_exc, l_ukr, '��� ���. ����� %s �� ������������ ', '', 1, 'NOT_AGREEMENT_TYPE');

    bars_error.add_message(l_mod, 207, l_exc, l_rus, '������������� ���������� �������������� �������', '', 1, 'INNER_INFO_NOTALLOWED');
    bars_error.add_message(l_mod, 207, l_exc, l_ukr, '����������� ��������� ������� ����������� ������', '', 1, 'INNER_INFO_NOTALLOWED');

    bars_error.add_message(l_mod, 208, l_exc, l_rus, '�� ���� �� ��� �� ����� ��� ������ �����', '', 1, 'NO_OUR_MFO');
    bars_error.add_message(l_mod, 208, l_exc, l_ukr, '����� � ��� �� ������� ��� ������ �����', '', 1, 'NO_OUR_MFO');

    bars_error.add_message(l_mod, 209, l_exc, l_rus, '���� %s(%s) �� ���������� � ����� �����', '', 1, 'NO_ACCOUNT_FOUND');
    bars_error.add_message(l_mod, 209, l_exc, l_ukr, '������� %s(%s) �� ���� � ������ �����', '', 1, 'NO_ACCOUNT_FOUND');

    bars_error.add_message(l_mod, 210, l_exc, l_rus, '��� ���-%s, ���� %s(%s) �� ������� ��������� � ����������� ������� ������������', '', 1, 'NO_ALIEN_FOUND');
    bars_error.add_message(l_mod, 210, l_exc, l_ukr, '��� ���-%s, ������� %s(%s) �� �������� �������� � �������� ������� �����������', '', 1, 'NO_ALIEN_FOUND');

    bars_error.add_message(l_mod, 211, l_exc, l_rus, '��������� �������� ���� ��� ������� � ���=%s (��� ����� %s-%s) �����������: %s', '', 1, 'CUST_OKPO_NOTCORRECT');
    bars_error.add_message(l_mod, 211, l_exc, l_ukr, '�������� �������� ���� ��� �볺��� � ���=%s (��� ������� %s-%s) �����������: %s', '', 1, 'CUST_OKPO_NOTCORRECT');

    bars_error.add_message(l_mod, 212, l_exc, l_rus, '������ ��� ������ ���� ��� ����� %s(%s) � ����������� ������ �����������(ALIEN): %s', '', 1, 'ALIEN_OKPO_NOTCORRECT');
    bars_error.add_message(l_mod, 212, l_exc, l_ukr, '������� ��� ������ ���� ��� ������� %s(%s) � �������� ����� ����������(ALIEN): %s', '', 1, 'ALIEN_OKPO_NOTCORRECT');

    bars_error.add_message(l_mod, 213, l_exc, l_rus, '� �������� � �������� ��� ���������� ������ ��� �������� %s. ��� ��������� ������ ��� ���� ��������', '', 1, 'SUCH_DRECDPT_WASPAYED');
    bars_error.add_message(l_mod, 213, l_exc, l_ukr, '� �������� � �������� ��� ���������� ������ ��� �������� %s. ��� ��������� ������ ��� ���� ��������', '', 1, 'SUCH_DRECDPT_WASPAYED');

    bars_error.add_message(l_mod, 214, l_exc, l_rus, '������������ ���� �� ����� ����� %s(%s)', '', 1, 'NO_DEBET_RIGHTS');
    bars_error.add_message(l_mod, 214, l_exc, l_ukr, '����������� ���� �� ����� ������� %s(%s)', '', 1, 'NO_DEBET_RIGHTS');

    bars_error.add_message(l_mod, 215, l_exc, l_rus, '������������ ���� �� ������ ����� %s(%s)', '', 1, 'NO_KREDIT_RIGHTS');
    bars_error.add_message(l_mod, 215, l_exc, l_ukr, '����������� ���� �� ������ ������� %s(%s)', '', 1, 'NO_KREDIT_RIGHTS');

    bars_error.add_message(l_mod, 216, l_exc, l_rus, '����� �� ����� �� ������ ��� %s', '', 1, 'NOT_OUR_MFO');
    bars_error.add_message(l_mod, 216, l_exc, l_ukr, '����� � ������� �� ����� ��� %s', '', 1, 'NOT_OUR_MFO');

    bars_error.add_message(l_mod, 217, l_exc, l_rus, '�� ������ ��� ��� ������� ��� �������� ����������� %s (����� ��� ������ ������ ���)', '', 1, 'NO_SAB_FORREF');
    bars_error.add_message(l_mod, 217, l_exc, l_ukr, '�� ������� ��� ��� ��i���� ��� �������� ���i����� %s (����i��� ��� ����ii ������ ���)', '', 1, 'NO_SAB_FORREF');

    bars_error.add_message(l_mod, 218, l_exc, l_rus, '�� ���������� ������ �������������� ������� ��� �������� ����������� %s', '', 1, 'NO_SUCHSAB_FORREF');
    bars_error.add_message(l_mod, 218, l_exc, l_ukr, '�� icy� ������ i������i������ ��i���� ���  �������� ���i����� %s (����i��� ��� ����ii ������ ���)', '', 1, 'NO_SUCHSAB_FORREF');

    bars_error.add_message(l_mod, 219, l_exc, l_rus, '�������� ������� ���� ����� �� ������ ���� ������ 99', '', 1, 'NOTCORRECT_SK');
    bars_error.add_message(l_mod, 219, l_exc, l_ukr, '�������� ������� ��� ����� �� ������ ���� ������� �� 99', '', 1, 'NOTCORRECT_SK');

    bars_error.add_message(l_mod, 220, l_exc, l_rus, '�������� ������������ �������������� ��� = %s ����������� � ��������� ���������� ������������ ', '', 1, 'SAB_DUBLS');
    bars_error.add_message(l_mod, 220, l_exc, l_ukr, '�������� ����������� i������i������ ��� =  %s ����i������ i �������� ���i����� ������������', '', 1, 'SAB_DUBLS');

    bars_error.add_message(l_mod, 221, l_exc, l_rus, '%s', '', 1, 'INSEP_ERROR');
    bars_error.add_message(l_mod, 221, l_exc, l_ukr, '%s', '', 1, 'INSEP_ERROR');

    bars_error.add_message(l_mod, 222, l_exc, l_rus, '������������ �������� ���� �������� (������/������ ������ �� ����.����): %s', '', 1, 'NOTVALID_DATD');
    bars_error.add_message(l_mod, 222, l_exc, l_ukr, '��������� �������� ���� ��������� (�i����/����� �i���� �i� ����i����� ����): %s', '', 1, 'NOTVALID_DATD');

    bars_error.add_message(l_mod, 223, l_exc, l_rus, '� ������� ��� %s ���� ����������� ����� ����� ����������: %s', '', 1, 'NLSA_NLSB_ARE_EQUAL');
    bars_error.add_message(l_mod, 223, l_exc, l_ukr, '� ������i ��� %s ������� �i��������� �� ���������� - �������i: %s', '', 1, 'NLSA_NLSB_ARE_EQUAL');

    bars_error.add_message(l_mod, 224, l_exc, l_rus, '������ ����� �������������� ����� �� ������ ��������� 30 ��������: %s', '', 1, 'FILENAME_TOO_LONG');
    bars_error.add_message(l_mod, 224, l_exc, l_ukr, '������� i���i ����� �� ������� ������������ 30 ������i�: %s', '', 1, 'FILENAME_TOO_LONG');

    bars_error.add_message(l_mod, 225, l_exc, l_rus, '���������� ������� �������� ���������� �������(����.������� �������)', '', 1, 'NOPRINT_CHAR_NAZN');
    bars_error.add_message(l_mod, 225, l_exc, l_ukr, '����������� ������� �i����� ����������i �������(����.�����i� �������)', '', 1, 'NOPRINT_CHAR_NAZN');

    bars_error.add_message(l_mod, 226, l_exc, l_rus, '������������ ����������� �������� ���������� �������(����.������� �������)', '', 1, 'NOPRINT_CHAR_NAMA');
    bars_error.add_message(l_mod, 226, l_exc, l_ukr, '����� �������� �i����� ����������i �������(����.�����i� �������)', '', 1, 'NOPRINT_CHAR_NAMA');

    bars_error.add_message(l_mod, 227, l_exc, l_rus, '������������ ���������� �������� ���������� �������(����.������� �������)', '', 1, 'NOPRINT_CHAR_NAMB');
    bars_error.add_message(l_mod, 227, l_exc, l_ukr, '����� ���������� �i����� ����������i �������(����.�����i� �������)', '', 1, 'NOPRINT_CHAR_NAMB');

    bars_error.add_message(l_mod, 228, l_exc, l_rus, '���������� ��� ������ ����� %s � ob22=%s ���������� ��� �������� %s', '', 1, 'NOTALLOWED_NBSOB22_D');
    bars_error.add_message(l_mod, 228, l_exc, l_ukr, '���������� ��� ������ ������� %s �� ob22=%s ����������� ��� ������i� %s', '', 1, 'NOTALLOWED_NBSOB22_D');

    bars_error.add_message(l_mod, 229, l_exc, l_rus, '���������� ��� ������� ��� ����� %s � ob22=%s ���������� ��� �������� %s', '', 1, 'NOTALLOWED_NBSOB22_K');
    bars_error.add_message(l_mod, 229, l_exc, l_ukr, '���������� ��� ������� ������� %s �� ob22=%s ����������� ��� ������i� %s', '', 1, 'NOTALLOWED_NBSOB22_K');

    bars_error.add_message(l_mod, 230, l_exc, l_rus, '����� �� ����� ���� ������� ��� ���������', '', 1, 'NULLABLE_SUM');
    bars_error.add_message(l_mod, 230, l_exc, l_ukr, '���� �� ���� ���� �������� ��� ���������', '', 1, 'NULLABLE_SUM');

    bars_error.add_message(l_mod, 231, l_exc, l_rus, '����� ��������� #%s', '', 1, 'DUPLICATE_DOCUMENT');
    bars_error.add_message(l_mod, 231, l_exc, l_ukr, '����� ��������� #%s', '', 1, 'DUPLICATE_DOCUMENT');

    bars_error.add_message(l_mod, 232, l_exc, l_rus, '���� ��������� ������ ��� ������ ����.���� �� 1 ����� %s', '', 1, 'NOT_CORRECT_DATD');
    bars_error.add_message(l_mod, 232, l_exc, l_ukr, '���� ����������� ����� ��� ����� �� ����.���� �� 1 ����� %s', '', 1, 'NOT_CORRECT_DATD');

    bars_error.add_message(l_mod, 233, l_exc, l_rus, '�� ������ ����� ��������', '', 1, 'NOT_CORRECT_PASSP');
    bars_error.add_message(l_mod, 233, l_exc, l_ukr, '�� ������� ����� ��������', '', 1, 'NOT_CORRECT_PASSP');

    bars_error.add_message(l_mod, 234, l_exc, l_rus, '������ ����������� ��� � ������ (���� 10,11 � �������) %s', '', 1, 'NOT_CORRECT_DATP');
    bars_error.add_message(l_mod, 234, l_exc, l_ukr, '������ ����������� ��� � ������ (���� 10,11 � �������) %s', '', 1, 'NOT_CORRECT_DATP');

    bars_error.add_message(l_mod, 235, l_exc, l_rus, '������ ���������� ������� ����������', '', 1, 'CLOSE_PAY_DOCS');
    bars_error.add_message(l_mod, 235, l_exc, l_ukr, '������ ��������� ����������� ����������', '', 1, 'CLOSE_PAY_DOCS');

    bars_error.add_message(l_mod, 236, l_exc, l_rus, '���� ����������� %s(%s) - ������', '', 1, 'CLOSE_PAYER_ACCOUNT');
    bars_error.add_message(l_mod, 236, l_exc, l_ukr, '������� �������� %s(%s) - �������', '', 1, 'CLOSE_PAYER_ACCOUNT');

    bars_error.add_message(l_mod, 237, l_exc, l_rus, '���� ���������� %s(%s) - ������', '', 1, 'CLOSE_PAYEE_ACCOUNT');
    bars_error.add_message(l_mod, 237, l_exc, l_ukr, '������� ���������� %s(%s) - �������', '', 1, 'CLOSE_PAYEE_ACCOUNT');

    bars_error.add_message(l_mod, 238, l_exc, l_rus, '� ��������� �� ������ ���� ����� 99-�� ����� BIS', '', 1, 'MORE_THAN_99_BIS');
    bars_error.add_message(l_mod, 238, l_exc, l_ukr, '� �������� �� ������� ���� ���� �� 99-�� BIS �����', '', 1, 'MORE_THAN_99_BIS');

    bars_error.add_message(l_mod, 239, l_exc, l_rus, '��� �������� �������� ��������� �� �����, ������ ����. ����� = 66, � ���������� %s', '', 1, 'NOT_CORRECT_CASH66');
    bars_error.add_message(l_mod, 239, l_exc, l_ukr, '��� �������� ������������ ��������� �� ����, ������ ���. ����� = 66, � ����������� %s', '', 1, 'NOT_CORRECT_CASH66');

    bars_error.add_message(l_mod, 240, l_exc, l_rus, '��� �������� �������� �� ��������� � �����, ������ ����. ����� = 39, � ���������� %s', '', 1, 'NOT_CORRECT_CASH39');
    bars_error.add_message(l_mod, 240, l_exc, l_ukr, '��� �������� ������������ � ��������� � ����, ������ ���. ����� = 39, � ����������� %s', '', 1, 'NOT_CORRECT_CASH39');

    bars_error.add_message(l_mod, 241, l_exc, l_rus, '������������ ����������� ������ ��� ����� ����������� %s', '', 1, 'NOTCORECT_CHECK_DIGIT_A');
    bars_error.add_message(l_mod, 241, l_exc, l_ukr, '����������� ����������� ������ ��� ������� ���������� %s', '', 1, 'NOTCORECT_CHECK_DIGIT_A');

    bars_error.add_message(l_mod, 242, l_exc, l_rus, '������������ ����������� ������ ��� ����� ���������� %s', '', 1, 'NOTCORECT_CHECK_DIGIT_B');
    bars_error.add_message(l_mod, 242, l_exc, l_ukr, '����������� ����������� ������ ��� ������� ����������� %s', '', 1, 'NOTCORECT_CHECK_DIGIT_B');
  commit;
end;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/Bars/Data/Err/mod_KLB.sql =========*** Run *** ==
PROMPT ===================================================================================== 
