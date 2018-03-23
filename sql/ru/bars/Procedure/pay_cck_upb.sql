

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/PAY_CCK_UPB.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** Create  procedure PAY_CCK_UPB ***

  CREATE OR REPLACE PROCEDURE BARS.PAY_CCK_UPB 
              (flg_  SMALLINT DEFAULT NULL,  -- Plan/Fact flg
               ref_  INTEGER,    -- Reference
               dat_  DATE,       -- Value Date
                tt_  CHAR,       -- Transaction code
                dk_  SMALLINT,   -- Debet/Credit
               kv1_  SMALLINT,   -- Currency code 1
              nls1_  VARCHAR2,   -- Account number 1
              sum11_ DECIMAL,    -- Amount 1
               kv2_  SMALLINT,   -- Currency code 2
              nls2_  VARCHAR2,   -- Account number 2
              sum2_  DECIMAL   -- Amount 2
) IS
/*
  Ver 3.34
  01-02-2017  http://jira.unity-bars.com.ua:11000/browse/COBUSUPABS-5268
              Погоджено з бек-офісом!
              Символ каси дійсно має проставлятися не номеру рахунку , а по призначенню коштів!
              Тобто якщо на 2620 зараховується готівка , яка в майбутньому піде на погашення кредитної заборгованості, має проставлятися символ 14, в інших випадках символ 16!
              Операція ССК призначена тільки для погашення кредитної заборгованості тому, завжди має проставлятися символ 14!
  06-12-2012  В довідник кодів продуктів cck_ob22  добавляємо поле sd8 - Об22 для пені (patch090.sql)
              рахунок пені шукається на бранчі кредиту по умові  - якщо sd8 null з параментрів бранчу
              інакше шукається nbs_ob22_null(6397, OB22_6397, TOBO_) якщо не найшли то видаєм помилку.
  25-07-2012  В доп. реквизиты документа добавлены код плательщика, курс обмена при выкупе центов,
              снял ограничение на сумму для паспортных данных плательщика.
  04-01-2012  При погашении валютной комиссии (вал кредит) с (просрочка + нормальный ком долг)
              возникала разность округления (с 2909 уходило больше на одну копейку). + для случаев
              меньше частное решение см. ниже по коду
              Ослабил формулу поиска  контр счета по пене 6397. Для Надра (Ощаду не помешает)
              Не проверяю на каком уровне находиться 6397. Да так и универсальнее.
              теперь она выражаеться в виде нереализованого дохода.
  29-11-2011  Выкуп центов операцмя VPF. Клиент обязан внести наличности большую
              сумму чем оплачевуемую (введенную касиром). Разница должна быть
              возвращена кассиром в грн.
  04-02-2011  Отбирать КД только ФЛ как в get_info_upb_ext
              При остаточном пог сумма досрочки расчит-ся как от тек плат
  02-02-2011  Добавлена проверка при проведении проводок на допустимость бал счетов
  03-09-2010  Сумма долга которая будет считаться досрочным погашением
              определяется двумя мотодами CCK_PAY_S  0-абсолютным 1-относительным
               SD4 - определяется еще и на лету с помощью проц cc_o_nls
  26-06-2010  Комиссионные доходы принимать только в грн через гривневый SG
              если комис доходы указаны для погашения первыми перекидывать на
              вал транзитник (УПБ). Иначе разбирать сразу по ком счетам(Сбербанк)
  19-05-2010  Комиссию начисленную в ин валюте
  14-04-2010  Из за неправильно переданных данных веб-ской формы не гасилась
              комис. в валюте договора
  26-01-2010  Добавлена возможность гасить комиссию в валюте отличной от вал.
              КД. GET_INFO_UPB_EXT - расширена
  24-02-2009  Доп.рекв из ВЭБ = DAT1.
              Можно работать через общий счет в оп CCK/
              Через этот счет суммы не будут прокручены. Он - пустышка.
  27-01-2009  Доп.рекв для больших сумм
  16-01-2009  Для пени СС8 !!
  личная процедура Маршавиной (вызываемая по  #ifdef UPB из PAYTT)
  специфика обработки CCK-операции.
  доп.реквизит ПЕНЯ
*/


  sTmp_   varchar2(100);
  Sum1B_   number;
  SumQB_   number;

  VOB_     oper.VOB%type :=130;
  l_rang    CC_RANG_ADV_REP_NAME.blk%type;
  sum1_    oper.S%type:=0;  --общая сумма платежа без пени
  sum1T_   oper.S%type:=0;  --общая сумма платежа по телу КД
  sum1D_   oper.S%type:=0;  -- сумма платежа по дох.банку(без пени) ПРОЦЕНТЫ
  sum1M_   oper.S%type:=0;  -- сумма платежа по дох.банку(без пени) КОМИССИЯ
  sum1A_   oper.S%type:=0;  -- сумма за досрочное погашение

  sum1T_P_   oper.S%type:=0;  --общая сумма     (проср) платежа по телу КД
  sum1D_P_   oper.S%type:=0;  -- сумма платежа  (проср) по дох.банку(без пени) ПРОЦЕНТЫ
  sum1M_P_   oper.S%type:=0;  -- сумма платежа  (проср) по дох.банку(без пени) КОМИССИЯ

  nSSP_   number;  -- просрочка тела
  nSSPN_  number;  -- просрочка %
  nSSPK_  number;  -- просрочка ком

  sn8_     oper.S%type;
  qn8_     oper.S%type;
  SK0      oper.S%type;   -- сумма к оплате комиссии общая оплачеваемая клиентом
  SK0_980  oper.S%type;   -- сумма к оплате комиссии общая оплачеваемая клиентом

  ratn_advanced number;   -- досрочное погашение

  N980_    accounts.KV%type;
  TOBO_    accounts.TOBO%type; -- ТОБО эмит.КД
  nls_1002 accounts.NLS%type ; -- счет кассы
  nls_6397 accounts.NLS%type ; -- счет дох по пене ТОБО-эмитента КД
  nls_6110 accounts.NLS%type ; -- счет дох ком за доср погашенние
  nls_sk0  accounts.NLS%type ; -- счет комиссионных доходов
  RANG_SK9SK0 Varchar2(6);     -- Первые два типа для погашения указанные в ранге для погашения
  acc_     accounts.ACC%type ; -- Счет гашения
  acc8_    accounts.ACC%type ; -- Счет лимита
  ND_      cc_deal.ND%type   ;
  PASP_    operw.value%type  ;
  PASPN_   operw.value%type  ;
  ATRT_    operw.value%type  ;
  DT_R_    operw.value%type  ;

