CREATE OR REPLACE PACKAGE BARS.FIN_DEB IS  G_HEADER_VERSION  CONSTANT VARCHAR2(64)  :=  'ver.1.2  30.10.2018' ;
------------------------------------------------------------------
/*   ФИНАНСОВАЯ ДЕБИТОРКА
30.10.2018 Sta Функція побудови платіжного дня DAT_PL по № дня в поточному місяці, в тому числі від`ємне число.

25.09.2018 Олексій Тарасенко <oleksii.tarasenko@unity-bars.com>  Дефолтне значення параметру TERM_DAY
31.07.2018 Sta - На базе заявки COBUMMFO-7564 Перенесення не сплачених нарахованих доходів за послуги інкасації на прострочені доходи
                 погодивши з Демкович МС,
                 зроблено універсальну функцію "Винесення на ПРОСТРОЧЕНІ залишків ФІН.ДЕБ." (proc SP)  та погашення фін.деб ( в першу чегру простроч) ( proc PAY)
                 Для початкової демонстрації її розміщено ав АРМ  $RM_BVBB ="АРМ Бек-офісу" , це можна змінити
                 В параметрах виклику:
       1) Модуль (або пусто, це без фильтру на модуль)  - Довідник FIN_DEBM - ваша заявка - це модуль з кодом = 6
              0  Поза модулями
              1  MONEX. Системи переводів
              2  КП ЮО
              3  КП ФО
              4  Абонплата
              5  РКО
              6  Інкасація (*) = На базе заявки COBUMMFO-7564
              7  БПК WAY4
              8  Цінні папери
       2) Продукт (або пусто,це без фильтру на Бал+Об22)
       3) РНК_кл (або пусто, це без фільтру на РНК клієнта-дебітора)
              День просрочки - це дод.рекв рах.фін.деб з тегом =TERM_DAY =Термін(день міс) для сплати %% та комісій
              Для централ.інкасації він заповнюється через довідник, та запям`ятовується автоматично як дод.реквізит.
              Рах.простроч.фін/деб з типом 'OFR' відкриваються автоматично (за необхідності)  та запям`ятовуються в парі з основним рах. фін/деб.
              Черговість Погашення простроченої фін/деб відслідковується автоматично - при любій спробі кредитувати осн.рах.фін/деб.


01-10.09.2015 Сухова в cc_deal ЗАНОСИММ ТОЛЬКО ДОГОВОРА ДЛЯ МОДУЛЕЙ 0, 1, 6 - по договоренности с А.Билецким
                  37 разделено на : 137=Банки, 237=ЮЛ, 337=ФЛ
           Протокол ош.
*/

function DAT_PL(p_DatB date, p_Day int  ) return date ;  -- Функція побудови платіжного дня DAT_PL по № дня в поточному місяці, в тому числі від`ємне число.

PROCEDURE SP( p_mode     int,  -- модуль фин.деб
              p_NBS_ob22 varchar2 , -- похож на ...
              p_Rnk      accounts.RNK%type   -- рег № клиента
              ) ;  --------------------------------------------------------------- Процедура выноса на просрочку фин.дебиторки - перечень ее счетов = PRVN_FIN_DEB
PROCEDURE PAY
            (flg_ SMALLINT,  -- флаг оплаты
             ref_ INTEGER,   -- референция
            VDAT_ DATE,      -- дата валютировния
              tt_ CHAR,      -- тип транзакции
             dk_ NUMBER,    -- признак дебет-кредит
             kv_ SMALLINT,  -- код валюты А
            nlsm_ VARCHAR2,  -- номер счета А
              sa_ DECIMAL,   -- сумма в валюте А
             kvk_ SMALLINT,  -- код валюты Б
            nlsk_ VARCHAR2,  -- номер счета Б
              ss_ DECIMAL    -- сумма в валюте Б
             ) ;             ----------------------------------------Вызывается из PAYTT

---================================================================
PROCEDURE Del_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) ;  --Процедура "Изъять счет"
PROCEDURE Ins_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) ;  --Процедура "Добавить счет"
PROCEDURE Upd_nd  ( p_ND number, p_CC_ID varchar2, p_SDATE date, p_WDATE date ) ;  --обновить гл.реквизыты ДДЗ
--------------------------------------------------------------------------
------------------------------------------------------------
function  Frot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number) return varchar2 ; --формирование протокала  по 1 счету
PROCEDURE prot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number, p_nd OUT number, p_err OUT  varchar2 ); --формирование протокала  по 1 счету
PROCEDURE prot   ( p_mod int, p_prod varchar2 ) ;  --формирование протокала  ош
------------------------------------------------------------
function sum_mod(p_mod int, p_prod varchar2, p_kv int ) return number ;
-------------------------------------------------------------
function header_version return varchar2;
function body_version   return varchar2;
-------------------

END FIN_DEB;
/


CREATE OR REPLACE PACKAGE BODY BARS.FIN_DEB IS  G_BODY_VERSION  CONSTANT VARCHAR2(64)  :=   'ver.2.1  30.10.2018';

/*     ФИНАНСОВCOВАЯ ДЕБИТОРКА
07.12.2018 SP Обмеження винесення на прострочку рахунків NBS_P IS NULL: NBS_N=NBS_P.
30.10.2018 Sta Функція побудови платіжного дня DAT_PL по № дня в поточному місяці, в тому числі від`ємне число.
31.07.2018 Sta - На базе заявки COBUMMFO-7564 Перенесення не сплачених нарахованих доходів за послуги інкасації на прострочені доходи
                 погодивши з Демкович МС,
                 зроблено універсальну функцію "Винесення на ПРОСТРОЧЕНІ залишків ФІН.ДЕБ." (SP) та погашення фін.деб ( в першу чегру простроч) PAY

