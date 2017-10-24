

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PF_NOT_PAY.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PF_NOT_PAY ***

  CREATE OR REPLACE PROCEDURE BARS.PF_NOT_PAY (dat_ date, dd_ number default 1) is

/*
  18-01-2011 Sta Отмена/Восстановление политик
                 после выполнения процедуры pf_not
*/

begin

  -- сделать полный доступ
  bc.set_policy_group('WHOLE');

  begin

    -- вызов внутренней процедуры
    DPT_PF.NOT_GET_PENSION (dat_, dd_);

    -- вернуться в свою область видимости при нормальном завершении
    bc.set_context();

  exception when others then

    -- вернуться в свою область видимости при аварийном  завершении
    bc.set_context();

    -- исключение бросаем дальше
    raise_application_error(-20000, SQLERRM||chr(10)
    	||dbms_utility.format_error_backtrace(), true);

  end;

END pf_not_pay;
/
show err;

PROMPT *** Create  grants  PF_NOT_PAY ***
grant EXECUTE                                                                on PF_NOT_PAY      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on PF_NOT_PAY      to DPT_ADMIN;
grant EXECUTE                                                                on PF_NOT_PAY      to RPBN001;
grant EXECUTE                                                                on PF_NOT_PAY      to START1;
grant EXECUTE                                                                on PF_NOT_PAY      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PF_NOT_PAY.sql =========*** End **
PROMPT ===================================================================================== 
