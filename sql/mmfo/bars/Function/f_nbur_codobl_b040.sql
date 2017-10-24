
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nbur_codobl_b040.sql =========***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NBUR_CODOBL_B040 
( p_b040 IN varchar2,
  p_type IN NUMBER DEFAULT 4
) RETURN VARCHAR2 deterministic
IS
 -------------------------------------------------------------------
 -- ВЕРСИЯ: 09/06/2016
 -------------------------------------------------------------------
 -- код области для безбалансовых отделений или код подразделения (только BRANCH)
 -- параметры:
 --    branch_ - код подразделения
 --    type_ - вид поиска кода области для БО
 --          =4 - код области
 --          =5 - возвращает код области и код подразделения (по типу 4)
 ----------------------------------------------------------------
    l_nbuc VARCHAR2(20):=NULL;
    l_type_branch NUMBER;
    l_bpos NUMBER;
BEGIN
    IF p_b040 IS NOT NULL THEN
       l_type_branch := TO_NUMBER(SUBSTR(p_b040, 9, 1));

       IF l_type_branch = 0 THEN
          l_bpos := 4;
       ELSIF l_type_branch = 1 THEN
          l_bpos := 10;
       ELSE
          l_bpos := 15;
       END IF;

       -- код области
       l_nbuc:=SUBSTR(p_b040, l_bpos, 2);

       -- в разрезе кода области+код подразделения
       IF p_type IN (3, 5, 7) THEN
          l_nbuc:=l_nbuc || SUBSTR(Trim(p_b040), -12);
       END IF;
    ELSE
       l_nbuc:=NULL;
    END IF;

    RETURN nvl(trim(l_nbuc),'00');
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nbur_codobl_b040.sql =========***
 PROMPT ===================================================================================== 
 