21.10.2015 Протокол и одновременная правка ( ош по 3578.05 ОВЕРД)
05.10.2015 Сухова Уникальній № дог ФДЗ
02.10.2015 Сухова в cc_deal ЗАНОСИММ ТОЛЬКО ДОГОВОРА ДЛЯ МОДУЛЕЙ 0, 1, 6 - по договоренности с А.Билецким
                  37 разделено на : 137=Банки, 237=ЮЛ, 337=ФЛ
           Протокол ош.
*/
-------------------------------------------------------------------------------------------------------------------------------
function DAT_PL(p_DatB date, p_Day int  ) return date  IS  -- Функція побудови платіжного дня DAT_PL по № дня в поточному місяці, в тому числі від`ємне число.
  l_DatB  date := NVL( p_DatB, gl.Bdate ) ;
  l_DAT   date ;
  l_Dat01 date ;
  l_Dat31 date ;
  x_Day   int  ;
begin

  l_Dat01 := trunc    (l_DatB, 'MM'       ) ;
  l_Dat31 := last_day (l_DatB             ) ;
  x_Day   := to_number(to_char(l_Dat31,'DD')) ;

  If    p_Day  < -x_Day   then  l_DAT := l_Dat01  ;
  ElsIf p_Day  < 0        then  l_DAT := l_Dat31 +1 + p_Day ; 
  ElsIf p_Day  = 0        then  l_DAT := l_Dat01  ;
  ElsIf p_Day <=  x_Day   then  l_Dat := l_Dat01 -1 + p_Day ;
  elsIf p_Day >   x_Day   then  l_DAT := l_Dat31  ;
  end if ;

  RETURN l_DAT ;

end DAT_PL;

PROCEDURE SP ( p_mode     int,  -- модуль фин.деб
               p_NBS_ob22 varchar2 , -- похож на ...
               p_Rnk      accounts.RNK%type   -- рег № клиента
               ) is  --------------------------------------------------------------- Процедура выноса на просрочку фин.дебиторки - перечень ее счетов = PRVN_FIN_DEB

   l_NBS  varchar2(5) ;
   l_ob22 accounts.ob22%type;

   DD_ varchar2(2);
   Dat31_ date ;
   Dat01_ date ;
   Dat05_ date ;
   Dat06_ date ;
   SP accounts%rowtype ; -- просроч.комиссия
   PP FIN_DEBT%rowtype ;
   p4_ int ;
   Ref_  oper.Ref%type ;
   NAZN_ oper.Nazn%type;
   kol_ int := 0 ;
   okpo_ customer.okpo%type;
   Fdat_ saldoa.Fdat%type;

begin

   l_NBS  := Substr( p_NBS_ob22,1,4) ||'%';
   l_ob22 := Substr( p_NBS_ob22,5,2) ;

   for ss in (select f.ACC_SP , a.*
              from (select x.* 
                    from accounts x, FIN_DEBT z 
                    where NVL(p_mode,z.MOD_ABS) = z.MOD_ABS 
                      and NVL(p_Rnk ,x.RNK    ) = x.RNK  
                      and NVL(l_ob22, x.ob22  ) = x.ob22 and x.nls like l_NBS
                      and x.ostc < 0 and x.ostc = x.ostb  
                      and x.nbs||x.ob22 = z.NBS_N/*Tarasenko =>*/
                      and z.nbs_p is not null
                      and z.nbs_n <> z.nbs_p
                   ) a,
                   PRVN_FIN_DEB f
              where a.ACC = f.acc_ss
             )
   loop

      pp.NBS_N := ss.NBS||ss.ob22 ;

      begin select * into PP from FIN_DEBT where nbs_n = pp.NBS_N  ;
      EXCEPTION WHEN NO_DATA_FOUND then goto NEXT_; ---  raise_application_error(-20100, 'НЕ Описано продукт FIN_DEBT = '|| ss.NBS||'.'||ss.ob22  ) ;
      end;

      begin select substr( trim(value),1,2)  into DD_ from accountsw where acc = SS.acc and tag = 'TERM_DAY';
      EXCEPTION WHEN NO_DATA_FOUND then           dd_ := pp.TERM_DAY ;
      end;

      Begin  Dat05_ := fin_deb.DAT_PL(p_DatB => gl.bdate, p_Day => to_number(DD_)  )  ;  -- Функція побудови платіжного дня DAT_PL по № дня в поточному місяці, в тому числі від`ємне число. 
      exception when others then dat05_ := to_date  ( '05'||to_char( gl.bdate, 'MMYYYY'), 'DDMMYYYY') ;
      end;

      Dat05_ := DAT_NEXT_U ( dat05_,  0 ) ;
      Dat06_ := DAT_NEXT_U ( dat05_, +1 ) ;
      If gl.bdate < DAT06_  then  goto NEXT_ ; end if ;

      Dat01_ := trunc (DAT05_, 'MM');
      Dat31_ := Dat01_ - 1 ;

      SS.OSTc := - Fost (SS.acc, Dat31_ ) - Fkos (SS.ACC, DAT01_, gl.Bdate);
      If SS.OSTc <= 0  THEN goto NEXT_ ; end if ;

      begin select okpo into okpo_ from customer where rnk = ss.rnk ;
      EXCEPTION WHEN NO_DATA_FOUND THEN goto NEXT_ ;
      end;

      If SS.acc_SP is null then
         If pp.NBS_P is null OR Substr(pp.NBS_P,1,4)  <> Substr(pp.NBS_N,1,4)  then goto NEXT_ ; end if;
         -- открыть счет просрочки
         sp.NLS := f_newnls (ss.acc, 'SP ', Substr(pp.NBS_P,1,4) ) ;
         SP.nms := Substr ('Просроч.'|| SS.NMS,1,38) ;
         op_reg_ex( mod_=>99, p1_=>0, p2_=>0, p3_=>ss.grp, p4_=>p4_, rnk_=>ss.rnk, nls_=>SP.nls, kv_=>ss.kv, nms_=>SP.nms, tip_=>'OFR', isp_=>SS.isp, accR_=> SS.acc_SP, tobo_=>ss.branch);
         Accreg.setAccountSParam(SS.Acc_sp, 'OB22', Substr(pp.NBS_P,5,2)  )  ;
         update PRVN_FIN_DEB set acc_sp = SS.acc_SP where acc_SS = SS.acc ;
      end if;

      begin select * into SP from accounts where acc = SS.acc_SP ;
            select max(fdat) into fdat_ from saldoa where acc = ss.acc and dos > 0 and fdat <= DAT31_ ;
      EXCEPTION WHEN NO_DATA_FOUND    THEN goto NEXT_ ;
      end;

      NAZN_ := Substr ( 'Перенесення нарахованих '|| to_char(fdat_, 'dd.mm.yyyy') || ' доходів, які не було своєчасно до '|| to_char(DAT06_, 'dd.mm.yyyy') || ' сплачено', 1, 160) ;

      kol_ := kol_ + 1;
      gl.ref (Ref_);
      gl.in_doc3 (ref_=>REF_ , tt_ =>'ASP'   ,  vob_=> 6    ,  nd_ =>to_char(Kol_),pdat_=>SYSDATE, vdat_=>gl.Bdate, dk_  => 1,
                   kv_=>ss.kv, s_  =>ss.OSTC ,  kv2_=>ss.kv ,  s2_ =>ss.ostc      ,sk_  => null  , data_=>gl.BDATE, datp_=> gl.bdate,
                nam_a_=>Substr(sp.NMS,1,38)  , nlsa_=>sp.nls, mfoa_=>gl.aMfo,
                nam_b_=>Substr(ss.NMS,1,38)  , nlsb_=>ss.nls, mfob_=>gl.aMfo,
                nazn_ =>NAZN_, d_rec_ =>null , id_a_=>okpo_ , id_b_=>okpo_  ,id_o_=>null   , sign_=>null, sos_=>1, prty_=>null, uid_=>null );
      gl.payv(0, ref_, gl.bdate, 'ASP', 1, ss.kv, SP.nls, ss.OSTC, ss.kv, ss.nls, ss.OSTC ) ;
      gl.pay (2, ref_, gl.bdate) ;

      <<NEXT_>> null;

   end loop; -- kk

