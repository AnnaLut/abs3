
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/perek_nd.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.PEREK_ND (NLS_ varchar2,KV_ int) return char is
ND_ varchar2(10);
-- Должна возвращать обязательно символьные данные
-- используем для конструирования назначения платежа в перекрытиях
-- Номер договора за РКО
BEGIN
 begin
   select distinct ltrim(rtrim(nd)) into nd_
          from customer c,cust_acc s,accounts a
          where a.acc=s.acc and c.rnk=s.rnk and a.nls=NLS_ and a.kv=KV_;
   EXCEPTION WHEN NO_DATA_FOUND THEN nd_:='';
 end;
return nd_;
end perek_nd;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/perek_nd.sql =========*** End *** =
 PROMPT ===================================================================================== 
 