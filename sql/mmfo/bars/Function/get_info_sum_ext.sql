
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/function/get_info_sum_ext.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE FUNCTION BARS.GET_INFO_SUM_EXT 
 ( CC_ID_  IN  varchar2, -- идентификатор   КД
   DAT1_   IN  date    , -- дата ввода      КД
   LocalBD_ IN date default  gl.bd -- Дата, на которую нужно получить информацию по КД
) return number AS
   l_sRet   varchar2(5000); -- Текст ошибки (?)
   l_nRet number;
   STOP_PRC EXCEPTION;
   l_RNK    int     ; -- Рег № заемщика
   l_nS     number:=0  ; -- Сумма текущего платежа
   l_nS1    number :=0 ; -- Сумма окончательного платежа
   l_KV     int  ; -- код валюты   КД
    ---- ТЕЛО
   l_nSS    number:=0  ; -- Тек. платеж  с условной прострочкой (платеж(ы) не вынесены на прострочку  )  ВЫЧИСЛЯЕМ
   l_nSS_ost   number:=0  ; --/ остаток   основного долга по КП
   DAT4_   date    ; --\ дата завершения КД
   -- ПРОЦЕНТЫ
   l_nSN_ost    number:=0  ; --/ Сумма нач %   на счетах  остаток
   l_nSN          number:=0  ;-- | Сумма проц.долга   по платежный день        ВЫЧИСЛЯЕМ
   l_nSN_end   number:=0  ;-- | Оконч.Сумма проц.долга      для закрытия КД (напр. досрочно - когда проц за прошл месяц)    ВЫЧИСЛЯЕМ
   --Комиссия
   l_DAT_SK date    ; --\ По какую дату нач ком
   l_SK_ost    number:=0  ; --/ сумма уже начисленной комиссии
   l_nSK   number:=0  ; --| Сумма комис.долга для погашения (совпадает всегда с закрытием КД)
   l_KVSK_ int     ; -- Вал комиссии
   --NLS_SG_980 varchar2 (14);

   --ПЕНЯ
   DAT_SN8_ date    ; -- По какую дату нач пеня
   l_nSN8    number  ; -- сумма уже начисленной пени
   l_KVSN8  int     ; -- валюта пени
   SN8_NLS varchar2 (14); -- счет  пени
   SD8_NLS varchar2 (14); -- счет  доходов пени
   -- СЧЕТ ГАШЕНИЯ
   l_SG_NLS varchar2 (14); -- счет  гашения
   l_nSG     NUMBER(38,2);  -- остаток на счете гашения
   -- ПРОСРОЧКИ
   l_nSSP   number  ; --\ сумма просроченного тела
   l_nSSPN  number  ; --\ сумма просроченных процентов
   l_nSSPK  number  ; --\ сумма  просроченной комиссии

   -- Комиссия за досрочное погашение платежа
   l_nSK4          number:=0   ;
   del_SK4       number:=0   ; -- дельта уже погашенной суммы в тек-ем месяце

   tip_SN   int:=1; -- 0 UPB   Проценты реальные Ничего не доначислять платить по факту
                          -- 1 SBER  Проценты плановые
  tip_pog  int;  -- 0 - З канікулами.  1-  Без канікул 9 - Вiдмiна Канік
  CC_PAY_I int; -- Проц за = 0 - день 1 - месяц
  CC_PAY_S int:= NVL( GetGlobalOption('CC_PAY_S'),'0'); -- 0 -считать сумму досрочным погашением при  погашении превышающем
                                                        --    текущий лимит ГПК минус текущий платеж ( абсолютное превышение)   НЕ ПОДДЕРЖИВАЕМ   сейчас никто не использует, а постановка была сделана из за неопытности кредитчиков.
                                                        -- 1- считать сумму досрочным с учетом уже уплаченной суммы за
                                                        --    досрочное погашение  (относительное)
                                                        -- а точнее не брать досрочку с текущего платежа
  CC_PAY_D int:= to_number(GetGlobalOption('CC_PAY_D'));
  CC_DAYNP  number ;
  --переменные
  l_ND     cc_deal.ND%type   ;
  l_ccid  cc_deal.CC_ID%type;
  l_limit cc_deal.LIMIT%type;
  ACC8_   accounts.ACC%type ;
  VID_    accounts.VID%type ;
  nInt_   number            ;
  ratn_advanced number:=0   ;

  l_nISG          number:=0   ; -- сумма которая находится на 3600
  day_pog_SN    number;   -- день
  dat_pog_SN    date  ;   -- дата погашения процентного долга в_числяется по дате


  -- аналог таблицы cc_lim только с запятыми для копеек
 -- храним в грн
 type t_lim  is record
  (
  ND        NUMBER(10),
  FDAT      DATE,
  LIM2      NUMBER(38,2),
  ACC       INTEGER,
  NOT_9129  INTEGER,
  SUMG      NUMBER(38,2),
  SUMO      NUMBER(38,2),
  OTM       INTEGER,
  KF        VARCHAR2(6 BYTE),
  SUMK      NUMBER (38,2),
  NOT_SN    INTEGER
  );

  rLim t_lim; -- данные ГПК за текщий платежный период

  DAT_och date ;

     PRAGMA AUTONOMOUS_TRANSACTION;
