
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtorajurl.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTORAJURL (branch in varchar2) return varchar2 is
  -- Функція повертає чотирьохсимвольну адресу району пошти НБУ для вказаного бранча
  -- (потрібно для створення звітів в розрізі районів)
  s varchar2(30);
begin
  s := substr(RPAD(branch,30),9,6);
  case
    when s='000136' then return 'DRLB'; -- Березно
    when s='000145' then return 'DRLC'; -- Володимирець
    when s='000151' then return 'DRLD'; -- Гоща
    when s='000133' then return 'DRLF'; -- Дубровиця
    when s='000087' then return 'DRLE'; -- Дубно
    when s='000096' then return 'DRLH'; -- Здолбунів
    when s='000119' then return 'DRLI'; -- Корець
    when s='000106' then return 'DRLJ'; -- Костопіль
    when s='000156' then return 'DRLK'; -- Млинів
    when s='000122' then return 'DRLL'; -- Остріг
    when s='000164' then return 'DRLN'; -- Рокитне
    when s='000113' then return 'DRLO'; -- Сарни
    when s='000129' then return 'DRLP'; -- Радивилів
    when s='000000' then return 'URLA'; -- Рівне (ОПЕРВ)
    when s='000080' then return 'DRLM'; -- Кузнецовськ
    when s='000081' then return 'DRLG'; -- Зарічне
    when s='000084' then return 'DRLT'; -- Демидівка
    else return '';
  end case;
  return '';
end f_BranchToRajUrl; 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTORAJURL ***
grant EXECUTE                                                                on F_BRANCHTORAJURL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BRANCHTORAJURL to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtorajurl.sql =========*** E
 PROMPT ===================================================================================== 
 