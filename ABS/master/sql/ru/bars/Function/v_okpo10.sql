
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/v_okpo10.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.V_OKPO10 ( okpo_  varchar2,bday_ date ) RETURN VARCHAR2 IS
-- Возвращает правильный ОКПО физ лица в зависимости от даты рождения или д.р. и пола
begin

  if length(okpo_)<>10 or length(okpo_) is null
     or to_number(okpo_)<=400000000
     or bday_<=to_date('31/12/1899','DD/MM/YYYY') or bday_ is null
    then
      return null;
  end if;

return substr('00000000000' ||
               to_char(bday_-to_date('31/12/1899','DD/MM/YYYY')) ||
               substr(okpo_,6,5),-10);
end;
/
 show err;
 
PROMPT *** Create  grants  V_OKPO10 ***
grant EXECUTE                                                                on V_OKPO10        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on V_OKPO10        to CUST001;
grant EXECUTE                                                                on V_OKPO10        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/v_okpo10.sql =========*** End *** =
 PROMPT ===================================================================================== 
 