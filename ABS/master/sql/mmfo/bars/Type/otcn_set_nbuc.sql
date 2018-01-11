
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/otcn_set_nbuc.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.OTCN_SET_NBUC AS TABLE OF OTCN_NBUC;
/

 show err;
 
PROMPT *** Create  grants  OTCN_SET_NBUC ***
grant EXECUTE                                                                on OTCN_SET_NBUC   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/otcn_set_nbuc.sql =========*** End *** 
 PROMPT ===================================================================================== 
 