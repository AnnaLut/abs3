
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/t_penaltyset.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.T_PENALTYSET is table of t_penaltyrec
/

 show err;
 
PROMPT *** Create  grants  T_PENALTYSET ***
grant EXECUTE                                                                on T_PENALTYSET    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on T_PENALTYSET    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/t_penaltyset.sql =========*** End *** =
 PROMPT ===================================================================================== 
 