

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_SPM.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_SPM ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_SPM 
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
------------------
1) Покупка на длин РКР  нет
2) Продажа с  кор. РКР  нет
3) Продажа с  длин РКР  есть
4) Покупка на кор. РКР  есть
5) Конверс с длин на длин   РКР нет   -- 1) Вх.поз.ПОКУП - длин,  Вх.поз.ПРОД - длин
6) Конверс с длин на кор/0  РКР есть  -- 7) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - длин
                                      -- 4) Вх.поз.ПОКУП - 0,     Вх.поз.ПРОД - длин
7) Конверс с кор/0 на дл/0  РКР нет   -- 2,3,5,6) Вх.поз.ПОКУП - длин(0), Вх.поз.ПРОД - корот(0)
8) Конверс с кор/0 на кор.  РКР есть  -- 8,9) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - крот(0)
-----------------------------------

14-05-2015 Sta/ Позорная ош. ДК

643	     1184168798    куп.=  0.3
826	       -6817568    прод= 40.0
840	     5289277166    куп.= 20.0
978	     -185926657    прод= 30.0
381                   0

1)   Покупка 840 на длин                       РКР - нет
     paytt ( 0, 288974228, gl.bdate, '013', 1, 840, '37397906547', 100000, 980, '37397906547',  2200000);
2.1) Продажа выгодная  840 с  длин по курсу 22.0     РКР = +200000
     paytt ( 0, 288974228, gl.bdate, '013', 0, 840, '37397906547', 100000, 980, '37397906547',  2200000);
2.2) Продажа НЕвыгодная 840 с  длин по курсу 18.0    РКР = -200000
     paytt ( 0, 288974228, gl.bdate, '013', 0, 840, '37397906547', 100000, 980, '37397906547',  1800000);
3)   Продажа 978 с кор                               РКР - нет
     paytt ( 0, 288974228, gl.bdate, '013', 0, 978, '37397906547', 100000, 980, '37397906547',  3300000);
3.1) Покупка Невыгодная 978 на кор   по курсу 33.0   РКР = -300000
     paytt ( 0, 288974228, gl.bdate, '013', 1, 978, '37397906547', 100000, 980, '37397906547',  3300000);
3.2) Покупка Выгодная 978 на кор   по курсу 27.0     РКР = +300000
     paytt ( 0, 288974228, gl.bdate, '013', 1, 978, '37397906547', 100000, 980, '37397906547',  2700000);
------------------------------------------------------------------------
4.1) Конверс 840 - 643 с дл на дл (прод 840 дл. пок 643 дл)
     paytt ( 0, 288974228, gl.bdate, '013', 0, 840, '37397906547', 100000, 643, '37397906547',  9900000);     НЕТ
     paytt ( 0, 288974228, gl.bdate, '013', 0, 840, '37397906547', 100000, 643, '37397906547',  3300000);     НЕТ
     Только НРК
     VX_kup > 0 and VX_prd > 0 then    -- 1) Вх.поз.ПОКУП - длин, Вх.поз.ПРОД - длин

4.2) Конверс 840 - 978 с дл на кор (прод 840 дл. пок 978 кор )
     -- Дважды выгодная
     paytt ( 0, 288974228, gl.bdate, '013', 0, 840, '37397906547', 100000, 978, '37397906547',  100000);     РКР = +453922 +350949
     paytt ( 0, 288974228, gl.bdate, '013', 0, 840, '37397906547', 100000, 978, '37397906547',  100   );     РКР = +454    +350949
     VX_kup < 0 and VX_prd > 0  then  -- 7) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - длин

4.3) Конверс 978 - 840 с кор на дл (прод 978 кор.  пок 840 дл)
     -- Невыгодная покуп
     paytt ( 0, 288974228, gl.bdate, '013', 0, 978, '37397906547', 100000, 840, '37397906547',  100000 );  НЕТ
     Только НРК
     VX_kup >= 0 and VX_prd <=0 then  -- 2,3,5,6) Вх.поз.ПОКУП - длин(0), Вх.поз.ПРОД - корот(0)

4.4) Конверс 978 - 826 с кор на кор (прод 978 кор . пок 826 кор)
     paytt ( 0, 288974228, gl.bdate, '013', 0, 978, '37397906547', 100000, 826, '37397906547',  100000 ); РКР = +519850
     VX_kup < 0 and VX_prd <=0 then  -- 8,9) Вх.поз.ПОКУП - корот, Вх.поз.ПРОД - крот(0)