-- переменные для получения инф о КД
  CC_ID_   cc_deal.CC_ID%type;
  PROD_   cc_deal.PROD%type;
  DAT1_    cc_deal.SDATE%type;
  DAT4_    cc_deal.WDATE%type;
  nRet_    int               ;
  sRet_    varchar2(256)     ;
  rnk_     accounts.RNK%type ;
  nS_      number            ; -- Сумма текущего платежа
  nS1_     number            ; -- Сумма окончательного платежа
  NMK_     operw.value%type  ;
  OKPO_    customer.OKPO%type; -- OKPO         клиента
  ADRES_   operw.value%type  ;
  KV_      accounts.KV%type  ;
  LCV_     tabval.LCV%type   ;  -- ISO валюты   КД
  NAMEV_   tabval.NAME%type  ; -- валютa       КД
  UNIT_    tabval.UNIT%type  ; -- коп.валюты   КД
  GENDER_  tabval.GENDER%type; -- пол валюты   КД
  nSS_     number            ; -- Тек.Сумма осн.долга
  nSS1_    number            ; -- Оконч.Сумма осн.долга
  DAT_SN_  date              ; --\ По какую дату нач %
  nSN_     number            ; --/ Сумма нач %
  nSN1_    number            ;-- | Оконч.Сумма проц.долга
  DAT_SK_  date              ; --\ По какую дату нач ком
  nSK_     number            ; --/ сумма уже начисленной комиссии
  nSK1_    number            ; --| Оконч.Сумма комис.долга
  ACC_SK0  accounts.acc%type ;
  KV_KOM_  int               ; -- Вал комиссии
  DAT_SP_  date              ; -- По какую дату нач пеня
  nSP_     number            ; -- сумма уже начисленной пени
  KV_SN8   accounts.KV%type  ;
  NLS_8008 accounts.NLS%type ; --\
  NLS_8006 accounts.NLS%type ; --/ счета начисления пени
  MFOK_    oper.MFOB%type    ; --\
  nls_SG   accounts.NLS%type ; --/ счет гашения
  nls_SG_980 accounts.NLS%type ; --/ счет гашения
  OB22_6397 accounts.ob22%type ; -- об22 для пени для продукта
  Mess_    varchar2(1024)    ;
--
  flg_spn int:=0;
  flg_sk9 int:=0;
  flg_sp  int:=0;
  flg_sn int:=0;
  flg_sk0 int:=0;
  flg_ss  int:=0;

  Del_SK4 number:=0;
  SK4_stp_dat date;
  l_limit number:=0;
  l_VID  number:=0;
  l_OSTX number:=0;
  CC_PAY_S int:= NVL( GetGlobalOption('CC_PAY_S'),'0');
  L_ALLSUM_FOR_VP number:=0; --
  L_DEL_VP  number:=0;
  l_nSK_980 number:=0;   -- Для ин валютных комиссий (temp)
  rate_   cur_rates$base.rate_b%type; -- Курс выкупа центов


PROCEDURE pay_no(nlsm_ varchar2,nlsk_ varchar2, TT_ char)
is
  l_SERR  varchar2(35);
  l_NERR  int;
begin
        select max(n.id), max(n.name)
          into l_NERR, l_SERR
          from PAYTT_NO n
         where rownum=1
           and TT_ = Nvl(n.TT,TT_)
           and (dk_=1 and nlsm_ like trim(NBSD)||'%' AND nlsk_ like trim(NBSK)||'%'
                OR
                dk_=0 and nlsk_ like trim(NBSD)||'%' AND nlsm_ like trim(NBSK)||'%'
               );
  if l_NERR is not null then
  raise_application_error(-(20203),
  '\PAY_CCK_UPB:'||l_NERR||'.'||l_SERR||' '|| nlsm_||' - '||nlsk_||'('||TT_||')', TRUE);
  end if;
end;


BEGIN
  N980_:= GL.BASEVAL;

 logger.trace ('PAY_CCK: ref_='||ref_);

  -- найти доп.реквизит CC_ID
  begin
    select trim(value) into CC_ID_ from operw where ref=REF_ and tag ='CC_ID';
    If substr(CC_ID_,-4,1) ='/' then
       KV_   := to_number(substr(CC_ID_,-3,3));
       CC_ID_:= substr(CC_ID_,1, length(CC_ID_)-4);
    else
       If dk_=0 then   kv_ := kv2_; else  kv_ := kv1_; end if;
    end if;

  EXCEPTION  WHEN OTHERS THEN
    raise_application_error(-(20203),' Помилковий дод. рекв CC_ID по реф='||REF_, TRUE);
  end;

  If dk_=0 then  nls_1002 := NLS2_;  else  nls_1002 := NLS1_;  end if;