end SP ;
----------------------------------------
PROCEDURE PAY
            (flg_ SMALLINT,  -- флаг оплаты
             ref_ INTEGER,   -- референция
            VDAT_ DATE,      -- дата валютировния
              tt_ CHAR,      -- тип транзакции
             dk_ NUMBER,    -- признак дебет-кредит
             kv_ SMALLINT,  -- код валюты А
            nlsm_ VARCHAR2,  -- номер счета А
              sa_ DECIMAL,   -- сумма в валюте А
             kvk_ SMALLINT,  -- код валюты Б
            nlsk_ VARCHAR2,  -- номер счета Б
              ss_ DECIMAL    -- сумма в валюте Б
             ) IS            ----------------------------------------Вызывается из PAYTT
  l_NlSD   accounts.NlS%type;  l_kvd accounts.kv%type;  l_SD number;
  l_NlSK   accounts.NlS%type;  l_kvk accounts.kv%type;  l_SK number;
  aa       accounts%ROWtype ;   -- Для просрочки
  l_OSTB   accounts.ostb%type;
begin

  If    dk_=1  THEN   l_kvd := kv_ ; l_NlSD := nlsm_; l_SD := sa_;     l_kvk := kvk_; l_NlSK := nlsk_; l_SK := ss_ ;
  elsIf dk_=0  then   l_kvd := kvk_; l_NlSD := nlsk_; l_SD := ss_;     l_kvk := kv_ ; l_NlSK := nlsm_; l_SK := sa_ ;
  else RETURN;
  end if;

  If l_Kvd = l_kvk  and l_SD >= 1 and l_SD = l_SK then
     begin select asp.ostb, asp.nls,  ass.OSTB
           into    aa.OSTB,  aa.nls,  l_OSTB
           from accounts ass, accounts asp, PRVN_FIN_DEB FF
           where  aSS.acc = FF.acc_SS  and aSS.kv   = l_kvk and aSS.NLS = l_NlSK and  -- осн.сч фин.деб
                  aSP.acc = FF.acc_SP  and aSP.ostB < 0 ;                             -- сч просроч имеет остатоk
           -- сначала погасить просрочку
           l_SD   := LEAST ( l_SD , -aa.OSTB ) ;
           gl.payv(flg_, ref_, VDAT_, 'ASG', 1, l_Kvd, l_NLSD, l_SD, l_Kvd, aa.nls, l_SD ) ;
           l_SK := l_SK - l_SD ;
           l_SD := l_SK ;
     EXCEPTION  WHEN no_data_found THEN  null;
     end;
  end if ;

  -- гасим остальное
  L_SD := LEAST ( l_SD, - l_OSTB ) ;
  If l_SD >= 1 then  gl.payv(flg_, ref_, VDAT_, TT_, 1, l_Kvd, l_NLSD, l_SD, l_Kvd, l_NLSK, l_SK ) ; end if;

  return;

