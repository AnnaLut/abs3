
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_sab.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SAB (NLS_ varchar2, KV_ int default 980) return char is
ND_ varchar2(10);
-- Должна возвращать обязательно символьные данные (для макросов)

BEGIN
 begin
   select max(sab) into ND_
          from customer c, accounts a, cust_acc cu
          where a.nls=NLS_ and a.kv=kv_
                and a.acc=cu.acc and cu.rnk=c.rnk;
   EXCEPTION WHEN NO_DATA_FOUND THEN ND_:='';
 end;
return ND_;
end f_sab;
 
/
 show err;
 
PROMPT *** Create  grants  F_SAB ***
grant EXECUTE                                                                on F_SAB           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SAB           to START1;
grant EXECUTE                                                                on F_SAB           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_sab.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 