--------------
  -- найти доп.реквизит DAT1
  begin
    select substr(trim(value),1,10) into sTmp_
    from operw where ref=REF_ and tag ='DAT1' ;
    DAT1_:=to_date (sTmp_,'dd-mm-yyyy' );
  EXCEPTION  WHEN OTHERS THEN DAT1_:=null;
  end;

 logger.trace ('PAY_CCK: CC_ID='||CC_ID_);
  --- Ищем счет гашения
  begin

     IF DAT1_ is not null then

        select acc, rnk, nd, tobo, nls,limit, prod
        INTO ACC_,RNK_,ND_,TOBO_, nls_SG, l_limit, PROD_
        from (
           select a.acc, a.rnk, n.nd, a.tobo, a.nls,d.limit, d.prod
        from accounts a, nd_acc n, cc_deal d,cc_add ca
        where trim(d.CC_ID)=trim(CC_ID_) and d.sdate=DAT1_ and d.nd  = n.ND
          and d.nd=ca.nd  and ca.adds=0  and d.vidd in (11,12,13)
             and ca.kv =kv_  and (a.tip = 'SG ' or nbs ='2620' ) AND A.KV=CA.KV
             and a.acc=n.acc and a.dazs is null and d.sos<14
          order by a.nbs, a.acc)
        where rownum=1;

     else
        If dk_=0 then nls_SG := nls1_; else nls_SG := nls2_; end if;

       -- В УПБ есть КД с одинаковім номером и датой (мультивалютній)
        select a.acc, a.rnk, n.nd, a.tobo, d.sdate
        INTO ACC_,RNK_,ND_,TOBO_,DAT1_
        from accounts a, nd_acc n, cc_deal d
        where d.CC_ID=CC_ID_ and d.nd  = n.ND
          and a.kv =kv_      and a.nls = nls_SG and d.vidd in (11,12,13)
          and a.acc=n.acc    and a.dazs is null and d.sos<15;
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'DAT1',to_char(DAT1_,'dd/mm/yyyy'));
     end if;

  EXCEPTION  WHEN OTHERS THEN
     raise_application_error(-(20203),
     '     Не знайдено кл., КД, рах.SG '||kv_||'/'||nls_SG, TRUE);
  end;

   logger.trace ('PAY_CCK: nls_SG = '||nls_SG);

--  для получения инф по КД
GET_INFO_UPB_EXT
 ( CC_ID_, DAT1_, nRet_, sRet_, rnk_,
  nS_    , -- Сумма текущего платежа
  nS1_   , -- Сумма окончательного платежа
  NMK_   , OKPO_, ADRES_, KV_, LCV_, NAMEV_, UNIT_, GENDER_,
  nSS_   , -- Тек.Сумма осн.долга в целых
  DAT4_  ,
  nSS1_  , -- Оконч.Сумма осн.долгав целых
  DAT_SN_,
  nSN_   , -- Сумма нач % в целых
  nSN1_  , -- Оконч.Сумма проц.долга в целых
  DAT_SK_,
  nSK_   , -- сумма уже начисленной комиссии в целых
  nSK1_  , -- Оконч.Сумма комис.долга в целых
  KV_KOM_,
  DAT_SP_,
  nSP_   , -- сумма уже начисленной пени
  KV_SN8 ,
  NLS_8008,
  NLS_8006,
  MFOK_   ,
  sTmp_   ,
  nSSP_   , -- сумма просроченного тела
  nSSPN_  , -- сумма просроченных процентов
  nSSPK_  , -- сумма  просроченной комиссии
  Mess_

);

-- Для погашения с отсрочкой не відаем расшифровку погашения
   if substr (nls2_,1,2)='26' then
 begin
       select vob into vob_ from tts_vob where tt='CCK' and ord=3;
      exception when no_data_found then
         VOB_:=350;
      end;
   else
    begin
  select r.blk
     into l_rang
    from nd_txt t, cc_rang_name r where t.nd=nd_ and T.TAG='CCRNG' and T.TXT =R.RANG;
    exception when no_data_found then l_rang:=0;

 end;
 -- По платiжним дням (на рах. SG) основного боргу
    if l_rang=2 then
      begin
       select vob into vob_ from tts_vob where tt='CCK' and ord=2;
      exception when no_data_found then
         VOB_:=134;
      end;
    else
      begin
       select vob into vob_ from tts_vob where tt='CCK' and ord=1;
      exception when no_data_found then
         VOB_:=130;
      end;
    end if; -- l_rang=2
   end if;  -- substr (nls2_,1,2)='26'


