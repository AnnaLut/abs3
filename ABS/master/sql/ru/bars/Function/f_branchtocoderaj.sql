
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtocoderaj.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTOCODERAJ (branch in varchar2) return number is
  -- Функція повертає код району для вказаного бранча
  -- (потрібно для створення звітів в розрізі районів)
  s varchar2(30);
begin
  s := substr(RPAD(branch,30),9,6);
  case
    when s='000136' then return  1; -- Березно
    when s='000145' then return  2; -- Володимирець
    when s='000151' then return  3; -- Гоща
    when s='000133' then return  4; -- Дубровиця
    when s='000087' then return  5; -- Дубно
    when s='000096' then return  6; -- Здолбунів
    when s='000119' then return  8; -- Корець
    when s='000106' then return  9; -- Костопіль
    when s='000156' then return 10; -- Млинів
    when s='000122' then return 11; -- Остріг
    when s='000164' then return 12; -- Рокитне
    when s='000113' then return 13; -- Сарни
    when s='000129' then return 14; -- Радивилів
    when s='000000' then return 16; -- Рівне (ОПЕРВ)
    when s='000080' then return 80; -- Кузнецовськ
    when s='000081' then return 81; -- Зарічне
    when s='000084' then return 84; -- Демидівка
    else return 16;
  end case;
  return 16;
end f_BranchToCodeRaj; 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTOCODERAJ ***
grant EXECUTE                                                                on F_BRANCHTOCODERAJ to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BRANCHTOCODERAJ to RPBN002;
grant EXECUTE                                                                on F_BRANCHTOCODERAJ to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtocoderaj.sql =========*** 
 PROMPT ===================================================================================== 
 