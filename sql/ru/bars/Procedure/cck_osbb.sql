CREATE OR REPLACE PROCEDURE BARS.cck_OSBB (p_mode int, p_nd1 number) is

-- p_mode = 0 Проверка условий для существующено КДВ
-- p_mode = 1 Авторизація первинного КД ОСББ
-- p_mode = 2 Фініш       первинного КД ОСББ + Авто-Старт вторинного КД ОСББ
-- p_mode = 3 Авторизація вторинного КД ОСББ - як самостійного КД
/*
08/02/2018 LitvinSO COBUSUPABS-7041 При створенні нового договору необхідно автоматично згенерувати параметр CIG_D13 зі значенням 1
10/11/2017 LitvinSO Для p_mode = 2 с учетом на переход новый план счетов так как мы не меняем cc_deal.PROD анализируем продукт 
26/05/2017 Pivanova додано заміну коми на крапку при вичитуванні тагу S_SDI
18.11.2015 LitvinSO Реалізовано у перевіркі РНК пропускало клієнтів які відносяться до ЖБК з кодом K050 = 320 і K051 = 62.
17.11.2015 LitvinSO По зауваженням Мешко Ж. виправив по перевіркам умов не передавались данні з cc_deal і хибно впрацьовували помилки.
16.11.2015 Sta Від Мешко Ж:
   Так щоб повна вибірка кредиту спрацьовувала тільки по КД виданих до 20/11/2015
   (ElsIf -aa1.ostc >= dd1.sdog*100 then  s_Txt2 := '. Повна виборка кредиту';)

12.11.2015 Sta Отключение в финише старых ОСББ p_mode = 2 Фініш
03.11.2015 Sta
 - Закомментарила привязку 2600 к КД
 - Установила ранг = 6 для КД2
 - Установила ранг = 6 для MODE= 3

28.10.2015 Sts наконец-то дали об22
22.10.2015 Sta p_mode = 0 Проверка условий для существующено КД
22.10.2015 Sta В части-2 наследовать продукт от Части-1
21.10.2015 Sta Облегчение некоторых условий для -- p_mode = 3 Авторизація вторинного КД ОСББ - як самостійного КД
17.09.2015 LitvinSO Підправив визначення > 6 міс. : Дата dd1.sdate була пустою, переніс запит вище умови.
17.09.2015 Sta По результатам тестирования есть несколько замечаний.
1+ При формировании второго договора в случае наличия суммы невыбранного лимита, эти суммы должны быть списаны с внебаланса.
2+ Просьба добавить продуктовую проверку – грейс-период не больше 6 месяцев с даты договора.
4+ Не коректне формування  договору 2 при повній видачі кредиту (. Повна виборка кредиту).
5+ Зауваження до побудови ГПК.
3. Обязателен контроль уплаты комиссии. Настроить на Типе продукта ОСББ . Только для этого продукта.
   Контроль при видачі кредиту, щодо наявності комісії (дисконту) на рахунку дисконту (2066,3600) для кредитних ліній буде налаштовано
   на операції  видачі (КК1, КК2,…) після доведення до розробника кодів продуктів для ОСББ (2062/ОБ22, 2063/ОБ22)
   Для стандартних кредитів контроль в поточній версії ПЗ виконується.
------------------------------------------------------------------------------------------------------------
 01.09.2015 Сухова Обработка конца грейс-периода
 28.08.2015 Сухова Заменила АВто-авторизацию
 27.08.2015 Сухова Фмниш-скан по доп.рекв
 25.08.2015 Сухова p_mode = 3 Авторизація вторинного КД ОСББ - як самостійного КД
 18.08.2015 Сухова. Согласование проверок.
 15.06.2015 Sta
 Мета проекту: впровадження ОБ – кредитування об’єднань співвласників багатоквартирних будинків (ОСББ).
 --------------------
2063  09  кредити, що наданў об"їднанням спўввласникўв багатоквартирних будинкўв
2062  19  кредити, що наданў об"їднанням спўввласникўв багатоквартирних будинкўв
Потрібно (якщо Ануїтет може інсувати самостійно для ЮО) добавити
2063  хх  Ануїтет для ЮО
2062  yy  Ануїтет для ЮО
*/
  kl1 customer%rowtype ;
  nn1 nd_acc%rowtype   ; aa8 accounts%rowtype ;
  dd1 cc_deal%rowtype  ; aa1 accounts%rowtype ; ad1 cc_add%rowtype   ;  sd1 accounts%rowtype ; ii1 int_accn%rowtype;
  dd2 cc_deal%rowtype  ; aa2 accounts%rowtype ; oo1 oper%rowtype     ;  l_pl1  number        ; SumR_ number        ; SumP_ number ;
  l_datnp date         ; l_ir number          ; s_Txt1 varchar2(250) ;  s_Txt2 varchar2(250) ; nTmp_ number        ; sTmp_ varchar2(100);
  sErr varchar2(2000)  ; nlchr char(2)        := chr(13)||chr(10)    ;  s_GRAC1 varchar2(10) ; d_GRAC1 date        ;
