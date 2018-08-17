CREATE OR REPLACE PROCEDURE bars.p_ref_search (p_ref IN OUT NUMBER)
IS
BEGIN
   SELECT o.REF
     INTO p_ref
     FROM oper o
    WHERE     o.REF = p_ref
          AND EXISTS
                 (SELECT 1
                    FROM opldok op
                   WHERE op.REF = o.REF AND op.sos < 5);
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      p_ref := 0;
END;
/


GRANT EXECUTE ON bars.p_ref_search TO BARS_ACCESS_DEFROLE;