begin
        logger.trace ('GET_INFO_SUM_EXT: Start ');
        l_sRet:=''; l_ccid:=trim(CC_ID_); PUL.Set_Mas_Ini('CC_ID','', '№ КД');

         if CC_PAY_D<1 or CC_PAY_D>31 then
            CC_PAY_D:=null;
         end if;

        -------найти КД, вал.КД  и клиента
        If l_KV is null then
           begin
              --1. Искать в ЛОБ !
              SELECT d.nd, a.KV
              INTO    l_ND, l_KV
              FROM cc_deal d, cc_add a
              WHERE d.ND   = a.ND   and d.sos>9 and d.sos<15
                and d.cc_id= l_ccid and d.SDATE = DAT1_ and d.vidd in (11,12,13);
              -- ОДНОВАЛЮТНЫЙ, нашли однозначно, все хорошо
           EXCEPTION
           WHEN Too_Many_Rows THEN
                -- нашли НЕоднозн, м.б. МУЛЬТИВАЛ ? портебовать код вал
                l_sRet:='пом. №1 КД №'||l_ccid||' НЕ один. Задайте '||l_ccid ||'/вал';  raise STOP_PRC;
           WHEN NO_DATA_FOUND THEN
                -- НЕ нашли, м.б. он уже с кодом вал ? отсечь ее и поискать далее.
                begin
                   l_KV   := to_number(substr(l_ccid,-3));
                   l_ccid:= substr(l_ccid,1,length(l_ccid)-4);
                EXCEPTION  WHEN OTHERS THEN
                   l_sRet :='пом. №2 КД №'||l_ccid||' НЕ знайдено !'; raise STOP_PRC;
                end;
           end;
        end if;
        --============== код валюты уже известен  ================
        begin
           SELECT d.nd ,d.wdate ,c.rnk  ,  d.limit*100,
                  a.acc  , d.RNK,
                  to_number(substr(CCK_APP.GET_ND_TXT(d.nd,'FLAGS'),1,1)),
                  to_number(substr(CCK_APP.GET_ND_TXT(d.nd,'FLAGS'),2,1))
           INTO     l_ND,  DAT4_ ,  l_RNK , l_Limit,
                      ACC8_,    l_RNK,
                     tip_pog,
                     CC_PAY_I
           FROM cc_deal d, customer c,  accounts a, nd_acc n
           WHERE d.sos   > 9       and d.sos   < 14
             and d.rnk   = c.rnk   and a.KV    = l_KV and d.nd=n.nd and n.acc=a.acc
             and d.cc_id = l_ccid  and d.SDATE = DAT1_
             and a.tip='LIM'  and d.vidd in (11,12,13);
        EXCEPTION
        WHEN Too_Many_Rows THEN
             l_sRet :='пом. №3.КД №'||l_ccid||' знайдено НЕ однозначно!'; raise STOP_PRC;
        WHEN NO_DATA_FOUND THEN
             l_sRet :='пом. №4 КД №'||l_ccid||' НЕ знайдено !'; raise STOP_PRC;
        end;
        ------------------------------
         logger.trace ('GET_INFO_SUM_EXT: ND='||l_ND||' CC_PAY_I='||to_char(CC_PAY_I)||' tip_pog='||to_char(tip_pog) );
        --найти счет гашения
        begin
         -- 10-06-2013 Вводим поиск по 2620, который привязан к договору
         SELECT a.nls,greatest(a.ostc,a.ostb)
         into l_SG_NLS,l_nSG
         from nd_acc n, accounts a where n.nd=l_ND
         and a.NBS='2620' and a.kv=l_KV and n.acc=a.acc and a.dazs is null and a.tip not like 'W4%'; --COBUMMFO-9987 кроме карточных
        EXCEPTION
        WHEN Too_Many_Rows THEN
         l_sRet :='пом. №6.1.КД №'||l_ccid||' Знайдено дек_лька рахунк_в погашення 2620!'; raise STOP_PRC;

        WHEN NO_DATA_FOUND THEN
         Begin
          SELECT a.nls,greatest(a.ostc,a.ostb)
            into l_SG_NLS,l_nSG
            from nd_acc n, accounts a  where n.nd=l_ND
                 and a.tip='SG ' and a.kv=l_KV and n.acc=a.acc and a.dazs is null;
            if l_nSG>0 then
                 l_sRet :='пом №8.КД №'||l_ccid||' Транзитний рахунок погашення даного договору має незав_зований або нероз_браний залишок!'; raise STOP_PRC;
                        -- ||'Зверн_ться до бухгалтер_в кредитного в_дд_лу!' ;

            end if;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN null;
              l_sRet :='пом. №5.КД №'||l_ccid||' НЕ знайдено рахунок погашення (SG) !'; raise STOP_PRC;

            WHEN Too_Many_Rows THEN
             l_sRet :='пом. №6.0.КД №'||l_ccid||' Знайдено дек_лька рахунк_в погашення (SG) !'; raise STOP_PRC;

         end;
        end;

    ------------------------- Комиссия ----------------------------------------------------------------
        l_SK_ost:= 0;
         begin
           -- По какую дату нач ком ?
           SELECT acr_dat into l_DAT_SK FROM int_accn WHERE acc=ACC8_ and id=2;

             -- Узнаем валюту комиссии. Ищем один счет с наибольшим остатком
             -- на случай если в другой валюте открыт случайно
             -- (в процентной карточки будет остсутствовать счет SK9)

            SELECT kv
              INTO l_KVSK_
              from
               (
                select a.kv kv
                  FROM accounts a, nd_acc n
                 WHERE n.nd=l_ND and n.acc=a.acc and a.tip in ('SK0','SK9')
                 order by a.tip desc,a.ostb+a.ostf,decode (a.kv,l_KV,0,1)
               ) where rownum<2;

             -- Начинаем танцы с бубном из за прибамбаса НБУ гасить в грн.
             -- для не гривневой комиссии и комисии в другой валюте
             -- берем только два счета в указ вал и с макс. остатком
             if l_KVSK_<>l_KV  then
                  --   if l_KVSK_<>l_KV or l_KVSK_<> gl.baseval  then
                l_sRet:='Валюта комиссиии не совподает с валютой КД реф КД='||to_char(l_ND); raise STOP_PRC;
                /*
                SELECT
                       Nvl(-min(decode(a.tip,'SK0',ostb+ostf,0)),0) SK0_OST,
                       Nvl(-min(decode(a.tip,'SK9',ostb+ostf,0)),0) SK9_OST

                  INTO l_SK_ost,l_nSSPK
                  FROM accounts a, l_NDacc n
                 WHERE n.nd=l_ND and n.acc=a.acc and
                       a.tip in ('SK0','SK9') and a.kv=l_KVSK_;
                     */
                -- l_SK_ost:=nvl(l_SK_ost,0)+nvl(l_nSSPK,0);
             else
                SELECT
                       Nvl(-SUM(decode(a.tip,'SK0',ostb+ostf,0)),0) SK0_OST,
                       Nvl(-SUM(decode(a.tip,'SK9',ostb+ostf,0)),0) SK9_OST
                  INTO  l_SK_ost ,l_nSSPK
                  FROM accounts a, nd_acc n
                    WHERE n.nd=l_ND and n.acc=a.acc and
                          a.tip in ('SK0','SK9') and a.kv=l_KV;
             end if;
             -- Если комиссия в инвалюте и больше нуля ищем счет гашения в гривне
             /*
             if l_KVSK_!=gl.baseval and l_SK_ost>0 then
               begin
                 SELECT a.nls
                   into NLS_SG_980
                   from l_NDacc n, accounts a  where n.nd=l_ND
                        and a.tip='SG ' and a.kv=gl.baseval and n.acc=a.acc
                        and a.dazs is null and rownum=1;
               EXCEPTION
               WHEN NO_DATA_FOUND THEN null;
                 l_sRet :='пом №5.1.КД №'||l_ccid||' НЕ знайдено рахунок погашення (SG) у нац_ональн_й валют_!'; raise STOP_PRC;

               end;
             end if;
             */


         EXCEPTION WHEN NO_DATA_FOUND THEN
         l_nSSPK:=0; l_SK_ost:=0; l_KVSK_:=l_KV;
         end;

               ------------------ ПЕНЯ ------------------------------------

         l_nSN8:= 0;
         begin
          -- По какую дату нач пеня
          SELECT Nvl(i.acr_dat,a.daos-1),
                 a8.NLS,
                 a8.kv ,
                 a6.NLS,
                 -(a8.ostb+a8.ostf)
          INTO DAT_SN8_, SN8_NLS, l_KVSN8,SD8_NLS, l_nSN8
          FROM accounts a, nd_acc n, int_accn i, accounts a8, accounts a6
          WHERE n.nd=l_ND and n.acc=a.acc and a.tip in ( 'SPN','SP ','SK9' )
            and a.dazs is null
            and i.id=2 and a.acc=i.acc and i.acrA=a8.acc and i.acrB=a6.acc
            and a8.ostc<0
            and rownum=1;
         EXCEPTION
          WHEN NO_DATA_FOUND THEN null;
               -- для старых кредитов когда все счета закрыты
             if DAT4_<=LocalBD_ then
                begin
                    SELECT LocalBD_,
                           a.NLS,
                           a.kv ,
                           null,
                           -(a.ostb+a.ostf)
                    INTO DAT_SN8_, SN8_NLS, l_KVSN8,SD8_NLS, l_nSN8
                    FROM accounts a, nd_acc n
                    WHERE n.nd=l_ND and n.acc=a.acc and a.tip in ('SN8')
                      and a.dazs is null and a.ostc<0 and rownum=1;
                EXCEPTION
                 WHEN NO_DATA_FOUND THEN
                 null;
                end;
             end if;

          WHEN Too_Many_Rows THEN
            l_sRet :='пом. №7 КД №'||l_ccid||' Знайдено декілька рахунків просрочених відсотків (SPN)!'; raise STOP_PRC;
         end;

         -- суммы задолженностей
        -- 1)фактически начисленные %
         begin
          SELECT Nvl(-SUM(decode(a.tip,'SS ',a.ostb+a.ostf,0)),0),
                      Nvl(-SUM(decode(a.tip,'SP ',a.ostb+a.ostf)+decode(a.tip,'SL ',a.ostb+a.ostf,0)),0),
                      Nvl(-SUM(decode(a.tip,'SN ',a.ostb+a.ostf,0)),0),
                      Nvl(-SUM(decode(a.tip,'SPN',a.ostb+a.ostf)+decode(a.tip,'SLN ',a.ostb+a.ostf,0)),0)
            INTO  l_nSS_ost,l_nSSP,l_nSN_ost, l_nSSPN
            FROM accounts a, nd_acc n
           WHERE n.nd=l_ND and n.acc=a.acc and a.tip in ('SS ','SP ','SL ','SN ','SPN','SLN')
                 and a.kv=l_KV;
         exception when no_data_found then
          l_nSS_ost:=0; l_nSSP:=0; l_nSN_ost:=0; l_nSSPN:=0;
         end;

         logger.trace ('GET_INFO_SUM_EXT: l_SG_NLS='||to_char(l_SG_NLS)||' l_nSG='||to_char(l_nSG)||' l_SK_ost='||to_char(l_SK_ost)||' l_nSSPK='||to_char(l_nSSPK)||' DAT_SN8_='||to_char(DAT_SN8_)||' SN8_NLS='||to_char(SN8_NLS)||' l_KVSN8='||to_char(l_KVSN8)||' l_nSN8='||to_char(l_nSN8)||' l_nSN_ost='||to_char(l_nSN_ost)||' l_nSSPN='||to_char(l_nSSPN)||' l_nSS_ost='||to_char(l_nSS_ost)||' l_nSSP='||to_char(l_nSSP) );
         --
         -- старая философия платежный день всегда рабочий день то есть день если день субота тогда он переносится на понедельник и проц берем по воскрес  (перенос на пятницу был но сейчас на практике отсутствует)
         -- новая философия 2620 - если платеж субота он платит в понедельник но проц берем по пятницу (вариант на пятницу отсутствует в практике - поэтому его не рассматриваем)
         if substr(l_SG_NLS,1,2)='26' then
            CC_DAYNP:=-2;
         else
             CC_DAYNP:= coalesce(CCK_APP.GET_ND_TXT(l_ND,'DAYNP'),  to_number( GetGlobalOption('CC_DAYNP')),   1);
         end if;

        begin
           -- 3)ближайший платеж
           select      fdat, lim2, sumg, nvl(sumk,0), sumo
             into rLim.fdat,rLim.lim2,rLim.SUMg,rLim.SUMk       ,rLim.SUMo
             from cc_lim l
            where l.nd=l_ND and (l.nd,l.fdat)=
                  (select nd,min(fdat) from cc_lim
                   where nd=l_ND and fdat >= LocalBD_ and sumo>0
                   group by nd
                  );
             logger.trace ('GET_INFO_SUM_EXT: платеж следующий к оплате fdat='||to_char(rLim.fdat,'dd/mm/yyyy')||'LIMIT='||to_char(rLim.lim2)||' SUMo='||rLim.SUMo||' SUMg='||rLim.SUMg||' rLim.SUMk='||rLim.SUMk);
        --  Если больше месяца до погашения считаем такой вид кредита "кредитной линией" которая
        --  не предпологает погашения тела кредита на данную дату

          if cck_app.CorrectDate2(980,rLim.fdat, CC_DAYNP)>cck_app.CorrectDate2(980,add_months(LocalBD_,1),CC_DAYNP)
              or (TIP_SN=0 and rLim.fdat>last_day(LocalBD_))
                                    then
             logger.trace ('GET_INFO_SUM_EXT: следующий платеж еще не наступил');
             rLim.LIM2:=l_limit;
             rLim.SUMo:=0; -- проц вычисляем ниже по процедуре
             rLim.sumg:=0;
             rLim.SUMk:=0;
             logger.trace ('GET_INFO_SUM_EXT: 2 платеж следующий к оплате fdat='||to_char(rLim.fdat,'dd/mm/yyyy')||'LIMIT='||to_char(rLim.lim2)||' SUMo='||rLim.SUMo||' SUMg='||rLim.SUMg||' rLim.SUMk='||rLim.SUMk);
          end if;


        EXCEPTION  WHEN NO_DATA_FOUND THEN
             rLim.Lim2:=l_limit; rLim.SUMo:=0; rLim.SUMg:=0; rLim.SUMk:=0;
             rLim.fdat:=null;
        end;

       -- день погашения процентов определяем иг ГПК

         -- Если день погашения установлен то начисляем по него включительно (в Киеве проц начисляются по конец текущего месяца для старых КД)
         -- при заданном дне начисляем по вчерашний
          -- НАДО ДОБАВИТЬ ВАРИАНТ КРЕДИТ ЗАКОНЧИЛСЯ
         if CC_PAY_D>=1 and CC_PAY_D<=31 and (substr(l_SG_NLS,1,4)= '3739' or substr(l_SG_NLS,1,4) ='2909') then
            l_nRet:=1;
            dat_pog_SN:= cck_app.check_max_day(LocalBD_, CC_PAY_D,-2,gl.baseval); --  старая философия  (в Киеве проц начисляются по последний день месяца месяца для старых КД)
                                                                                                                                --оставляем логику   поскольку позволяет его
         elsif  rLim.fdat is not null and substr(l_SG_NLS,1,2) ='26'   then -- НОВАЯ ФИЛОСОФИЯ  берем из ГПК берем день погашения из ГПК
                if CC_PAY_I=0 then
                dat_pog_SN:= rLim.fdat-1; -- день
                l_nRet:=2;
                else
                dat_pog_SN:= trunc(last_day(add_months(rLim.fdat,-1))); -- за прошлый месяц
                l_nRet:=3;
                end if;
         else  -- Если не нашли в ГПК берем по дате погашения для старых КД с плохим ГПК  (резерв)