begin

If p_mode in (0,1,2) then

   -- Конторль кiнцевої дати-1 та  кiнцевої дати-2 та
   Begin select substr(trim(txt),1,10) into s_GRAC1 from nd_txt where tag = 'GRAC1' and nd = p_nd1;
         begin d_GRAC1 := to_date( s_GRAC1, 'dd.mm.yyyy') ; exception when others then null;  end  ;
   EXCEPTION WHEN NO_DATA_FOUND THEN
         If p_mode = 2 then RETURN; end if ; ---12.11.2015 Sta Отключение в финише старых ОСББ p_mode = 2 Фініш
   end;

   If p_mode in (0, 1 ) then -- авторизация КД-1

      begin select d.* into dd1 from cc_deal d, nd_txt x where  d.vidd=2 and d.nd = p_nd1 and d.sos<15 and x.nd = d.nd and x.tag = 'I_CR9' and x.txt = '1';
      EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||           '2) не Є НЕвіднов.,НЕтранш. кредитна лінія';
      end;
      If d_GRAC1 is null OR   dd1.wdate <= d_GRAC1  OR     months_between (d_GRAC1, dd1.sdate) > 6  then
         sErr  := sErr || nlchr ||'5) Не корр./відсут/>6 міс дод.реквізит GRAC1 = '|| s_GRAC1;
      end if;

   ElsIf p_mode = 2 then   -- Фініш       первинного КД ОСББ + Авто-Старт вторинного КД ОСББ
         If d_GRAC1 is null then RETURN; end if;
         -- найти старый КД (лин) -1 .
         begin select d.* into dd1 from cc_deal  d  where d.vidd=2 and d.ndi is null and d.nd  = p_nd1 and d.sos < 15 ;
               select a.* into aa1 from accounts a, nd_acc n where a.tip = 'LIM' and a.ostc=a.ostb and a.acc = n.acc and n.nd  = dd1.nd and a.ostc < 0 ;
               s_Txt1 := 'Переведення КД з КЛ  реф='|| dd1.nd|| ' в подальший станд.ануїтет, реф=';

               If d_GRAC1 <=  gl.bdate         then
                  s_Txt2 := '. Закінчення терміну грейс-періода';

               ElsIf -aa1.ostc >= dd1.sdog*100 and  dd1.sdate < to_date ('26/11/2015', 'dd/mm/yyyy') then  -- спрацьовувала тільки по КД виданих до 20/11/2015
                  s_Txt2 := '. Повна виборка кредиту';

               Else  RETURN;
               end if;

               select * into ad1 from cc_add   where nd= dd1.nd and adds = 0 ;
               select * into ii1 from int_accn where id= 0 and acc = aa1.acc ;
         EXCEPTION WHEN NO_DATA_FOUND THEN return;
         end;
   end if;
end if;

