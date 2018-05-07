 PROMPT =====================================================================================  
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_adr.sql =========*** Run *** 
 PROMPT ===================================================================================== 
CREATE OR REPLACE FUNCTION BARS.F_GET_ADR (RK in varchar2,TYPE_A in numeric default 2) RETURN  varchar2
IS
  adr varchar2(290);

BEGIN

 select
     address||', '
     ||case when a.locality_type_n is not null then st.SETTLEMENT_TP_CODE ||' '
        else  decode(locality_type,1,'м.',3,'c.',2,'смт.',5, 'ст.',4, 'хут.',null ) --26.03.2018 хоть и не верно, но оставил как есть
       end   
     ||decode(locality,null,null,(locality||', '))
     ||decode(region,null,null,(region||', '))
     ||decode(domain,null,null,(domain||', '))
     ||C.NAME||', '
     ||zip
     into adr
 from customer_address a, country c,
      adr_settlement_types st
 where
     a.rnk=RK
     and a.type_id=TYPE_A
     and c.country=a.country
     and a.locality_type_n = st.settlement_tp_id(+);

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
