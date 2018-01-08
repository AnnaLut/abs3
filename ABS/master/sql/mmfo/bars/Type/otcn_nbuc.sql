
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/type/otcn_nbuc.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE TYPE BARS.OTCN_NBUC AS OBJECT  (nbuc varchar2(20));
/

 show err;
 
PROMPT *** Create  grants  OTCN_NBUC ***
grant EXECUTE                                                                on OTCN_NBUC       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/type/otcn_nbuc.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 