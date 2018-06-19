
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/cc_o_nls_ext.sql =========*** Run *
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.CC_O_NLS_EXT 
  (bal_     in varchar2,  
   RNK_     in int,
   sour_    in int,
   ND_      in int,
   kv_      in int,
   tip_bal_ in varchar2,
   tip3_    in varchar2, -- Тип Искомого счета
   PROD_    in varchar2,
   TT_      in out varchar2
  )
RETURN number IS

 -- 08.06.2018 Sta  Уточнения от  Вікторія Семенова <viktoriia.semenova@unity-bars.com>

  ID_  int    := 0;   -- id проц карточки
  ACC_ number :=null ; -- возвращаем 
  a2 accounts%rowtype;
  kk cck_ob22%rowtype;
  a6 accounts%rowtype;

BEGIN
   TT_     := substr( rtrim( ltrim(nvl(TT_,'%%1'))),1,3);
   A2.TIP  := rtrim ( ltrim( tip_bal_));  -- тип базового счета  

   if tip3_ like 'SD_' then  
      ID_ := nvl(to_number(ltrim(substr(tip3_,3,1))) ,0);  
   end if;

   ---- 1
   IF tip3_   ='SN ' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.kv=kv_ and a.tip='SN ' and a.dazs is null );
   ELSIF tip3_='SK0' THEN select max(acc)   into acc_ from accounts where  acc=(select min(a.acc) from accounts a,nd_acc n where a.acc=n.acc and n.nd=nd_ and a.tip='SK0' and a.dazs is null);
   ELSIF tip3_='SN8' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='SN8' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9N' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9N' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ELSIF tip3_='S9K' THEN select max(a.acc) into acc_ from accounts a, nd_acc n where a.tip='S9K' and a.kv=kv_ and a.dazs is null and a.acc=n.acc and n.nd=ND_ and rownum=1;
   ElsIf tip3_ like 'SD_' then    ------------------------Счета 6 кл====
      ----------------2
      Begin
         -- 3   ОБЩИЙ Счет доходов по пене
         IF ID_ = 2 and ( A2.tip in ('SP','SL','SPN','SLN','SK9','SN8') or A2.tip is null)  THEN
            select a.acc ,'%%1'   into A6.ACC, tt_   from accounts a where a.tip='SD8' and a.nbs='8006' and a.kv=KV_    and rownum=1;
         Else -- Остальное
            select substr(prod,1,4), substr(prod,5,2), branch   into  a2.NBS, a2.OB22, a2.Branch from cc_deal where nd = nd_;
            select * into kk from cck_ob22 where nbs = A2.NBS and ob22 = A2.OB22 ;
            A6.NBS := null ; A6.OB22:= Null ; A6.Branch := Substr( A2.branch, 1, 15 ); 

            -- 4 Счет доходов для комиссии многоразовой  (вызывается при открытии счета с типом SK0),  в т.ч Для гарантий которые введены в Ощадбанке в КП
            IF ID_ = 2 and bal_ = '8999' and cck_ui.check_product_6353(prod_) = 0   THEN
               If A2.NBS like '9%' then   A6.NBS  := '6518'    ;
               else                       A6.NBS  := '6511'    ;
               end If ;                   A6.Ob22 := kk.SD_SK0 ;

            ELSIF ID_ = 0 and A2.tip in ('SL','S9N','S9K')                          THEN A6.NBS := '8990' ; A6.ob22 := '00'       ;  --- Счет доходов для сомнительных(внебаланс)
            ELSIF ID_ = 0 and (substr(bal_,1,1) = '9' or A2.tip = 'CR9')            THEN A6.NBS := '6518' ; A6.ob22 := kk.SD_9129 ;  --- Счет доходов для ком 9129
            ELSIF ID_ = 4                                                           THEN A6.NBS := '6510' ; A6.ob22 := kk.SD_SK4  ;  --- Дострокове погашення
            Else   ---------------------------------------------------------------------------------------------------------- ПРОЦЕНТНЫЕ/амортизац.доходы
               -- 5 
               If    A2.NBS =    '2010'  then A6.NBS := '6022' ; --  ЮО*Корзина № 1*Кредити, що надані за операціями репо
               elsIf A2.NBS =    '2020'  then A6.NBS := '6023' ; --  ЮО*Корзина № 1*Кредити, що наданi за врахованими векселями
               elsIf A2.NBS =    '2030'  then A6.NBS := '6024' ; --  ЮО*Корзина № 1*Вимоги, що придбанi за операцiями факторингу 
               elsIf A2.NBS =    '2040'  then A6.NBS := '6030' ; --  ЮО*Корзина № 4*кредити за операцўями репо 
               elsIf A2.NBS =    '2041'  then A6.NBS := '6031' ; --  ЮО*Корзина № 4*кредити,що наданў за врахованими векс 
               elsIf A2.NBS =    '2042'  then A6.NBS := '6032' ; --  ЮО*Корзина № 4*вимоги за операцўями факторингу 
               elsIf A2.NBS =    '2043'  then A6.NBS := '6033' ; --  ЮО*Корзина № 4*кредити в поточну дўяльнўсть 
               elsIf A2.NBS =    '2044'  then A6.NBS := '6034' ; --  ЮО*Корзина № 4*кредити за фўнансовим лўзингом
               elsIf A2.NBS =    '2045'  then A6.NBS := '6035' ; --  ЮО*Корзина № 4*ўпотечнў кредити 
               elsIf A2.NBS =    '2063'  then A6.NBS := '6025' ; --  ЮО*Корзина № 1*Кредити в поточну діяльність
               elsIf A2.NBS =    '2071'  then A6.NBS := '6026' ; --  ЮО*Корзина № 1*Фінансовий лізинг (оренда)
               elsIf A2.NBS =    '2083'  then A6.NBS := '6027' ; --  ЮО*Корзина № 1*Iпотечнi кредити
               ----------------------------------------------------------------------------------------
               ElsIf A2.NBS =    '2103'  then A6.NBS := '6040' ; --  ОРГ*Корзина № 1*Кредити, що надані ОРГ ДЕРЖ ВЛАДИ
               elsIf A2.NBS =    '2113'  then A6.NBS := '6041' ; --  ОРГ*Корзина № 1*Кредити, що надані ОРГ МІСЦ ВДАДИ
               elsIf A2.NBS =    '2123'  then A6.NBS := '6042' ; --  ОРГ*Корзина № 1*Iпотечнi кредити, що наданi ОРГ ДЕРЖ ВЛАДИ 
               elsIf A2.NBS =    '2133'  then A6.NBS := '6043' ; --  ОРГ*Корзина № 1*Iпотечнi кредити, що наданi ОРГ МІСЦ ВДАДИ
               elsIf A2.NBS =    '2140'  then A6.NBS := '6044' ; --  ОРГ*Корзина № 4*Кредити, що надані ОРГ ДЕРЖ ВЛАДИ         
               elsIf A2.NBS =    '2141'  then A6.NBS := '6045' ; --  ОРГ*Корзина № 4*Кредити, що надані ОРГ МІСЦ ВДАДИ          
               elsIf A2.NBS =    '2142'  then A6.NBS := '6046' ; --  ОРГ*Корзина № 4*Iпотечнi кредити, що наданi ОРГ ДЕРЖ ВЛАДИ
               elsIf A2.NBS =    '2143'  then A6.NBS := '6047' ; --  ОРГ*Корзина № 4*Iпотечнi кредити, що наданi ОРГ МІСЦ ВДАДИ
               ----------------------------------------------------------------------------------------
               ElsIf A2.NBS =    '2203'  then A6.NBS := '6052' ; --  ФО*Корзина № 1*Кредити на поточні потреби
               elsIf A2.NBS =    '2211'  then A6.NBS := '6053' ; --  ФО*Корзина № 1*Фiнансовий лiзинг (оренда)
               elsIf A2.NBS =    '2220'  then A6.NBS := '6054' ; --  ФО*Кредити, що надані за врах.векселями
               elsIf A2.NBS =    '2233'  then A6.NBS := '6055' ; --  ФО*Iпотечнi кредити
               elsIf A2.NBS =    '2240'  then A6.NBS := '6060' ; --  ФО*Корзина № 4*кредити на поточнў потреби 
               elsIf A2.NBS =    '2241'  then A6.NBS := '6061' ; --  ФО*Корзина № 4*кредити за фўнансовим лўзингом (орендою) 
               elsIf A2.NBS =    '2242'  then A6.NBS := '6062' ; --  ФО*Корзина № 4*кредити, що наданў за врахованими вексел
               elsIf A2.NBS =    '2243'  then A6.NBS := '6063' ; --  ФО*Корзина № 4*ўпотечнў кредити
               ----------------------------------------------------------------------------------------
               elsIf A2.NBS =    '2303'  then A6.NBS := '6070' ; --  ЮО*Корзина № 2*Кредити в поточну діяльність
               elsIf A2.NBS =    '2301'  then A6.NBS := '6076' ; --  ЮО*Корзина № 5*Кредити в поточну діяльність
               elsIf A2.NBS =    '2310'  then A6.NBS := '6071' ; --  ЮО*Корзина № 2*Кредити, що наданў за операцўями репо

               elsIf A2.NBS =    '2311'  then A6.NBS := '6071' ; --  ЮО*Корзина № 5*Кредити, що наданў за операцўями репо
               elsIf A2.NBS =    '2321'  then A6.NBS := '6072' ; --  ЮО*Корзина № 5*Кредити, що наданў за врахованими векселями
               elsIf A2.NBS =    '2331'  then A6.NBS := '6077' ; --  ЮО*Корзина № 5*за операцўями факторингу
               elsIf A2.NBS =    '2341'  then A6.NBS := '6074' ; --  ЮО*Корзина № 5*Фўнансовий лўзинг
               elsIf A2.NBS =    '2320'  then A6.NBS := '6072' ; --  ЮО*Корзина № 2*Кредити, що наданў за врахованими векселями
               elsIf A2.NBS =    '2330'  then A6.NBS := '6073' ; --  ЮО*Корзина № 2*за операцўями факторингу
               elsIf A2.NBS =    '2340'  then A6.NBS := '6074' ; --  ЮО*Корзина № 2*Фўнансовий лўзинг

               elsIf A2.NBS =    '2353'  then A6.NBS := '6075' ; --  ЮО*Корзина № 2*ўпотечнў кредити
               elsIf A2.NBS =    '2351'  then A6.NBS := '6078' ; --  ЮО*Корзина № 5*ўпотечнў кредити
               elsIf A2.NBS =    '2360'  then A6.NBS := '6080' ; --  ОРГ*Корзина № 2*Кредити  ДЕРЖ 
               elsIf A2.NBS =    '2361'  then A6.NBS := '6084' ; --  ОРГ*Корзина № 5*Кредити  ДЕРЖ 
               elsIf A2.NBS =    '2362'  then A6.NBS := '6081' ; --  ОРГ*Корзина № 2*Ўпотечнў Кредити  ДЕРЖ 
               elsIf A2.NBS =    '2363'  then A6.NBS := '6086' ; --  ОРГ*Корзина № 5*Ўпотечнў Кредити  ДЕРЖ 
               elsIf A2.NBS =    '2370'  then A6.NBS := '6082' ; --  ОРГ*Корзина № 2*Кредити  МІСЦ 
               elsIf A2.NBS =    '2371'  then A6.NBS := '6085' ; --  ОРГ*Корзина № 5*Кредити  МІСЦ 
               elsIf A2.NBS =    '2372'  then A6.NBS := '6083' ; --  ОРГ*Корзина № 2*Ўпотечнў Кредити МІСЦ 
               elsIf A2.NBS =    '2373'  then A6.NBS := '6087' ; --  ОРГ*Корзина № 5*Ўпотечнў Кредити МІСЦ 
               elsIf A2.NBS =    '2380'  then A6.NBS := '6096' ; --  ОРГ*Корзина № 3* Кредити ДЕРЖ 
               elsIf A2.NBS =    '2381'  then A6.NBS := '6096' ; --  ОРГ*Корзина № 3* Кредити МІСЦ 
               elsIf A2.NBS =    '2382'  then A6.NBS := '6096' ; --  ОРГ*Корзина № 3* Ўпотечнў кредити ДЕРЖ 
               elsIf A2.NBS =    '2383'  then A6.NBS := '6096' ; --  ОРГ*Корзина № 3* Ўпотечнў кредити МІСЦ 
               elsIf A2.NBS =    '2390'  then A6.NBS := '6090' ; --  ЮО*Корзина № 3*Кредити в поточну дўяльнўсть
               elsIf A2.NBS =    '2391'  then A6.NBS := '6091' ; --  ЮО*Корзина № 3*Кредити за операцўями репо
               elsIf A2.NBS =    '2392'  then A6.NBS := '6092' ; --  ЮО*Корзина № 3*Кредити, що наданў за врахованими векс
               elsIf A2.NBS =    '2393'  then A6.NBS := '6093' ; --  ЮО*Корзина № 3*Вимоги, що придбанў за операцўями факт
               elsIf A2.NBS =    '2394'  then A6.NBS := '6094' ; --  ЮО*Корзина № 3*Фўнансовий лўзинг (оренда)
               elsIf A2.NBS =    '2395'  then A6.NBS := '6095' ; --  ЮО*Корзина № 3*Ўпотечнў кредити
               ------------------------------------------------------------------------------------------
               elsIf A2.NBS =    '2401'  then A6.NBS := '6104'  ; --  ФО*Корзина № 5*Кредити на поточнў потреби
               elsIf A2.NBS =    '2403'  then A6.NBS := '6100'  ; --  ФО*Корзина № 2*Кредити на поточнў потреби
               elsIf A2.NBS =    '2410'  then A6.NBS := '6101'  ; --  ФО*Корзина № 2*Фўнансовий лўзинг (оренда)
               elsIf A2.NBS =    '2411'  then A6.NBS := '6105'  ; --  ФО*Корзина № 5*Фўнансовий лўзинг (оренда)    
               elsIf A2.NBS =    '2420'  then A6.NBS := '6102'  ; --  ФО*Корзина № 2*Кредити, що наданў за врахованими векселя
               elsIf A2.NBS =    '2421'  then A6.NBS := '6106'  ; --  ФО*Корзина № 5*Кредити, що наданў за врахованими векселя
               elsIf A2.NBS =    '2431'  then A6.NBS := '6107'  ; --  ФО*Корзина № 5*Ўпотечнў кредити
               elsIf A2.NBS =    '2433'  then A6.NBS := '6103'  ; --  ФО*Корзина № 2*Ўпотечнў кредити
               elsIf A2.NBS =    '2450'  then A6.NBS := '6110'  ; --  ФО*Корзина № 3*Кредити на поточнў потреби
               elsIf A2.NBS =    '2453'  then A6.NBS := '6113'  ; --  ФО*Корзина № 3*Ўпотечнў кредити
               end if ; --- 5 
               ------------------------------------------------------------------------------------------
               If    KV_ = gl.baseval and ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_M ;   --Дисконт грн
               ElsIf                      ( substr(bal_,4,1)= '6' OR bal_ = '3648')   THEN A6.OB22 := kk.SD_J ;   --Дисконт вал
               ElsIf KV_ = gl.baseval                                                 THEN A6.OB22 := kk.SD_N ;   --нач.проц грн
               Else                                                                        A6.OB22 := kk.SD_I ;   --нач.проц вал
               end if ;

            End if ; --4 Счет доходов для комиссии многоразовой  (вызывается при открытии счета с типом SK0),  в т.ч Для гарантий которые введены в Ощадбанке в КП

         end if;  -- 3   ОБЩИЙ Счет доходов по пене
         select acc into ACC_ from accounts where nls = NBS_OB22_BRA ( A6.NBS, A6.OB22, a6.BRANCH );
      exception when no_data_found then null;
      end;  ---2

   end if;  -- 1    ---tip3_   ='SN '

   RETURN ACC_;

END CC_O_NLS_EXT;
/
 show err;
 
PROMPT *** Create  grants  CC_O_NLS_EXT ***
grant EXECUTE                                                                on CC_O_NLS_EXT    to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on CC_O_NLS_EXT    to RCC_DEAL;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/cc_o_nls_ext.sql =========*** End *
 PROMPT ===================================================================================== 
 