CREATE OR REPLACE FUNCTION BARS.IS_CAN_SIGN(p_rnk  customer.rnk%type,
                                       p_okpo customer.okpo%type) return number is
  l_rnk_rel   bars.customer.rnk%type;
  l_is_sign   number(1);
begin
    begin  
        select cr.sign_privs
          into l_rnk_rel 
          from customer_rel cr, customer c
         where cr.rnk = p_rnk
           and c.okpo = p_okpo
           and cr.rel_id = 20
           and c.date_off is null
           and cr.rel_rnk = c.rnk;
     exception
     when no_data_found then
       l_rnk_rel := null;
    end;

    if l_rnk_rel is not null and l_rnk_rel != 0 then
      return l_rnk_rel;
    end if;
      
    select cr.sign_privs
      into l_rnk_rel
      from customer_rel cr, customer_extern ce
     where cr.rnk = p_rnk
       and ce.okpo = p_okpo
       and cr.rel_id = 20
   		 and cr.rel_rnk = ce.id;

    if l_rnk_rel is not null then
      return l_rnk_rel;
    else
      return 0;
    end if;  
    
   exception
     when no_data_found then
       return 0;
end;

/

grant execute on IS_CAN_SIGN to bars_access_defrole;