bars_audit.trace('PAY_CCK_UPB: CC_ID_='||CC_ID_||', DAT1_='||DAT1_||
', nS_='    ||nS_    ||', nS1_='   ||nS1_   ||', KV_='    ||KV_    ||
', nSS_='   ||nSS_   ||', DAT4_='  ||DAT4_  ||', nSS1_='  ||nSS1_  ||
', DAT_SN_='||DAT_SN_||', nSN_='   ||nSN_   ||', nSN1_='  ||nSN1_  ||
', DAT_SK_='||DAT_SK_||', nSK_=   '||nSK_   ||', nSK1_='  ||nSK1_  ||
', KV_KOM_='||KV_KOM_||', DAT_SP_='||DAT_SP_||', nSP_=   '||nSP_   ||
', nSSP_='  ||nSSP_  ||', nSSPN_=' ||nSSPN_ ||', nSSPK_= '||nSSPK_ ||
', sum11_=' ||sum11_ ||', sum1_=' ||sum1_||' VOB='||to_char(VOB_)
);


  --------------------------- ПЕНЯ ------------------------------------
   -- нам все равно какую валюту вернула get_info_upb_ext
   -- исользуем ту что прописана  в спец параметрах документа
   -- поскольку именно ее оплачивал клиент

 logger.trace ('PAY_CCK: KV_KOM_'||KV_KOM_);

  begin
    select to_number(value) into KV_SN8 from operw where ref=ref_ and tag='SN8KV';
    select to_number(value) into SN8_ from operw where ref=ref_ and tag='SN8';
    qn8_ := gl.p_icurval(kv_sn8, sn8_, gl.BDATE);
  EXCEPTION  WHEN OTHERS THEN    sn8_:=0; qn8_:=0;
  end;

 logger.trace ('PAY_CCK: KV_SN8 = '||KV_SN8||' SN8 = '||SN8_);

  If nvl(sn8_,0) >0 then
      begin
          select sd8
            into OB22_6397
            from cck_ob22
           where nbs||ob22 = PROD_;
        EXCEPTION  WHEN OTHERS
           THEN OB22_6397 := null;
      end;

  if OB22_6397 is null then
       begin
       -- счет для дох по пене эмит
       select a.nls into NLS_6397
       from accounts a, TOBO_PARAMS t
       where t.tobo=TOBO_
         and t.tag='CC_6397' and a.kv=n980_
         and t.val=a.nls and a.dazs is null;

     EXCEPTION  WHEN OTHERS THEN
       raise_application_error(-(20203),
       ' Не знайдено рах.доходiв по пенi для ТОБО '||TOBO_||'Заповніть довідник  "Параметри підрозділів банку"(TOBO_PARAMS) Таг ="CC_6397" ', TRUE);
     end;

  else

    NLS_6397 := nbs_ob22_null(6397, OB22_6397, TOBO_);
                if NLS_6397 is null then
                raise_application_error(-20203,
                    '\9356 - Не найден счет Бал='|| '6397'||' OB22='||OB22_6397||' для уровня = ' || TOBO_,TRUE);
                end if;
  end if;

     --сворачивание нач.пени в номинале
        pay_no(nls_8006,nls_8008,tt_); -- проверка на допустимость бал счетов
     gl.payv(flg_,ref_,dat_,tt_,1,KV_SN8,nls_8006,sn8_,KV_SN8,nls_8008, sn8_);
     --зачисление пени на доходы в эквив
       pay_no(nls_1002,nls_6397,'CC8');
     gl.payv(flg_,ref_,dat_,'CC8',1,N980_,nls_1002,Qn8_,N980_,nls_6397, Qn8_);
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'QN8', QN8_ );
  else
     -- вообще ничего делать не надо, тк нет суммы ни пени, ни осн.док
     If sum11_ = 0 then RETURN;
     end if;
  end if;

 logger.trace ('PAY_CCK: 4');
  --Доп.реквизиты операции должны быть:
  --1. Фио клиента
  INSERT INTO operw (ref,tag,value) VALUES (REF_,'FIO', NMK_ );
  --2. Иден. код клиента
  INSERT INTO operw (ref,tag,value) VALUES (REF_,'POKPO', OKPO_ );

      update oper set vob=vob_, sk = 14 where ref=REF_; --sk = decode(substr(nls2_,1,4),'2620',16,14)

  -- Узнаем код валюты КОМИССИИ
    begin
      select to_number(value) into KV_KOM_  from operw where ref=ref_ and tag='SK0KV';
      select abs(to_number(value)) into SK0 from operw where ref=ref_ and tag='SK0';
    exception when no_data_found then
      sk0:=0; kv_kom_:=kv_;
    end;
    logger.trace ('PAY_CCK: KV_KOM_ = '||KV_KOM_||' SK0 = '||SK0);

