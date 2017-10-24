
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/trim.sql =========*** Run *** =====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.TRIM ( str VARCHAR2 ) return VARCHAR2 is
begin
  return LTRIM( RTRIM( str ));
END;

 
/
 show err;
 
PROMPT *** Create  grants  TRIM ***
grant EXECUTE                                                                on TRIM            to ABS_ADMIN;
grant EXECUTE                                                                on TRIM            to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on TRIM            to START1;
grant EXECUTE                                                                on TRIM            to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/trim.sql =========*** End *** =====
 PROMPT ===================================================================================== 
 