
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/sum_limiter.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.SUM_LIMITER (p_sum in number, p_threshold in number) return number
is
begin
  if p_sum > p_threshold then
    raise_application_error(-20000, 'Перевищено максимально допустиму суму: '||p_threshold, TRUE);
  end if;
  return 0;
end;
/
 show err;
 
PROMPT *** Create  grants  SUM_LIMITER ***
grant EXECUTE                                                                on SUM_LIMITER     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on SUM_LIMITER     to PYOD001;
grant EXECUTE                                                                on SUM_LIMITER     to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/sum_limiter.sql =========*** End **
 PROMPT ===================================================================================== 
 