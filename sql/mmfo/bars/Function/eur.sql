
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/eur.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.EUR 
(kv_ IN NUMBER, s_ IN NUMBER) RETURN NUMBER IS
SE_ NUMBER;
BEGIN
  SELECT ROUND( s_/e1,0)
  INTO SE_
  FROM euro
  WHERE kv=kv_ ;
  RETURN SE_;
END EUR;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/eur.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 