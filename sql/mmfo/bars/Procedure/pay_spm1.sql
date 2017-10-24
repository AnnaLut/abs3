

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_SPM1.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_SPM1 ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_SPM1 
 (flgi_ SMALLINT,  -- флаг оплаты внешний
  ref_  INTEGER ,  -- референция
  DATV_ DATE    ,  -- дата валютировния
  tt_   CHAR    ,  -- тип транзакции
  dk0_  NUMBER  ,  -- признак дебет-кредит
  kva_  SMALLINT,  -- код валюты А
  nls1_ VARCHAR2,  -- номер счета А
  sa_   DECIMAL ,  -- сумма в валюте А
  kvb_  SMALLINT,  -- код валюты Б
  nls2_ VARCHAR2,  -- номер счета Б
  sb_   DECIMAL    -- сумма в валюте Б
 ) IS

/*
 06-04-2015 Sta Исключить проводки "сам-себе" при конверсии ( или всегда !)
 17-09-2014 Sta Убрать отладки
 26-02-2011 Убрала вюху SAL - наконец-то !!!
 03-06-2010 Флаг опл: если null, то с карт осн.опрерации
 21-02-2009  exception when no_data_found then
 26.03.2008 Учет Операций типа BM*
 11.10.2008 Реализованный результат мо методике НБУ
 Для КБ и НБУ -  описание в doc\Modules Manual\SPM\Den_0.doc

*/
  flg_   INT    ;  -- флаг оплаты реальный (из карточки операции)
  KV_PRD int    :=gl.baseval;
  SPROD_ number :=0;
  SVYRU_ number :=0; -- сумма прд вал и выручка в грн за продажу
  KV_KUP int    :=gl.baseval;
  SKUPL_ number :=0;
  SZATR_ number :=0; -- сумма пок вал и затраты в грн на покупку
  DK_    int    ;
  nls_NR_kup varchar2(15);  nls_RR_prd varchar2(15);
  nls_NR_prd varchar2(15);  nls_RR_kup varchar2(15);
  VX_prd number ; VX_kup number; ACC_PRD int; ACC_KUP int; MM_ number;
  K980   int    :=gl.baseval   ;
  L_3800   varchar2(155)       ;
  Nls_3800 varchar2(15)        ;
  F1_      varchar2(155)       ;
  C1_      int;  i1_      int  ;  nTmp_    int;
  ern    CONSTANT POSITIVE := 203;  erm    VARCHAR2(80);  err    EXCEPTION;
  tag_ operw.tag%type;
--------------------
  procedure opl1 ( flg_ int, ref_ number, DATV_ date, nlsa_ varchar2, nlsb_ varchar2, s_ number) is

  begin 
  --If nlsa_ <> nlsb_ then
         If    S_> 0    then
         -- gl.payv (flg_, ref_, DATV_, 'SPM', 1, gl.baseval, nlsa_, + s_ , gl.baseval, nlsb_, + s_ );
insert into test_9 ( ref, nlsd, nlsk, s) values (ref_,nlsa_, nlsb_, s_ )         ;
         
           ElsIf s_< 0    then 
           --gl.payv (flg_, ref_, DATV_, 'SPM', 1, gl.baseval, nlsa_, - s_ , gl.baseval, nlsb_, - s_ );
insert into test_9 ( ref, nlsd, nlsk, s) values (ref_,nlsb_, nlsa_, - s_ )         ;           
           
           End if;
        --end if;
  end opl1 ;
-------------
begin
 
 nls_3800 := '38003001025' ;
  
  begin
    If kva_ <> k980 then
       begin select 1 into nTmp_ from spot s, accounts a  where a.kv=s.kv and a.kv=kva_ and a.acc=s.acc and a.nls=nls_3800 and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN  return;
       end;
    end if;
    If kvb_ <>k980 then
       begin select 1 into nTmp_ from spot s, accounts a  where a.kv=s.kv and a.kv=kvb_ and a.acc=s.acc and a.nls=nls_3800 and rownum=1;
       EXCEPTION WHEN NO_DATA_FOUND THEN  return;
       end;
    end if;
  end;

  If    dk0_=1 and kva_=K980  and kvb_ not in (K980,960) then SPROD_:=sb_; SVYRU_:=sa_; SKUPL_:=0  ; SZATR_:=0  ; KV_PRD:=kvb_; --продажа HE 960
  elsIf dk0_=0 and kvb_=K980  and kva_ not in (K980,960) then SPROD_:=sa_; SVYRU_:=sb_; SKUPL_:=0  ; SZATR_:=0  ; KV_PRD:=kva_; --продажа HE 960
  ElsIf dk0_=0 and kva_=K980  and kvb_ not in (K980,960) then SPROD_:=0  ; SVYRU_:=0  ; SKUPL_:=sb_; SZATR_:=sa_; KV_KUP:=kvb_; --покупка HE 960
  elsIf dk0_=1 and kvb_=K980  and kva_ not in (K980,960) then SPROD_:=0  ; SVYRU_:=0  ; SKUPL_:=sa_; SZATR_:=sb_; KV_KUP:=kva_; --покупка HE 960
  elsIf dk0_=1 and kva_<>K980 and kvb_ not in (K980)     then SPROD_:=sb_; SVYRU_:=gl.p_icurval(kva_,sa_, DATV_); KV_PRD:=kvb_; --\конв по кр.не 960
                                                              SKUPL_:=sa_; SZATR_:=gl.p_icurval(kvb_,sb_, DATV_); KV_KUP:=kva_; --/
  elsIf dk0_=0 and kvb_<>K980 and kva_ not in (K980)     then SPROD_:=sa_; SVYRU_:=gl.p_icurval(kvb_,sb_, DATV_); KV_PRD:=kva_; --\конв по кр.не 960
                                                              SKUPL_:=sb_; SZATR_:=gl.p_icurval(kva_,sa_, DATV_); KV_KUP:=kvb_; --/
  end if;
  --------------------------------------------------------------------------
