
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_cust_h.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CUST_H (p_rnk customer_update.rnk%type,
                                        p_tag varchar2,
                                        p_dat customer_update.chgdate%type)
  return varchar2 is
  l_ret varchar2(500);
begin
  begin
    execute immediate 'select ' || p_tag || '
          from customer_update
         where idupd = (select max(idupd)
                          from customer_update
                         where rnk = :p_rnk and chgdate < :p_dat)'
      into l_ret
      using p_rnk, trunc(p_dat) + 1;

  exception  when no_data_found then
    l_ret := null;
  end;

  if l_ret is null then
    begin
      execute immediate 'select ' || p_tag || '
                           from customer
                          where rnk = :p_rnk  '
                   into l_ret
                  using p_rnk;
    exception when no_data_found then null;
    end;
  end if;

  return l_ret;

end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CUST_H ***
grant EXECUTE                                                                on F_GET_CUST_H    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CUST_H    to CC_DOC;
grant EXECUTE                                                                on F_GET_CUST_H    to START1;
grant EXECUTE                                                                on F_GET_CUST_H    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_cust_h.sql =========*** End *
 PROMPT ===================================================================================== 
 