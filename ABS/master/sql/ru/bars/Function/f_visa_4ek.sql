
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_visa_4ek.sql =========*** Run ***
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_VISA_4EK ( REF_ int, PDAT_ date )
return number is
-- определяет референс основного документа с визами для чеков
-- или возвращает свой REF для остальных
  reT_ int;
  REM_ int;
  tt_ char(3);
begin
  -------------
  RET_:=REF_;
  for k in 1..100
  loop
    begin
      select tt,ref into TT_,REM_
      from oper
      where refl=RET_ and ref<RET_ and ref>RET_-100 and trunc(pdat)<=PDAT_ ;
      RET_:=REM_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
    begin
    REM_:=to_number(NULL);
    exit;
    end;
    end;
  end loop;
 return RET_;
end F_visa_4ek;
/
 show err;
 
PROMPT *** Create  grants  F_VISA_4EK ***
grant EXECUTE                                                                on F_VISA_4EK      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_VISA_4EK      to RPBN001;
grant EXECUTE                                                                on F_VISA_4EK      to START1;
grant EXECUTE                                                                on F_VISA_4EK      to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_visa_4ek.sql =========*** End ***
 PROMPT ===================================================================================== 
 