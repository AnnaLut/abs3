create or replace function F_ZAY_GET_BCONTL (p_f092 varchar2) return varchar2
is
l_val varchar2(50);
/*
Використовується в біржевому модулі ZAY
18/02/2019 функція повертає 1, якщо параметр f092 входить до групи контролю (BIRJA.PAR like 'B_CONT_%' )
06,02,2019 функція яка повертає значення Ідент. підстави купівлі для контролю добового ліміту
*/
begin
--  select val into l_val from birja where par='B_CONT_L';
  select count('x') into l_val from birja where par like 'B_CONT_%' and val = p_f092;
  return l_val;
end;
/
