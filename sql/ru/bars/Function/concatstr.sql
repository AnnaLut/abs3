
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/concatstr.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CONCATSTR (input varchar2) RETURN varchar2
PARALLEL_ENABLE AGGREGATE USING t_ConcatStr; 
/
 show err;
 
PROMPT *** Create  grants  CONCATSTR ***
grant EXECUTE                                                                on CONCATSTR       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CONCATSTR       to RCC_DEAL;
grant EXECUTE                                                                on CONCATSTR       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/concatstr.sql =========*** End *** 
 PROMPT ===================================================================================== 
 