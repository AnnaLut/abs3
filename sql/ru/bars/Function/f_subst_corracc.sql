
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_subst_corracc.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SUBST_CORRACC (
    p_kv                in accounts.kv%type,
    p_nls               in accounts.nls%type
    ) return varchar2 is
begin
  return f_subst_acc(p_kv, p_nls, 'tobopack.GetTOBOParam(''CORRACC'')');
end;
/
 show err;
 
PROMPT *** Create  grants  F_SUBST_CORRACC ***
grant EXECUTE                                                                on F_SUBST_CORRACC to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_SUBST_CORRACC to PYOD001;
grant EXECUTE                                                                on F_SUBST_CORRACC to WR_ALL_RIGHTS;
grant EXECUTE                                                                on F_SUBST_CORRACC to WR_DOC_INPUT;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_subst_corracc.sql =========*** En
 PROMPT ===================================================================================== 
 