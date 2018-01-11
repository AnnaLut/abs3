
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tt_num_array.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TT_NUM_ARRAY is table of number;
/

 show err;
 
PROMPT *** Create  grants  TT_NUM_ARRAY ***
grant EXECUTE                                                                on TT_NUM_ARRAY    to PUBLIC;
grant EXECUTE                                                                on TT_NUM_ARRAY    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tt_num_array.sql =========*** End *** =
 PROMPT ===================================================================================== 
 