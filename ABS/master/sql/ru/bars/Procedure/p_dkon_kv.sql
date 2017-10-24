

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_DKON_KV.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_DKON_KV ***

  CREATE OR REPLACE PROCEDURE BARS.P_DKON_KV ( dat1 DATE, dat2 DATE )
IS
  DKON_KV1    date;
  DKON_KV     date;
BEGIN

   If    to_char (dat1,'MM') in ('03','06','09','12') then
         DKON_KV := Dat_last(dat1);
   elsIf to_char (dat1,'MM') in ('02','05','08','18') then
         DKON_KV := Dat_last( add_months(dat1,1) ) ;
   else
         DKON_KV := Dat_last( add_months(dat1,2) ) ;
   end if;

   Delete from CCK_AN_TMP;
   Insert into CCK_AN_TMP (CC_ID) values (to_char(DKON_KV,'DD/MM/YYYY'));

END;
/
show err;

PROMPT *** Create  grants  P_DKON_KV ***
grant EXECUTE                                                                on P_DKON_KV       to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on P_DKON_KV       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_DKON_KV.sql =========*** End ***
PROMPT ===================================================================================== 
