

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/EXECUTE_IMMEDIATE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure EXECUTE_IMMEDIATE ***

  CREATE OR REPLACE PROCEDURE BARS.EXECUTE_IMMEDIATE ( p_sql_text VARCHAR2 ) IS

   COMPILATION_ERROR EXCEPTION;
   PRAGMA EXCEPTION_INIT(COMPILATION_ERROR,-24344);

   l_cursor INTEGER DEFAULT 0;
   rc       INTEGER DEFAULT 0;
   stmt     VARCHAR2(1000);

BEGIN

   l_cursor := DBMS_SQL.OPEN_CURSOR;
   DBMS_SQL.PARSE(l_cursor, p_sql_text, DBMS_SQL.NATIVE);
   rc := DBMS_SQL.EXECUTE(l_cursor);
   DBMS_SQL.CLOSE_CURSOR(l_cursor);
--
-- Ignore compilation errors because these sometimes happen due to
-- dependencies between views AND procedures
--
   EXCEPTION WHEN COMPILATION_ERROR THEN NULL;
       WHEN OTHERS THEN
          raise_application_error(-20101,sqlerrm||'  when executing '''||p_sql_text||'''   ');
END;
 
/
show err;

PROMPT *** Create  grants  EXECUTE_IMMEDIATE ***
grant EXECUTE                                                                on EXECUTE_IMMEDIATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/EXECUTE_IMMEDIATE.sql =========***
PROMPT ===================================================================================== 
