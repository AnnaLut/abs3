
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dat_nd.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DAT_ND (NLS_ varchar2,KV_ int) return char is
DATD_ varchar2(10);
-- Должна возвращать обязательно символьные данные
-- используем для конструирования назначения платежа в перекрытиях
-- Дата договора за РКО (регистрации клиента)
BEGIN
 begin
   select distinct to_char(DATE_ON) into DATD_
          from customer c,cust_acc s,accounts a
          where a.acc=s.acc and c.rnk=s.rnk and a.nls=NLS_ and a.kv=KV_;
   EXCEPTION WHEN NO_DATA_FOUND THEN DATD_:='';
 end;
return DATD_;
end dat_nd;
/
 show err;
 
PROMPT *** Create  grants  DAT_ND ***
grant EXECUTE                                                                on DAT_ND          to ABS_ADMIN;
grant EXECUTE                                                                on DAT_ND          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DAT_ND          to START1;
grant EXECUTE                                                                on DAT_ND          to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dat_nd.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 