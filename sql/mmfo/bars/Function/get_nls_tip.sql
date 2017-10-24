
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_nls_tip.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_NLS_TIP (p_nls varchar2, p_kv number) return varchar2
is
  l_tip accounts.tip%type;
begin
  begin
     select tip into l_tip from accounts where nls = p_nls and kv = p_kv;
  exception when no_data_found then
     l_tip := null;
  end;
  return l_tip;
end get_nls_tip;
/
 show err;
 
PROMPT *** Create  grants  GET_NLS_TIP ***
grant EXECUTE                                                                on GET_NLS_TIP     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_NLS_TIP     to PYOD001;
grant EXECUTE                                                                on GET_NLS_TIP     to TOSS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_nls_tip.sql =========*** End **
 PROMPT ===================================================================================== 
 