If p_mode = 3 then
   begin select d.* into dd1 from cc_deal d  where  d.vidd=1  and d.nd = p_nd1 and d.sos < 15 ;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '2) не Є стандартним КД ';
   end;
end if ;

If p_mode in (0, 1, 3) then
   If p_mode <> 3  then
      begin select d.* into dd1 from cc_deal d  where  d.nd = p_nd1 and d.sos < 15 ;
           select * into kl1 from customer where rnk = dd1.rnk and (( sed like '56%' or k050 like '855%') or (sed like '62%' or k050 like '320%')) ;
      EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '0)  RNK '||dd1.rnk ||' не Є ОСББ або ЖБК ';
      end;
   end if;
   begin select a.* into aa8 from accounts a, nd_acc n where a.tip='LIM' and a.acc= n.acc and n.nd = p_nd1;
         select *   into ad1 from cc_add               where nd = dd1.nd and adds = 0;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '2`) не знайдено 8999*LIM';
   end;
   if aa8.kv<> gl.baseval then sErr := sErr || nlchr||                '1) Код вал - тільки національна ';
   end if ;
   begin select *   into ii1 from int_accn             where id= 0 and acc = aa8.acc and s >=1 ;
         If    p_mode in (   3 ) and ii1.basem<> 1 then sErr := sErr || nlchr||'3) Не ануїтет «по-новому»' ;
         elsIf p_mode in (0, 1 ) and ii1.basey<> 0 then sErr := sErr || nlchr||'3) метод нарахування %% HE = «факт/факт»' ;
         end if ;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '4) Не визначено пл.день ДД ';
   end;

   If p_mode <> 3  then
      SELECT - Nvl (sum(a9.ostb),0)   into nTmp_     FROM accounts a9  WHERE a9.dazs  IS  NULL  and a9.acc in
        (select z.acc from cc_accp z, pawn_acc p, cc_pawn w where z.nd = dd1.nd and z.acc=p.acc and p.pawn=w.pawn and w.s031 = '59');
         If nTmp_ = 0 then   sErr := sErr || nlchr||                     '6) Відсутня застава-депозит' ; end if;
   end if ;

   begin select * into aa1 from accounts where nbs='2600' and dazs is null and rnk  = dd1.rnk and kv = gl.baseval and rownum = 1 ;

----     begin select n.* into nn1 from accounts a, nd_acc n where a.nbs='2600' and a.dazs is null and a.acc = n.acc and n.nd  = dd1.nd ;
----     EXCEPTION WHEN NO_DATA_FOUND THEN          insert into nd_acc (nd, acc) values( dd1.nd, aa1.acc);
---      end ;
   EXCEPTION WHEN NO_DATA_FOUND THEN sErr := sErr || nlchr||          '7) Відсутній відкритий пот.рах. позичальника РНК='|| dd1.rnk;
   end;

   If p_mode <> 3  then

      Begin select nvl(to_number(replace(txt,',','.')), 0) into nTmp_ from nd_txt where tag = 'S_SDI' and nd = p_nd1;
      exception when others then                nTmp_ := 0;
      end  ; If nTmp_<= 0 then sErr  := sErr || nlchr||      '8) Відсутні дані про початкову комісію'; end if;

   end if;

   If months_between(dd1.wdate,dd1.sdate)>60 then sErr :=sErr||nlchr||'9) Порушено макс строк кредитування = 60 міс.' ;  end if;

   If p_mode in (0)       then  PUL.Set_Mas_Ini( 'ERR_OSBB', sErr, 'ERR_OSBB' );  RETURN ;
   else
      If length(sErr) > 0 then  raise_application_error(-(20203),'\8999 - cck_OSBB: КД '||p_ND1|| sErr ) ;  end if ;
   end if;
end if;
------------- #########################################

