
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_adr.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_ADR (RK in varchar2,TYPE_A in numeric default 2) RETURN  varchar2
IS
  adr varchar2(290);

BEGIN

 select
     address||', '||decode(locality_type,1,'�.',3,'c.',2,'���.',5, '��.',4, '���.',null )||decode(locality,null,null,(locality||', '))||decode(region,null,null,(region||', '))||decode(domain,null,null,(domain||', '))||C.NAME||', '||zip
     into adr
 from customer_address a, country c
 where
     a.rnk=RK
     and a.type_id=TYPE_A
     and c.country=a.country;

RETURN adr ;

end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_ADR ***
grant EXECUTE                                                                on F_GET_ADR       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_ADR       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_adr.sql =========*** End *** 
 PROMPT ===================================================================================== 
 