
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tt_str_array.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TT_STR_ARRAY is table of varchar2(32676);
/

 show err;
 
PROMPT *** Create  grants  TT_STR_ARRAY ***
grant EXECUTE                                                                on TT_STR_ARRAY    to PUBLIC;
grant EXECUTE                                                                on TT_STR_ARRAY    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tt_str_array.sql =========*** End *** =
 PROMPT ===================================================================================== 
 