If p_mode = 1 then
   -- Комісія за видачу договору згідно умов первинного договору амортизується лінійно до закінчення грейс-періоду
   update int_accn set metr=4 where id=1 and acc in (select a.acc from accounts a, nd_acc n where n.nd=dd1.nd and n.acc=a.acc and a.tip = 'SDI' );

   -- Построение графика погашения  для ПЕРВОЙ ЧАсти
   --   GPK - начало и конец + сплата виключно нарахованих по факту вибраних коштів відсотків  ЩОМІСЯЧНО ?
   CCK.CC_LIM_NULL( p_nd1 ) ;
   l_Ir :=  acrn.fprocn(aa8.acc, 0, gl.bdate);
   CCK.CC_GPK (MODE_ => 1        , --- int ,
               ND_   => p_nd1    , -- int ,
               ACC_  => aa8.acc  , -- int,
               BDAT_1=> gl.bdate , -- date,   -- начало
               DATN_ => cck.f_dat (ii1.s, trunc(add_months(gl.bdate,1),'MM')  ),   -- ii1.APL_DAT, --- date,   -- первая дата погашенпя
               DAT4_ => dd1.wdate, --  date,   -- завершение
               SUM1_ => dd1.sdog , -- number, -- сумма к погашению в грн (1.00)
               FREQ_ => 5        , -- int,
               RATE_ => l_ir     , ----number, -- годовая % ставка
               DIG_  => 0) ;

   begin  Insert into cc_lim (ND, FDAT, LIM2, ACC, SUMG, SUMO, SUMK) Values(p_nd1, d_GRAC1, 0, aa8.acc, 0, 0, 0);
   exception when dup_val_on_index then  null;
   end;
   SumR_ := dd1.sdog*100   ;
   update cc_lim set sumg = decode (fdat, d_GRAC1, SumR_, 0) where nd = p_nd1 ;
   CCK.CC_GPK_LIM ( p_ND1, aa8.Acc    , gl.bdate, gl.bdate, SumR_) ;
   CCK.cc_TMP_GPK (ND_   => p_nd1     , --   int,     -- реф КД
                   nVID_ => 2         , --   int,     -- вид ГПК = 4 для "типа ануитет", =2 иначе( клас + другое)
                   ACC8_ => aa8.acc   , --   int,     -- АСС для сч 8999
                   DAT3_ => gl.bdate  , --  date,    -- Первая Дата выдачи КД
                   DAT4_ => dd1.wdate , --  date,    -- Дата завершения КД
                   Reserv_=> null     , --  char,    --резевв. не использую
                   SUMR_  => null     , --  number,  --РЕЗЕРВ. НЕ ИСПОЛЬЗУЮ -- Новый лимит по КД
                   gl_BDATE => null     -- date     --резевв. не использую
                  ) ;
----- добавить прогноз-график для части-2    -------------------------RETURN ;
   cck.UNI_GPK_FL (p_lim2  => SumR_  ,  -- новый лимит
                   p_gpk   => 4      ,  -- 1-Ануитет. 0 - Класс
                   p_dd    => ii1.s  ,  -- <Платежный день>, по умол = DD от текущего банк.дня
                   p_datn  => d_GRAC1,  -- дата нач КД
                   p_datk  => dd1.wdate,   -- дата конца КД
                   p_ir    => l_ir   ,    -- проц.ставка
                   p_pl1   => cck.f_pl1(0, SumR_, 4, ii1.s, d_GRAC1, dd1.wdate, l_ir,0),        -- сумма 1 пл
                   p_ssr   => 0      ,     -- признак =0= "с сохранением срока"
                   p_ss    => 0      ,     -- остаток по норм телу
                   p_acrd  => d_GRAC1,     -- с какой даты начислять % acr_dat+1
                   p_basey => 2             -- база для нач %%;
                        );

   select nvl(sum(sumo-sumg),0)  into SumP_ from cc_lim   where nd = p_nd1 and fdat >= d_GRAC1;
   delete                              from cc_lim        where nd = p_nd1 and fdat >  d_GRAC1;
   update cc_lim set sumg = 0, sumo = SumP_, lim2 = Sumr_ where nd = p_nd1 and fdat  = d_GRAC1;
   insert into cc_lim (ND,FDAT,LIM2,ACC,SUMG,SUMO,SUMK) select p_nd1,fdat,lim2,aa8.acc,sumg,sumo,nvl(sumk,0) from tmp_gpk where fdat>d_GRAC1;
   --------
   RETURN ;  ------- p_mode = 1
   --------
