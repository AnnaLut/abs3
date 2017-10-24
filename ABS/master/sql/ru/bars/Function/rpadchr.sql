
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/rpadchr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.RPADCHR (val VARCHAR2, ch CHAR, len_ NUMBER) RETURN VARCHAR2
IS

res VARCHAR2(300);
i  NUMBER;

BEGIN

res:=val;
SELECT len_ - length(val) INTO i FROM dual;

WHILE i>0 LOOP
  res:=res||ch;
  i:=i-1;
END LOOP;
 return substr(res,1,len_);

END;
/
 show err;
 
PROMPT *** Create  grants  RPADCHR ***
grant EXECUTE                                                                on RPADCHR         to ABS_ADMIN;
grant EXECUTE                                                                on RPADCHR         to BARSUPL;
grant EXECUTE                                                                on RPADCHR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on RPADCHR         to BARS_SUP;
grant EXECUTE                                                                on RPADCHR         to RPBN001;
grant EXECUTE                                                                on RPADCHR         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/rpadchr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 