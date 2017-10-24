
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/verify_rep_cellphone.sql =========*
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VERIFY_REP_CELLPHONE (CELLPHONE VARCHAR2)
   RETURN NUMBER
/*
2015/06/08 Inga Pavlenko COBUSUPABS-3528
2) при введенні номеру мобільного телефону, що складається з однакових цифр (наприклад, +380675555555),
-- АБС повинна надавати повідомлення (текст повідомлення аналогічний тексту,
-- що у функції «Реєстрація клієнтів та рахунків (ФО)») та можливістю вибору
-- "Так, підтверджую", "Ні, не підтверджую".
-- Якщо користувач натискає на кнопку "Так, підтверджую", то поле "Моб. телефон" зберігається.
-- Якщо користувач натискає на кнопку "Ні, не підтверджую", то поле "Моб. телефон" очищує введений номер.
*/
IS
   L_CELL       VARCHAR2 (20);
   L_ACCOUNT    VARCHAR2 (100);
   P_CELL_NUM   NUMBER;
   L_RESULT     NUMBER;
   L_RES        VARCHAR2 (1);
BEGIN
   L_RESULT := 0;
   L_CELL := cellphone;
   L_ACCOUNT := SUBSTR (L_CELL, 7, LENGTH (L_CELL) - 6);

   IF VERIFY_CELLPHONE (CELLPHONE) = 1
   THEN
      IF (    REPLACE (L_ACCOUNT, '0', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '1', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '2', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '3', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '4', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '5', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '6', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '7', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '8', '_') = '_______'
          OR REPLACE (L_ACCOUNT, '9', '_') = '_______')
      THEN
         L_RESULT := 0;
      ELSE
         L_RESULT := 1;
      END IF;
   END IF;

   RETURN L_RESULT;
END;
/
 show err;
 
PROMPT *** Create  grants  VERIFY_REP_CELLPHONE ***
grant EXECUTE                                                                on VERIFY_REP_CELLPHONE to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/verify_rep_cellphone.sql =========*
 PROMPT ===================================================================================== 
 