
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_subst.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_SUBST (
    p_kva                in accounts.kv%type,
    p_nlsa               in accounts.nls%type,
    p_kvb                in accounts.kv%type,
    p_nlsb               in accounts.nls%type
    ) return varchar2 is
  l_nls         accounts.nls%type;
  l_branch_a    accounts.branch%type;
  l_branch_b    accounts.branch%type;
begin
  bars_audit.info(p_kva||','||p_nlsa||','||p_kvb||','||p_nlsb);
  select branch into l_branch_a from accounts where kv=p_kva and nls=p_nlsa;
  begin
    select branch into l_branch_b from accounts where kv=p_kvb and nls=p_nlsb;
  exception when no_data_found then
    l_branch_b := '/';
  end;
  if l_branch_a=l_branch_b then
    l_nls := p_nlsb;
  else
    select val into l_nls from branch_parameters
    where tag='CORRACC' and branch=l_branch_a;
  end if;
  return l_nls;
end;
/
 show err;
 
PROMPT *** Create  grants  F_SUBST ***
grant EXECUTE                                                                on F_SUBST         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_subst.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 