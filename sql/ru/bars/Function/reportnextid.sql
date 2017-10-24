
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/reportnextid.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.REPORTNEXTID 
RETURN  NUMBER IS

BEGIN

  FOR c IN ( SELECT id + 1 as newid FROM reports o1
             WHERE NOT EXISTS (SELECT id FROM reports WHERE id=o1.id + 1)) LOOP
         RETURN c.newid;
		 EXIT;
  END LOOP;

END;
/
 show err;
 
PROMPT *** Create  grants  REPORTNEXTID ***
grant EXECUTE                                                                on REPORTNEXTID    to ABS_ADMIN;
grant EXECUTE                                                                on REPORTNEXTID    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on REPORTNEXTID    to RPBN001;
grant EXECUTE                                                                on REPORTNEXTID    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/reportnextid.sql =========*** End *
 PROMPT ===================================================================================== 
 