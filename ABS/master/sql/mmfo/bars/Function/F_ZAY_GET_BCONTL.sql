CREATE OR REPLACE function BARS.F_ZAY_GET_BCONTL return varchar2
is
l_val varchar2(50);
/*
��������������� � �������� ����� ZAY
06,02,2019 ������� ��� ������� �������� �����. ������� ����� ��� �������� �������� ���� 

*/
begin
  select val into l_val from birja where par='B_CONT_L';
  return l_val;
end;
/