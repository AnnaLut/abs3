CREATE OR REPLACE function BARS.F_get_CURR_LIM_DAY1 return number
is
/*
06.02.2019 ������� ������� �������� �������� 
���� �� ����� ������ ������ � �� � �������� �����. 
*/

begin
  return to_number(branch_attribute_utl.get_value('/','CURR_LIM_DAY1'));
end;
/