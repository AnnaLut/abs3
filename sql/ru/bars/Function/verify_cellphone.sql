
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/verify_cellphone.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VERIFY_CELLPHONE (CELLPHONE VARCHAR2)
   RETURN NUMBER
   /*
   2015/02/06 Inga Pavlenko COBUSUPABS-3201
   ќбовТ€зков≥сть заповненн€ пол€ Ђћоб≥льний телефонї при заведенн≥ кредитноњ за€вки в ј–ћ≥  редитний менеджер у формат≥, що в≥дпов≥даЇ полю Ђћоб. тел.ї в картц≥ кл≥Їнта, а саме: ЌЌ PPPPPPP, де HЌ Ц код моб≥льного оператора, PPPPPPP Ц номер моб≥льного телефону. ƒл€ цього:
    -    Ќеобх≥дно розд≥лити ≥снуюче поле введенн€ номеру моб≥льного телефону на два: 1. дл€ введенн€ коду моб≥льного оператора; 2. дл€ введенн€ номеру телефону;
    -    «наченн€ коду моб≥льного телефону вибирати з дов≥дника Ђ оди моб. оператор≥вї;
    -    значенн€ коду моб≥льного оператора складаЇтьс€ з двох цифр в≥д Д1Ф до Д9Ф;
    -    перед полем дл€ введенн€ коду моб≥льного оператора створити напис Ф+380Ф;
    -    номер моб≥льного телефону повинен м≥стити р≥вно с≥м цифр в≥д Д0Ф до Д9Ф.
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
   L_CELL       := substr(cellphone,1,20);
   L_PREFIX     := SUBSTR (L_CELL, 1, 4);
   L_OPERATOR   := SUBSTR (L_CELL, 5, 2);
   L_ACCOUNT    := SUBSTR (L_CELL, 7, LENGTH(L_CELL)-6);

   IF L_PREFIX != '+380'
   THEN
      L_RESULT := 0;
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
--   L_RESULT := 1; -- временно, пока не запрос€т включить
   RETURN L_RESULT;
END;
/
 show err;
 
PROMPT *** Create  grants  VERIFY_CELLPHONE ***
grant EXECUTE                                                                on VERIFY_CELLPHONE to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on VERIFY_CELLPHONE to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/verify_cellphone.sql =========*** E
 PROMPT ===================================================================================== 
 