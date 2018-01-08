
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/tt_visa_array.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.TT_VISA_ARRAY is table of tt_visa_obj;
/

 show err;
 
PROMPT *** Create  grants  TT_VISA_ARRAY ***
grant EXECUTE                                                                on TT_VISA_ARRAY   to PUBLIC;
grant EXECUTE                                                                on TT_VISA_ARRAY   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/tt_visa_array.sql =========*** End *** 
 PROMPT ===================================================================================== 
 