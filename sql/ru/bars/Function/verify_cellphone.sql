
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/verify_cellphone.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.VERIFY_CELLPHONE (CELLPHONE VARCHAR2)
   RETURN NUMBER
   /*
   2015/02/06 Inga Pavlenko COBUSUPABS-3201
   ������������ ���������� ���� ��������� ������� ��� �������� �������� ������ � ��̳ ��������� �������� � ������, �� ������� ���� ����. ���.� � ������ �볺���, � ����: �� PPPPPPP, �� H� � ��� ��������� ���������, PPPPPPP � ����� ��������� ��������. ��� �����:
    -    ��������� �������� ������� ���� �������� ������ ��������� �������� �� ���: 1. ��� �������� ���� ��������� ���������; 2. ��� �������� ������ ��������;
    -    �������� ���� ��������� �������� �������� � �������� ����� ���. ���������;
    -    �������� ���� ��������� ��������� ���������� � ���� ���� �� �1� �� �9�;
    -    ����� ����� ��� �������� ���� ��������� ��������� �������� ����� �+380�;
    -    ����� ��������� �������� ������� ������ ���� �� ���� �� �0� �� �9�.
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
--   L_RESULT := 1; -- ��������, ���� �� �������� ��������
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
 