
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/energo.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.ENERGO (KV_ NUMBER, nls_ varchar2) rETURN NUMBER
IS
kol int;
begin
 select count(*) into kol from cust_acc u, accounts a
 where a.acc=u.acc and a.kv=kv_ and a.nls=nls_ and u.rnk in (300257,300245);
 RETURN kol;
END energo;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/energo.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 