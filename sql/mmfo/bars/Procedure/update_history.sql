

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/UPDATE_HISTORY.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  procedure UPDATE_HISTORY ***

  CREATE OR REPLACE PROCEDURE BARS.UPDATE_HISTORY (
   tab1_name IN VARCHAR2,
   tab2_name IN VARCHAR2,
   date_in   IN DATE
   )
AS
   cur            INTEGER := DBMS_SQL.OPEN_CURSOR;
   rows_inserted  INTEGER;
BEGIN
   DBMS_SQL.PARSE (
      cur,
      'INSERT INTO ' || tab1_name ||
      '  (SELECT * FROM ' || tab2_name ||
      ' WHERE created_on < :datelimit)',
      DBMS_SQL.NATIVE);

   DBMS_SQL.BIND_VARIABLE (cur, 'datelimit', date_in);

   rows_inserted := DBMS_SQL.EXECUTE (cur);

   DBMS_SQL.CLOSE_CURSOR (cur);
END;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/UPDATE_HISTORY.sql =========*** En
PROMPT ===================================================================================== 