If SPROD_>0 and SKUPL_>0 and KV_KUP not in(k980,960) then
     -- оьычная конверсия  --
     begin select N.nls, FOST(p.acc,GL.BDATE -1), p.acc, R.nls INTO nls_NR_prd, VX_prd, acc_PRD, nls_RR_prd  --Сч.Нереа.ПРОД, Вх.поз.ПРОД,Сч.Реал.ПРОД
           from accounts p, vp_list v, accounts N,accounts R
           WHERE nls_3800= p.nls and p.kv = KV_PRD AND p.acc= v.acc3800 AND N.acc= v.acc_rrD AND R.acc=v.ACC_RRS ;
     exception when no_data_found then   raise_application_error( -(20000+333),  '\     - SPM-1 '||nls_3800,      TRUE);
     end;
     begin select N.nls, FOST(p.acc,GL.BDATE -1), p.acc,  R.nls INTO   nls_NR_kup, VX_kup, acc_KUP, nls_RR_kup --Сч.Нереа.ПОКУП,  Вх.поз.ПОКУП,Сч.Реал.ПОКУП
           from  accounts p, vp_list v, accounts N,accounts R
           WHERE nls_3800 = p.nls and p.kv = KV_KUP and p.acc= v.acc3800  AND N.acc= v.acc_rrD  AND R.acc=v.ACC_RRS ;
     exception when no_data_found then   raise_application_error( -(20000+333),   '\     - SPM-2 '||nls_3800,  TRUE);
     end;

     If VX_kup > 0 and VX_prd > 0 then    -- 1) Вх.поз.ПОКУП - длин, Вх.поз.ПРОД - длин
        MM_ := gl.p_icurval(KV_KUP,SKUPL_,DATV_) -  gl.p_icurval(KV_PRD,SPROD_,DATV_);
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_NR_kup, MM_) ; -- 2)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_NR_kup, MM_);

        begin select round(gl.p_icurval(KV_PRD,SPROD_,DATV_) - SPROD_*c.RATE_k,0)  INTO MM_  FROM  SPOT c
              where c.acc=acc_PRD and c.kv=KV_PRD and c.vdate= (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate<DATV_ );
        exception when no_data_found then  raise_application_error( -(20000+333), '\     - SPM-3 '||nls_3800,  TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_NR_kup, MM_) ; -- 3)        gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_NR_kup, MM_);

     ElsIf VX_kup >= 0 and VX_prd <=0 then  -- 2,3,5,6) Вх.поз.ПОКУП - длин(0), Вх.поз.ПРОД - корот(0)
        MM_ := gl.p_icurval(KV_KUP,SKUPL_,DATV_) -  gl.p_icurval(KV_PRD,SPROD_,DATV_);
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_NR_kup, MM_) ; -- 4)        gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_NR_kup, MM_);

     ElsIf VX_kup < 0 and VX_prd > 0  then  -- 7) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - длин
        MM_ := gl.p_icurval(KV_KUP,SKUPL_,DATV_) -  gl.p_icurval(KV_PRD,SPROD_,DATV_);
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_NR_kup, MM_) ; -- 5)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_NR_kup, MM_);

        begin select round(SKUPL_*c.RATE_p - SVYRU_, 0)  INTO MM_  FROM  SPOT c
              where c.acc=acc_kup and c.kv=KV_kup and c.vdate=  (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate<DATV_ );
        exception when no_data_found then   raise_application_error(   -(20000+333),   '\     - SPM-4 '||nls_3800,  TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_kup, nls_RR_kup, MM_) ; -- 6)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_kup, MM_,K980,nls_RR_kup, MM_);

        begin select round(SZATR_ - SPROD_*c.RATE_k , 0)   INTO MM_  FROM  SPOT c
              where c.acc=acc_prd and c.kv=KV_prd and c.vdate = (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate< DATV_ );
        exception when no_data_found then   raise_application_error( -(20000+333), '\     - SPM-5 '||nls_3800,  TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_RR_prd, MM_) ; -- 7)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_RR_prd, MM_);

     ElsIf VX_kup < 0 and VX_prd <=0 then  -- 8,9) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - крот(0)
        MM_:= SVYRU_ - SZATR_;
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_NR_kup, MM_) ; --- 8)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_NR_kup, MM_);

        begin select round(SKUPL_* c.RATE_p -SVYRU_ , 0)  INTO MM_  FROM  SPOT c
              where c.acc=acc_kup and c.kv=KV_kup and c.vdate= (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate< DATV_ );
        exception when no_data_found then  raise_application_error( -(20000+333), '\     - SPM-6 '||nls_3800,   TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_kup, nls_RR_kup, MM_) ; -- 9)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_kup, MM_,K980,nls_RR_kup, MM_);

     ElsIf VX_kup = 0 and VX_prd > 0 then   -- 4) Вх.поз.ПОКУП - 0, Вх.поз.ПРОД - длин
        MM_:= SVYRU_ - SZATR_;
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_NR_kup, MM_) ; -- 10)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_NR_kup, MM_);

        begin select round( SZATR_ - SPROD_ * c.RATE_k , 0)   INTO MM_  FROM  SPOT c
              where c.acc=acc_prd and c.kv=KV_prd and c.vdate = (select  max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate< DATV_ );
        exception when no_data_found then   raise_application_error(   -(20000+333), '\     - SPM-7 '||nls_3800, TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_RR_prd, MM_) ; --11)         gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_prd, MM_,K980,nls_RR_prd, MM_);

     end if;
  -------------------------------------------------------------
  ElsIf SPROD_ > 0 and KV_KUP in (k980,960) then    -- продажа
     begin select N.nls,R.nls, FOST(p.acc,GL.BDATE -1), p.acc  INTO nls_NR_prd,nls_RR_prd,VX_prd, acc_PRD
           from  accounts p, vp_list v, accounts N, accounts R
           WHERE nls_3800 = p.nls and p.kv = KV_PRD AND p.acc= v.acc3800 AND R.acc=v.acc_rrS and R.kv=K980 AND N.acc=v.acc_rrD and N.kv=K980;
     exception when no_data_found then  raise_application_error(  -(20000+333),   '\     - SPM-8 '||nls_3800,  TRUE);
     end;
     If VX_prd > 0 then
        If KV_KUP =960 then  SVYRU_:= gl.p_icurval(KV_PRD,SPROD_, DATV_);   end if;
        begin select round(SVYRU_- SPROD_*c.RATE_k,0)   INTO MM_  FROM  SPOT c
              where c.acc=acc_PRD and c.kv=KV_PRD and c.vdate=  (select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate< DATV_ );
       exception when no_data_found then  raise_application_error(   -(20000+333),   '\     - SPM-9 '||nls_3800,  TRUE);
       end;
       opl1 ( flg_, ref_, DATV_, nls_NR_prd, nls_RR_prd, MM_) ; -- 12)         gl.payv(flg_,ref_,DATV_,'SPM',1,K980,nls_NR_prd, MM_,K980,nls_RR_prd, MM_);

    end if;
  -------------------------------------------------------------------
  ElsIf SKUPL_ > 0 and KV_PRD in (k980) and KV_KUP not in (960) then    --  покупка
     begin select N.nls,R.nls, FOST(p.acc,GL.BDATE -1), p.acc INTO nls_NR_kup,nls_RR_kup,VX_kup,acc_KUP
           from accounts p, vp_list v, accounts N, accounts R
           WHERE nls_3800 = p.nls and p.kv = KV_KUP  AND p.acc= v.acc3800 AND R.acc= v.acc_rrS and R.kv=K980 AND N.acc=v.acc_rrD and N.kv=K980;
     exception when no_data_found then  raise_application_error(  -(20000+333),   '\     - SPM-91 '||nls_3800,  TRUE);
     end;
     If VX_kup < 0 then
        begin select round(SKUPL_*c.RATE_p -SZATR_,0)  INTO MM_  FROM  SPOT c
              where c.acc=acc_KUP and c.kv=KV_kup and c.vdate= (select  max(vdate) from SPOT  where kv=c.kv and acc=c.acc AND vdate< DATV_ );
        exception when no_data_found then  raise_application_error(  -(20000+333),  '\     - SPM-92 '||nls_3800, TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_kup, nls_RR_kup, MM_) ; --13)         gl.payv(flg_,ref_,DATV_,'SPM',1,K980,nls_NR_kup, MM_,K980,nls_RR_kup, MM_);
     end if;
  --------------------------------------
  end if;
end PAY_SPM1;
/
show err;

PROMPT *** Create  grants  PAY_SPM1 ***
grant EXECUTE                                                                on PAY_SPM1        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_SPM1.sql =========*** End *** 
PROMPT ===================================================================================== 
