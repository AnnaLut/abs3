
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_get_custw_hlist.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_GET_CUSTW_HLIST (
  p_rnk  customerw_update.rnk%type,
  p_tag  customerw_update.tag%type,
  p_dat  customerw_update.chgdate%type,
  p_razd varchar2 default null) return varchar2
is
  l_ret varchar2(2000) := null;
begin
  for k in (select isp, value
              from customerw_update u
             where idupd = (select max(idupd)
                              from customerw_update
                             where rnk       = p_rnk
                               and trim(tag) = trim(p_tag)
                               and isp       = u.isp
                               and chgdate  <= p_dat+0.9999) )
  loop
    l_ret := l_ret || rpad(k.value, 500, ' ') ;
  end loop;

  l_ret := rpad(l_ret, 2000, ' ');

  return l_ret;

end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_CUSTW_HLIST ***
grant EXECUTE                                                                on F_GET_CUSTW_HLIST to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_GET_CUSTW_HLIST to CC_DOC;
grant EXECUTE                                                                on F_GET_CUSTW_HLIST to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_get_custw_hlist.sql =========*** 
 PROMPT ===================================================================================== 
 