
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_global_param.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_GLOBAL_PARAM (p_par in params$global.par%type) return params$global.val%type 
    result_cache relies_on(params$global) 
    is
    l_val   params$global.val%type;
begin    
    select val into l_val from params$global where par=p_par;
    return l_val;
exception when no_data_found then
    raise_application_error(-20000, 'Глобальный параметр '''||p_par||''' не найден', true);
end get_global_param; 
 
/
 show err;
 
PROMPT *** Create  grants  GET_GLOBAL_PARAM ***
grant EXECUTE                                                                on GET_GLOBAL_PARAM to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_GLOBAL_PARAM to TOSS;
grant EXECUTE                                                                on GET_GLOBAL_PARAM to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_global_param.sql =========*** E
 PROMPT ===================================================================================== 
 