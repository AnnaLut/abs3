
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_check_payment.sql =========*** Ru
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_CHECK_PAYMENT (
    p_ref oper.ref%type,
    flag number default null)
return number
/**
    filename: <b>\modules\gl\sql\function\f_check_payment.fnc</b><br/>
    Project : <a href="http://confluence.unity-bars.com.ua:8090/pages/viewpage.action?pageId=1966387">АБС БАРС</a><br/>
    Module  : <b>GL</b><br/>
    Description: <em>Стоп-правила при виконанні операцій, що перевищують 150'000 грн в еквіваленті</em><br/>
    Developer(s): <em>artem.iurchenko</em><br/><br/>
    Copyright (c) 2015, unity-bars, Inc. All rights reserved.<br/>
*/
is
    l_s_val opldok.sq%type;
begin
    -- flag = 1 - Сума яку треба виплатити на касу, 2 - Сума яку треба перерахувати на 2909
    -- контроль перевищення суми виконується в LCV, тому тут просто повертаємо суму операції і тільки для flag = 1
    if (flag = 1) then

        select o.s
        into   l_s_val
        from   oper o
        where  o.ref = p_ref;

        return l_s_val;
    else
        return 0;
    end if;
end;
/
 show err;
 
PROMPT *** Create  grants  F_CHECK_PAYMENT ***
grant EXECUTE                                                                on F_CHECK_PAYMENT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_CHECK_PAYMENT to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_check_payment.sql =========*** En
 PROMPT ===================================================================================== 
 