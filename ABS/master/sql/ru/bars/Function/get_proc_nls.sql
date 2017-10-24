
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_proc_nls.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_PROC_NLS (p_tip in accounts.tip%type, p_kv in accounts.kv%type)
return accounts.nls%type is

  -- Sta 31-05-2011 Более 1-го НЕ закр счета

  -- возвращает лицевой номер процессингового счета по типу и коду валюты
  l_nls     accounts.nls%type;
begin
  begin
    select  nls into  l_nls   from  accounts
    where tip = p_tip and kv = p_kv and dazs is null and rownum = 1;
  exception when no_data_found then
    raise_application_error(-20000, 'No account found: tip='''||p_tip||''', kv='||p_kv);
  end;
  return l_nls;
end get_proc_nls;
/
 show err;
 
PROMPT *** Create  grants  GET_PROC_NLS ***
grant EXECUTE                                                                on GET_PROC_NLS    to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_proc_nls.sql =========*** End *
 PROMPT ===================================================================================== 
 