end if;
----------------------------------

If p_mode = 2 then  -- Фініш       первинного КД ОСББ + Авто-Старт вторинного КД ОСББ
   oo1.tt := '024' ;
   begin select a.* into sd1 from accounts a, nd_acc n where a.tip ='SDI' and a.ostb >0 and a.acc=n.acc and n.nd = dd1.nd;
   EXCEPTION WHEN NO_DATA_FOUND THEN null;
   end;
end if;

----------Его первая пл.дата
l_datnp := trunc(gl.Bdate, 'MM') ;   l_datnp := cck.f_dat ( p_dd => ii1.s, p_DAT1 => l_datnp );
If l_datnp <= gl.bdate then          l_datnp := add_months ( l_datnp,1 ) ;              end if;

-------- Его проц.ставка
If p_mode = 2 then
   l_ir := acrn.fprocn ( aa1.acc, 0, gl.bdate);

   -------Его открытие
   CCK.CC_OPEN ( ND_  => dd2.nd,
                 nRNK => dd1.rnk,
               CC_ID_ => dd1.cc_id||'/2',
               Dat1   => gl.bdate ,
               Dat4   => dd1.WDATE,
               Dat2   => gl.bdate,
               Dat3   => gl.bdate,
               nKV    => aa1.kv  ,
               nS     => -aa1.ostc/100,
               nVID   => 1,
               nISTO  => ad1.sour,
               nCEL   => ad1.aim,
               MS_NX  => null,
               nFIN   => dd1.fin,
               nOBS   => dd1.obs,
               sAIM   => null,
               ID_    => dd1.user_id,
               NLS    => null,
               nBANK  => null,
               nFREQ  => 5   ,
               dfPROC => l_ir,
               nBasey => 2,
               dfDen  => ii1.s,
               DATNP  => l_datnp,
               nFREQP => 5 ,
               nKom   => sd1.ostb ) ;
   
   if newnbs.g_state= 1 then
        begin  
            SELECT r020_new||ob_new
              INTO dd1.prod
              FROM TRANSFER_2017
             WHERE r020_old||ob_old = dd1.prod and r020_old <> r020_new;
        EXCEPTION WHEN NO_DATA_FOUND THEN null;
        end;     
   end if;
   
   update cc_deal set prod  =  dd1.prod  where nd = dd2.nd ;
   select *       into dd2 from cc_deal  where nd = dd2.nd ;
   --------Его доп.рекв.
   CCK_APP.SET_ND_TXT(dd2.nd,'INIC' ,CCK_APP.Get_ND_TXT (dd1.ND,'INIC' ) );
   CCK_APP.SET_ND_TXT(dd2.nd,'EMAIL',CCK_APP.Get_ND_TXT (dd1.ND,'EMAIL') );
