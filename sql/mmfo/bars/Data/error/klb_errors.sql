declare
  l_mod  varchar2(3) := 'KLB';
  l_rus  varchar2(3) := 'RUS';
  l_ukr  varchar2(3) := 'UKR';
  l_exc  number(6)   := -20000;
begin
  
  bars_error.add_module(l_mod, '������-����', 1);

  bars_error.add_message(l_mod, 1, l_exc, l_rus, '�� ������ ��� ��������� %s ','', 1);
  bars_error.add_message(l_mod, 1, l_exc, l_ukr, '�� �������� ��� ���i�������� %s','', 1);

  bars_error.add_message(l_mod, 2, l_exc, l_rus, '� ����������� kl_customer_params ���� �������� ��� �������  %s ','', 1);
  bars_error.add_message(l_mod, 2, l_exc, l_ukr, '� ���i����� kl_customer_params ���������� ���� ��� ��i����  %s','', 1);

  bars_error.add_message(l_mod, 4, l_exc, l_rus, '�������� branch ��� sab %s ','', 1);
  bars_error.add_message(l_mod, 4, l_exc, l_ukr, '�� �������� branch ��� sab %s','', 1);

  bars_error.add_message(l_mod, 5, l_exc, l_rus, '��� ������� %s �� ���������� �������� SAB','', 1);
  bars_error.add_message(l_mod, 5, l_exc, l_ukr, '��� �i�i� %s �� �������� �������� SAB','', 1);
  
  -- ������ ��������� ���������� ���-��  6 - 30

  bars_error.add_message(l_mod, 6, l_exc, l_rus, '�������� ����� ���������','', 1);
  bars_error.add_message(l_mod, 6, l_exc, l_ukr, '���������� ����� ���������','', 1);

  bars_error.add_message(l_mod, 7, l_exc, l_rus, '���������� ���� ���������','', 1);
  bars_error.add_message(l_mod, 7, l_exc, l_ukr, '�i������ ���� ���������','', 1);

  bars_error.add_message(l_mod, 8, l_exc, l_rus, '�� ������� ������������ �����������','', 1);
  bars_error.add_message(l_mod, 8, l_exc, l_rus, '�� ������� ��i��������� �i���������','', 1);

  bars_error.add_message(l_mod, 9, l_exc, l_rus, '�� ������� ��� ����� �����������','', 1);
  bars_error.add_message(l_mod, 9, l_exc, l_rus, '�� ������� ��� ����� �i���������','', 1);

  bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ������ ���� �����������','', 1);
  bars_error.add_message(l_mod, 10, l_exc, l_rus, '�� ������� �i���������','', 1);

  bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ������� ���� �����������','', 1);
  bars_error.add_message(l_mod, 11, l_exc, l_rus, '�� ������� ���� �i���������','', 1);

  bars_error.add_message(l_mod, 12, l_exc, l_rus, '�� ������� ������������ ����������','', 1);
  bars_error.add_message(l_mod, 12, l_exc, l_rus, '�� ������� ��i��������� ����������','', 1);

  bars_error.add_message(l_mod, 13, l_exc, l_rus, '�� ������� ��� ����� ����������','', 1);
  bars_error.add_message(l_mod, 13, l_exc, l_rus, '�� ������� ��� ����� ����������','', 1);

  bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ������ ���� ����������','', 1);
  bars_error.add_message(l_mod, 14, l_exc, l_rus, '�� ������� ����������','', 1);

  bars_error.add_message(l_mod, 15, l_exc, l_rus, '�� ������� ���� ����������','', 1);
  bars_error.add_message(l_mod, 15, l_exc, l_rus, '�� ������� ���� ����������','', 1);

  bars_error.add_message(l_mod, 16, l_exc, l_rus, '�� ������� ����� ���������','', 1);
  bars_error.add_message(l_mod, 16, l_exc, l_rus, '�� ������� ���� ���������','', 1);

  bars_error.add_message(l_mod, 17, l_exc, l_rus, '�� ������� ������','', 1);
  bars_error.add_message(l_mod, 17, l_exc, l_rus, '�� ������� ������ ���������','', 1);

  bars_error.add_message(l_mod, 18, l_exc, l_rus, '�� ������� ���� �������������','', 1);
  bars_error.add_message(l_mod, 18, l_exc, l_rus, '�� ������� ���� �����������','', 1);

  bars_error.add_message(l_mod, 19, l_exc, l_rus, '�� ������ ��� ���������(vob)','', 1);
  bars_error.add_message(l_mod, 19, l_exc, l_rus, '�� ������� ��� ���������(vob)','', 1);

  bars_error.add_message(l_mod, 20, l_exc, l_rus, '���������� ������� ������ ��� ����� 3-� ��������','', 1);
  bars_error.add_message(l_mod, 20, l_exc, l_rus, '����������� ������� ������� ���� ������ 3-� �������','', 1);

  bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ������ ��� ��������(TT)','', 1);
  bars_error.add_message(l_mod, 21, l_exc, l_rus, '�� ������� ��� ������i�','', 1);

  bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������ ������� ���./����.','', 1);
  bars_error.add_message(l_mod, 22, l_exc, l_rus, '�� ������� ������� ���./����.','', 1);

  bars_error.add_message(l_mod, 23, l_exc, l_rus, '�� ������ ��� ������ �','', 1);
  bars_error.add_message(l_mod, 23, l_exc, l_rus, '�� ������� ��� ������ �','', 1);

  bars_error.add_message(l_mod, 24, l_exc, l_rus, '�� ������� ����� � ������ �','', 1);
  bars_error.add_message(l_mod, 24, l_exc, l_rus, '�� ������� ���� � ����i �','', 1);

  bars_error.add_message(l_mod, 25, l_exc, l_rus, '������ ������ ���. ����� �� ������ - %s','', 1);
  bars_error.add_message(l_mod, 25, l_exc, l_rus, '����� ������ ���. ����� �� �������� - %s','', 1);

  bars_error.add_message(l_mod, 26, l_exc, l_rus, '����������� ������� �������� �������� ��� %s','', 1);
  bars_error.add_message(l_mod, 26, l_exc, l_rus, '���������� ������� ������� �������� ��� %s','', 1);

  bars_error.add_message(l_mod, 27, l_exc, l_rus, '�� ������ �������� ���������� �����������','', 1);
  bars_error.add_message(l_mod, 27, l_exc, l_rus, '�� ������ �������� ���������� ����������','', 1);

  bars_error.add_message(l_mod, 28, l_exc, l_rus, '���������� ������� �����-�����������','', 1);
  bars_error.add_message(l_mod, 28, l_exc, l_rus, '³������ ����� ����� ������. ���������','', 1);

  bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ������ �������� ����� �����-�����������','', 1);
  bars_error.add_message(l_mod, 29, l_exc, l_rus, '�� ������ �������� ����� ������. ���������','', 1);

  bars_error.add_message(l_mod, 30, l_exc, l_rus, '�� ������ �������� ����� �����-�����������','', 1);
  bars_error.add_message(l_mod, 30, l_exc, l_rus, '�� ������ �������� ����� �_����_�. ���������','', 1);

  -----

  bars_error.add_message(l_mod, 30, l_exc, l_rus, '���� %s(%s) �� ������','', 1);
  bars_error.add_message(l_mod, 30, l_exc, l_rus, '������� %s(%s) �� ��������','', 1);

  bars_error.add_message(l_mod, 31, l_exc, l_rus, '���. �������� %s �� ��������� � �����','', 1);
  bars_error.add_message(l_mod, 31, l_exc, l_rus, '���. ����i��� %s �� i��� � �����','', 1);

  bars_error.add_message(l_mod, 32, l_exc, l_rus, '��������(���) ���. ��������� - ������ ��������','', 1);
  bars_error.add_message(l_mod, 32, l_exc, l_rus, '�����(���) ���. ����i���� - ����� ��������','', 1);

  bars_error.add_message(l_mod, 33, l_exc, l_rus, '���� �������� ����� ������ �����������','', 1);
  bars_error.add_message(l_mod, 33, l_exc, l_rus, '������� ��������� �������� i���� ��������i��','', 1);

  bars_error.add_message(l_mod, 34, l_exc, l_rus, '������ ������ ���������:'||chr(13)||chr(10)||'%s','', 1);
  bars_error.add_message(l_mod, 34, l_exc, l_rus, '������� ������ ���������:'||chr(13)||chr(10)||'%s','', 1);

  bars_error.add_message(l_mod, 35, l_exc, l_rus, '%s','', 1);
  bars_error.add_message(l_mod, 35, l_exc, l_rus, '%s','', 1);

  bars_error.add_message(l_mod, 36, l_exc, l_rus, '������ �������: %s: %S','', 1);
  bars_error.add_message(l_mod, 36, l_exc, l_rus, '������� �i�����: %s: %s','', 1);

  bars_error.add_message(l_mod, 37, l_exc, l_rus, '������ ��� ������ in_sep - %s','', 1);
  bars_error.add_message(l_mod, 37, l_exc, l_rus, '������� ��� �����i in_sep - %s','', 1);

  bars_error.add_message(l_mod, 38, l_exc, l_rus, '�������� %s, ��������� � ������� - �� ������� � �����','', 1);
  bars_error.add_message(l_mod, 38, l_exc, l_rus, '������i� %s, �� ������ � ������� - �� ������� � �����','', 1);

  bars_error.add_message(l_mod, 39, l_exc, l_rus, '��� ��������� %s - �� ������ � �����','', 1);
  bars_error.add_message(l_mod, 39, l_exc, l_rus, '��� ��������� %s - �� ������� � �����','', 1);

  bars_error.add_message(l_mod, 40, l_exc, l_rus, '�� ��������������� ��������� <���� �����> � ������. ������� ����-%s, � �����-%s','', 1);
  bars_error.add_message(l_mod, 40, l_exc, l_rus, '�� �������i�����j ��������� <������� ����> � ������. �������� �������-%s, � �����-%s','', 1);

  bars_error.add_message(l_mod, 41, l_exc, l_rus, '����������� ������ ���� � ���� %s','', 1);
  bars_error.add_message(l_mod, 41, l_exc, l_rus, '���������� ������ ���� � ��� %s','', 1);

  bars_error.add_message(l_mod, 42, l_exc, l_rus, '���������� ���� %s �������. ������ ����������.','', 1);
  bars_error.add_message(l_mod, 42, l_exc, l_rus, '����i����� ���� %s �������. ������ ���������.','', 1);
  
  bars_error.add_message(l_mod, 43, l_exc, l_rus, '��� ��� %s �� ������ �������� RRPDAY � params$base','', 1);
  bars_error.add_message(l_mod, 43, l_exc, l_rus, '��� ��� %s �� ������� �������� RRPDAY � params$base','', 1);

  bars_error.add_message(l_mod, 44, l_exc, l_rus, '� ��������� ��� ������� ���������� ����������� ���� �� ������ ��� Body','', 1);
  bars_error.add_message(l_mod, 44, l_exc, l_rus, '� �������� ��� ������� ����������� ���������� ���� � �������� ��� Body','', 1);

  bars_error.add_message(l_mod, 45, l_exc, l_rus, '��� ��������� % �� ������������� ���������','', 1);
  bars_error.add_message(l_mod, 45, l_exc, l_rus, '��� ��������� % �� ����������� ������� �������','', 1);

  bars_error.add_message(l_mod, 46, l_exc, l_rus, '��� ��������� % ����������� ��� % ','', 1);
  bars_error.add_message(l_mod, 46, l_exc, l_rus, '��� ����������� % �������� ��� % ','', 1);

  bars_error.add_message(l_mod, 47, l_exc, l_rus, '������ �������� ��� ���� ��������� % ������ ���� �����, ����� ��������- % ','', 1);
  bars_error.add_message(l_mod, 47, l_exc, l_rus, '������ �������� ��� ���� ����������� % ������� ���� �����, ����� �������� - %','', 1);

  bars_error.add_message(l_mod, 48, l_exc, l_rus, '��� ���� ��������� % �� ������� ���� ������ ','', 1);
  bars_error.add_message(l_mod, 48, l_exc, l_rus, '��� ���� ������������ �� ������� ����� ������','', 1);

  bars_error.add_message(l_mod, 49, l_exc, l_rus, '�� ������ ��� ������� %s ','', 1);
  bars_error.add_message(l_mod, 49, l_exc, l_ukr, '�� �������� ��� ����i�� %s','', 1);

  bars_error.add_message(l_mod, 50, l_exc, l_rus, '����� ��� ������ ������� %s ��� �������� %s �� ������','', 1);
  bars_error.add_message(l_mod, 50, l_exc, l_ukr, '³������ ��� ������ ������ %s ��� �������� %s �� ��������','', 1);

  bars_error.add_message(l_mod, 51, l_exc, l_rus, '������ ���. ��������� %s ��� ������� �������� ���� %s - %s','', 1);
  bars_error.add_message(l_mod, 51, l_exc, l_ukr, '������� ��� �����. ��������� %s ��� ������� �������� ���� %s - %s','', 1);

  bars_error.add_message(l_mod, 52, l_exc, l_rus, '�� ������ ����� �������� - %s','', 1);
  bars_error.add_message(l_mod, 52, l_exc, l_ukr, '�� �������� ����� �������� - %s','', 1);

  bars_error.add_message(l_mod, 53, l_exc, l_rus, '� ���������� ��� ������ �� ������ �������� TRDPT (������� ��� ���������� ���������)','', 1);
  bars_error.add_message(l_mod, 53, l_exc, l_ukr, '� ���������� ��� ������ �� ������� �������� TRDPT (������� ��� ���������� ��������)','', 1);

  bars_error.add_message(l_mod, 54, l_exc, l_rus, '�� ���������� ����������� ����� %s ��� ���������� ���. ������� � ����','', 1);
  bars_error.add_message(l_mod, 54, l_exc, l_ukr, '�� ���� ����������� ������� %s ��� ���������� ���.������ � ����','', 1);

  bars_error.add_message(l_mod, 55, l_exc, l_rus, '��� ������� �������� �� ������ ���. �������� ����� �������� � ���� (CNTR)','', 1);
  bars_error.add_message(l_mod, 55, l_exc, l_ukr, '��� ������� �������� �� �������� ���.������� ����� ����� � ���� (CNTR)','', 1);

  bars_error.add_message(l_mod, 56, l_exc, l_rus, '�� ������ ����� �������� %s ��� ������ %s','', 1);
  bars_error.add_message(l_mod, 56, l_exc, l_ukr, '�� �������� ����� �������� %s ��� ������ %s','', 1);

  bars_error.add_message(l_mod, 57, l_exc, l_rus, '�� ������� ������ � int_accn ��� ����� � ��� = %s','', 1);
  bars_error.add_message(l_mod, 57, l_exc, l_ukr, '�� �������� ����� � ������� int_accn ��� ������� � ��� = %s','', 1);

  bars_error.add_message(l_mod, 58, l_exc, l_rus, '�� ������ ���� %s, ������������ ���������� GetTOBOParam(''TRDPT'') ��� ������ %s','', 1);
  bars_error.add_message(l_mod, 58, l_exc, l_ukr, '�� �������� ������� %s, �� ����������� ���������� GetTOBOParam(''TRDPT'') ��� ������ %s','', 1);

  bars_error.add_message(l_mod, 59, l_exc, l_rus, '����� �������� %s ��� ���������','', 1);
  bars_error.add_message(l_mod, 59, l_exc, l_ukr, '����� �������� %s ��� ����','', 1);

  bars_error.add_message(l_mod, 60, l_exc, l_rus, '�� ����� ������� ���� ������� �� ��� = %s','', 1);
  bars_error.add_message(l_mod, 60, l_exc, l_ukr, '�� �������� ������� ������ �� ��� = %s','', 1);

  bars_error.add_message(l_mod, 61, l_exc, l_rus, '�� ����� ������� ���� ����������� %% �� ��� = %s','', 1);
  bars_error.add_message(l_mod, 61, l_exc, l_ukr, '�� �������� ������� ����������� %%  �� ��� = %s','', 1);

  bars_error.add_message(l_mod, 62, l_exc, l_rus, '���. �������� %s ��� ���. %s ��� ����������','', 1);
  bars_error.add_message(l_mod, 62, l_exc, l_ukr, '���. ������� %s ��� ���. %s ��� ����','', 1);

  bars_error.add_message(l_mod, 63, l_exc, l_rus, '��� ���-�� ����������� ���. �������� %s ','', 1);
  bars_error.add_message(l_mod, 63, l_exc, l_ukr, '��� ���-�� ������� ���. ������� %s'   ,'', 1);

  bars_error.add_message(l_mod, 64, l_exc, l_rus, '������ � ����� %s ������ ��������� ���� ���� ������','', 1);
  bars_error.add_message(l_mod, 64, l_exc, l_ukr, '����� � ����� %s ������� ������� ���� ���� �����'   ,'', 1);

  bars_error.add_message(l_mod, 65, l_exc, l_rus, '���. �������� %s �� ������ ���������','', 1);
  bars_error.add_message(l_mod, 65, l_exc, l_ukr, '���. ������� %s �� ������ ��������'   ,'', 1);

  bars_error.add_message(l_mod, 66, l_exc, l_rus, '�������� ���������� �� ������ - ������','', 1);
  bars_error.add_message(l_mod, 66, l_exc, l_ukr, '������ ���������� �� ������ - �����'   ,'', 1);

  bars_error.add_message(l_mod, 67, l_exc, l_rus, '��� ���� %s(%s) �� ������ ��� ��� ������ ����� �� ������� ���� ����������� (���.392-405)','', 1);
  bars_error.add_message(l_mod, 67, l_exc, l_rus, '��� ���. %s(%s) �� �������� ��� ��� ������ ���. �� �������� ���� �i���������(���.392-405)','', 1);

  bars_error.add_message(l_mod, 68, l_exc, l_rus, '��� ���� %s(%s) �� ������ ��� ��� ������ ����� �� ������� ��� �����������','', 1);
  bars_error.add_message(l_mod, 68, l_exc, l_rus, '��� ���. %s(%s) �� �������� ��� ��� ������ ���. �� �������� ��� �i���������','', 1);

  bars_error.add_message(l_mod, 69, l_exc, l_rus, '��� ���� %s(%s) �� ������ ��� ��� ������ ����� �� ������� ������������ �����������','', 1);
  bars_error.add_message(l_mod, 69, l_exc, l_rus, '��� ���. %s(%s) �� �������� ��� ��� ������ ���. �� ������� ������������ �i���������','', 1);

  bars_error.add_message(l_mod, 70, l_exc, l_rus, '��� �������� %s(����������) �� ���������� ���.�������� DPTOP(��� ��������)','', 1);
  bars_error.add_message(l_mod, 70, l_exc, l_rus, '��� �������� %s(���������) �� �����������  ���.������� DPTOP(��� ��������)','', 1);

  bars_error.add_message(l_mod, 71, l_exc, l_rus, '��� �������� %s(����������) �� ����������� �������� ���.��������� DPTOP ��-���������','', 1);
  bars_error.add_message(l_mod, 71, l_exc, l_rus, '��� �������� %s(���������) �� ����������� �������� ���.�������� DPTOP ��-������������','', 1);

  bars_error.add_message(l_mod, 72, l_exc, l_rus, '��� ������������� � �������� ����������� %s � ������� SELECT_STMT ����������� ����� ���� ACTION','', 1);
  bars_error.add_message(l_mod, 72, l_exc, l_rus, '��� ������������ � ���� �������� %s � ������ SELECT_STMT ������ ���� ACTION','', 1);

  bars_error.add_message(l_mod, 73, l_exc, l_rus, '���������� %s �� ������ � ����. xml_reflist ��� �� ������� � �������������','', 1);
  bars_error.add_message(l_mod, 73, l_exc, l_rus, '������� %s �� ������� � ����.  xml_reflist ��� �� �������� � �������������','', 1);

  bars_error.add_message(l_mod, 74, l_exc, l_rus, '��� ������ ��� ������������ ���-�� � ��� = %s �� ������ ���. �������� CNTR','', 1);
  bars_error.add_message(l_mod, 74, l_exc, l_ukr, '��� ������ ��� ������������ ���-�� � ��� = %s �� ������ ���. �������� CNTR','', 1);

  bars_error.add_message(l_mod, 75, l_exc, l_rus, '������� %s ���� �������, ��� ����� �� ��������� ����� �� ���� ������������ � xml_reaque','', 1);
  bars_error.add_message(l_mod, 75, l_exc, l_ukr, '������� %s ��� ������, �� ������ �� ��������� ����� �� ��� ��������������� � �������  xml_refque','', 1);

  bars_error.add_message(l_mod, 76, l_exc, l_rus, '������������ �������� ����������� % ��� ������������� (������ �������� ��� ��������� ����. � ��������������� � ORACLE STREAMS)','', 1);
  bars_error.add_message(l_mod, 76, l_exc, l_ukr, '������������ �������� ����������� % ��� ������������� (������ �������� ��� ��������� ����. � ��������������� � ORACLE STREAMS','', 1);

  bars_error.add_message(l_mod, 77, l_exc, l_rus, '��� ���������(������) %s �� ������ �������� RNK � branch_parameters','', 1);
  bars_error.add_message(l_mod, 77, l_exc, l_ukr, '��� ��������(������) %s �� ������� �������� RNK � branch_parameters','', 1);

  bars_error.add_message(l_mod, 78, l_exc, l_rus, '������ � RNK = %s �� ������ ��� �������� ������� ','', 1);
  bars_error.add_message(l_mod, 78, l_exc, l_ukr, '�볺�� � RNK = %s �� ������� �� �������� �������','', 1);

  bars_error.add_message(l_mod, 79, l_exc, l_rus, '�� ��� ������ ����������� xml_reflist_reqv �� �������� ��� ��������� %s ','', 1);
  bars_error.add_message(l_mod, 79, l_exc, l_ukr, '�� ��� ������ ����������� xml_reflist_reqv �� �������� ��� ��������� %s','', 1);

  bars_error.add_message(l_mod, 80, l_exc, l_rus, '������������ %s �� ������ ��� ������������ ��� � staff$base','', 1);
  bars_error.add_message(l_mod, 80, l_exc, l_ukr, '������������ %s �� ������ ��� ������������ ��� � staff$base','', 1);

  bars_error.add_message(l_mod, 81, l_exc, l_rus, '���������� ����� ������� � ��� %s','', 1);
  bars_error.add_message(l_mod, 81, l_exc, l_ukr, '���������� ����� ������� � ��� %s','', 1);

  bars_error.add_message(l_mod, 82, l_exc, l_rus, '��� ������� � ��� %s �� ������ ���','', 1);
  bars_error.add_message(l_mod, 82, l_exc, l_ukr, '��� ������� � ��� %s �� ������ ���','', 1);

  bars_error.add_message(l_mod, 83, l_exc, l_rus, '���� "%s" ��� ��� ������������ %s.', '', 1, 'FILE_ALREADY_IMPORTED' );
  bars_error.add_message(l_mod, 83, l_exc, l_ukr, '���� "%s" ��� ���� ����������� %s.', '', 1, 'FILE_ALREADY_IMPORTED' );

  bars_error.add_message(l_mod, 84, l_exc, l_rus, '������ ��������� %s �� ����������','', 1);
  bars_error.add_message(l_mod, 84, l_exc, l_ukr, '������ �������� %s �� ic��','', 1);

  bars_error.add_message(l_mod, 85, l_exc, l_rus, '�������� �����.������ ��� ����� ����������� %s','', 1);
  bars_error.add_message(l_mod, 85, l_exc, l_ukr, '����������� �����.������ ��� ���. �i���������  %s ','', 1);

  bars_error.add_message(l_mod, 86, l_exc, l_rus, '�������� �����.������ ��� ����� ���������� %s','', 1);
  bars_error.add_message(l_mod, 86, l_exc, l_ukr, '����������� �����.������ ��� ���. ����������  %s ','', 1);

  bars_error.add_message(l_mod, 87, l_exc, l_rus, '������������ �������� ���� ����������� %s','', 1);
  bars_error.add_message(l_mod, 87, l_exc, l_ukr, '���������� �������� ���� �i��������� %s','', 1);

  bars_error.add_message(l_mod, 88, l_exc, l_rus, '�������� ���� ����������� %s �� �������� ���','', 1);
  bars_error.add_message(l_mod, 88, l_exc, l_ukr, '�������� ���� �i��������� %s �� �������� ���','', 1);

  bars_error.add_message(l_mod, 89, l_exc, l_rus, '������ ���� ����������� %s ������ �� 8 ��������','', 1);
  bars_error.add_message(l_mod, 89, l_exc, l_ukr, '������� ���� �i��������� %s ����� �� 8 ������i�','', 1);

  bars_error.add_message(l_mod, 90, l_exc, l_rus, '��� ������������ %s �� ����������','', 1);
  bars_error.add_message(l_mod, 90, l_exc, l_ukr, '��� �i��������� %s �� i����','', 1);

  bars_error.add_message(l_mod, 91, l_exc, l_rus, '��� ������������ %s �����������','', 1);
  bars_error.add_message(l_mod, 91, l_exc, l_ukr, '��� �i��������� %s ���������','', 1);

  bars_error.add_message(l_mod, 92, l_exc, l_rus, '�������� ���� ���������� %s �� �������� ���','', 1);
  bars_error.add_message(l_mod, 92, l_exc, l_ukr, '�������� ���� ���������� %s �� �������� ���','', 1);

  bars_error.add_message(l_mod, 93, l_exc, l_rus, '������ ���� ���������� %s ������ �� 8 ��������','', 1);
  bars_error.add_message(l_mod, 93, l_exc, l_ukr, '������� ���� ���������� %s ����� �� 8 ������i�','', 1);

  bars_error.add_message(l_mod, 94, l_exc, l_rus, '������������ �������� ���� ���������� %s','', 1);
  bars_error.add_message(l_mod, 94, l_exc, l_ukr, '���������� �������� ���� ���������� %s','', 1);

  bars_error.add_message(l_mod, 96, l_exc, l_rus, '��� ���������� %s �� ����������','', 1);
  bars_error.add_message(l_mod, 96, l_exc, l_ukr, '��� ���������� %s �� i����','', 1);

  bars_error.add_message(l_mod, 95, l_exc, l_rus, '��� ���������� %s �����������','', 1);
  bars_error.add_message(l_mod, 95, l_exc, l_ukr, '��� ���������� %s ���������','', 1);

  bars_error.add_message(l_mod, 97, l_exc, l_rus, '��� ������� ����� �������� ������ ���.����� %s (������� ���� 2-39)','', 1);
  bars_error.add_message(l_mod, 97, l_exc, l_ukr, '��� ����i�� ���� ���i���� ������ %s ���.����� (�������� ���� 2-39)','', 1);

  bars_error.add_message(l_mod, 98, l_exc, l_rus, '��� ������� ����� �������� ������ ���.����� %s (������� ���� 40-73)','', 1);
  bars_error.add_message(l_mod, 98, l_exc, l_ukr, '��� ������� ���� ���i���� ������ %s ���.����� (�������� ���� 40-73)','', 1);


  bars_error.add_message(l_mod, 99, l_exc, l_rus,  '�� ������� ���� ����������','', 1);
  bars_error.add_message(l_mod, 99, l_exc, l_rus,  '�� ������� ���� ����������','', 1);

  bars_error.add_message(l_mod, 100, l_exc, l_rus, '�� ������� ��� ����������','', 1);
  bars_error.add_message(l_mod, 100, l_exc, l_rus, '�� ������� ��� ����������','', 1);

  bars_error.add_message(l_mod, 101, l_exc, l_rus, '�� ������� ������������ ����������','', 1);
  bars_error.add_message(l_mod, 101, l_exc, l_rus, '�� ������� ��i��������� ����������','', 1);

  -- ������� ��_������� ������� (��� ������_ ���� �������_ � bars.kltoss.common.BarsError)
                                                  
  -- ������� �����_��� �_����� �� ��������_ %s ��� ����� %s
  bars_error.add_message(l_mod, 102, l_exc, l_rus, '%s','', 1);  
  bars_error.add_message(l_mod, 102, l_exc, l_ukr, '%s','', 1);

  bars_error.add_message(l_mod, 106, l_exc, l_rus, '�������� ����������� �����������','', 1);
  bars_error.add_message(l_mod, 106, l_exc, l_ukr, '��_���� �������� ���������','', 1);

  bars_error.add_message(l_mod, 111, l_exc, l_rus, '��� ��������� �� ������ � ������� ����� %s ','', 1);
  bars_error.add_message(l_mod, 111, l_exc, l_ukr, '��� ���_�������� �� ������� � ��������� ����� %s','', 1);

  bars_error.add_message(l_mod, 112, l_exc, l_rus, '����������� ��� ����� �������������� %s ','', 1);
  bars_error.add_message(l_mod, 112, l_exc, l_ukr, '���_����� ��� ������ �������������� %s','', 1);

  bars_error.add_message(l_mod, 113, l_exc, l_rus, '����������� ���������� ��� ������������� %s ','', 1);
  bars_error.add_message(l_mod, 113, l_exc, l_ukr, '���i����� ���_���� ��� �������_���_� %s','', 1);

  bars_error.add_message(l_mod, 114, l_exc, l_rus, '����������� ���������� ��� ������������� %s ','', 1);
  bars_error.add_message(l_mod, 114, l_exc, l_ukr, '���i����� ���_���� ��� �������_���_� %s','', 1);

  -- ������ ������� �����-�� ��� �������
  
  bars_error.add_message(l_mod, 150, l_exc, l_rus, '%s','', 1);
  bars_error.add_message(l_mod, 150, l_exc, l_rus, '%s','', 1);

  bars_error.add_message(l_mod, 151, l_exc, l_rus, '������������ ������ ���� � ���� ���� ��������� - %s','', 1);
  bars_error.add_message(l_mod, 151, l_exc, l_rus, '����������� ������ ���� � ��� ���� ��������� - %s','', 1);

  bars_error.add_message(l_mod, 152, l_exc, l_rus, '������������ ������ ����� ������� - %s','', 1);
  bars_error.add_message(l_mod, 152, l_exc, l_rus, '����������� ������ ���� ������� - %s','', 1);

  bars_error.add_message(l_mod, 153, l_exc, l_rus, '���������� �������� � ����� �������� ���� ������ � - %s','', 1);
  bars_error.add_message(l_mod, 153, l_exc, l_rus, '��������� �������� �� ����� �������� ���� ������ � - %s','', 1);

  bars_error.add_message(l_mod, 154, l_exc, l_rus, '������������ ������ ���� ������������� - %s','', 1);
  bars_error.add_message(l_mod, 154, l_exc, l_rus, '����������� ������ ���� ����������� - %s','', 1);

  bars_error.add_message(l_mod, 155, l_exc, l_rus, '���������� �������� � ����� �������� ���� ��������� - %s','', 1);
  bars_error.add_message(l_mod, 155, l_exc, l_rus, '��������� �������� �� ����� �������� ���� ������� - %s','', 1);

  bars_error.add_message(l_mod, 156, l_exc, l_rus, '���������� �������� � ����� �������� ����.��������� - %s','', 1);
  bars_error.add_message(l_mod, 156, l_exc, l_rus, '��������� �������� �� ����� �������� ����.�������� - %s','', 1);

  bars_error.add_message(l_mod, 157, l_exc, l_rus, '���������� �������� � ����� �������� �� - %s','', 1);
  bars_error.add_message(l_mod, 157, l_exc, l_rus, '��������� �������� �� ����� �������� �� - %s','', 1);

  bars_error.add_message(l_mod, 158, l_exc, l_rus, '���������� �������� � ����� �������� ���� ������ � - %s','', 1);
  bars_error.add_message(l_mod, 158, l_exc, l_rus, '��������� �������� �� ����� �������� ���� ������ � - %s','', 1);

  bars_error.add_message(l_mod, 159, l_exc, l_rus, '������������ ������ ����� � ������� - %s','', 1);
  bars_error.add_message(l_mod, 159, l_exc, l_rus, '����������� ������ ���� � ������� - %s','', 1);

  bars_error.add_message(l_mod, 160, l_exc, l_rus, '������������ ������ ���� ������� - %s','', 1);
  bars_error.add_message(l_mod, 160, l_exc, l_rus, '����������� ������ ���� ������� - %s','', 1);

  bars_error.add_message(l_mod, 161, l_exc, l_rus, '��� �������� %s �� ������ ��� ��������� vob','', 1);
  bars_error.add_message(l_mod, 161, l_exc, l_rus, '��� �������� %s �� ������� ��� ��������� vob','', 1);

  bars_error.add_message(l_mod, 162, l_exc, l_rus, '��������������� �������� � ���.������� %s �� ������','', 1);
  bars_error.add_message(l_mod, 162, l_exc, l_rus, '������������ �������� � ���.������� %s �� ��������','', 1);

  bars_error.add_message(l_mod, 163, l_exc, l_rus, '�������� ���. ��������� %s - ������','', 1);
  bars_error.add_message(l_mod, 163, l_exc, l_rus, '�������� ���. ����i���� %s - �����','', 1);

  bars_error.add_message(l_mod, 164, l_exc, l_rus, '���� %s �� ���� %s �� ��� ���������������','', 1);
  bars_error.add_message(l_mod, 164, l_exc, l_rus, '���� %s �� ���� %s �� ��� ���i�����������','', 1);

  bars_error.add_message(l_mod, 165, l_exc, l_rus, '�� ����� ������ ���� �����','', 1);
  bars_error.add_message(l_mod, 165, l_exc, l_rus, '�� ������ ������ ���.�����','', 1);

  bars_error.add_message(l_mod, 166, l_exc, l_rus, '���������� ������� ��� ��������� ��� ���������� ��������','', 1);
  bars_error.add_message(l_mod, 166, l_exc, l_rus, '��������� �������� ��� ��������� ��� ��������� ��������','', 1);

  bars_error.add_message(l_mod, 167, l_exc, l_rus, '���������� �������� ��������� ��� ���������� ��� ����������� ���������','', 1);
  bars_error.add_message(l_mod, 167, l_exc, l_rus, '��������� ������ �������� ��� ���������� ��� ���������� ���������','', 1);

  bars_error.add_message(l_mod, 168, l_exc, l_rus, '���� ����������� %s �� ���������� � ����� �����','', 1);
  bars_error.add_message(l_mod, 168, l_exc, l_rus, '������� ���������� %s �� ���� � ������ �����','', 1);

  bars_error.add_message(l_mod, 169, l_exc, l_rus, '���� ���������� %s �� ���������� � ����� �����','', 1);
  bars_error.add_message(l_mod, 169, l_exc, l_rus, '������� ���������� %s �� ���� � ������ �����','', 1);

  bars_error.add_message(l_mod, 170, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������ �������� SNCLOCAL - ������ ������(���������) ��� ������������� offline','', 1);
  bars_error.add_message(l_mod, 170, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������� �������� SNCLOCAL - ����� �������(��������) ��� ������������ offline','', 1);

  bars_error.add_message(l_mod, 171, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������ �������� SNCPARNT - ������ ������(���� �� �������) ��� ������������� offline','', 1);
  bars_error.add_message(l_mod, 171, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������� �������� SNCPARNT - ����� �������(���� �� �����) ��� ������������ offline','', 1);

  bars_error.add_message(l_mod, 172, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������ �������� SNCGLBL - ������ ������(����������) ��� ������������� offline','', 1);
  bars_error.add_message(l_mod, 172, l_exc, l_rus, '� ���������� ���������� (params$global) �� ������� �������� SNCGLBL - ����� �������(���������) ��� ������������ offline','', 1);

  bars_error.add_message(l_mod, 173, l_exc, l_rus, '�������� ����� � ����� �������� ����� �','', 1);
  bars_error.add_message(l_mod, 173, l_exc, l_rus, '�������� ������� � ���� �������� ������� �','', 1);

  bars_error.add_message(l_mod, 174, l_exc, l_rus, '������ �������� ��� ������ ��� ��������� %s','', 1);
  bars_error.add_message(l_mod, 174, l_exc, l_rus, '����� �������� ��� ������ ��� ��������� %s','', 1);

  bars_error.add_message(l_mod, 175, l_exc, l_rus, '�������� %s - �� ����������','', 1);
  bars_error.add_message(l_mod, 175, l_exc, l_rus, '������� %s - �� ����','', 1);

  bars_error.add_message(l_mod, 176, l_exc, l_rus, '�������� %s ��� ���������� ��� ������ ���������','', 1);
  bars_error.add_message(l_mod, 176, l_exc, l_rus, '������� %s ��� ���� ��� ������ ���������','', 1);

  bars_error.add_message(l_mod, 177, l_exc, l_rus, '��� ������� �� �������� � %s (�������� %s ) �� ������ ��� �������� (���. �������� DPTPR)','', 1);
  bars_error.add_message(l_mod, 177, l_exc, l_rus, '��� ������� �� �������� � %s (�������� %s ) �� ������� ��� �������� (���. ������� DPTPR)','', 1);

  bars_error.add_message(l_mod, 178, l_exc, l_rus, '��� ������� �� �������� � %s �� ������� ��� ������� ������ ��� �������� DPTPR (������� ���� DPT1 ��� DPT2)','', 1);
  bars_error.add_message(l_mod, 178, l_exc, l_rus, '��� ������� �� �������� � %s �� ������� ��� ������� ����������� ��� �������� DPTPR (������ ���� DPT1 ��� DPT2)','', 1);

  bars_error.add_message(l_mod, 179, l_exc, l_rus, '�� ������� ������ ��� ������� B �� ����������: %s','', 1);
  bars_error.add_message(l_mod, 179, l_exc, l_rus, '�� �������� ���i �� ����i�����: %s','', 1);

  bars_error.add_message(l_mod, 180, l_exc, l_rus, '�� ������� ��� %s','', 1);
  bars_error.add_message(l_mod, 180, l_exc, l_rus, '�� �������� ��� %s','', 1);

  bars_error.add_message(l_mod, 181, l_exc, l_rus, '��� ��������� %s �� �������������� ��� ���������� ���.����������','', 1);
  bars_error.add_message(l_mod, 181, l_exc, l_rus, '��� ����������� %s �� ������������ ��� ���������� ���. ����','', 1);

  bars_error.add_message(l_mod, 182, l_exc, l_rus, '����� ��������(���������� ����� �������� �����) %s �� ������ � ������� �����','', 1);
  bars_error.add_message(l_mod, 182, l_exc, l_rus, '����� �����(��������� ����� ��������� �����) %s �� �������� � ��������� ����� ','', 1);

  bars_error.add_message(l_mod, 183, l_exc, l_rus, '���� ������ ��������� %s, ������ ���� �������� %s','', 1);
  bars_error.add_message(l_mod, 183, l_exc, l_rus, '���� ������ ��������� %s, ����� �� ���� ���������� %s','', 1);

  bars_error.add_message(l_mod, 183, l_exc, l_rus, '���� ������ ��������� %s, ������ ���� �������� %s','', 1);
  bars_error.add_message(l_mod, 183, l_exc, l_rus, '���� ������ ��������� %s, ����� �� ���� ���������� %s','', 1);

  bars_error.add_message(l_mod, 184, l_exc, l_rus, '���-�� ������� � ������� ��������� aq_refsync_tbl ��������� 10000. �������������� ������ ����� ����� �� ����������. �������� ������� ��� ����������� ������ ��� JBOSS �������', '', 1);
  bars_error.add_message(l_mod, 184, l_exc, l_ukr, '���-�� ������� � ������� ��������� aq_refsync_tbl ��������� 10000. �������������� ������ ����� ����� �� ����������. �������� ������� ��� ����������� ������ ��� JBOSS �������', '', 1);    

  bars_error.add_message(l_mod, 185, l_exc, l_rus, '������ ������ ����� ��� %s �� ����� ��������� 14-�� ��������', '', 1);
  bars_error.add_message(l_mod, 185, l_exc, l_ukr, '������� ������ ������� ��� %s �� ���� ������������ 14-�� �������', '', 1);    

  bars_error.add_message(l_mod, 186, l_exc, l_rus, '������ ������������ �������: %s �� ������ ��������� 38-�� ��������', '', 1);
  bars_error.add_message(l_mod, 186, l_exc, l_ukr, '������� ����� �볺���: %s �� ������� ������������ 38-�� �������', '', 1);    

  bars_error.add_message(l_mod, 187, l_exc, l_rus, '������ ���������� ������� �� ������ ��������� 160 ��������(��� ����������� ����������� ������� �������������� ���. �������� �)', '', 1);
  bars_error.add_message(l_mod, 187, l_exc, l_ukr, '������� ����������� ������� �� ������� ������������ 160-�� �������(��� ����������� ����������� ������� �������������� ���.�������� �)', '', 1);    

  bars_error.add_message(l_mod, 188, l_exc, l_rus, '����� �������� %s �� ������������� ����� xxxxxx/N (xxxxxx-��� ���., N-�������� � ���.) ', '', 1);
  bars_error.add_message(l_mod, 188, l_exc, l_ukr, '����� �������� %s �� ������� ����� xxxxxx/N (xxxxxx-��� ����., N-�������� � ���.)', '', 1);    

  bars_error.add_message(l_mod, 189, l_exc, l_rus, '�������� DPTNUM ��� %s - ������ ���� ������, � ��� �������� ������ ����� %s ', '', 1);
  bars_error.add_message(l_mod, 189, l_exc, l_ukr, '�������� DPTNUM ��� %s - ������� ���� ������, � ���� �������� ����� ������� %s', '', 1);    

  bars_error.add_message(l_mod, 190, l_exc, l_rus, '������������ ����� ��������: %s. ������� ���� ������� �� ����� ���������� ��������', '', 1);
  bars_error.add_message(l_mod, 190, l_exc, l_ukr, '������������ ����� ��������: %s. ������� ����� �� ����� ���������� ��������', '', 1);    

  bars_error.add_message(l_mod, 191, l_exc, l_rus, '��� �������� � ��������� %s - �� ������� ��������������� �������� ��� ������ ���������', '', 1, 'NOTEXISTS_OFFLINE_TT');
  bars_error.add_message(l_mod, 191, l_exc, l_ukr, '��� �������� � ��������� %s - �� ������� �������� �������� ��� ������ ��������', '', 1, 'NOTEXISTS_OFFLINE_TT');    

  bars_error.add_message(l_mod, 192, l_exc, l_rus, '��������� �������� ��� %s �� �������',   '', 1, 'NO_SUCH_RNK');
  bars_error.add_message(l_mod, 192, l_exc, l_ukr, '������� ��������  ��� %s �� �������', '', 1,    'NO_SUCH_RNK');    

  bars_error.add_message(l_mod, 193, l_exc, l_rus, '��������� �������� ������ %s �� �������', '', 1, 'NO_SUCH_BRANCH');
  bars_error.add_message(l_mod, 193, l_exc, l_ukr, '������� ��������  ������ %s �� �������', '', 1,  'NO_SUCH_BRANCH');    

  bars_error.add_message(l_mod, 194, l_exc, l_rus, '�� ������� �������� ������ ��� ���������', '', 1,   'NO_BRANCH');
  bars_error.add_message(l_mod, 194, l_exc, l_ukr, '�� ������� �������� ������ ��� ��������', '', 1,  'NO_BRANCH');    
  
  bars_error.add_message(l_mod, 195, l_exc, l_rus, '�� ������� �������� ������������ ��������������(���) ��� %s', '', 1,  'NO_SAB');
  bars_error.add_message(l_mod, 195, l_exc, l_ukr, '�� ������� �������� ������������ ��������������(���) ��� %s', '', 1,  'NO_SAB');    

  bars_error.add_message(l_mod, 196, l_exc, l_rus, '�� ������� �������� ����� ��������� ��� %s', '', 1, 'NO_TECHKEY');
  bars_error.add_message(l_mod, 196, l_exc, l_ukr, '�� ������� �������� ����� ��������� ��� %s', '', 1,  'NO_TECHKEY');    

  bars_error.add_message(l_mod, 197, l_exc, l_rus, '��� ���������� ��� %s, �� ������� ����� %s, � ��� ���� ���������� ����� %s', '', 1, 'NOT_CORRECT_BRANCH');
  bars_error.add_message(l_mod, 197, l_exc, l_ukr, '��� ��������� ��� %s, �� ������� ����� %s, � ��� ����� ����������� ����� %s', '', 1, 'NOT_CORRECT_BRANCH');    

  bars_error.add_message(l_mod, 198, l_exc, l_rus, '�������� ����� %s ������ ���� ������� ��� �������� ������', '', 1, 'NOT_CORRECT_BRANCH2');
  bars_error.add_message(l_mod, 198, l_exc, l_ukr, '�������� ����� %s ������� ���� ������� ��� �������� ����', '', 1, 'NOT_CORRECT_BRANCH2');    

  bars_error.add_message(l_mod, 199, l_exc, l_rus, '����������� �������������(���) %s ��� ��������� %s ������ �������� �� 6-�� ��������', '', 1,  'NOT_CORRECT_SAB');
  bars_error.add_message(l_mod, 199, l_exc, l_ukr, '����������� �������������(���) %s ��� �������� %s ������� ������ 6-�� �������', '', 1,    'NOT_CORRECT_SAB');    

  bars_error.add_message(l_mod, 200, l_exc, l_rus, '����������� �������������(���) ����� %s ��� ��������� %s ������ �������� �� 6-�� ��������', '', 1,  'NOT_CORRECT_FILESAB');
  bars_error.add_message(l_mod, 200, l_exc, l_ukr, '����������� �������������(���) ����� %s ��� �������� %s ������� ������ 6-�� �������', '', 1,    'NOT_CORRECT_FILESAB');    

  bars_error.add_message(l_mod, 201, l_exc, l_rus, '���� ��������� %s ��� ��������� %s ������ �������� �� 5-�� ��������', '', 1,  'NOT_CORRECT_TECHKEY');
  bars_error.add_message(l_mod, 201, l_exc, l_ukr, '���� ��������� %s ��� �������� %s ������� ������ 5-�� �������', '', 1,    'NOT_CORRECT_TECHKEY');    

  bars_error.add_message(l_mod, 202, l_exc, l_rus, '��������� ��� %s ��� ���������� � ������� �������', '', 1,  'SUCH_SAB_EXISTS');
  bars_error.add_message(l_mod, 202, l_exc, l_ukr, '�������� ��� %s ��� ���� � ������ �볺���', '', 1,    'SUCH_SAB_EXISTS');    

  bars_error.add_message(l_mod, 203, l_exc, l_rus, '������ ������� %s, ��������� �������� %s, ������� ��� ���� � staff$base', '', 1,  'BROKEN_SEQUENCE');
  bars_error.add_message(l_mod, 203, l_exc, l_ukr, '������ ������� %s, ��������� �������� %s, ������� ��� ���� � staff$base', '', 1,  'BROKEN_SEQUENCE');    

  bars_error.add_message(l_mod, 204, l_exc, l_rus, '���.�������� <��� �������� � ���������> (DPTOP) - ���������� �������� %s', '', 1,  'DPTOP_NOT_NUMBER');
  bars_error.add_message(l_mod, 204, l_exc, l_ukr, '���.������� <��� �������� � ���������> (DPTOP) - �� ������� �������� %s', '', 1,  'PTOP_NOT_NUMBER');    

  bars_error.add_message(l_mod, 205, l_exc, l_rus, '���� ������������� ������ ��� ������ ����.���� �� 1 ����� %s', '', 1,   'NOT_CORRECT_PAYDATE');
  bars_error.add_message(l_mod, 205, l_exc, l_ukr, '���� ����������� ����� ��� ����� �� ����.���� �� 1 ����� %s', '', 1,  'NOT_CORRECT_PAYDATE');    

  bars_error.add_message(l_mod, 206, l_exc, l_rus, '��� ���. ���������� %s �� ��������������', '', 1,   'NOT_AGREEMENT_TYPE');
  bars_error.add_message(l_mod, 206, l_exc, l_ukr, '��� ���. ����� %s �� ������������ ', '', 1,         'NOT_AGREEMENT_TYPE');    

  bars_error.add_message(l_mod, 207, l_exc, l_rus, '������������� ���������� �������������� �������', '', 1,              'INNER_INFO_NOTALLOWED');
  bars_error.add_message(l_mod, 207, l_exc, l_ukr, '����������� ��������� ������� ����������� ������', '', 1,         'INNER_INFO_NOTALLOWED');    
  
  bars_error.add_message(l_mod, 208, l_exc, l_rus, '�� ���� �� ��� �� ����� ��� ������ �����', '', 1,              'NO_OUR_MFO');
  bars_error.add_message(l_mod, 208, l_exc, l_ukr, '����� � ��� �� ������� ��� ������ �����', '', 1,                        'NO_OUR_MFO');    
  
  bars_error.add_message(l_mod, 209, l_exc, l_rus, '���� %s(%s) �� ���������� � ����� �����', '', 1,           'NO_ACCOUNT_FOUND');
  bars_error.add_message(l_mod, 209, l_exc, l_ukr, '������� %s(%s) �� ���� � ������ �����', '', 1, 'NO_ACCOUNT_FOUND');    
  
  bars_error.add_message(l_mod, 210, l_exc, l_rus, '��� ���-%s, ���� %s(%s) �� ������� ��������� � ����������� ������� ������������', '', 1,        'NO_ALIEN_FOUND');
  bars_error.add_message(l_mod, 210, l_exc, l_ukr, '��� ���-%s, ������� %s(%s) �� �������� �������� � �������� ������� �����������', '', 1, 'NO_ALIEN_FOUND');    
      
  bars_error.add_message(l_mod, 211, l_exc, l_rus, '��������� �������� ���� ��� ������� � ���=%s (��� ����� %s-%s) �����������: %s', '', 1,  'CUST_OKPO_NOTCORRECT');
  bars_error.add_message(l_mod, 211, l_exc, l_ukr, '�������� �������� ���� ��� �볺��� � ���=%s (��� ������� %s-%s) �����������: %s', '', 1, 'CUST_OKPO_NOTCORRECT');    
  
  --bars_error.add_message(l_mod, 212, l_exc, l_rus, '��� ��������� - ������������ ����������. ��� ������ ���� ��� ����� %s(%s) � ����������� ����������� �����������: %s', '', 1,  'ALIEN_OKPO_NOTCORRECT');
  --bars_error.add_message(l_mod, 212, l_exc, l_ukr, '��� ��������� - ����������� ��������. ��� ������ ���� ��� ������� %s(%s) � �������� ����������(ALIEN) �����������: %s', '', 1,   'ALIEN_OKPO_NOTCORRECT');    
  
  bars_error.add_message(l_mod, 212, l_exc, l_rus, '������ ��� ������ ���� ��� ����� %s(%s) � ����������� ������ �����������(ALIEN): %s', '', 1,  'ALIEN_OKPO_NOTCORRECT');
  bars_error.add_message(l_mod, 212, l_exc, l_ukr, '������� ��� ������ ���� ��� ������� %s(%s) � �������� ����� ����������(ALIEN): %s', '', 1,   'ALIEN_OKPO_NOTCORRECT');    
  
  bars_error.add_message(l_mod, 213, l_exc, l_rus, '� �������� � �������� ��� ���������� ������ ��� �������� %s. ��� ��������� ������ ��� ���� ��������', '', 1,   'SUCH_DRECDPT_WASPAYED');
  bars_error.add_message(l_mod, 213, l_exc, l_ukr, '� �������� � �������� ��� ���������� ������ ��� �������� %s. ��� ��������� ������ ��� ���� ��������', '', 1,   'SUCH_DRECDPT_WASPAYED');    
  
  bars_error.add_message(l_mod, 214, l_exc, l_rus, '������������ ���� �� ����� ����� %s(%s)', '', 1,    'NO_DEBET_RIGHTS');
  bars_error.add_message(l_mod, 214, l_exc, l_ukr, '����������� ���� �� ����� ������� %s(%s)', '', 1,   'NO_DEBET_RIGHTS');    

  bars_error.add_message(l_mod, 215, l_exc, l_rus, '������������ ���� �� ������ ����� %s(%s)', '', 1,    'NO_KREDIT_RIGHTS');
  bars_error.add_message(l_mod, 215, l_exc, l_ukr, '����������� ���� �� ������ ������� %s(%s)', '', 1,   'NO_KREDIT_RIGHTS');    

  bars_error.add_message(l_mod, 216, l_exc, l_rus, '����� �� ����� �� ������ ��� %s', '', 1, 'NOT_OUR_MFO');
  bars_error.add_message(l_mod, 216, l_exc, l_ukr, '����� � ������� �� ����� ��� %s', '', 1, 'NOT_OUR_MFO');    

  bars_error.add_message(l_mod, 217, l_exc, l_rus, '�� ������ ��� ��� ������� ��� �������� ����������� %s (����� ��� ������ ������ ���)', '', 1, 'NO_SAB_FORREF');
  bars_error.add_message(l_mod, 217, l_exc, l_ukr, '�� ������� ��� ��� ��i���� ��� �������� ���i����� %s (����i��� ��� ����ii ������ ���)', '', 1, 'NO_SAB_FORREF');    

  bars_error.add_message(l_mod, 218, l_exc, l_rus, '�� ���������� ������ �������������� ������� ��� �������� ����������� %s', '', 1, 'NO_SUCHSAB_FORREF');
  bars_error.add_message(l_mod, 218, l_exc, l_ukr, '�� icy� ������ i������i������ ��i���� ���  �������� ���i����� %s (����i��� ��� ����ii ������ ���)', '', 1, 'NO_SUCHSAB_FORREF');    

  bars_error.add_message(l_mod, 219, l_exc, l_rus, '�������� ������� ���� ����� �� ������ ���� ������ 99', '', 1, 'NOTCORRECT_SK');
  bars_error.add_message(l_mod, 219, l_exc, l_ukr, '�������� ������� ��� ����� �� ������ ���� ������� �� 99', '', 1, 'NOTCORRECT_SK');    

  bars_error.add_message(l_mod, 220, l_exc, l_rus, '�������� ������������ �������������� ��� = %s ����������� � ��������� ���������� ������������ ', '', 1, 'SAB_DUBLS');
  bars_error.add_message(l_mod, 220, l_exc, l_ukr, '�������� ����������� i������i������ ��� =  %s ����i������ i �������� ���i����� ������������'   , '', 1, 'SAB_DUBLS');    

  bars_error.add_message(l_mod, 221, l_exc, l_rus, '%s','',1,'INSEP_ERROR');
  bars_error.add_message(l_mod, 221, l_exc, l_ukr, '%s','',1,'INSEP_ERROR');    

  bars_error.add_message(l_mod, 222, l_exc, l_rus, '������������ �������� ���� �������� (������/������ ������ �� ����.����): %s', '', 1, 'NOTVALID_DATD');
  bars_error.add_message(l_mod, 222, l_exc, l_ukr, '��������� �������� ���� ��������� (�i����/����� �i���� �i� ����i����� ����): %s'   , '', 1, 'NOTVALID_DATD');    

  bars_error.add_message(l_mod, 223, l_exc, l_rus, '� ������� ��� %s ���� ����������� ����� ����� ����������: %s', '', 1, 'NLSA_NLSB_ARE_EQUAL');
  bars_error.add_message(l_mod, 223, l_exc, l_ukr, '� ������i ��� %s ������� �i��������� �� ���������� - �������i: %s'   , '', 1, 'NLSA_NLSB_ARE_EQUAL');    

  bars_error.add_message(l_mod, 224, l_exc, l_rus, '������ ����� �������������� ����� �� ������ ��������� 30 ��������: %s', '', 1, 'FILENAME_TOO_LONG');
  bars_error.add_message(l_mod, 224, l_exc, l_ukr, '������� i���i ����� �� ������� ������������ 30 ������i�: %s'   , '', 1, 'FILENAME_TOO_LONG');    

  bars_error.add_message(l_mod, 225, l_exc, l_rus, '���������� ������� �������� ���������� �������(����.������� �������)', '', 1, 'NOPRINT_CHAR_NAZN');
  bars_error.add_message(l_mod, 225, l_exc, l_ukr, '����������� ������� �i����� ����������i �������(����.�����i� �������)'     , '', 1, 'NOPRINT_CHAR_NAZN');    

  bars_error.add_message(l_mod, 226, l_exc, l_rus, '������������ ����������� �������� ���������� �������(����.������� �������)', '', 1, 'NOPRINT_CHAR_NAMA');
  bars_error.add_message(l_mod, 226, l_exc, l_ukr, '����� �������� �i����� ����������i �������(����.�����i� �������)'     , '', 1, 'NOPRINT_CHAR_NAMA');    

  bars_error.add_message(l_mod, 227, l_exc, l_rus, '������������ ���������� �������� ���������� �������(����.������� �������)', '', 1, 'NOPRINT_CHAR_NAMB');
  bars_error.add_message(l_mod, 227, l_exc, l_ukr, '����� ���������� �i����� ����������i �������(����.�����i� �������)'     , '', 1, 'NOPRINT_CHAR_NAMB');    

  bars_error.add_message(l_mod, 228, l_exc, l_rus, '���������� ��� ������ ����� %s � ob22=%s ���������� ��� �������� %s', '', 1,        'NOTALLOWED_NBSOB22_D');
  bars_error.add_message(l_mod, 228, l_exc, l_ukr, '���������� ��� ������ ������� %s �� ob22=%s ����������� ��� ������i� %s'     , '', 1, 'NOTALLOWED_NBSOB22_D');    

  bars_error.add_message(l_mod, 229, l_exc, l_rus, '���������� ��� ������� ��� ����� %s � ob22=%s ���������� ��� �������� %s', '', 1,        'NOTALLOWED_NBSOB22_K');
  bars_error.add_message(l_mod, 229, l_exc, l_ukr, '���������� ��� ������� ������� %s �� ob22=%s ����������� ��� ������i� %s'     , '', 1, 'NOTALLOWED_NBSOB22_K');    

end;
/

commit;
