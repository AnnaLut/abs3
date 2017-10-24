
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_derived_param.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_DERIVED_PARAM (
    p_nls in accounts.nls%type,
    p_kv  in accounts.kv%type,
    p_tag in branch_parameters.tag%type) return varchar2 is
    l_branch    accounts.branch%type;
    l_val       branch_parameters.val%type;
begin
    --
    -- возвращает значение параметра по тэгу дл€ бранча счета nls(kv)
    --
    begin
        select branch into l_branch from accounts where nls=p_nls and kv=p_kv;
    exception when no_data_found then
        raise_application_error(-20000, '—чет не найден: '||p_nls||'('||p_kv||')', true);
    end;
    begin
        l_val := branch_edit.getBranchParams(l_branch, p_tag);
    exception when no_data_found then
        raise_application_error(-20000, '«начение параметра '''||p_tag||''' не найдено дл€ BRANCH='''||l_branch||'''', true);
    end;
end get_derived_param; 
/
 show err;
 
PROMPT *** Create  grants  GET_DERIVED_PARAM ***
grant EXECUTE                                                                on GET_DERIVED_PARAM to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_derived_param.sql =========*** 
 PROMPT ===================================================================================== 
 