

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/WEB_REFBOOKS_PRIVILEGES.sql ======
PROMPT ===================================================================================== 


PROMPT *** Create  procedure WEB_REFBOOKS_PRIVILEGES ***

  CREATE OR REPLACE PROCEDURE BARS.WEB_REFBOOKS_PRIVILEGES (
   p_operation   IN   VARCHAR2,
   p_tabid       IN   NUMBER
)
IS
   tabname_   VARCHAR2 (30);
   grant_     VARCHAR2 (75);
   grant2_     VARCHAR2 (75);
BEGIN
   SELECT tabname
     INTO tabname_
     FROM meta_tables
    WHERE tabid = p_tabid;
   IF p_operation = 'GRANT'
   THEN
      grant_ := 'grant select on ' || tabname_ || ' to wr_refread';
      grant2_ := 'grant flashback on ' || tabname_ || ' to wr_refread';
   ELSIF p_operation = 'REVOKE'
   THEN
      grant_ := 'revoke select on ' || tabname_ || ' from wr_refread';
      grant2_ := 'revoke flashback on ' || tabname_ || ' from wr_refread';
   END IF;
   EXECUTE IMMEDIATE grant_;
   EXECUTE IMMEDIATE grant2_;
END web_refbooks_privileges;
/
show err;

PROMPT *** Create  grants  WEB_REFBOOKS_PRIVILEGES ***
grant EXECUTE                                                                on WEB_REFBOOKS_PRIVILEGES to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on WEB_REFBOOKS_PRIVILEGES to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/WEB_REFBOOKS_PRIVILEGES.sql ======
PROMPT ===================================================================================== 
