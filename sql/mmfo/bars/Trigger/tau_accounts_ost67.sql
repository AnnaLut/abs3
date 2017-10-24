

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_OST67.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** Create  trigger TAU_ACCOUNTS_OST67 ***

  CREATE OR REPLACE TRIGGER BARS.TAU_ACCOUNTS_OST67 
   AFTER UPDATE OF ostb
   ON accounts
   FOR EACH ROW
     WHEN (SUBSTR (old.nbs, 1, 1) IN ('6', '7')) DECLARE
   l_Branch3   VARCHAR2 (22);
BEGIN
   BEGIN
      SELECT SUBSTR (TRIM (VALUE), 1, 22)
        INTO l_Branch3
        FROM operw
       WHERE REF = gl.aRef AND tag = 'TOBO3';

      UPDATE opldok
         SET txt = l_Branch3
       WHERE txt NOT LIKE '/%/' AND REF = gl.aref AND stmt = gl.astmt;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         NULL;
   END;
END tau_accounts_ost67;



/
ALTER TRIGGER BARS.TAU_ACCOUNTS_OST67 ENABLE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Trigger/TAU_ACCOUNTS_OST67.sql =========*** 
PROMPT ===================================================================================== 
