/* D:\K\MMFO\forex\COBUMMFO-4222.sql 
   ��������-������� ����� �� ������ ���� ��������� � �����, � �������. 
   �� �� ������� ��������� ������ ���.���.���. �� ��� ����. � �� ���� ����.
   ��������, ������ ���� �������� ��������, �� ������ ����, � ���� �� ���� �������������.

   1) �������� � �������� ���� �������. �������� ����� ���� � �������� �� ������ "�������_�������� ���� �������� ���.���"
   2) ��� ����. ��� �Ѳ �������� ������������ �������� �������� ����� ������� ��������� ���������
  ��������    - ����� ����.
  � �������� - �������� ����
*/

--  ��������    - ����� ����.
exec bc.go ('300465');
update spot set RATE_K = RATE_P where RATE_K = 0;
update spot set RATE_P = RATE_K where RATE_P = 0;
commit; 