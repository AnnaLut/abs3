
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/dpt_pay.sql =========*** Run *** ==
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.DPT_PAY ( nls_ VARCHAR2, kv_ INT, dat_ DATE, sum_ NUMBER )
   RETURN NUMBER  IS
 APL_DAT_  DATE;    OSTB_     NUMBER;
 ACR_DAT_  DATE;    OSTC_     NUMBER;
 DAOS_     DATE;    PR_       NUMBER(10,5);
 DEN_      INT;     ACCN_     INT;
 ern  CONSTANT POSITIVE := 808; err  EXCEPTION; erm  VARCHAR2(80);
 ern1 CONSTANT POSITIVE := 809; err1 EXCEPTION; erm1 VARCHAR2(80);
BEGIN
  BEGIN
    SELECT  to_number(to_char(a.daos,'dd')), b.ost, a.ostc, a.daos,
            nvl(acrn.fproc(a.acc,a.daos),0),
            nvl(i.acr_dat,a.daos), b.acc
    INTO   DEN_,  OSTB_,  OSTC_, DAOS_, PR_, ACR_DAT_, ACCN_
    FROM accounts a, int_accn i, sal b
    WHERE b.nls=nls_   AND  b.kv=kv_ AND a.acc=i.acc AND
          i.acra=b.acc AND  b.fdat=DAT_;
    EXCEPTION WHEN NO_DATA_FOUND THEN
        erm := 'Не было начислены проценты!';   RAISE err;
  END;
  BEGIN
    SELECT max(o.fdat) INTO APL_DAT_  FROM  opldok o
    WHERE  o.acc=ACCN_ AND  o.dk=0 AND o.sos=5 GROUP BY o.sos;
    EXCEPTION WHEN NO_DATA_FOUND THEN  APL_DAT_:=DAOS_;
  END;
  -- сколько месяцев от предыдущей выплаты ?
  IF MONTHS_BETWEEN( DAT_, APL_DAT_ ) <1 THEN
     erm1 := '8023- Невозможно выплатить проценты!';
     RAISE err1;
  END IF;
  -- Необходимо выплатить по APL_DAT_
  IF DEN_<=to_number(to_char(to_date(DAT_),'dd')) THEN
     -- пришел позже контр.числа текущего месяца
     APL_DAT_:=to_date( lpad(to_char(DEN_),2,'0')||to_char(to_date(DAT_),'mmyyyy'),'DDMMYYYY');
ELSE
     -- пришел раньше контр.числа текущего месяца,позже контр.числа прошлого месяца
     APL_DAT_:=DAT_ - to_number(to_char(to_date(DAT_),'dd'));
     APL_DAT_:=to_date( lpad(to_char(DEN_),2,'0')||to_char(to_date(APL_DAT_),'mmyyyy'),'DDMMYYYY');
END IF;
  IF ACR_DAT_ < APL_DAT_ THEN
      erm :='Необходимо доначислить % до '||to_char(APL_DAT_, 'dd/mm/yyyy');
  -- erm := '8024- Недоначислены проценты'||erm;
  RAISE err;
  ELSIF ACR_DAT_ >= APL_DAT_ THEN
        -- переначислили за
        DEN_:=ACR_DAT_ - APL_DAT_;
        ostb_:= ostb_ - round((ostc_*DEN_*pr_)/36500,0);
        RETURN least(ostb_,sum_);
  END IF;
  EXCEPTION
       WHEN err      THEN raise_application_error(-(20000+ern),erm,TRUE);
       WHEN err1     THEN raise_application_error(-(20000+ern1),erm1,TRUE);
       WHEN OTHERS  THEN raise_application_error(-(20000+ern),SQLERRM,TRUE);
END DPT_PAY;
/
 show err;
 
PROMPT *** Create  grants  DPT2PAY ***
grant SELECT                                                                 on DPT2PAY         to BARSREADER_ROLE;
grant SELECT                                                                 on DPT2PAY         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT2PAY         to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/dpt_pay.sql =========*** End *** ==
 PROMPT ===================================================================================== 
 