-- ???? месяц день
         l_nRet:=4;
         dat_pog_SN:= cck_app.check_max_day(LocalBD_, cck_app.pay_day_sn_to_nd (l_ND),-2,gl.baseval)-1;
                    -- Если платежный день тек-го месяца в прошлом повторяем тоже самое для следующего месяца
           -- код будет работать только для старых вариантов в новых  будет всегда больше или равно
           if dat_pog_SN<LocalBD_ then
            l_nRet:=5;
             if CC_PAY_D is null or CC_PAY_D<1 or CC_PAY_D>31 then
                l_nRet:=6;
                dat_pog_SN:= cck_app.check_max_day(add_months(LocalBD_,1), cck_app.pay_day_sn_to_nd (l_ND),-2,gl.baseval)-1;
             else
                l_nRet:=7;
                dat_pog_SN:= cck_app.check_max_day(add_months(LocalBD_,1), CC_PAY_D,-2,gl.baseval);
             end if;

           end if;
         end if;

             logger.trace ('GET_INFO_SUM_EXT CC_PAY_D='||to_char(CC_PAY_D)||' dat_pog_SN='||dat_pog_SN||' l_nRet='||to_char(l_nRet));

        -- 3600
         begin
          SELECT Nvl(a.ostb+a.ostf,0)
            INTO  l_nISG
            FROM accounts a, nd_acc n
           WHERE n.nd=l_ND and n.acc=a.acc and a.tip in ('ISG')
                 and a.nbs='3600'
                 and a.kv=l_KV and rownum=1 and a.dazs is null;
         exception when no_data_found then
          l_nISG:=0;
         end;
        -- Узнаем дельту переплаты для относительного метода. Берем по законному признаку   ( tip_pog=1 - без каникул), а не по признаку ануитет не ануитет
          if CC_PAY_S=1 or tip_pog=1 then
           begin
            -- DEL_SK4 - какую сумму погасил клиент в текущем месяце
            SELECT greatest(Nvl(SUM(s.KOS),0)-Nvl(SUM(decode(a.tip,'SP ',s.DOS,0)),0) ,0)
               INTO  Del_SK4
               FROM accounts a, nd_acc n,saldoa s
              WHERE n.nd=l_ND and n.acc=a.acc and a.tip in ('SS ','SP ')
                    and a.kv=l_KV and s.acc=a.acc
                    and s.fdat>(select max(fdat) from cc_lim
                                 where nd=l_ND and fdat < LocalBD_ and sumg>0
                               );

             logger.trace ('GET_INFO_SUM_EXT: Погашено в тек. месяце Del_SK4='||to_char(Del_SK4));

           DEL_SK4:=greatest(least(rLim.Sumg,DEL_SK4)-greatest(l_nSS_ost-rLim.LIM2,0),0);


             logger.trace ('GET_INFO_SUM_EXT: Дельта переплаты Del_SK4='||to_char(Del_SK4));
           exception when no_data_found then
             Del_SK4:=0;
             logger.trace ('GET_INFO_SUM_EXT: Дельта переплаты exception Del_SK4='||to_char(Del_SK4));
           end;
          end if;

        -- Рассматриваем 4 варианта (ануитет, равные части)х(относительный метод, абсолютный)
        -- l_nSS - сумма тек - го платежа по телу кредита
        --l_nSSpay - сумма с которой не надо взымать досрочку ( а ля сумма текущего платежа)
         If rLim.fdat is not null and LocalBD_<DAT4_ then
            If  tip_pog=1 then
               -- расшифровка формулы-Сумма по ГПК, 2 Просрочка +тек пл- дельта оплат тек мес но небол
               l_nSS:= greatest(l_nSS_ost+l_nSSP-rLim.LIM2,least( rLim.Sumg-Del_SK4,l_nSS_ost),0) ; --без каникул
               logger.trace ('GET_INFO_SUM_EXT:  1. l_nSS= '||l_nSS);
            else
               l_nSS:= greatest(l_nSS_ost+l_nSSP -rLim.LIM2,l_nSSP,0); --с каникулами
                              logger.trace ('GET_INFO_SUM_EXT: 2  l_nSS= '||l_nSS);
            end if;
         else
             l_nSS:= l_nSS_ost;
               logger.trace ('GET_INFO_SUM_EXT:  3 l_nSS= '||l_nSS);
         end if;

        -- Процент за дострокове погашення
        -- begin
        /*
           ratn_advanced:=acrn.fprocn(ACC8_,4,null);
              logger.trace ('GET_INFO_SUM_EXT: Процентная ставка за досрочное погашение ratn_advanced='||to_char(ratn_advanced));
           if ratn_advanced>0 and LocalBD_<DAT4_ then
             -- sAddInfo_:= sAddInfo_||'<BR>'||'Комiсiя за дострокове погашення становить: '||to_char(ratn_advanced,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||'%';
              if  l_KV!=gl.baseval then
                --  sAddInfo_:= sAddInfo_||'<BR>'||'<font color="red"><b> Комiсiя за дострокове погашення для iноземних валют автоматично не стягується.<br>Для сплати використовуйте iншу операцiю. </b></font>';
                 null;
              else
                  l_nSK4:=trunc(greatest(l_nSS_ost-l_nSSpay,0)*ratn_advanced*0.01,2);
                  if l_nSK4 >0 then
                  --sAddInfo_:= sAddInfo_||'<BR>'||'При остаточному погашенн_ комiсiя за дострокове погашення буде становити: '||to_char(l_nSK4,'999G999G999G990D99','NLS_NUMERIC_CHARACTERS = '',.'' ')||' грн.';
                  null;
                  end if;
             logger.trace ('GET_INFO_SUM_EXT: Сумма достр пог='||to_char(l_nSK4)||' l_nSS_ost= '||to_char(l_nSS_ost)||'l_nSSpay= '||to_char(l_nSSPAY));
           end if;
           end if;

*/

        --прогноз %% и комиссии  - доначислить %% в игровом режиме


           savepoint DO_ACRN;
           FOR k in (SELECT a.acc,a.tip,i.metr,NVL(i.acr_dat, a.daos-1) + 1 DAT1,a.nls,i.stp_dat,i.basem, a.accc, i.id
                     FROM nd_acc n, accounts a, int_accn i
                     WHERE n.nd=l_ND and n.acc=a.acc and a.dazs is null and a.acc=i.acc
                                and i.acra is not null
                                and (i.id=0 and a.tip in ( 'SS ','SP ','SL ')OR (i.id=2 and a.tip='LIM' ))
                     )
           LOOP
              If k.Tip='LIM'  and l_DAT_SK< nvl(k.stp_dat,dat_pog_SN)  then
                 --  Нач.коми по разным METR
                  --delete from ACR_INTN where acc=k.acc;
                 CC_KOMISSIA (k.Metr,k.Acc, 2, k.Dat1, least(nvl(k.stp_dat,rLim.fdat-1),rLim.fdat-1), l_nSK, Null,0);
                 l_nSK := abs( nvl(l_nSK,0));
              elsif  k.Tip in ('SS ','SP ','SL ') then

                if k.DAT1 < nvl(k.stp_dat,dat_pog_SN) then
                 -- delete from ACR_INTN where acc=k.acc;
                  /*
                  acrn.p_int(k.Acc,0,k.DAT1,least(nvl(k.stp_dat, LocalBD_-1),LocalBD_-1),nInt_,NULL,1); - начисление до текущего дня
                  -- здесь l_nSN - сумма неначисленных % по прошлый день
                  l_nSN:=l_nSN+abs(round(nvl(nInt_,0)));


                           -- по платежный день
                    --   if LocalBD_<=least(dat_pog_sn,nvl(k.stp_dat,dat_pog_sn)) then
                          --acrn.p_int(k.Acc,0, LocalBD_, least(nvl(k.stp_dat,dat_pog_sn),dat_pog_sn),nInt_,NULL,1); -- вариант от сегоднешнего дня до платежной даты
                   */
                        if  nvl(k.basem,0)=1 then
                           CCK.INT_METR_A(k.Accc,k.acc,0,k.DAT1, least(nvl(k.stp_dat,dat_pog_sn),dat_pog_sn),nInt_,NULL,1);
                           l_nRet:=1;
                        else
                          acrn.p_int(k.Acc,0,k.DAT1, least(nvl(k.stp_dat,dat_pog_sn),dat_pog_sn),nInt_,NULL,1);             -- вариант от последнего начисления до платежного дня
                          l_nRet:=0;
                         end if;
                            logger.trace ('GET_INFO_SUM_EXT nls= '||k.nls||' id= '||k.id||' basem='||to_char(l_nRet)||' l_nSN='||to_char(nInt_));
                          l_nSN:=l_nSN+abs(round(nInt_));
                     --  end if;
                end if;
              end if;
           END LOOP;
           rollback;

     /*
   l_nS                  - Сумма текущего платежа
   l_nS1                - Сумма окончательного платежа
   ---- ТЕЛО
   l_nSS                - Тек. платеж  с условной прострочкой (платеж(ы) не вынесены на прострочку  )  ВЫЧИСЛЯЕМ
   l_nSS_ost             - остаток   основного долга по КП

   -- ПРОЦЕНТЫ
   l_nSN_ost    - Сумма нач %   на счетах  остаток
   l_nSN   - Сумма проц.долга   по платежный день        ВЫЧИСЛЯЕМ
   l_nSN_end   - Оконч.Сумма проц.долга      для закрытия КД (напр. досрочно - когда проц за прошл месяц)    ВЫЧИСЛЯЕМ
   --Комиссия
   l_SK_ost              - сумма уже начисленной комиссии
   l_nSK           - Сумма комис.долга для погашения (совпадает всегда с закрытием КД)

   -- 3600
   l_nISG - остаток на счете 3600

   --ПЕНЯ
   l_nSN8    number  ; -- сумма уже начисленной пени  ДОНАЧИСЧЛЕНИЯ НЕ ПРОИЗВОДИМ ПЕНЯ ДОЛЖА НАЧИСЛЯТЬСЯ ЕЖЕДНЕВНО
   -- СЧЕТ ГАШЕНИЯ
   l_nSG    -- остаток на счете гашения
   -- ПРОСРОЧКИ
   l_nSSP     --\ сумма просроченного тела
   l_nSSPN  - -\ сумма просроченных процентов
   l_nSSPK   --\ сумма  просроченной комиссии

   -- Комиссия за досрочное погашение платежа при досрочном погашении
    l_nSK4
    del_SK4    -- дельта уже погашенной суммы в тек-ем месяце

   l_nSN      --  недонарахованні відсотки з дати LocalBD_ (майбутні)
  */

           -- проценты по платежный день с просрочкой
         l_nSN:=l_nSN+l_nSN_ost+l_nSSPN;
         --l_nSN_end:=l_nSN+l_nSSPN; надо изменить условия для начисления по плат дату всегда
         --  Комиссия
         l_nSK:=l_SK_ost + l_nSK;
         --  Проценты +Комиссия - остаток на 3600
          l_nSN:=greatest(l_nSN+l_nSK- abs(l_nISG),0);

         --  платiж
        --  тело(с просрочкой) + проценты + комиссия + пеня
         l_nS := l_nSS
                + (case when tip_pog=1
                        then greatest(l_nSN,(rLim.SUMo-nvl(rLim.SUMk,0)-(rLim.SUMg-Del_SK4)))
                        else l_nSN
                    end)
                  +(case when l_KV=l_KVSK_ and l_KVSK_=gl.baseval then l_SK_ost else 0 end)
                  +(case when l_KV=980 and substr(l_SG_NLS,1,4)='2620'  then l_nSN8 else 0 end);

         -- окончательное погашение
         --  тело + проценты + комиссия + пеня
         l_nS1 := l_nSS_ost
                      + l_nSN
                      +(case when l_KV=l_KVSK_ and l_KVSK_=gl.baseval then l_SK_ost else 0 end)
                      +(case when l_KV=980 and substr(l_SG_NLS,1,4)='2620'  then l_SK_ost else 0 end);

           logger.trace ('GET_INFO_SUM_EXT  l_nS1 = '||l_nS1||' l_nS = '||l_nS||' l_nSN = '||l_nSN||' l_nSK = '||l_nSK);
                   logger.trace ('GET_INFO_SUM_EXT   l_nS = '||l_nS||'l_nSS = '||l_nSS||' l_SN = '||(case when tip_pog=1
                        then greatest(l_nSN,(rLim.SUMo-nvl(rLim.SUMk,0)-(rLim.SUMg-Del_SK4)))
                        else l_nSN
                    end) ||' SK = '||(case when l_KV=l_KVSK_ and l_KVSK_=gl.baseval then l_SK_ost else 0 end)||' l_nSK = '||l_nSK||' SN8='||(case when l_KV=980 and substr(l_SG_NLS,1,4)='2620'  then l_nSN8 else 0 end));

           l_nS   :=greatest(round (l_nS   -  l_nSG,2),0);
           l_nS1 :=greatest(round (l_nS1 - l_nSG,2),0);  -- выплыли сотые и у кассиров было масса вопросов



        <<KONEC>> null;
        PUL.Set_Mas_Ini( 'CC_ID', l_ccid, '№ КД' );


        RETURN l_nS;
       commit;
exception when  STOP_PRC then
 RAISE_APPLICATION_ERROR (-20111,l_sRet);


END;
/
 show err;
 
PROMPT *** Create  grants  GET_INFO_SUM_EXT ***
grant EXECUTE                                                                on GET_INFO_SUM_EXT to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on GET_INFO_SUM_EXT to RCC_DEAL;
grant EXECUTE                                                                on GET_INFO_SUM_EXT to STO;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/function/get_info_sum_ext.sql =========*** E
 PROMPT ===================================================================================== 
 
