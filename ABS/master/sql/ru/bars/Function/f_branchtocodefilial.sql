
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_branchtocodefilial.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_BRANCHTOCODEFILIAL (branch in varchar2) return number is
  -- Функція повертає код району для вказаного бранча
  -- (потрібно для створення звітів в розрізі районів)
  s   varchar2(30);
begin
  if length(branch)<15 then
    return 0;
  end if;
  if (length(branch)<22) and (branch like '/______/______/')  then
    return to_number(substr(branch,11,4));
  end if;
  if (branch like '/______/______/______/')  then
    return to_number(substr(branch,18,4));
  end if;
  return 0;
end f_BranchToCodeFilial; 
/
 show err;
 
PROMPT *** Create  grants  F_BRANCHTOCODEFILIAL ***
grant EXECUTE                                                                on F_BRANCHTOCODEFILIAL to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_BRANCHTOCODEFILIAL to RPBN002;
grant EXECUTE                                                                on F_BRANCHTOCODEFILIAL to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_branchtocodefilial.sql =========*
 PROMPT ===================================================================================== 
 