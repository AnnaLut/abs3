CREATE OR REPLACE function BARS.F_ZAY_GET_BCONTL return varchar2
is
l_val varchar2(50);
/*
Використовується в біржевому модулі ZAY
06,02,2019 функція яка повертає значення Ідент. підстави купівлі для контролю добового ліміту 

*/
begin
  select val into l_val from birja where par='B_CONT_L';
  return l_val;
end;
/