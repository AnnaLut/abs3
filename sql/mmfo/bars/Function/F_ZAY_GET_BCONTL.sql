create or replace function F_ZAY_GET_BCONTL (p_f092 varchar2) return varchar2
is
l_val varchar2(50);
/*
��������������� � �������� ����� ZAY
18/02/2019 ������� ������� 1, ���� �������� f092 ������� �� ����� �������� (BIRJA.PAR like 'B_CONT_%' )
06,02,2019 ������� ��� ������� �������� �����. ������� ����� ��� �������� �������� ����
*/
begin
--  select val into l_val from birja where par='B_CONT_L';
  select count('x') into l_val from birja where par like 'B_CONT_%' and val = p_f092;
  return l_val;
end;
/
