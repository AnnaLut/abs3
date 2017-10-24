
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtonameraj.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTONAMERAJ (branch in varchar2) return varchar2 is
  -- Функція повертає назву району для вказаного бранча
  -- (потрібно для створення звітів в розрізі районів)
  s varchar2(30);
begin
  s := substr(RPAD(branch,30),9,6);
  case
    when s='000136' then return 'Березно';
    when s='000145' then return 'Володимирець';
    when s='000151' then return 'Гоща';
    when s='000133' then return 'Дубровиця';
    when s='000087' then return 'Дубно';
    when s='000096' then return 'Здолбунів';
    when s='000119' then return 'Корець';
    when s='000106' then return 'Костопіль';
    when s='000156' then return 'Млинів';
    when s='000122' then return 'Остріг';
    when s='000164' then return 'Рокитне';
    when s='000113' then return 'Сарни';
    when s='000129' then return 'Радивилів';
    when s='000000' then return 'Рівне (ОПЕРВ)';
    when s='000080' then return 'Кузнецовськ';
    when s='000081' then return 'Зарічне';
    when s='000084' then return 'Демидівка';
    else return 'Рівне (ОПЕРВ)';
  end case;
  return 'Рівне (ОПЕРВ)';
end f_BranchToNameRaj; 
 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTONAMERAJ ***
grant EXECUTE                                                                on F_BRANCHTONAMERAJ to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtonameraj.sql =========*** 
 PROMPT ===================================================================================== 
 