-- Погашение КОМИССИИ в валюте отличной от договора
-- теперь только для комиссии в гривне (остается на прямую на 3578/3579)

     -- Если комиссия в инвалюте и больше нуля ищем счет гашения в гривне
     -- поскольку клиент платит только в ГРН
     if KV_KOM_!=gl.baseval and nSK1_>0 then
       begin
         SELECT a.nls
           into NLS_SG_980
           from nd_acc n, accounts a  where n.nd=ND_
                and a.tip='SG ' and a.kv=gl.baseval and n.acc=a.acc
                and a.dazs is null and rownum=1;
       EXCEPTION
       WHEN NO_DATA_FOUND THEN null;
            raise_application_error(-(20204),
            ' НЕ знайдено рахунок погашення (SG) у національній валюті! Реф дог = '||to_char(ND_), TRUE);
       end;
     end if;

      -- Для инвалютных кредитов с грн. комиссией
      if SK0>0 and kv_kom_<>kv_ and kv_kom_=N980_ then
        -- гасим комиссионную просрочку
        begin
        select a.nls,abs(a.ostb+a.ostf)
          into nls_sk0,nSSPK_
          FROM accounts a, nd_acc n
         WHERE n.nd=ND_ and n.acc=a.acc and
               a.tip='SK9' and a.kv=KV_KOM_ and rownum=1
               and (a.ostb+a.ostf)=
                    (SELECT min(aa.ostb+aa.ostf)
                       FROM accounts aa, nd_acc nn
                      WHERE nn.nd=ND_ and nn.acc=aa.acc and
                            aa.tip='SK9' and aa.kv=KV_KOM_
                    );
        exception when no_data_found then
           nSSPK_:=0;
        end;


        if nSSPK_>0 then
              pay_no(nls_1002,nls_sk0,'CCM');
           gl.payv(flg_,ref_,dat_,'CCM',1,kv_kom_,nls_1002,least(nSSPK_,SK0),kv_kom_,nls_sk0, least(nSSPK_,SK0) );
        end if;
        logger.trace ('PAY_CCK: 6');
        -- гасим комиссию
        if  SK0-least(nSSPK_,SK0)>0 then
         begin
         select a.nls,abs(a.ostb+a.ostf)
           into nls_sk0,nSK_
           FROM accounts a, nd_acc n
          WHERE n.nd=ND_ and n.acc=a.acc and
                a.tip='SK0' and a.kv=KV_KOM_ and rownum=1
                and (a.ostb+a.ostf)=
                     (SELECT min(aa.ostb+aa.ostf)
                        FROM accounts aa, nd_acc nn
                       WHERE nn.nd=ND_ and nn.acc=aa.acc and
                             aa.tip='SK0' and aa.kv=KV_KOM_
                     );
         exception when no_data_found then
            nSK_:=0;
         end;
         if nSK_<SK0-least(nSSPK_,SK0) then
            raise_application_error(-(20204),
              ' Введена сума для погашення більше ніж нарахована на комісійні рахунки ='||to_char(nSSPK_+nSK_), TRUE);

         else
               pay_no(nls_1002,nls_sk0,'CCM');
            gl.payv(flg_,ref_,dat_,'CCM',1,kv_kom_,nls_1002,
                    least(nSK_,SK0-least(nSSPK_,SK0)),kv_kom_,nls_sk0, least(nSK_,SK0-least(nSSPK_,SK0)) );
         end if;
        end if;
      end if;

     logger.trace ('PAY_CCK: 7');


        -- Комиссия нач винвалюте но платится в грн
        -- модель 1001 (980)  - 2909 (980)
        --        2909 (980)  - 3578 (840)

   if SK0>0 and kv_kom_!=N980_ then

     -- Кидаем деньги на гривневый транзитник 2909
     SK0_980:=gl.p_icurval(KV_KOM_,SK0,gl.BDATE) ;
        pay_no(nls_1002,NLS_SG_980,'CCM');
     gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,nls_1002,SK0_980,gl.baseval,NLS_SG_980, SK0_980 );

        -- смотрим на приоритеты погашения
         select max(decode (rownum,1,tip,null))||max(decode (rownum,2,tip,null))
           into RANG_SK9SK0
           from
               (
                select tip from cc_rang
                 where tip in ('SS ','SP ','SN ','SPN','SK0','SK9') and
                       rang=to_number(nvl((select txt from nd_txt where tag='CCRNG' and nd=ND_),GetGlobalOption('CC_RANG')))
                 order by ord
               );
   -- если комис доходы имеют наивысший приоритет закидываем
   -- их на валютный транзитник (Маршавинский вариант)
   -- иначе распределяем по счетам 3578/3579
    if RANG_SK9SK0='SK9SK0' then
          pay_no(NLS_SG,NLS_SG_980,'CCM');
       gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980,SK0_980,KV_,NLS_SG, SK0);
    else

  -- гасим комиссионную просрочку
        begin
        select a.nls,abs(a.ostb+a.ostf)
          into nls_sk0,nSSPK_
          FROM accounts a, nd_acc n
         WHERE n.nd=ND_ and n.acc=a.acc and
               a.tip='SK9' and a.kv=KV_KOM_ and rownum=1
               and (a.ostb+a.ostf)=
                    (SELECT min(aa.ostb+aa.ostf)
                       FROM accounts aa, nd_acc nn
                      WHERE nn.nd=ND_ and nn.acc=aa.acc and
                            aa.tip='SK9' and aa.kv=KV_KOM_
                    );
        exception when no_data_found then
           nSSPK_:=0;
        end;
        if nSSPK_>0 then
              pay_no(nls_sk0,NLS_SG_980,'CCM');
           gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980
                   ,gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE)
                   ,kv_kom_,nls_sk0
                   ,least(nSSPK_,SK0)
                  );
        end if;
        logger.trace ('PAY_CCK: 6-1');
        -- гасим текущую комиссию

--        if  SK0-least(nSSPK_,SK0)>0 then
       -- оставшаяся сумма для погашения
       if  SK0_980-gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE)>0 then
         begin
         select a.nls,abs(a.ostb+a.ostf)
           into nls_sk0,nSK_
           FROM accounts a, nd_acc n
          WHERE n.nd=ND_ and n.acc=a.acc and
                a.tip='SK0' and a.kv=KV_KOM_ and rownum=1
                and (a.ostb+a.ostf)=
                     (SELECT min(aa.ostb+aa.ostf)
                        FROM accounts aa, nd_acc nn
                       WHERE nn.nd=ND_ and nn.acc=aa.acc and
                             aa.tip='SK0' and aa.kv=KV_KOM_
                     );
         exception when no_data_found then
            nSK_:=0;
         end;

         -- боремся с округлением в 1 копейку если клиент оплатил строго указанную сумму
         -- решение не универсально только если
         -- сумма к погашению комиссии в ин валюте и сумма указанная клиентом  к оплате совпадает
         -- тогда вторую сумму получаем вычитанием от первой в гривневом эквиваленте
         -- иначе для полноценного решения надо вводить дельту округлений

         if SK0-nSSPK_-nSK_=0  then
            l_nSK_980:= SK0_980-gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE);

          else
            l_nSK_980:=least (gl.p_icurval(KV_KOM_,nSK_,gl.bdate),
                             SK0_980-gl.p_icurval(KV_KOM_,least(nSSPK_,SK0),gl.BDATE));
          end if;

            pay_no(NLS_SG_980,nls_sk0,'CCM');
            gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980,
                    l_nSK_980                     ,kv_kom_,nls_sk0,
                    least(nSK_,SK0-least(nSSPK_,SK0)) );


         -- не умеем обрабатывать неначисленную комиссию