END PAY ;

----------------------------------------------------

PROCEDURE Del_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) is  --Процедура "Изъять счет"
begin
  if p_acc >0 then delete from nd_acc where nd=p_nd and acc = p_acc ;
  else             delete from nd_acc where nd=p_nd and acc = (select acc from accounts where kv = p_kv and nls = p_nls) ;
  end if;
end Del_acc;
------------------------------------------------------------------------------
PROCEDURE Ins_acc ( p_nd number, p_nls varchar2  , p_kv int    , p_acc number ) is  --Процедура "Добавить счет"
  aa accounts%rowtype ;
  dd cc_deal%rowtype  ;
  cc customer%rowtype ;
  ff fin_debt%rowtype ;
  sTmp_ varchar2(200) ;
begin

  begin sTmp_ := ' Рах. НЕ знайдено !';
     if p_acc > 0 then sTmp_ := 'АСС= '||      p_acc || sTmp_; select * into aa from accounts where acc = p_acc;
     else              sTmp_ :=  p_nls ||'/'|| p_kv  || sTmp_; select * into aa from accounts where kv  = p_kv and nls = p_nls ;
     end if;
  EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
  end;

  begin sTmp_ := 'Рах.'|| aa.nls || ', RNK='|| aa.rnk || ' Ід.код='|| gl.aOkpo || ' - НЕдопустимий !';
     select * into cc from customer where rnk = aa.rnk and okpo <> gl.aOkpo ;
  EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
  end ;

  dd.vidd := cc.custtype *100 + 37 ;

  If p_nd > 0 then
     begin  sTmp_  := 'ДДЗ реф=' || p_nd || ' в портфелі ФД (vidd='|| dd.vidd || ') НЕ знайдено !' ;
        select * into dd from cc_deal where vidd = dd.vidd  and sos < 15  and nd = p_nd ;
     EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
     end ;
  else
     dd.prod:= aa.nbs||aa.ob22 ;
     begin sTmp_  := 'Нова Угода, Код продукту (від рах) ='|| dd.prod || ' НЕ є ДДЗ ! ';
           select * into ff from fin_debt where nbs_n = substr(dd.prod,1,6) and mod_abs in (0, 1, 6 )  ;
     EXCEPTION WHEN NO_DATA_FOUND    THEN  raise_application_error(  -(20203), sTmp_ );
     end ;
  end if ;
  -------------------------------
  sTmp_ := 'Рах.' || aa.nls || '/' || aa.kv || ' уже прив`язано до іншої угоди з реф. = '     ;
  begin  select d.* into dd from nd_acc n, cc_deal d where n.acc = aa.acc and n.nd = d.nd and rownum = 1;
         sTmp_:= sTmp_|| dd.nd || ', Vidd = ' || dd.vidd ;  raise_application_error(  -(20203), sTmp_ );
  EXCEPTION WHEN NO_DATA_FOUND    THEN  Null ;
  end;
  -------------------------------
  dd.vidd := cc.custtype *100 + 37 ;
  If nvl ( p_nd,0 ) = 0 then
     select bars_sqnc.get_nextval('S_CC_DEAL') into dd.ND from dual;
