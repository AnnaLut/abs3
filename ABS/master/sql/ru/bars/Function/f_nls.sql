
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/f_nls.sql =========*** Run *** ====
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.F_NLS 
(bal_  varchar2, rnk_ int,sour_ int,nd_ int,kv_ int,tip3_  varchar2 )
RETURN number IS
tip_ varchar2(3); NLS_ VARCHAR2(15);  R1_ char(1);  XX_ varchar2(20);
m5_  varchar2(5);
--BBBBkRRRRRNNNV -
BEGIN
tip_:=rtrim(ltrim(tip3_));
IF kv_=980 THEN R1_:='7';  ELSE R1_:='0'; END IF;
NLS_:=NULL;
XX_:='0'|| substr((1000000000+rnk_)||'',6,5) ||
           substr((1000000000+nd_) ||'',8,3) ||R1_;
   IF tip_='SS' or tip_='DEP'    THEN   NLS_:=BAL_||XX_ ;
ELSIF tip_='RUF'                 THEN   NLS_:='98110'||sour_ ;
ELSIF tip_='SP' AND bal_<>'2000' THEN   NLS_:=substr(bal_,1,3)||'7'||XX_ ;
ELSIF tip_='SN' or tip_='DEN'    THEN   NLS_:=substr(bal_,1,3)||'8'||XX_ ;
ELSIF tip_='DER'                 THEN
   select iif_s(kv_,980,v67,g67,v67)  into NLS_
   from proc_dr  where nbs=bal_ and sour=4;
ELSIF tip_='SD'                  THEN
   select iif_s(kv_,980,v67,g67,v67)   into NLS_
   from proc_dr   where nbs=bal_ and sour=sour_;
ELSIF tip_='SN8'                 THEN   NLS_:='8008'||XX_ ;
ELSIF tip_='SD8'                 THEN   NLS_:='80060021201' ;
ELSIF tip_='ZAL'                 THEN
      NLS_:=iif_s(sour_,1,'95010','95000','95010')||
            substr((1000000000+rnk_)||'',6,5)||
            substr((1000000000+nd_)||'',8,3)|| mod(kv_,10) ||'';
ELSIF tip_='SGR'                 THEN   NLS_:='9031'||XX_ ;
ELSIF tip_='KS9'                 THEN   NLS_:='9903'||XX_ ;
ELSIF tip_='SSZ'                 THEN   NLS_:='209'||substr(bal_,3,1)||XX_ ;
ELSIF tip_='SL' AND bal_<>'2000' THEN   NLS_:=substr(bal_,1,3)||'6'||XX_ ;
ELSIF tip_='SPN' AND bal_<>'2000' THEN  NLS_:=substr(bal_,1,3)||'9'||XX_ ;
ELSIF tip_='SDK'                  THEN
     IF sour_=4                   THEN  NLS_:='61184021203' ;
  ELSIF sour_=1                   THEN  NLS_:='61119021201' ;
  ELSIF sour_=3                   THEN  NLS_:='61118021202' ;
  ELSIF sour_=2                   THEN  NLS_:='61117021203' ;
  END IF;
ELSIF tip_='SDP'                  THEN
   IF sour_=4                     THEN
      NLS_:=iif_s(kv_,980,'63977021203','63979021201','63977021203');
   ELSIF sour_=1                  THEN  NLS_:='63975021205' ;
   ELSIF sour_=3                  THEN  NLS_:='63976021204' ;
   ELSIF sour_=2                  THEN
      NLS_:=iif_s(kv_,980,'63974021206','63979021201','63974021206');
   END IF;
END IF;
select substr(val,1,5) into m5_  from params where par='MFO';
IF NLS_ is not NULL THEN  NLS_:=VKRZN(m5_,NLS_); END IF;

RETURN to_number(NLS_);
END F_NLS ;
/
 show err;
 
PROMPT *** Create  grants  F_NLS ***
grant EXECUTE                                                                on F_NLS           to ABS_ADMIN;
grant EXECUTE                                                                on F_NLS           to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on F_NLS           to FOREX;
grant EXECUTE                                                                on F_NLS           to RCC_DEAL;
grant EXECUTE                                                                on F_NLS           to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/f_nls.sql =========*** End *** ====
 PROMPT ===================================================================================== 
 