--         if nSK_<SK0-least(nSSPK_,SK0) then
--            raise_application_error(-(20204),
--              ' Введена сума для погашення більше ніж нарахована на комісійні рахунки ='||to_char(nSSPK_+nSK_), TRUE);
--         else
--            gl.payv(flg_,ref_,dat_,'CCM',1,gl.baseval,NLS_SG_980
--                    ,gl.p_icurval(KV_KOM_,   least(nSK_,SK0-least(nSSPK_,SK0))     ,gl.bdate)
--                    ,kv_kom_,nls_sk0,
--                    least(nSK_,SK0-least(nSSPK_,SK0)) );

--         end if;
        end if;



    end if;     --   RANG_SK9SK0='SK9SK0'
   end if;      --   SK0>0 and kv_kom_!=N980_

 -- от общей математической суммы отнимаем уже списанную пеню и валютную комиссию
  sum1_:= sum11_ - (sn8_+sk0);


  -----------------------
  -- Если основной платеж sum1_ >0
  --разбить основной платеж на осн.долг и дох.банка
  -- Окончательный или промежуточный платеж ?
  -- Эмитируем работу процедуры CCK.CC_ASG


  if CC_PAY_S=1 then

        select a.vid,nvl(a.ostx,0)
        INTO   l_vid,l_ostx
        from accounts a, nd_acc n, cc_deal d,cc_add ca
        where d.nd  = ND_ and a.acc=n.acc and d.nd=n.nd and a.tip='LIM' and rownum=1;
    -- Текущий платеж с учетом суммы необлагаемой комис досрочного поашения
    -- для равных частей сумма к погашению != сумме с которой не брать комиссию за доср погашение
    -- для ануитета подходит сумма переданная get_info_upb_ext
    if l_vid=2 then
       nSS_:=CCK_PLAN_SUM_POG(ND_, KV_,l_vid,l_ostx,CC_PAY_S)/100;
      --       nSS_:=CCK_PLAN_SUM_POG(ND_, KV_,l_vid,l_ostx,CC_PAY_S)/100+nSSP_;
      --         logger.trace ('PAY_CCK: CCK_PLAN_SUM_POG = '||to_char(nSS_-nSSP_));
         logger.trace ('PAY_CCK: CCK_PLAN_SUM_POG = '||to_char(nSS_));
    end if;
   end if;

  -- переводим все величины в копейки
  nSS1_:=nvl(nSS1_,0)*100;
  nSS_:=nvl(nSS_,0)*100;

  If sum1_< nSS1_+nSN_+(case when KV_=KV_KOM_ and KV_KOM_=gl.baseval then nSK_ else 0 end)
  then
     -- Это промежуточный платеж
     sum1D_:= (nSN_) * 100; -- сумма платежа по дох.банку ПРОЦЕНТы
     sum1M_:= (nSK_) * 100; -- сумма платежа по дох.банку Комиссия
  else
     -- Это Окончательный платеж
     sum1D_:= (nSN1_) * 100; -- сумма платежа по дох.банку ПРОЦЕНТы
     sum1M_:= (nSK1_) * 100; -- сумма платежа по дох.банку Комиссия
  end if;
 logger.trace ('PAY_CCK: 8');
-- просрочки переводим в целые цисла
  sum1T_P_:=nvl(nSSP_ ,0)* 100;
  sum1D_P_:=nvl(nSSPN_,0)* 100;
  sum1M_P_:=nvl(nSSPK_,0)* 100;
-- вычитаем просрочки из общей суммы доходов и комиссий
  sum1D_:=sum1D_-sum1D_P_;
  sum1M_:=sum1M_-sum1M_P_;

