
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_custw_h.sql =========*** Run 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CUSTW_H (p_rnk customerw_update.rnk%type,
                                              p_tag customerw_update.tag%type,
                                              p_dat customerw_update.chgdate%type,
                                              p_isp customerw_update.isp%type default 0)
  return varchar2 is
  l_ret varchar2(500);
begin
  begin
    select val
      into l_ret
      from (select first_value(u.value) over(order by u.idupd desc) as val
              from customerw_update u
             where rnk = p_rnk
               and trim(tag) = trim(p_tag)
               and isp = decode(p_isp, 0, isp, p_isp)
               and chgdate <= p_dat + 0.9999)
     where rownum = 1;
  exception
    when no_data_found then  l_ret := null;
/*      begin
        select value
          into l_ret
          from customerw
         where rnk = p_rnk
           and trim(tag) = trim(p_tag);
      exception
        when no_data_found then
          l_ret := null;
        when others   then
        raise_application_error (-20111,'RNK='||to_char(p_rnk)||' p_tag='||p_tag);
      end;  */
  end;
  return l_ret;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CUSTW_H ***
grant EXECUTE                                                                on F_GET_CUSTW_H   to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CUSTW_H   to CC_DOC;
grant EXECUTE                                                                on F_GET_CUSTW_H   to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_custw_h.sql =========*** End 
 PROMPT ===================================================================================== 
 