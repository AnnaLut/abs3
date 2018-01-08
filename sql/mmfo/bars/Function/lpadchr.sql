
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/lpadchr.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.LPADCHR (val VARCHAR2, ch CHAR, len_ NUMBER) RETURN VARCHAR2
IS
res VARCHAR2(300);
i  NUMBER;

BEGIN

res:=nvl(val,' ');
SELECT len_ - length(nvl(val,' ')) INTO i FROM dual;

WHILE i>0 LOOP
  res:=ch||res;
  i:=i-1;
END LOOP;

return substr(res,1,len_);

END;
/
 show err;
 
PROMPT *** Create  grants  LPADCHR ***
grant EXECUTE                                                                on LPADCHR         to ABS_ADMIN;
grant EXECUTE                                                                on LPADCHR         to BARSUPL;
grant EXECUTE                                                                on LPADCHR         to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on LPADCHR         to RPBN001;
grant EXECUTE                                                                on LPADCHR         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/lpadchr.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 