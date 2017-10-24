
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/verify_cellphone_byrnk.sql ========
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VERIFY_CELLPHONE_BYRNK (P_RNK NUMBER)
   RETURN NUMBER
IS
   L_CELLPHONE   VARCHAR2 (50);
   L_CUSTTYPE    NUMBER;
   L_SPDFO       NUMBER;
   L_RESULT      NUMBER;
BEGIN
   BEGIN
      SELECT CUSTTYPE,
             CASE
                WHEN sed = '91 '
                     AND ise IN ('14100', '14200', '14101', '14201')
                THEN
                   1
                ELSE
                   0
             END
        INTO L_CUSTTYPE, L_SPDFO
        FROM CUSTOMER
       WHERE RNK = P_RNK;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         L_RESULT := 0;
         BARS_AUDIT.INFO (
            'VERIFY_CELLPHONE_BYRNK: Тип клиента не определен! РНК = '
            || TO_CHAR (P_RNK));
   END;

   IF L_CUSTTYPE = 3 AND L_SPDFO = 0
   THEN
      BEGIN
         SELECT VALUE
           INTO L_CELLPHONE
           FROM CUSTOMERW
          WHERE RNK = P_RNK AND TAG = 'MPNO';
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            L_RESULT := 0;
      END;

      L_RESULT := VERIFY_CELLPHONE (L_CELLPHONE);
   ELSE
      L_RESULT := 1;
   END IF;

   RETURN L_RESULT;
END;
/
 show err;
 
PROMPT *** Create  grants  VERIFY_CELLPHONE_BYRNK ***
grant EXECUTE                                                                on VERIFY_CELLPHONE_BYRNK to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/verify_cellphone_byrnk.sql ========
 PROMPT ===================================================================================== 
 