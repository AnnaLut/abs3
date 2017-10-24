
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/gate_user_id.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GATE_USER_ID return NUMBER IS
-----------------------------
-- Module : SEC
-- Author : ANNY
-- Date   : 11.12.2002
-- Modified:
/*
   11.05.2004 SERG в условии WHERE все приведено в верхний регистр
*/
-----------------------------
  RESULT NUMBER;
BEGIN
  BEGIN
    SELECT s.id INTO RESULT
    FROM sec_logins l, staff s
    WHERE upper(trim(l.oralogin)) = USER
      AND upper(trim(l.secid))=upper(trim(s.tabn));
  EXCEPTION WHEN NO_DATA_FOUND THEN
    RESULT := NULL;
  END;
  RETURN RESULT;
END GATE_USER_ID;
/
 show err;
 
PROMPT *** Create  grants  GATE_USER_ID ***
grant EXECUTE                                                                on GATE_USER_ID    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/gate_user_id.sql =========*** End *
 PROMPT ===================================================================================== 
 