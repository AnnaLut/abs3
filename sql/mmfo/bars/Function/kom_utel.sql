
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/kom_utel.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.KOM_UTEL (S_ int) return char is
KOMN_ number;
KOM_ varchar2(10);

-- Должна возвращать обязательно символьные данные
-- Комиссия с УТЕЛ за перечисленные платежи

BEGIN
 begin
   select 0.005*S_/100 into KOMN_  from dual;
   EXCEPTION WHEN NO_DATA_FOUND THEN KOMN_:=0;
 end;
 if KOMN_<100 then  KOM_:=to_char(KOMN_,'0.99');
 else KOM_:=to_char(KOMN_,'999999.99');
 end if;
return KOM_;
end KOM_UTEL;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/kom_utel.sql =========*** End *** =
 PROMPT ===================================================================================== 
 