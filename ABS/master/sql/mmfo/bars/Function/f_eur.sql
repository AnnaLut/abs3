
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_eur.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_EUR 
(kv_ IN NUMBER) RETURN NUMBER IS
SE_ NUMBER;
BEGIN
  --проверка на вхождение валюты  в ЕВРО-союз, 1 -YES, 0-NO
  SELECT count(*)  INTO SE_
  FROM euro  WHERE kv=kv_ ;  RETURN SE_;
END F_EUR;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_eur.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 