--   dd.cc_id :=  'FD/'||dd.prod||'/'||aa.rnk;
     dd.cc_id :=  'FD/'||aa.nls ||'/'||aa.kv;
     dd.wdate := nvl(aa.mdate,TO_DATE('31/12/2050', 'DD/MM/YYYY'));
     Insert into CC_DEAL   (ND, SOS,    CC_ID,   SDATE,    WDATE,    RNK, VIDD, LIMIT, USER_ID,    BRANCH,    PROD)
                 Values (dd.nd, 10 , dd.cc_id, aa.daos, dd.wdate, aa.rnk, dd.vidd, 0    ,  aa.isp, aa.branch, dd.prod);
  else
     sTmp_ := 'Пар/рах.'|| aa.nls   || '(' || aa.nbs   || '.' || aa.ob22  || ') НЕдопустимі для даного продукту ДДЗ : ' ||
                           ff.nbs_n || ' ' || ff.nbs_p || ' ' || ff.nbs_k ;
     If (aa.nbs|| aa.ob22)  NOT in  ( ff.nbs_n, nvl(ff.nbs_p, ff.nbs_n) , nvl(ff.nbs_k, ff.nbs_n) )  then
        raise_application_error(  -(20203), sTmp_ );
     end if;
  end if ;
  ---------------------------------------------------
  insert into nd_acc (nd,acc) values (dd.nd, aa.acc);
  ---------------------------------------------------
  if aa.ostc < 0 and  (aa.nbs||aa.ob22) = ff.nbs_p  then
     update cc_deal set sos = 13 where nd = dd.nd ;
  end if;

end Ins_acc;

