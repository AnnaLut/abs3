
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_elt_nd.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_ELT_ND (NLS_ varchar2, KV_ int default 980) return char is
ND_ varchar2(20);
-- Определение № договора на ELT   !! по счету абонплаты 3600/3570
-- Должна возвращать обязательно символьные данные  (под макросы)
-- *** V1.4 27/02-14
BEGIN
 begin
 select cc_id into ND_ from
        (select cc_id
         from e_deal
         where nls36=NLS_ and kv36=KV_ and sos!=15 order by acc26 desc)
 where rownum=1;
 EXCEPTION WHEN NO_DATA_FOUND THEN ND_:='';
 end;
return ND_;
end f_elt_nd;
/
 show err;
 
PROMPT *** Create  grants  F_ELT_ND ***
grant EXECUTE                                                                on F_ELT_ND        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_ELT_ND        to ELT;
grant EXECUTE                                                                on F_ELT_ND        to START1;
grant EXECUTE                                                                on F_ELT_ND        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_elt_nd.sql =========*** End *** =
 PROMPT ===================================================================================== 
 