-- CCK_APP.SET_ND_TXT(dd2.nd,'CCRNG',CCK_APP.Get_ND_TXT (dd1.ND,'CCRNG') );
   CCK_APP.SET_ND_TXT(dd2.nd,'CCRNG', '6'                                );

   CCK_APP.SET_ND_TXT(dd2.nd,'S260' ,CCK_APP.Get_ND_TXT (dd1.ND,'S260' ) );
   CCK_APP.SET_ND_TXT(dd2.nd,'FLAGS','10'                                );
   if sd1.ostb >0 then
      CCK_APP.SET_ND_TXT(dd2.nd,'S_SDI',to_char(sd1.ostb/100)            );
   end if ;
   ------------??????????? TRIGGER tbu_ccdeal_eib10
   -- COBUSUPABS-7041 Після оновлення трігера TBU_CCDEAL_EIB10 по контролю за заповненням параметра CIG_D13 перестала працювати функція Додаткова щоденна бізнес-логіка продуктів КП
    BEGIN
      INSERT INTO mos_operw (ND, TAG, VALUE)
           VALUES (dd2.nd, 'CIG_D13', '1');
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX
      THEN
          NULL;
    END;
   CCK_APP.SET_ND_TXT(dd2.nd,'CPROD',CCK_APP.Get_ND_TXT (dd1.ND,'CPROD') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBIS',CCK_APP.Get_ND_TXT (dd1.ND,'EIBIS') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCW',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCW') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBTV',CCK_APP.Get_ND_TXT (dd1.ND,'EIBTV') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCR',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCR') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCE',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCE') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBND',CCK_APP.Get_ND_TXT (dd1.ND,'EIBND') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBNE',CCK_APP.Get_ND_TXT (dd1.ND,'EIBNE') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBIE',CCK_APP.Get_ND_TXT (dd1.ND,'EIBIE') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCS',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCS') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBSF',CCK_APP.Get_ND_TXT (dd1.ND,'EIBSF') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBPF',CCK_APP.Get_ND_TXT (dd1.ND,'EIBPF') );
   CCK_APP.SET_ND_TXT(dd2.nd,'EIBCB',CCK_APP.Get_ND_TXT (dd1.ND,'EIBCB') );
   ------ автозовать с полным фаршем.
   oo1.nazn := Substr( s_Txt1||dd2.nd||s_Txt2,1, 160) ;

ElsIf p_mode = 3     then l_ir := acrn.fprocn(aa8.acc, 0, gl.bdate) ;
   select d.*        into dd2 from cc_deal  d   where d.nd = p_nd1  ;
   oo1.nazn := 'Кредит для ОСББ на всю суму (без КЛ, без грейс-періоду) станд.ануїтет, реф='||dd2.nd;
   CCK_APP.SET_ND_TXT(dd2.nd,'CCRNG', '6'  );
end if ;

   select a.*        into aa2 from accounts a, nd_acc n where a.tip = 'LIM' and a.acc=n.acc and n.nd = dd2.nd ;
   update int_accn set baseM = 1, basey = 2 where acc = aa2.acc and id= 0 ;
   -- построение ГПК
   cck.CC_GPK (MODE_  => 3,
               ND_    => dd2.nd,
               ACC_   => aa2.acc,
               BDAT_1 => dd2.sdate,
               DATN_  => l_datnp,   -- первая дата погашенпя
               DAT4_  => dd2.wdate,
               SUM1_  => dd2.sdog, -- сумма к погашению в грн (1.00)
               FREQ_  => 5,
               RATE_  => l_ir,  -- годовая % ставка
               DIG_   => 0 ) ;

If p_mode = 2 then
    -------вызов стандартной процедуры авторизации
----cck.cc_autor( dd2.ND, oo1.nazn, CCK_APP.Get_ND_TXT (dd1.ND ,'MS_UR' )   );------

   delete from cc_prol        where nd = dd2.nd ;
   delete from nd_txt         where nd = dd2.nd and tag in ('AUTOR', 'MS_UR'  );
   INSERT INTO nd_txt (ND,TAG,TXT)          values (dd2.ND, 'AUTOR', oo1.nazn );
   INSERT INTO nd_txt (ND,TAG,TXT)          select  dd2.ND, 'MS_UR', txt from nd_txt where tag = 'MS_UR' and nd  = p_nd1;
   insert into cc_prol(ND,NPP,MDATE,fdat )  select  dd2.ND, 0, dd2.wdate, min(fdat) from  cc_lim where nd = dd2.ND ;
   UPDATE cc_deal set  sos = 10  where nd = dd2.ND ;
   INSERT INTO cc_sob (ND,FDAT,ISP,TXT,otm) values (dd2.ND,gl.bDATE,gl.aUID,'Авторизовано Частину-2 до КД='|| p_nd1,6);