----------------------------------------------------------------------------
PROCEDURE Upd_nd  ( p_ND number, p_CC_ID varchar2, p_SDATE date, p_WDATE date ) is  --обновить гл.реквизыты ДДЗ
begin
   update cc_deal set cc_id = p_cc_id, SDATE = p_SDATE , WDATE = p_WDATE  where nd = p_nd;
   if SQL%rowcount = 0 then  raise_application_error(  -(20203), 'ДДЗ реф=' || p_nd || ' НЕ знайдено  !' );  end if ;
end Upd_nd   ;
-----------------

function  Frot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number) return varchar2 is --ТОЛЬКО ПРОВЕРКА.формирование протокала  по 1 счету
   l_kol  number  ; l_nd number ; l_err varchar2 (100) := null; l_vidd number;
begin
   select count(*), max(nd) into l_kol, L_nd from nd_acc where acc = p_acc;
   If l_kol > 1 then L_err := '1.1) входить більше 1 разу по ND_acc';   goto RET_ ;   end if;
   If l_kol = 1 then
      --0 Поза модулями/cc_deal
      --1 MONEX. Системи переводів/cc_deal
      --2 КП ЮО
      --3 КП ФО
      --6 CIN. Центр.Інкасація (тільки в ГОУ)/cc_deal
      begin select vidd into l_vidd from cc_deal where nd = L_nd ;
            if l_vidd in  (  1,  2,  3) and  p_mod_abs = 2 OR
               l_vidd in  ( 11, 12, 13) and  p_mod_abs = 3 OR
               l_vidd in  (137,237,337) and  p_mod_abs in (0,1,6) then  null;
            else  L_err := '1.2) CC_DEAL.vidd='||l_vidd ||' не мод.0,1,2,3,6' ;
            end if;
            goto RET_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null ;
      end;
   end if;

   --4 Абонплата/ And
   select count(*),     max(nd) into l_kol, L_nd from e_deal where acc36 = p_acc ;
   If l_kol > 1         then  L_err := '4.1) входить більше 1 разу по E_deal';         goto  RET_ ;  end if;
   If l_kol = 1 then
      If p_mod_abs != 4 then  L_err := '4.2) входить в E_DEAL, але не є мод 4' ; else  goto  RET_ ;  end if;
   end if;

   --5 РКО/And
   select count(*),     max(nd) into l_kol, L_nd from rko_lst where acc1 = p_acc ;
   If l_kol > 1         then  L_err := '5.1) входить більше 1 разу по RKO_LST';        goto  RET_ ;  end if;
   If l_kol = 1 then
      If p_mod_abs != 5 then  L_err := '5.2) входить в RKO_LST, але не є мод 5' ; else goto  RET_ ;  end if;
   end if;

   --7 БПК WAY4 (есть индекс)
   begin select    nd into       L_nd from W4_acc where acc_3570 = p_acc ;
         If p_mod_abs != 7 then  L_err := '7.2) входить в W4_acc, але не є мод 7'; else   goto RET_ ;  end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
             when others  then
                  if sqlcode= -01422 then L_err := '7.1) входить більше 1 разу по W4_acc' ; goto RET_ ;
                  else raise;
                  end if;
   end;

   begin select '0.0) Власний Ід.код='|| gl.aOkpo into L_err from customer where rnk = p_rnk and okpo = gl.aOkpo;
   EXCEPTION WHEN NO_DATA_FOUND THEN                   L_err := '0.1) НЕ в CC_DEAL,EC_DEAL,RKO_LST,W4_ACC';
   end;

   <<RET_>> null;
   RETURN substr('000000000000000000000000000'||l_nd, -20)|| l_err ;

end Frot1;
---------
PROCEDURE prot1 ( p_mod_abs int, p_prod varchar2, p_acc int, p_rnk number, p_nd OUT number, p_err OUT  varchar2 ) is --ИСПРАВЛЕНИЕ и ПРОВЕРКА 2формирование протокала  по 1 счету
   l_kol0  int :=0 ; l_kol4 int:=0 ;  l_kol5 int :=0 ;
   l_nd    number  ; l_err varchar2 (100) := null; l_vidd number;
   l_prodP varchar2(10);
