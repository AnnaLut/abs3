
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/v_okpo.sql =========*** Run *** ===
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.V_OKPO ( okpo_  varchar2 ) RETURN VARCHAR2 IS
ln_   number ;
m7_   CHAR(7);
i_    number;
sum_  number;
kc_   number;
c1_   char(1);
okpon_ varchar2(14);
BEGIN
   ln_:=length(okpo_) ;
   if ln_ = 8 then
      if okpo_< '30000000' or okpo_>'60000000' then
         m7_:='1234567';
      else
         m7_:='7123456';
      end if;
      sum_:=0 ;
      FOR i_ in 1..7
      LOOP
         c1_:=substr(okpo_,i_,1);
         if ascii(c1_)<48 or ascii(c1_)>57 then
            return ' ' ;
         end if;
         sum_:=sum_+ substr(okpo_,i_,1)*substr(m7_,i_,1);
      END LOOP;
      kc_:=mod(sum_,11);
      if kc_=10 then
         if okpo_< '30000000' or okpo_>'60000000' then
            m7_:='3456789';
         else
            m7_:='9345678';
         end if;
         sum_ :=0 ;
         FOR i_ in 1..7
         LOOP
            sum_:=sum_+ substr(okpo_,i_,1)*substr(m7_,i_,1);
         END LOOP;
         kc_:=mod(sum_,11);
         if kc_ = 10 then
            kc_:=0;
         end if;
      end if;
      okpon_:=substr(okpo_,1,7)||kc_;
   else
      okpon_:=okpo_;
   end if;
   RETURN okpon_ ;
END V_OKPO ;
/
 show err;
 
PROMPT *** Create  grants  V_OKPO ***
grant EXECUTE                                                                on V_OKPO          to ABS_ADMIN;
grant EXECUTE                                                                on V_OKPO          to BARSAQ with grant option;
grant EXECUTE                                                                on V_OKPO          to BARSAQ_ADM;
grant EXECUTE                                                                on V_OKPO          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on V_OKPO          to START1;
grant EXECUTE                                                                on V_OKPO          to WR_ALL_RIGHTS;
grant EXECUTE                                                                on V_OKPO          to WR_CUSTREG;
grant EXECUTE                                                                on V_OKPO          to WR_TOBO_ACCOUNTS_LIST;
grant EXECUTE                                                                on V_OKPO          to WR_USER_ACCOUNTS_LIST;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/v_okpo.sql =========*** End *** ===
 PROMPT ===================================================================================== 
 