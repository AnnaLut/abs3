
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kv_eur.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KV_EUR (kv_ smallint)
return NUMBER IS
kol_ NUMBER;
BEGIN
 select count(*) into kol_ from euro where kv=kv_;
 RETURN kol_;
END;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kv_eur.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 