
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_dog_per.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DOG_PER (ID_ INTEGER) 
  RETURN VARCHAR2 IS
  text varchar2(30);
BEGIN
   SELECT substr( TRIM(dog),1,80)
   into text
   from perekr_dog
   where idg = id_;

 RETURN text;
END F_DOG_PER;
/
 show err;
 
PROMPT *** Create  grants  F_DOG_PER ***
grant EXECUTE                                                                on F_DOG_PER       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DOG_PER       to START1;
grant EXECUTE                                                                on F_DOG_PER       to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_dog_per.sql =========*** End *** 
 PROMPT ===================================================================================== 
 