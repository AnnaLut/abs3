
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/canilookclient.sql =========*** Run
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CANILOOKCLIENT (p_rnk in number) return number is
  l_res    number;
  l_value  customerw.value%type;
  l_parval number;
  l_cnt    pls_integer;
begin
  select nvl(min(t.value), '0')
    into l_value
    from customerw t
   where t.rnk = p_rnk and t.tag = 'KLBUF';

  if to_number(l_value) = 0 then
    l_res := 1;
  else
    begin
      select to_number(t.val)
        into l_parval
        from params t
       where t.par = 'KLBUG';

      select count(*)
        into l_cnt
        from groups_staff g
       where g.idu = user_id and g.idg = l_parval and g.sec_sel = 1;

      if l_cnt > 0 then
        l_res := 1;
      else
        l_res := 0;
      end if;

    exception
      when no_data_found then
        l_res := 0;
    end;
  end if;

  return(1);
end canilookclient;
/
 show err;
 
PROMPT *** Create  grants  CANILOOKCLIENT ***
grant EXECUTE                                                                on CANILOOKCLIENT  to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CANILOOKCLIENT  to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/canilookclient.sql =========*** End
 PROMPT ===================================================================================== 
 