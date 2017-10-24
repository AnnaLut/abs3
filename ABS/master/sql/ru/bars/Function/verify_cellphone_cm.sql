
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/verify_cellphone_cm.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VERIFY_CELLPHONE_CM (CELLPHONE VARCHAR2)
   RETURN NUMBER
   /*
  KVB проверка телефонов в формате +380ЧЧССССССС,380ЧЧССССССС
   */
IS
   L_CELL       VARCHAR2 (20);
   L_PREFIX     VARCHAR2 (4);
   L_OPERATOR   VARCHAR2 (2);
   T_OP         NUMBER;
   L_ACCOUNT    VARCHAR2 (100);
   P_CELL_NUM   NUMBER;
   L_RESULT     NUMBER;
   L_RES        VARCHAR2 (1);
BEGIN
   L_RESULT     := 0;
   L_CELL       := ltrim(substr(cellphone,1,20),'+');
   L_PREFIX     := SUBSTR (L_CELL, 1, 3);
   L_OPERATOR   := SUBSTR (L_CELL, 4, 2);
   L_ACCOUNT    := SUBSTR (L_CELL, 6, LENGTH(L_CELL)-5);



      IF instr(L_CELL,'0000000')>0
        THEN
      L_RESULT := 0;
      RETURN L_RESULT;
      END IF;

   IF L_PREFIX != '380'
   THEN
      L_RESULT := 0;
      RETURN L_RESULT;
   ELSE

      BEGIN
         SELECT 1
           INTO T_OP
           FROM PHONE_MOB_CODE
          WHERE CODE = TO_NUMBER (L_OPERATOR);
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN L_RESULT := 0;
         WHEN INVALID_NUMBER
         THEN L_RESULT := 0;
      END;

      IF T_OP = 1 AND LENGTH(L_ACCOUNT) = 7
      THEN
         BEGIN
            SELECT TO_NUMBER (L_ACCOUNT) INTO P_CELL_NUM FROM DUAL;
               L_RESULT := 1;
         EXCEPTION
         WHEN NO_DATA_FOUND
         THEN L_RESULT := 0;
         WHEN INVALID_NUMBER
         THEN L_RESULT := 0;
         END;
      END IF;
   END IF;
--   L_RESULT := 1; -- временно, пока не запросят включить
   RETURN L_RESULT;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/verify_cellphone_cm.sql =========**
 PROMPT ===================================================================================== 
 