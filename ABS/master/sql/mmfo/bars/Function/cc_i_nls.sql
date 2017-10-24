
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_i_nls.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_I_NLS (id_ in number, branch_ in varchar2)
  return number is
begin
  -- tvSukhov 20.02.2012 Логика работы функции перенесена в пакет cck_dop
  -- функция оставлена для поддержания обратной совместимости
  -- в будущем пользуемся только пакетом

  if (id_ is not null) then
    return cck_dop.get_isp_by_user(id_);
  elsif (branch_ is not null) then
    return cck_dop.get_isp_by_branch(branch_);
  else
    return null;
  end if;
end cc_i_nls;
/
 show err;
 
PROMPT *** Create  grants  CC_I_NLS ***
grant EXECUTE                                                                on CC_I_NLS        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_I_NLS        to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_i_nls.sql =========*** End *** =
 PROMPT ===================================================================================== 
 