4.5) Конверс 840 - 381 с дл на 0 (прод 840 дл. пок 381 0 )
     paytt ( 0, 288974228, gl.bdate, '013', 1, 381, '15006201287', 200000, 840, '37397906547',  100000 ); РКР = +350949
     VX_kup = 0 and VX_prd > 0 then   -- 4) Вх.поз.ПОКУП - 0, Вх.поз.ПРОД - длин


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

  begin If nlsa_ <> nlsb_ then
           If    S_> 0    then gl.payv (flg_, ref_, DATV_, 'SPM', 1, gl.baseval, nlsa_, + s_ , gl.baseval, nlsb_, + s_ );
           ElsIf s_< 0    then gl.payv (flg_, ref_, DATV_, 'SPM', 0, gl.baseval, nlsa_, - s_ , gl.baseval, nlsb_, - s_ );
           End if;
        end if;
  end opl1 ;
-------------
begin
  If L_3800 is null then
    begin select trim(s3800), nvl(flgi_, to_number ( substr(flags,38,1))) into L_3800, flg_ from tts where tt=tt_ and s3800 is not null; --найти счет ВАЛ ПОЗ
    EXCEPTION WHEN NO_DATA_FOUND THEN  return;
    END;

    if substr(L_3800,1,2)='#(' then    /* Формула счета вал поз */
       begin
         f1_:='SELECT '||SUBSTR(L_3800,3,LENGTH(L_3800)-3)||' FROM DUAL';
         c1_:=DBMS_SQL.OPEN_CURSOR;                   --открыть курсор
         DBMS_SQL.PARSE(c1_, f1_, DBMS_SQL.NATIVE)  ; --приготовить дин.SQL
         DBMS_SQL.DEFINE_COLUMN(c1_,1,nls_3800,15 ) ; --установить знач колонки в SELECT
         i1_:=DBMS_SQL.EXECUTE(c1_);                  --вып приготовл SQL
         IF DBMS_SQL.FETCH_ROWS(c1_)>0 THEN           --прочитать
            DBMS_SQL.COLUMN_VALUE(c1_,1,nls_3800);    --снять результ переменную
         end if;
         DBMS_SQL.CLOSE_CURSOR(c1_);                  -- закрыть курсор
       EXCEPTION  WHEN OTHERS THEN return;
       END;
    else   nls_3800:=L_3800;
    end if;
  end if;
  -----------------
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
  ----------------------------------------------
  If SPROD_>0 and SKUPL_>0 and KV_PRD        in(     960) then /* конверсия */
     -- специфическая конверсия
     select N.nls, FOST(p.acc,GL.BDATE -1) , p.acc,  R.nls     INTO   nls_NR_kup, VX_kup, acc_kup, nls_RR_kup
     from  accounts p, vp_list v, accounts N,accounts R
     WHERE nls_3800= p.nls and p.kv = KV_kup   and p.acc= v.acc3800    AND N.acc= v.acc_rrD  AND R.acc=v.ACC_RRS;

     If VX_kup <0 then /* вал.покупки -  поз кор */
        select round( SKUPL_*c.RATE_P - gl.p_icurval(KV_kup,SKUPL_,DATV_),0)          INTO MM_  FROM  SPOT c
        where c.acc=acc_kup and c.kv=KV_kup and c.vdate=(select max(vdate) from SPOT where kv=c.kv and acc=c.acc AND vdate<DATV_ );
        opl1 ( flg_, ref_, DATV_, nls_NR_kup, nls_RR_kup, MM_) ; -- 1        gl.payv(flg_,ref_,DATV_,'SPM',DK_,K980,nls_NR_kup, MM_,K980,nls_RR_kup, MM_);

     End if;
  --------------------------------------------------------------------------
  ElsIf SPROD_>0 and SKUPL_>0 and KV_KUP not in(k980,960) then
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
     If VX_prd > 0 then  -- 2.1) Продажа с  длин
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
     If VX_kup < 0 then  -- 3) Покупка на кор
        begin select round(SKUPL_*c.RATE_p -SZATR_,0)  INTO MM_  FROM  SPOT c
              where c.acc=acc_KUP and c.kv=KV_kup and c.vdate= (select  max(vdate) from SPOT  where kv=c.kv and acc=c.acc AND vdate< DATV_ );
        exception when no_data_found then  raise_application_error(  -(20000+333),  '\     - SPM-92 '||nls_3800, TRUE);
        end;
        opl1 ( flg_, ref_, DATV_, nls_NR_kup, nls_RR_kup, MM_) ; --13)         gl.payv(flg_,ref_,DATV_,'SPM',1,K980,nls_NR_kup, MM_,K980,nls_RR_kup, MM_);
     end if;
  --------------------------------------
  end if;
end PAY_SPM;
/
show err;

PROMPT *** Create  grants  PAY_SPM ***
grant EXECUTE                                                                on PAY_SPM         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_SPM.sql =========*** End *** =
PROMPT ===================================================================================== 