end if;

    ----- Вычисление  эффективной ставки p_ND < 0 -- l_mode := 2; По текущему ГПК + по условиям КД
    --p_irr_BV (p_ND => - dd2.nd, R_DAT => dd2.sdate );
    cck_dop.calc_sdi( dd2.nd, null);  -- Взята процедура из авторизации для первоначального расчета эф.ставки
    --------открытие счетов
    cck_dop.open_account(p_nd => dd2.nd,  p_tip => 'SS ') ;
    cck_dop.open_account(p_nd => dd2.nd,  p_tip => 'SN ') ;

    if sd1.ostb > 0 then
       cck_dop.open_account(p_nd => dd2.nd,  p_tip => 'SDI') ;
    end if;
    -----сохраняем данные об обеспечении
    insert into cc_accp(ACC,  ACCS,     ND )
      select distinct z.acc, s.acc, dd2.nd
      from (select * from cc_accp where nd = dd1.nd) z,
           (select a.acc from accounts a, nd_acc n where n.nd= dd2.nd and n.acc = a.acc and a.tip='SS ') s ;
    ------добавить 2600
    insert into nd_acc(nd,acc)
    select dd2.nd, a.acc  from nd_acc n, accounts a
    where a.nbs = '2600' and a.acc = n.acc and a.kv = aa2.kv and n.nd = dd1.nd
      and not exists ( select 1 from nd_acc where nd=dd1.nd and acc=a.acc );

If p_mode = 2 then
    -----связать два КД
    update cc_deal   set  ndi = dd1.nd  where nd in ( dd1.nd , dd2.nd) ;
    --------перебросить ост по норм.телу. Старый КД закрывается .или Не закрывается (если есть недоуплач %)
    for k in (select a.*
              from accounts a, nd_acc n
              where a.ostc <> 0
                and (a.accc=aa1.acc or a.tip in ('CR9','SDI' ) )
                and a.acc=n.acc and n.nd = dd1.nd
              order by a.acc )
    loop
       If k.tip = 'SDI' and k.ostb > 0 then oo1.dk := 0 ;
       else                                 oo1.dk := 1 ;
       end if;
       oo1.s := abs(k.ostb);
       begin
          If k.tip = 'CR9'  then
             select a.nls, substr(a.nms,1,38) into oo1.nlsa, oo1.nam_a from accounts a
             where  a.kv=k.kv and a.nls = BRANCH_USR.GET_BRANCH_PARAM2('NLS_9900',0) ;
          else
             select a.nls, substr(a.nms,1,38) into oo1.nlsa, oo1.nam_a from accounts a, nd_acc n
             where a.tip = decode (k.tip,'SDI',k.tip,'SS ') and a.kv=k.kv and a.acc=n.acc and n.nd = dd2.nd ;
          end if;

          If oo1.ref is null then
             gl.ref( oo1.ref);
             gl.in_doc3 (oo1.ref  , oo1.tt,6, substr(dd1.cc_id,1,10) , sysdate, gl.bdate, 1, k.kv, oo1.s, k.kv, oo1.s, null , gl.bdate, gl.bdate,
                         oo1.nam_a, oo1.nlsa, gl.amfo, substr(k.nms,1,38), k.nls, gl.amfo, oo1.nazn, null, gl.aOkpo, gl.aOkpo, null,null, 0,null, null);
          end if;
          gl.payv( 0, oo1.ref, gl.bdate, oo1.tt, oo1.dk, k.kv, oo1.nlsA, oo1.s, k.kv, k.nls, oo1.s);
       EXCEPTION WHEN NO_DATA_FOUND THEN return;
       end;
    end loop;

    if oo1.ref is not null then gl.pay (2, oo1.ref, gl.bdate) ; end if;
    RETURN ;
end if;

  RETURN;
end  cck_OSBB;
/
