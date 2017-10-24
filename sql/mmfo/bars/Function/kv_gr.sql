
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kv_gr.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KV_GR (kv_ smallint)
return NUMBER IS
kol_ NUMBER;
BEGIN
 select r031 into kol_ from kl_r030 where r030=kv_;
 RETURN kol_;
END kv_gr;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kv_gr.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 