begin

   select count(*), max(nd) into l_kol0, L_nd from nd_acc where acc = p_acc;

   If l_kol0 > 1 then
      If p_mod_abs in (0,1,6) then
         l_kol0 := 1 ;
         for z in (select * from nd_acc where acc = p_acc and nd <> l_nd )
         loop delete from nd_acc where nd = z.nd ; end loop   ;
      else    L_err := '1.1) входить більше 1 разу по ND_acc' ; goto  RET_ ;
      end if;
   end if;

   If l_kol0 = 1 then
      --0 Поза модулями/cc_deal
      --1 MONEX. Системи переводів/cc_deal
      --2 КП ЮО
      --3 КП ФО
      --6 CIN. Центр.Інкасація (тільки в ГОУ)/cc_deal
      begin select vidd into l_vidd from cc_deal where nd = L_nd ;
            if l_vidd in  (  1,  2,  3) and  p_mod_abs = 2 OR
               l_vidd in  ( 11, 12, 13) and  p_mod_abs = 3 OR
               l_vidd in  (137,237,337) and  p_mod_abs in (0,1,6) then  null;
            else  L_err := '1.2) CC_DEAL.vidd='||l_vidd ||' не мод.0,1,2,3,6' ;
            end if;
            goto RET_ ;
      EXCEPTION WHEN NO_DATA_FOUND THEN null ;
      end;
   end if;

   -------------------------------------    4 Абонплата/ And
   select count(*),     max(nd) into l_kol4, L_nd from e_deal where acc36 = p_acc ;
   If l_kol4 > 1         then    ----------- L_err := '4.1) входить більше 1 разу по E_deal';  goto  RET_ ;
      l_kol4 := 1 ;
   end if;
   If l_kol4 = 1 then
      If p_mod_abs != 4 then  L_err := '4.2) входить в E_DEAL, але не є мод 4' ; else  goto  RET_ ;  end if;
   end if;

   ------------------------------------     5 РКО/And
   select count(*),     max(nd) into l_kol5, L_nd from rko_lst where acc1 = p_acc ;
   If l_kol5 > 1         then       ---------L_err := '5.1) входить більше 1 разу по RKO_LST';    goto  RET_ ;
      l_kol5 :=  1 ;
   end if;
   If l_kol5 = 1 then
      If p_mod_abs != 5 then  L_err := '5.2) входить в RKO_LST, але не є мод 5' ; else goto  RET_ ;  end if;
   end if;

   --7 БПК WAY4 (есть индекс)
   begin select    nd into       L_nd from W4_acc where acc_3570 = p_acc ;
         If p_mod_abs != 7 then  L_err := '7.2) входить в W4_acc, але не є мод 7'; else   goto RET_ ;  end if;
   EXCEPTION WHEN NO_DATA_FOUND THEN  null;
             when others  then
                  if sqlcode= -01422 then L_err := '7.1) входить більше 1 разу по W4_acc' ; goto RET_ ;
                  else raise;
                  end if;
   end;

   begin select '0.0) Власний Ід.код='|| gl.aOkpo into L_err from customer where rnk = p_rnk and okpo = gl.aOkpo;
         goto RET_ ;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;

   If p_mod_abs NOT in (0, 1, 6)   then
      If l_kol4 = 0 and l_kol5 = 0 then   L_err := '0.1) НЕ в CC_DEAL,EC_DEAL,RKO_LST,W4_ACC';  end if ;
      goto RET_ ;
   End if;

   If l_kol0 = 0 then
      begin
        fin_deb.Ins_acc ( p_nd => null, p_nls=>null, p_kv =>null, p_acc => p_acc);
        select nbs_p into l_prodP from fin_debT where  nbs_n = p_prod ;

        If l_prodP is not null then  select nd into l_nd from nd_acc where acc = p_acc and rownum = 1 ;
           for p in (select acc,ostc from accounts where rnk=p_rnk and nbs||ob22 = l_prodP and acc not in (select acc from nd_acc) and dazs is null)
           loop  fin_deb.Ins_acc ( p_nd => l_nd, p_nls=>null, p_kv => null, p_acc => p.acc);
                 if p.ostc < 0 then update cc_deal set sos= 13 where nd = l_nd ; end if;
           end loop;
        end if;
      EXCEPTION WHEN NO_DATA_FOUND THEN  L_err := '0.2) Ош.не исправима';   goto RET_ ;
      end ;
   End iF ;
   <<RET_>> null;
   p_nd   := l_nd ; p_err := l_err ;
   RETURN ;

end prot1;
--------

PROCEDURE prot   ( p_mod int, p_prod varchar2 ) is
  l_FROT1 varchar2 (100); l_nd number; l_err varchar2(40);
