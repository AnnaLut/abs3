
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_subst_acc.sql =========*** Run **
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SUBST_ACC (
    p_kv                in accounts.kv%type,
    p_nls               in accounts.nls%type,
    p_subst_nls_expr    in varchar2
    ) return varchar2 is
  l_nls   accounts.nls%type;
begin
  bars_audit.trace('f_subst_acc(p_kv=>'||p_kv||',p_nls=>'''||p_nls||''',p_subst_nls_expr=>'''||p_subst_nls_expr||''')');
  l_nls := null;
  begin
    select nls into l_nls from accounts where kv=p_kv and nls=p_nls and branch=sys_context('bars_context', 'user_branch');
  exception when no_data_found then
    execute immediate 'select '||p_subst_nls_expr||' from dual' into l_nls;
  end;
  return l_nls;
end; 
 
/
 show err;
 
PROMPT *** Create  grants  F_SUBST_ACC ***
grant EXECUTE                                                                on F_SUBST_ACC     to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SUBST_ACC     to PYOD001;
grant EXECUTE                                                                on F_SUBST_ACC     to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_SUBST_ACC     to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_subst_acc.sql =========*** End **
 PROMPT ===================================================================================== 
 