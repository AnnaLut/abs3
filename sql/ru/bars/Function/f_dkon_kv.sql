
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_dkon_kv.sql =========*** Run *** 
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_DKON_KV ( dat1 DATE, dat2 DATE )
RETURN varchar2
IS
  DKON_KV1    date;
  DKON_KV     date;
BEGIN
BEGIN
   If    to_char (dat1,'MM') in ('03','06','09','12') then
         DKON_KV := Dat_last(dat1);
   elsIf to_char (dat1,'MM') in ('02','05','08','18') then
         DKON_KV := Dat_last( add_months(dat1,1) ) ;
   else
         DKON_KV := Dat_last( add_months(dat1,2) ) ;
   end if;
END;
RETURN DKON_KV;
END;
/
 show err;
 
PROMPT *** Create  grants  F_DKON_KV ***
grant EXECUTE                                                                on F_DKON_KV       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_DKON_KV       to START1;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_dkon_kv.sql =========*** End *** 
 PROMPT ===================================================================================== 
 