begin

  If    p_mod in (1,9)    then  execute immediate 'truncate table fin_debVY ';  -- полная очистка
  Elsif p_mod in (2)      then  delete  from fin_debVY where fin <>7 ;
  Elsif p_mod in (3)      then  delete  from fin_debVY where fin = 7 ;
  else  RETURN ; -- -- только просмотр
  end if;

logger.info('FIN_1 insert ');

  insert /*+ APPEND */  into fin_debVY ( FIN,    PROD,   KV,   NLS,   ACC,   OST ,   NMS, RNK, nd )
  select             f.mod_abs, f.nbs_n, a.kv, a.nls, a.acc, a.ostc, substr(a.nms,1,40), a.rnk, 0
  from  accounts A,
      (select * from fin_debt where p_mod=1  OR  p_mod=2 and mod_abs<>7  OR  p_mod=3 and mod_abs=7 )  F
  where A.dazs is null and a.nbs||A.ob22 = F.nbs_n ;
  commit;

logger.info('FIN_2 for k ');

  for k in ( select rowid RI, FIN,PROD,acc, rnk from  fin_debVY )
--loop  l_FROT1 := FIN_DEB.FROT1( k.FIN, k.PROD, k.acc, k.rnk) ;
  loop FIN_DEB.prot1 ( k.FIN, k.PROD, k.acc, k.rnk, l_nd,  l_err ) ;  --ИСПРАВЛЕНИЕ и ПРОВЕРКА 2формирование протокала  по 1 счету
       update fin_debVY  set nd =  l_nd, SERR = l_err where rowid = k.RI;
  end loop;

logger.info('FIN_3 finis ');

end prot      ;
------------------------------------------------------------
function sum_mod(p_mod int, p_prod varchar2, p_kv int ) return number is
 l_s number ;
begin

 If p_mod in (0, 1 ) then
-----Нет модуля   CC_DEAL --Сухова ----------------------------------
    select nvl(sum(a.ostc),0) into l_s
    from (select acc,ostc from accounts where kv = p_kv and nbs||ob22 = p_prod  ) a,
         nd_acc n,
         (select nd       from cc_deal  where vidd=37 and sos <15 )  d
    where  a.acc = n.acc and n.nd = d.nd;

 elsif p_mod in (2, 3 ) then
----- КД : CC_DEAL --Сухова ----------------------------------
    select nvl(sum(a.ostc),0) into l_s
    from (select acc,ostc from accounts where kv = p_kv and nbs||ob22 = p_prod  ) a,
         nd_acc n,
         (select nd       from cc_deal  where ( p_mod = 2 and vidd in (1,2,3)  OR  p_mod = 3 and vidd in (11,12,13) )  and sos <15 )  d
    where  a.acc = n.acc and n.nd = d.nd;


-------Абонплата E_DEAL---Кавчак------------------------------
 elsif p_mod in (4 ) then
    select nvl(sum(a.ostc),0) into l_s  from accounts a, e_deal d  where a.kv = p_kv and a.nbs||a.ob22 = p_prod  and a.acc = d.ACC36 ;

-------РКО RKO_LST--Суфтин-------------------------------
 elsif p_mod in (5 ) then
    select nvl(sum(a.ostc),0) into l_s  from accounts a, rko_lst d  where a.kv = p_kv and a.nbs||a.ob22 = p_prod  and a.acc = d.ACC1 ;

-------CIN_CUST --Суфтин+Сухова-------------------------------
 elsif p_mod in (6 ) and gl.amfo = '300465' then
     execute immediate
    'select nvl(sum(a.ostc),0) from accounts a, cin_cust d where a.kv = '|| p_kv ||' and a.nbs||a.ob22 = ''' || p_prod ||''' and a.nls = d.NLS_3578 ' into l_s;

-------БПК WAY4 --Чупахина -------------------------------
 elsif p_mod in (7 ) then
    select nvl(sum(a.ostc),0) into l_s  from accounts a, W4_ACC d  where a.kv = p_kv and a.nbs||a.ob22 = p_prod  and a.acc = d.ACC_3570 ;

 end if;

 return l_s ;

end sum_mod ;

------------------------------------------------------------
function header_version return varchar2 is begin  return 'Package header FIN_DEB '||G_HEADER_VERSION; end header_version;
function body_version   return varchar2 is begin  return 'Package body   FIN_DEB '||G_BODY_VERSION; end body_version;
--------------

---Аномимный блок --------------
begin
  null;
END FIN_DEB;

/

show error