/*
  sum1M_ := least(Sum1_,sum1M_);
  Sum1_  := Sum1_ - sum1M_;
  sum1D_ := least(Sum1_,sum1D_);
  Sum1_  := Sum1_ - sum1D_;
  sum1T_ := sum1_ ; --общая сумма платежа по телу КД
*/
/*
nSSP_
nSSPN_
nSSPK_
*/
     -- в get_info_upb под просрочкой понимаются и сомнительные тоже
  for p in (select tip from cc_rang r
             where  r.rang=nvl((select txt from nd_txt where tag ='CCRNG' and nd=nd_),1)
                    and r.tip <> (case when KV_KOM_=gl.baseval and KV_KOM_=KV_  then 'ODB' else 'SK0' end)
                    and r.tip <> (case when KV_KOM_=gl.baseval and KV_KOM_=KV_  then 'ODB' else 'SK9' end)
                    and substr(nls_SG,1,2)!='26'
             order by ord
           )
  loop
  logger.trace ('PAY_CCK: '||p.tip);
     if p.tip='SPN' then
           sum1D_P_ := least(Sum1_,sum1D_P_);
           Sum1_  := Sum1_ - least(Sum1_,sum1D_P_);
           flg_spn:=1;
              logger.trace ('PAY_CCK: SPN='||to_char(sum1D_P_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SK9' then
           sum1M_P_ := least(Sum1_,sum1M_P_);
           Sum1_  := Sum1_ - least(Sum1_,sum1M_P_);
           flg_sk9:=1;
              logger.trace ('PAY_CCK: SK9='||to_char(sum1M_P_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SP ' then
           sum1T_P_ := least(Sum1_,sum1T_P_);
           Sum1_  := Sum1_ - least(Sum1_,sum1T_P_);
           flg_sp:=1;
              logger.trace ('PAY_CCK: SP ='||to_char(sum1T_P_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SN'  then
           sum1D_ := least(Sum1_,sum1D_);
           Sum1_  := Sum1_ - least(Sum1_,sum1D_);
           flg_sn:=1;
              logger.trace ('PAY_CCK: SN ='||to_char(sum1D_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SK0' then
           sum1M_ := least(Sum1_,sum1M_);
           Sum1_  := Sum1_ - least(Sum1_,sum1M_);
           flg_sk0:=1;
              logger.trace ('PAY_CCK: SK0='||to_char(sum1M_)||' SUM1_='||to_char(Sum1_));
     elsif p.tip='SS ' and Sum1_>0 then
               logger.trace ('PAY_CCK: Sum advanced Sum1='||to_char(Sum1_)||'nSS1='||to_char(nSS1_)||'sum1T_P='||to_char(sum1T_P_)||'nSS='||to_char(nSS_));
               -- текущ платеж < наим вариант( тело + просрочка, полн задолж)
           if nvl(nSS_,0)<least(Sum1_+sum1T_P_,nSS1_) and kv_=gl.baseval then
             begin
                 logger.trace ('PAY_CCK: SK4 - OK!' );
               -- фактическое взятие ком-сии за досрочное погашение переносим на стандартный модуль CCK.CC_ASG
               select a.acc,
                     nls_SG,
                     n.stp_dat
                    --  (select nls from accounts where acc=decode(n.acrb,null,cc_o_nls('8999',RNK_,4,ND_,KV_,'SD4') ,n.acrb))
                 into acc8_ ,nls_6110,SK4_stp_dat
                 from accounts a, int_accn n,nd_acc na
                where n.acc=a.acc and a.tip='LIM' and na.nd=ND_ and na.acc=a.acc and n.id=4 and rownum=1;

               ratn_advanced:=acrn.fprocn(ACC8_,4,gl.bd)/100;
                -- последняя попытка найти ТОЛЬКО ИНДИВИДУАЛЬНУЮ проц ставку
               if ratn_advanced is null or ratn_advanced=0 then
                  select max(ir)/100 into ratn_advanced
                    from  int_ratn where acc=acc8_ and br is null and id=4 and
                          bdat=(select max(bdat) from int_ratn
                                 where acc=acc8_ and bdat<=gl.bd and id=4
                               );
               end if;
               logger.trace ('PAY_CCK: Ratn_Advanced = '||to_char(ratn_advanced));
               if nvl(ratn_advanced,0)>0 and (SK4_stp_dat is null or SK4_stp_dat>gl.bd) then
                      -- макс сумма комиссии
                      sum1A_:=(nSS1_-nSS_)*ratn_advanced;
                         logger.trace ('PAY_CCK: SK4 - MAX= '||to_char(sum1A_));
--                         logger.trace ('PAY_CCK: SK4 - sum1A_='||to_char(sum1A_) );
                     -- досрочка+ остотаточое тело без просрочки
                  if  (sum1A_+nSS1_)>Sum1_+sum1T_P_ then -- текущий платеж с досрочным погашением
                      sum1A_:=trunc((Sum1_+sum1T_P_-nSS_)*ratn_advanced/(1+ratn_advanced));
                        logger.trace ('PAY_CCK: SK4 - SUM= '||to_char(sum1A_));

                  end if;

                  Sum1_:=Sum1_-sum1A_;
               end if;
             exception when no_data_found then null;
             end;
           end if;
          -- flg_ss :=1;

     end if;


  end loop;
 -- убераем суммы по платежам которые отсутствуют в шаблоне разбора
 -- (сделано от возможной ошибки)
  if   flg_spn=0 then sum1D_P_ :=0; end if;
  if   flg_sk9=0 then sum1M_P_  :=0; end if;
  if   flg_sp =0 then sum1T_P_ :=0; end if;
  if   flg_sn =0 then sum1D_   :=0; end if;
  if   flg_sk0=0 then sum1M_   :=0; end if;
--  if   flg_ss =0 then sum1D_P_ :=0; end if;


  sum1T_ := sum1_ + nvl(sum1T_P_,0);        --общая сумма платежа  по телу КД
  sum1D_ :=nvl(sum1D_,0) + nvl(sum1D_P_,0); --общая сумма доходов  по КД
  sum1M_ :=nvl(sum1M_,0) + nvl(sum1M_P_,0); --общая сумма комиссий по КД
 logger.trace ('PAY_CCK: 11');
  -- Перепроверяем сами себя
  if (sum1T_+ sum1D_+sum1M_+sum1A_) = (sum11_ - (sn8_+sk0)) then
      null;
  else
      raise_application_error(-20001,'Ошибка работы алгоритма CCK_PAY_UPB');
  end if;

  -- только для сумм больше 5000000
  Sum1B_ := sum1T_ + sum1D_ + sum1M_;

  bars_audit.trace('PAY_CCK_UPB: D='||sum1D_||', M='||sum1M_||', T='||sum1T_ ||', B='||Sum1B_ );

  If sum1T_ >0 then
     if substr(nls_SG,1,2)='26' then
        pay_no(nls_1002,nls_SG,'CCK');
        gl.payv(flg_,ref_, DAT_, tt_, 1,kv_,nls_1002,sum1T_,kv_,nls_SG,sum1T_);
        --update opldok set txt='Зарахування коштів на поточний рахунок' where stmt=gl.aSTMT and ref=ref_; --COBUMMFO-6212
		  update opldok set txt='Надходження коштів для погашення кредиту' where stmt=gl.aSTMT and ref=ref_;
     else
        pay_no(nls_1002,nls_SG,'CCM');
     gl.payv(flg_,ref_, DAT_, tt_, 1,kv_,nls_1002,sum1T_,kv_,nls_SG,sum1T_);
     update opldok set txt='Погашення боргу по тiлу КД' where stmt=gl.aSTMT and ref=ref_;
  end if;
  end if;

  If sum1D_ >0 then
     gl.payv(flg_,ref_, DAT_,'CCD',1,kv_,nls_1002,sum1D_,kv_,nls_SG,sum1D_);
     update opldok set txt='Погашення процентного боргу по КД' where stmt=gl.aSTMT and ref=ref_;
  end if;

  If sum1M_ >0 then
     gl.payv(flg_,ref_, DAT_,'CCM',1,kv_,nls_1002,sum1M_,kv_,nls_SG,sum1M_);
     update opldok set txt='Погашення комiсiйного боргу по КД' where stmt=gl.aSTMT and ref=ref_;
  end if;

  If sum1A_ >0 then
     gl.payv(flg_,ref_, DAT_,'CCA',1,kv_,nls_1002,sum1A_,kv_,nls_6110,sum1A_);
     update opldok set txt='Сплата комiсiйного боргу за дострокове погашення по КД' where stmt=gl.aSTMT and ref=ref_;
  end if;

    -- выкуп центов
  L_ALLSUM_FOR_VP:=sum11_ - (sn8_+sk0); -- сумма которую оплатил судозаемщик в валюте кредита
    -- узнаем наличие центов
  l_del_vp:=(case when kv_=978 then MOD(L_ALLSUM_FOR_VP,500) else MOD(L_ALLSUM_FOR_VP,100) end);
  If L_ALLSUM_FOR_VP >0 and kv_<>gl.baseval and l_del_vp!=0 then

     -- инвентируем сумму
     l_del_vp:=(case when kv_=978 then 500 else 100 end) - l_del_vp;

     if l_del_vp>0 then
       gl.payv(flg_,ref_, DAT_,'VPF',1,kv_,nls_1002,l_del_vp,gl.baseval,nls_1002, eqv_obs(kv_,l_del_vp,gl.bd,1));
       update opldok set txt='Викуп нерозмiнної частини валюти по курсу купiвлi' where stmt=gl.aSTMT and ref=ref_;
       -- Узнаем курс покупки на бранче в котором платит клиент
       BEGIN
         SELECT rate_b/bsum into  rate_
           FROM cur_rates
          WHERE (kv,vdate) =
                (SELECT kv, MAX(vdate) FROM cur_rates
                  WHERE vdate <= gl.bd AND kv = kv_
                  GROUP BY kv );
       EXCEPTION
          WHEN NO_DATA_FOUND THEN
          raise_application_error(-20001,' CCK_PAY_UPB Не установлен курс для валюты '||TO_CHAR(kv_));
       END;
       INSERT INTO operw (ref,tag,value) VALUES (REF_,'KURS', rate_ );
     end if;
  end if;



  If kv_ <>gl.baseval then
     --в инвалюте
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'KOD_B', '25' );
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'KOD_G','804' );
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'KOD_N','8446');
     INSERT INTO operw (ref,tag,value) VALUES (REF_,'D#73' ,'246' );
     If sum1D_ >0 then
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'73CCD' ,'246');
     end if;
     If sum1M_ >0 then
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'73CCM' ,'270');
     end if;
  end if;

  -- Если эквивалент суммы платежа nSum > 50 000.00 (коп)
  -- с 25/07/2012 добавляем в документ адресные и паспортные данные
  SumQB_ := gl.p_icurval(kv_, Sum1B_, gl.BDATE);
--  If SumQB_ > 5000000 or l_del_vp>0 then
     begin
        SELECT k.name,
               p.SER   ||' '|| p.NUMDOC,
               p.ORGAN ||' '|| To_char(p.PDATE,'dd/mm/yyyy'),
               to_char(p.BDAY,'dd/mm/yyyy')
        INTO PASP_,PASPN_,ATRT_, DT_R_
        from PASSP k, person p
        where p.rnk= RNK_ and NVL(p.PASSP,1)=k.PASSP (+) ;
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'PASP', PASP_ );
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'PASPN',PASPN_);
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'ATRT', ATRT_ );
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'DT_R', DT_R_ );
        INSERT INTO operw (ref,tag,value) VALUES (REF_,'ADRES',ADRES_);
     exception when NO_DATA_FOUND THEN null;
     end;
--  end if;
end PAY_CCK_UPB;
/
show err;

PROMPT *** Create  grants  PAY_CCK_UPB ***
grant EXECUTE                                                                on PAY_CCK_UPB     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/PAY_CCK_UPB.sql =========*** End *
PROMPT ===================================================================================== 
