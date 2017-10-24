
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/operlistnextid.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.OPERLISTNEXTID RETURN  NUMBER IS
BEGIN
  FOR c IN
   ( SELECT codeoper + 1 as newid FROM operlist o1
     WHERE NOT EXISTS ( SELECT codeoper FROM operlist
                        WHERE codeoper=o1.codeoper + 1)) LOOP
     RETURN c.newid;
     EXIT;
  END LOOP;
END;
 
/
 show err;
 
PROMPT *** Create  grants  OPERLISTNEXTID ***
grant EXECUTE                                                                on OPERLISTNEXTID  to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/operlistnextid.sql =========*** End
 PROMPT ===================================================================================== 
 