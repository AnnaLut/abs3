
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_f_nls.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_F_NLS 
  (bal_ varchar2, RNK_ int, sour_ int, ND_ int, kv_ int, tip3_ varchar2 )
RETURN number IS
  CC_ID_   varchar2(20);  bal_old_ char(4);      tip_     varchar2(3);
  NLS_     VARCHAR2(15);  X4_      int;          R1_      char(1);
  XX_      varchar2(20);  XX_old_  varchar2(20); rTOBO_   varchar2(12);
/*
29.08.06 Sta Для сч SD - с учетом кода ТОБО по КД (PROC_DR.rezid = TOBO)
*/
BEGIN
   tip_:=rtrim(ltrim(tip3_));
   BEGIN
      select substr('000'||cc_id ,-3) into CC_ID_ from cc_deal where nd=ND_ ;
   EXCEPTION WHEN INVALID_NUMBER THEN CC_ID_:='000' ;
             WHEN NO_DATA_FOUND THEN CC_ID_:=substr('000'||nd_ ,-3) ;
   END;
   XX_:='0'||substr( '0000'||RNK_, -4 ) ||'00';
   If substr(CC_ID_,1,1)<'0' or substr(CC_ID_,1,1)>'9' then XX_:=XX_||'0';
   else                                      XX_:=XX_||substr(CC_ID_,1,1);
   end if;
   If substr(CC_ID_,2,1)<'0' or substr(CC_ID_,2,1)>'9' then XX_:=XX_||'0';
   else                                      XX_:=XX_||substr(CC_ID_,2,1);
   end if;
   If substr(CC_ID_,3,1)<'0' or substr(CC_ID_,3,1)>'9' then XX_:=XX_||'0';
   else                                      XX_:=XX_||substr(CC_ID_,3,1);
   end if;
   begin
     select a.nbs, '0'||substr(a.nls,6,9)  into bal_old_, xx_old_
     from accounts a, cc_add ad where ad.accs=a.acc and ad.nd=nd_ ;
   EXCEPTION WHEN NO_DATA_FOUND THEN  bal_old_:=bal_; XX_OLD_ := XX_;
   end;
   NLS_:=NULL;

   IF tip_='SS' or tip_='ZAL' THEN NLS_:=BAL_||XX_ ;
ELSIF tip_='SN'               THEN NLS_:=substr(bal_old_,1,3)||'8'||XX_old_ ;
ELSIF tip_='SD'               THEN
      select max(nls) into NLS_ from accounts
             where acc=cc_o_nls(bal_, RNK_, sour_, ND_, kv_, tip3_);
ELSIF tip_='SL'    THEN   NLS_:=substr(bal_old_,1,3)||'6'||XX_old_ ;
ELSIF tip_='SP'    THEN   NLS_:=substr(bal_old_,1,3)||'7'||XX_old_ ;
ELSIF tip_='SPN'   THEN   NLS_:=substr(bal_old_,1,3)||'9'||XX_old_ ;
ELSIF tip_='SUC'   THEN   NLS_:='9819'||XX_old_ ;
ELSIF tip_='SN8'   THEN   NLS_:='8008'||XX_old_ ;
ELSIF tip_='SD8'   THEN   NLS_:='80060021201' ;
END IF;

IF tip_<>'SD' and NLS_ is not NULL THEN  NLS_:=VKRZN( substr(gl.aMFO,1,5), NLS_ ); END IF;

RETURN to_number(NLS_);
END cc_F_NLS ;
/
 show err;
 
PROMPT *** Create  grants  CC_F_NLS ***
grant EXECUTE                                                                on CC_F_NLS        to BARS009;
grant EXECUTE                                                                on CC_F_NLS        to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_F_NLS        to RCC_DEAL;
grant EXECUTE                                                                on CC_F_NLS        to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_f_nls.sql =========*** End *** =
 PROMPT ===================================================================================== 
 