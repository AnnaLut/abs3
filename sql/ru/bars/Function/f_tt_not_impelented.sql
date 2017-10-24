
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_tt_not_impelented.sql =========**
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_TT_NOT_IMPELENTED return integer
is
begin
    raise_application_error(-20000, 'Помилка - операція не реалізована');
end f_tt_not_impelented;
/
 show err;
 
PROMPT *** Create  grants  F_TT_NOT_IMPELENTED ***
grant EXECUTE                                                                on F_TT_NOT_IMPELENTED to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_TT_NOT_IMPELENTED to PYOD001;
grant EXECUTE                                                                on F_TT_NOT_IMPELENTED to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_tt_not_impelented.sql =========**
 PROMPT ===================================================================================== 
 