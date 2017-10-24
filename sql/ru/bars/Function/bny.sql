
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/bny.sql =========*** Run *** ======
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.BNY (mode_ int ) RETURN number IS
  sTmp_ varchar2(80);
  kod_    number ;
  kol_    number ;
  nom_    number ;
  cena1_  number ;
  cena2_  number ;
  cenaf1_ number ;
  cenaf2_ number ;

  ---------------
  NOMI_   number :=0;
  KUPM_   number :=0;
  PDVM_   number :=0;
  DEBM_   number :=0;
  KUPF_   number :=0;
  PDVF_   number :=0;
  DEBF_   number :=0;
  PDV_    number :=0;
  PROD_   number :=0;
  DOX_    number :=0;
  S_      number :=0 ;
/*
05/05/2012 EAY Створена функцiя по аналогiї з BNY
           для продажу пам'ятних юв?лейних монет, що мають карбованцевий
           ном?нал ? не є засобом платежу

10-11-2010 Sta Балансировка разницы округлений на деб.задолженность
              --2.BMU Дебитор-Моне(for BNY)--D:2909/23  K:3500/07

08-11-2010 Sta  Отриц.сумма

--Цена приобретения монеты	 500,00	 cena1
--Цена приобретения ее футляра	  10,00  cenaf1
--Номинал монеты 		  20,00	 nom_mon
--Цена продажи монеты 		1421,00	 cena2
--Цена продажи ее футляра	  10,00	 cenaf2

1. Перераховано кошти - ПРЕДОПЛАТА МОНЕТ
Дебет 		Кредит		Сумма
3906/2		3900		500+10=510 ( cena1+ cenaf1 )

2. Оприбутковано - ПРИЕХАЛИ МОНЕТЫ
Дебет 		Кредит		Сумма
1001		3906/2		20,00	Номинал= nom_
3500/07		3906/2		400,00	дебитор= cena1+ PDVM-nom
3400/19		3906/2		8,33	футляр = cenaf1 - PDVF
3522/51		3906/2		81,67	ПДВ    = PDVM   + PDVF

3. Реализация монеты с футляром
N TT    Дебет 		Кредит		Сумма
0.BNY    1001		2909/23		1431,00	          = cena2  + cenaf2
3.BM3   2909/23	        3622/51		235,17	ПДВ 	  = [(cena2+cenaf2-nom)/6]
4.BM4   2909/23         6399/14		767,50	Доход     = банка
1.BMC   2909/23         1001		20,00	Номинал   = nom
5.BMF   2909/23         3400/19		8,33	Дебитор-ф = cenaf1 - PDVF
2.BMU   2909/23         3500/07		400,00	Дебитор-M = cena1  + PDVM-nom



*/
begin
  -- функция разных вычислений для операции BNY
  begin
     select value into sTmp_ from operw  where ref=gl.aREF and tag ='BM__C';
     kod_ := Nvl(to_number(sTmp_),0);

     select value into sTmp_ from operw  where ref=gl.aREF and tag ='BM__K';
     kol_ := Nvl(to_number(sTmp_),0);

     select s into s_ from oper  where ref=gl.aREF ;

     select Nvl(nom_mon,0),Nvl(cena2,0),Nvl(cenaf2,0),Nvl(cena1,0),Nvl(cenaf1,0)
     into       nom_ ,         cena2_,      cenaf2_,      cena1_  ,    cenaf1_
     from  v_MON3  where kod=kod_;

     --1.BMC Номинал(for BNY)     --D:2909/23  K:1001      20,00= nom
     NOMI_  := nom_  *100*kol_    ;
     NOMI_  := greatest(NOMI_,0)  ;
     ----------------------------------------
     --2.BMU Дебитор-Моне(for BNY)--D:2909/23  K:3500/07  400,00= cena1+PDVM-nom
     KUPM_  := (cena1_-nom_)*100*kol_ ;
     PDVM_  := round(KUPM_/6,0)   ;
     DEBM_  := KUPM_ - PDVM_      ;
     DEBM_  := greatest(DEBM_,0)  ;
     ----------------------------------------
     --5.BMF Дебитор-Футл(for BNY)--D:2909/23  K:3400/19    8,33=cenaf1-PDVF
     KUPF_  := (cenaf1_)*100*kol_ ;
     PDVF_  := round(KUPF_/6,0)   ;
     DEBF_  := KUPF_ - PDVF_      ;
     DEBF_  := greatest(DEBF_,0)  ;
     ----------------------------------------
     --3.BM3 ПДВ загальне(for BNY)--D:2909/23  K:3622/51  235,17=[(cena2+cenaf2-nom)/6]
     PROD_  := (cena2_+cenaf2_-nom_)*100*kol_;
     PDV_   := round( PROD_ /6,0) ;
     PDV_   := greatest(PDV_, 0)  ;
     ----------------------------------------
     --4.BM4 Торг.рез.(for BNY)   --D:2909/23  K:6399/14  767,50 =
     DOX_   := PROD_ - DEBM_ - DEBF_ -PDV_;
     DOX_   := greatest(DOX_, 0)  ;
     ----------------------------------------

     If mode_= 1 then Return NOMI_; end if;
     If mode_= 2 then
        DEBM_:= DEBM_ + (S_ - NOMI_ - DEBM_ - DEBF_ - PDV_ - DOX_);
        Return DEBM_;
     end if;
     If mode_= 5 then Return DEBF_; end if;
     if mode_= 3 then Return PDV_ ; end if;
     If mode_= 4 then Return DOX_ ; end if;

  EXCEPTION  WHEN NO_DATA_FOUND THEN null;
  end;
  return S_;
end BNY;
/
 show err;
 
PROMPT *** Create  grants  BNY ***
grant EXECUTE                                                                on BNY             to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on BNY             to PYOD001;
grant EXECUTE                                                                on BNY             to WR_ALL_RIGHTS;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/bny.sql =========*** End *** ======
 PROMPT ===================================================================================== 
 