
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_depositset.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_DEPOSITSET is table of t_depositrec
/

 show err;
 
PROMPT *** Create  grants  T_DEPOSITSET ***
grant EXECUTE                                                                on T_DEPOSITSET    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_depositset.sql =========*** End *** =
 PROMPT ===================================================================================== 
 