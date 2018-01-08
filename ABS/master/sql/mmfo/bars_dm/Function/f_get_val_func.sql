
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/function/f_get_val_func.sql =========*** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS_DM.F_GET_VAL_FUNC (p_func in varchar2) return number
is
 l_val number;
begin
bars_audit.info('f_get_val_func(char).p_func = ' ||p_func);
    begin
     execute immediate p_func  USING OUT l_val;
    exception when others then l_val := 0;
    end;
return l_val;
end;
/
 show err;
 
PROMPT *** Create  grants  F_GET_VAL_FUNC ***
grant EXECUTE                                                                on F_GET_VAL_FUNC  to BARSUPL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS_DM/function/f_get_val_func.sql =========*** 
 PROMPT ===================================================================================== 
 