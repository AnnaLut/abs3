
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_c9.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_C9 (p_ref oper.REF%TYPE)
   RETURN NUMBER
IS
   l_kv           VARCHAR2 (160);
   l_val          operw.VALUE%TYPE := NULL;
   ern   CONSTANT POSITIVE := 803;
   err            EXCEPTION;
   erm            VARCHAR2 (4000);
BEGIN
   -- Определяем код валюты
   BEGIN
      SELECT kv
        INTO L_kv
        FROM OPER
       WHERE                                                  /*KV !=980 AND*/
             REF = p_ref;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         raise_application_error (-20000,
                                  'Document ' || p_ref || ' not found');
   END;


   BEGIN
      SELECT VALUE
        INTO l_val
        FROM Operw
       WHERE REF = p_ref AND tag = 'D1#C9';
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         l_val := NULL;
   END;


   IF NVL (l_val, '0') = '0' AND l_kv != 980
   THEN
      erm :=
         '       Необхідно заповнення реквізиту Код мети надходження валюти';
      RAISE err;
   END IF;

   RETURN 0;
EXCEPTION
   WHEN err
   THEN
      raise_application_error (- (20000 + ern), '\' || erm, TRUE);
END;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_C9 ***
grant EXECUTE                                                                on F_CHECK_C9      to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_c9.sql =========*** End ***
 PROMPT ===================================================================================== 
 