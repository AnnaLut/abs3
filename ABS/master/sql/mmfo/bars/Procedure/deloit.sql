

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/DELOIT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure DELOIT ***

  CREATE OR REPLACE PROCEDURE BARS.DELOIT (mode_  INT,  -- режим формирования
                                         s_DAT1 VARCHAR2,
                                         s_DAT2 VARCHAR2)
IS

-- mode_ = 3 Дов_дник користувач_в обл_кової системи
-- mode_ = 2 План рахунк_в з обов'язковими полями:
-- mode_ = 1 информация по проводкам за период с учетом коригуючих.
-- mode_ = 4 Оборотно-сальдова в_дом_сть за трет_й квартал 2010 року, яка в_дпов_дає за сумою на ф_нансових рахунках _нформац_ї в базах трансакц_й обл_кових систем, з обов'язковими полями:
-- mode_ = 5 Сверка оборотов в сальдовке и проводок
-- mode_ = 6 по депозитным счетам клиентов информацию

/*
16.02.2015 Замена таблиц с именет TEST* --> ANI*
TEST_DEL1
TEST_DEL2
TEST_DEL3
TEST_DEL4
TEST_DEL6

 02.09.2014 Sta Mode=1. Перешла на OPER
 02.09.2014 Sta Только для 300465 , т.к.в РУ это будет безумно долго ! (Mode=1 Заміна OPLDOK -> OPLDOV  )

  7/03-14 Mode=1 Заміна OPLDOK -> OPLDOV
 24-01-2012 Если дата DAT_END в архиве договоров пустая, то брать из карточки счета.
            Если сч нач % = осн, то НЕ брать

 16-01-2012 вместо to_char(k.MDATE,'dd.mm.yyyy')  должно быть
                   to_char(l_MDATE,'dd.mm.yyyy') :

 13-01-2012 Ост с учетом корр (m.ostq - m.crdosQ + m.crkosQ )

 12-01-2012 Для ФЛ-СПД (custtype=3, sed='91') отношение д.б. как для  custtype=2
            Даты начала и завершения DEP-дог
                 для расчета кодов срока S240 +S180
                 берем из архива договоров, а не из текущих параметров.

 11-01-2012 OE заменила на VED  Для 2600 убрала об22=02

 04-01-2012 Были пропущены БС
           ('2622','2625','2514','2525','2546','2610','2615','2651','2652' )
            как не имеющие ограничения по об22.

 29-12-2011 В контексте этой переписки нужно дополнит такие :
            2620(07) - Приватний Нотар_ус
            2630(40) - Золотой Стандарт
            2635(33) - Золотой Стандарт
            2635(07,08) - Депозити по забезпеченню операц_й з БПК

09-12-2011 Sta Остаток на сче нач %
------------------------------------------------------
*/

  l_Sql varchar2(4000);

  -- шаблон для дат
  ch_ varchar2(10) := 'dd-mm-yyyy';

  -- '01-12-2010';  -- Первый мес
  DAT01_ char(10) := s_DAT1 ;

  -- '01-01-2011';  -- Второй мес
  DAT02_ char(10) := to_char(add_months(to_date(s_DAT1,ch_), 1 ), ch_ );

  -- ПоследниЙ мес   01.12.2010
  DAT12_ char(10) := to_char(add_months(trunc(to_date(s_DAT2,ch_),'MM'),0),ch_);

  -- след.за Последним мес   01.01.2011
  DAT13_ char(10) := to_char(add_months(trunc(to_date(s_DAT2,ch_),'MM'),1),ch_);

  -- след.за Последним мес+1 01.02.2011
  DAT14_ char(10) := to_char(add_months(trunc(to_date(s_DAT2,ch_),'MM'),2),ch_);

  Tabn_  varchar2(20) := 'ANI_del'|| MODE_;
  Tabn1_ varchar2(20) := 'ANI_del1' ;
  Tabn4_ varchar2(20) := 'ANI_del4' ;
  -----------------------------------------------------
  l_dat2       date     := to_date( s_DAT2 , 'dd-mm-yyyy' ) ;
  l_caldt_date ACCM_CALENDAR.caldt_date%type ;
  l_caldt_id   ACCM_CALENDAR.caldt_id%type   ;

BEGIN
  logger.info('DELOIT(mode_=>'||mode_||'s_DAT1=>'''||s_DAT1 ||''', s_DAT2=> '''||s_DAT1 ||''') -- BEGIN' );
  TUDA;

  IF s_DAT2 is not null 
  THEN     
    l_caldt_date := trunc ( l_dat2, 'MM');
    BEGIN  
      select caldt_id 
        into l_caldt_id 
        from ACCM_CALENDAR 
       where caldt_date =l_caldt_date ;
    EXCEPTION 
      WHEN NO_DATA_FOUND THEN raise_application_error(-20100,'В ACCM_CALENDAR вiдсутня дата '||to_char(l_caldt_date,'dd.mm.yyyy') ) ;
    END;
  END IF;

  IF mode_ not in ( 6,1)  
  THEN
    BEGIN      
      execute immediate 'drop table '|| Tabn_  ;
    EXCEPTION 
      WHEN OTHERS 
      THEN
        ---00942: table or view does not exist
        IF sqlcode = -00942 
        THEN      
          null;      
        ELSE        
          raise;      
        END IF;
    END;
  END IF;

  IF mode_ = 6 THEN

    DECLARE
      l_G01   varchar2(50) := substr(GetGlobalOption( 'GLB-NAME' ), 1, 50 ); -- 1.  Назва рег_онального управл_ння
      l_G02   varchar2(6)  := substr(GetGlobalOption( 'GLB-MFO'  ), 1, 6  ); -- 2.  МФО балансової установи
      l_G25   varchar2(4)  := 'BARS'; -- 25. Програма _з якої йшла вигрузка _нформац_ї

      l_cust  customer.custtype%type ;
      l_NMK   varchar2(38) ; -- 4.  П_Б власника рахунку/вкладника/Назва кл_єнта
      l_okpo  varchar2(10) ; -- 5.  _дентиф_кац_йний номер власника рахунку/вкладника/ЄДРПОУ кл_єнта
      l_insi  int          ; -- 9.  Ознака _нсайдера
      l_rez   int          ; -- 10. Резидент. нерезидент
      l_ND    varchar2(35) ; -- 11. Номер договору
      l_VIDD  int          ; -- 12. Вид вкладу (продукт)
      l_ostqP number       ; -- 18. Нарахован_ витрати, грн. екв.
      l_IR    number       ; -- 20. Д_юча в_дсоткова ставка за даним договором,  %
      l_FREQ  int          ; -- 21. Пер_одичн_сть сплати в_дсотк_в зг_дно з договором (1-щом_сячно, 2- щоквартально, 3- в к_нц_ строку д_ї договору, 4-щор_чно)
      l_240   char(1)      ; -- 22. Код строку до погашення зг_дно класиф_катора KL_S240 (файл #А7)
      l_180   char(1)      ; -- 23. Код початкового погашення (зг_дно класиф_катора KL_S180)
      l_VED   varchar2(2)  ; -- 24. Галузь економ_ки (зг_дно класиф_катора KL_K111)
      l_SED   varchar2(2)  ; -- = '91' для СПД
      l_mdate accounts.mdate%type;
      l_daos  accounts.daos%type;
    BEGIN
      /*
      Нужно выгрузить по депозитным счетам клиентов информацию
      в виде текстового csv файла. Пример файла DPUUUDMY.000

      Как выгружать описано в файле Рекомендацii щодо заповнення полiв
      форми Таблицi F_22.doc
      ФИО клиента нужно зашифровать.
      Список балансовых счетов в файле Рахунки до форми F_22_Физ и Юр.xls
      ---------------------------
      п2620, п2622, п2625, п2630, п2635, п2514, п2525, п2546, п2600 (ОБ22 02-09),
      п2610, п2615, п2650(об22 02-08),   п2651, п2652
      */

      EXECUTE IMMEDIATE 'delete from '|| Tabn_  ;
      COMMIT;

      /*
      l_Sql :='create table ' || Tabn_ || '
              ( G01 varchar2(50), G02 varchar2(6) , G03 varchar2(22), G04 varchar2(38), G05 varchar2(10),
                G06 varchar2(4) , G07 varchar2(2) , G08 varchar2(14), G09 int         , G10 int         ,
                G11 varchar2(35), G12 int         , G13 int         , G14 varchar2(10), G15 varchar2(10),
                G16 number      , G17 number      , G18 number      , G19 number      , G20 number      ,
                G21 int         , G22 char(1)     , G23 char(1)     , G24 varchar2(2) , G25 varchar2(4) )
              ';

      l_G01 := replace (l_G01,'''','`');
      l_G01 := replace (l_G01,'|','\');

      EXECUTE IMMEDIATE l_Sql;
      */

      BEGIN
        execute immediate 'grant insert, delete, select, update on '||Tabn_||' to start1';
      EXCEPTION 
        WHEN OTHERS THEN null;
      END;

      /*
      G01 varchar2(50), -- 1.  Назва рег_онального управл_ння
      G02 varchar2(6) , -- 2.  МФО балансової установи
      G03 varchar2(22), -- 3.  № ТВБВ
      G04 varchar2(38), -- 4.  П_Б власника рахунку/вкладника/Назва кл_єнта
      G05 varchar2(10), -- 5.  _дентиф_кац_йний номер власника рахунку/вкладника/ЄДРПОУ кл_єнта
      G06 varchar2(4) , -- 6.  Номер балансового рахунку (4 цифри)
      G07 varchar2(2) , -- 7.  Частина номеру  анал_тичного рахунку (2 цифри зг_дно ОВ22)
      G08 varchar2(14), -- 8.  Номер особового рахунку
      G09 int         , -- 9.  Ознака _нсайдера
      G10 int         , -- 10. Резидент. нерезидент
      G11 varchar2(35), -- 11. Номер договору
      G12 int         , -- 12. Вид вкладу (продукт)
      G13 int         , -- 13. Валюта рахунку (зг_дно класиф_катора валют R _030)
      G14 varchar2(10), -- 14. Дата в_дкриття  рахунку (початку договору)
      G15 varchar2(10), -- 15. Дата зак_нчення строку д_ї договору ( за наявност_ )
      G16 number      , -- 16. Залишок, у одиницях валюти рахунку
      G17 number      , -- 17. Залишок, грн. екв.
      G18 number      , -- 18. Нарахован_ витрати, грн. екв.
      G19 number      , -- 19. Неамортизований дисконт/прем_я, грн. екв.
      G20 number      , -- 20. Д_юча в_дсоткова ставка за даним договором,  %
      G21 int         , -- 21. Пер_одичн_сть сплати в_дсотк_в зг_дно з договором (1-щом_сячно, 2- щоквартально, 3- в к_нц_ строку д_ї договору, 4-щор_чно)
      G22 char(1)     , -- 22. Код строку до погашення зг_дно класиф_катора KL_S240 (файл #А7)
      G23 char(1)     , -- 23. Код початкового погашення (зг_дно класиф_катора KL_S180)
      G24 varchar2(2) , -- 24. Галузь економ_ки (зг_дно класиф_катора KL_K111)
      G25 varchar2(4) ) -- 25. Програма _з якої йшла вигрузка _нформац_ї
      */

      FOR k IN (select a.acc, a.branch, a.rnk, a.nls,  a.nbs , a.ob22, a.kv,
                       a.dazs, a.daos , a.mdate, a.tip,
                       (m.ost  - m.crdos  + m.crkos  ) OST,
                       (m.ostq - m.crdosQ + m.crkosQ ) OSTq
                  from accounts  a, ACCM_AGG_MONBALS m
                 where a.nbs in ('2620','2622','2625','2630','2635','2514','2525',
                                 '2546','2600','2610','2615','2650','2651','2652')
                   and a.daos <= l_dat2
                   and (a.dazs is null or a.dazs >=l_dat2)
                   and a.acc = m.acc and m.caldt_id = l_caldt_id
               )
      LOOP

        IF    k.nbs in ('2622','2625','2514','2525','2546','2610','2615','2651','2652' )
           OR k.NBS in ('2600') and k.OB22 in (     '03','04','05','06','07','08','09')
           OR k.NBS in ('2650') and k.ob22 in ('02','03','04','05','06','07','08')
           OR k.nbs in ('2620','2630','2635' ) and k.tip = 'DEP'
           OR k.nbs in ('2620') and k.ob22 in ('07')           -- 2620(07) Приватний Нотар_ус
           OR k.nbs in ('2630') and k.ob22 in ('40')           -- 2630(40) Золотой Стандарт
           OR k.nbs in ('2635') and k.ob22 in ('33','07','08') -- 2635(33) Золотой Стандарт
                                                               -- 2635(07,08)- Деп.по забезпеченню операц_й з БПК
          THEN  
            NULL  ;
          ELSE       
            goto HET_;
        END IF;

        BEGIN
          select c.custtype, nvl(substr(replace (c.nmk,'''','`') ,1,38), '???' ) ,
                 nvl(substr(c.okpo,1,10), '???' ) ,   
                 nvl(c.PRINSIDER, 99),
                 decode (c.codcagent , 2,2, 4,2, 6,2, 1),
                 substr ( nvl(trim(c.ved),'??'),1,2),
                 substr ( nvl(trim(c.sed),'??'),1,2)
            into l_cust, l_NMK, l_okpo, l_insi, l_rez, l_VED , l_SED
            from customer c
           where c.rnk = k.RNK;
        EXCEPTION 
          WHEN NO_DATA_FOUND THEN goto HET_;
        END;

        l_nmk   := replace (l_nmk,'|','\');
        -- Простий алгоритм шифрування пр?звища(алгоритм Цезаря).
        -- l_nmk := f_crypt(l_nmk);

        l_ND := '?'; l_VIDD := 0; l_ostqp :=0; l_FREQ := 0; l_240:= '0'; l_180 := '0';

        BEGIN
           select (m.ostq - m.crdosQ + m.crkosQ )
             into l_ostqp  from int_accn i, ACCM_AGG_MONBALS m
            where i.id = 1 
              and i.acc=k.acc  
              and m.acc= i.acra 
              and m.caldt_id = l_caldt_id;
        EXCEPTION 
          WHEN NO_DATA_FOUND THEN null;
        END;

        l_daos  := k.daos  ; -- начальная дата
        l_mdate := k.MDATE ; -- конечная  дата

        BEGIN
          IF k.tip = 'DEP'   
            THEN
              IF ( l_cust = 2 OR l_SED='91')   
                THEN
                  -- ЮЛ + СПД  -------------------------
                  select ND,   VIDD,   FREQv,   DAT_END, DAT_BEGIN
                    into l_nd, l_VIDD, l_FREQ , l_mdate  , l_daos
                    from ( select nvl(d.nd,to_char(d.Dpu_ID)) ND,
                                  d.VIDD, d.FREQv, d.DAT_END ,d.DAT_BEGIN
                             from DPU_DEAL_UPDATE d
                            where acc = k.acc 
                              and d.DATEU <= l_dat2
                            order by d.DATEU desc
                          )
                    where rownum = 1;
                ELSIF l_cust = 3 
                  THEN
                    -- чистые ФЛ  ---
                    select nvl(ND,to_char(d.DEPOSIT_ID)), VIDD, FREQ, DAT_END, DAT_BEGIN
                      into l_ND, l_VIDD , l_FREQ, l_mdate , l_daos
                      from DPT_DEPOSIT_CLOS d
                     where d.acc=k.acc
                       and (d.idupd) = (select max(idupd) 
                                          from dpt_deposit_clos
                                         where bdate <= l_dat2 
                                           and deposit_id=d.deposit_id);
              END IF;
            ELSIF k.tip like 'PK_'    
              THEN
                --БПК
                select to_char(d.nd), nvl(d.product_id,0)
                  into l_ND, l_VIDD
                  from bpk_acc d 
                 where acc_pk=k.acc;
              ELSE
                  null;
          END IF;
        EXCEPTION 
          WHEN NO_DATA_FOUND THEN null;
        END;

        IF l_mdate <= l_dat2 
          THEN 
            l_IR := 0;
          ELSE                       
            l_IR := nvl( acrn.fprocn( k.acc,1,l_dat2), 0);
        END IF;

        IF l_MDATE is not null 
          THEN
            -- есть договорная база
            l_240 := nvl ( f_srok ( l_dat2,  l_MDATE, 2 ), '0' );
            l_180 := nvl ( f_srok ( l_daos,  l_MDATE, 2 ), '0' );
          ELSE
            BEGIN
              -- просто спец.параметры
              select nvl(trim(S240),'0'), nvl(trim(s180),'0')    
                into l_240, l_180
                from specparam 
               where acc=k.acc;
            EXCEPTION 
              WHEN NO_DATA_FOUND THEN null;
            END;
        END IF;

        IF nvl(l_240,'0') = '0'  
          THEN l_240 := fs180_def(k.NBS, 2); 
        END IF;
        IF nvl(l_180,'0') = '0'  
          THEN l_180 := fs180_def(k.NBS, 2); 
        END IF;

        l_Sql := 'insert into ' || Tabn_  || 
                 '(G01, G02, G03, G04, G05, G06, G07, G08, G09, G10, G11, G12, G13, 
                   G14, G15, G16, G17, G18, G19, G20, G21, G22, G23, G24, G25 ) values ('''||
                 l_G01  ||''','''|| l_G02 ||''','''||k.BRANCH||''','''|| l_NMK  ||''','''||
                 l_okpo ||''','''||
                 k.NBS  ||''','''||k.ob22 ||''','''||k.NLS   ||''','  || l_insi ||'  ,  '||
                 l_rez  ||  ','''||
                 l_ND   ||''','  ||l_VIDD ||'  ,  '||k.KV    ||'  ,'''||
                 to_char(k.DAOS ,'dd.mm.yyyy')               ||''','''||
                 to_char(NVL(l_MDATE,K.MDATE),'dd.mm.yyyy')  ||''',  '||k.OST   ||'  ,  '||
                 k.OSTQ ||'  ,  '||
                 l_ostqp||',0,'  || to_char(l_IR)            ||'  ,  '|| l_FREQ ||'  ,'''||
                 l_240  ||''','''|| l_180 ||''','''|| l_VED  ||''','''|| l_G25  || ''' )';
        EXECUTE IMMEDIATE l_Sql;

        <<HET_>> null;

      END LOOP;

    END;
  
    logger.info('DELOIT(mode_=>'||mode_||'s_DAT1=>'''||s_DAT1 ||''', s_DAT2=> '''||s_DAT1 ||''') -- END' );
    SUDA;
    RETURN;

  END IF ;

------------------------------
if mode_ = 3 then

  /* 3. Дов_дник користувач_в обл_кової системи з обов'язковими полями:
        ID   a. _дентиф_катор користувача;
        FIO  b ._м'я та пр_звище користувача.
  */

   EXECUTE IMMEDIATE
'create table ' || Tabn_ || ' AS select id, fio from staff$base order by id ';

   begin
     execute immediate 'grant select, update on '||Tabn_||' to start1';
   exception when others then null;
   end;
  logger.info('DELOIT(mode_=>'||mode_||'s_DAT1=>'''||s_DAT1 ||''', s_DAT2=> '''||s_DAT1 ||''') -- END' );
  RETURN;

end if;
-------------------------------
If mode_ = 2 then
  /* 2.	План рахунк_в з обов'язковими полями:
     KV, NLS a. Номер ф_нансового рахунку;
     NMS     b. Назва ф_нансового рахунку;
  */
   EXECUTE IMMEDIATE 'create table ' || Tabn_ || ' AS
 select a.kv, a.nls, a.nms
 from accounts a
 where  a.nbs not like''8%''
   and  a.daos <  to_date('''|| DAT14_ || ''',''dd-mm-yyyy'')
   and (a.dazs is null
        or
        a.dazs < to_date('''|| DAT01_ || ''',''dd-mm-yyyy'')
        ) ';

   begin
     execute immediate 'grant select, update on '||Tabn_||' to start1';
   exception when others then null;
   end;
  logger.info('DELOIT(mode_=>'||mode_||'s_DAT1=>'''||s_DAT1 ||''', s_DAT2=> '''||s_DAT1 ||''') -- END' );
  RETURN;

end if;

--------------------- ANI_DEL1 --- ПРОВОДКИ ---------------
If mode_ = 1 then

 /* информация по проводкам за период с учетом коригуючих.
    1.Вс_ трансакц_ї з баз трансакц_й (головних книг) обл_кових систем,
      на баз_ яких була створена ф_нансова зв_тн_сть за трет_й квартал 2010 року
      (сума вивантажених трансакц_й по ф_нансових рахунках має дор_внювати оборотно-сальдов_й в_домост_ за в_дпов_дний пер_од),
      з обов'язковими полями:
     -----------------------
     REF      a. Номер трансакц_ї в обл_ков_й систем_ (призначається системою автоматично);
     PDAT     b. Дата введення трансакц_ї в обл_кову систему (має реєструватись системою автоматично);
     FDAT     c. Дата в_дображення трансакц_ї в ф_нансов_й зв_тност_ (зазвичай задається користувачем);
     ND       d. Номер документа, що п_дтверджує трансакц_ю;
     DATD     e. Дата документа, що п_дтверджує трансакц_ю;
     USERID   f. _дентиф_катор користувача;
     NLSD     g. Номер ф_нансового рахунку "Деб_т" зг_дно з планом рахунк_в;
     NLSK     h. Номер ф_нансового рахунку "Кредит" зг_дно з планом рахунк_в;
     SQ       i. Сума трансакц_ї в системн_й валют_ (валют_ створення балансу);
     KV       j. Валюта трансакц_ї, якщо використовується мультивалютн_сть;
     S        k. Сума трансакц_ї в ориг_нальн_й валют_;
--   MFO      l. _дентиф_катор структурного п_дрозд_лу або п_дприємства, якщо може бути застосовано.
     NAZN     m. Опис (пояснення) трансакц_ї користувачем;
 */

declare l_dat1 date := TO_DATE (s_DAT1, 'dd.mm.yyyy');  l_dat2 date := TO_DATE (s_DAT2, 'dd.mm.yyyy');
        aaD accounts%rowtype;  aaK accounts%rowtype;      l_ref varchar2(21);  l_NAZN varchar2(160);
begin
  EXECUTE IMMEDIATE ' truncate table ANI_DEL1 ' ;

  for p in (select  * from oper where vdat >= l_dat1 and vdat <= l_dat2  and sos <> - 1)
  loop
     for o in ( SELECT fdat,stmt,tt,s,sq,txt, acc accd, 0 acck FROM opldok WHERE ref=p.ref and sos=5  and tt not like 'ZG_' and dk=0 )

     loop
        If o.fdat <= l_dat2 OR  p.vob in (96, 99) then

           select * into aaD from accounts where  acc = o.accd;
           If (aaD.nls like '14%' or aaD.nls like '31%' or aaD.nls like '32%' or aaD.nls like '33%') and
               aaD.accc is not null and aaD.nbs is null then
               select * into aaD from accounts where  acc = aaD.accc;
           end if;

           begin
              select acc into o.acck  from opldok   where ref = p.ref and stmt = o.stmt and dk = 1 ;
              select *   into aaK     from accounts where acc = o.accK;
              If (aaK.nls like '14%' or aaK.nls like '31%' or aaK.nls like '32%' or aaK.nls like '33%') and
                 aaK.accc is not null and aaK.nbs is null then
                 select * into aaK from accounts where  acc = aaK.accc;
              end if;
              l_ref := p.REF||'*'||o.stmt ;    If o.tt = p.tt then l_nazn := p.nazn; else l_nazn :=o.txt; end if;
              insert into  ANI_DEL1 (ref,   PDAT,   FDAT,   ND,   DATD,   USERID,    NLSD,    NLSK,   SQ,     KV,   S,   NAZN )
                            values (l_ref, p.PDAT, o.FDAT, p.ND, p.DATD, p.USERID, aad.NLS, aak.nls, o.SQ, aad.KV, o.S, l_nazn ) ;
           EXCEPTION WHEN NO_DATA_FOUND THEN  null;
           end;
        end if;

     end loop ; --- o
  end loop ; --- p
end;
  begin  execute immediate 'grant select, update on ANI_DEL1 to start1';  exception when others then null;  end;
  logger.info('DELOIT(mode_=>'||mode_||'s_DAT1=>'''||s_DAT1 ||''', s_DAT2=> '''||s_DAT1 ||''') -- END' );
  RETURN;
end if;
----------------------------------------------------------------


if mode_ = 4 then
/* 4. Оборотно-сальдова в_дом_сть за трет_й квартал 2010 року, яка в_дпов_дає за сумою на ф_нансових рахунках _нформац_ї в базах трансакц_й обл_кових систем, з обов'язковими полями:
      KV, NLS a. Номер ф_нансового рахунку;
      VOSQ    b. Баланс на початок пер_оду В ЕКВ
      KOSQ    c. Оборот по кредиту         В ЕКВ;
      DOSQ    d. Оборот по деб_ту          В ЕКВ;
      IOSQ    e. Баланс на к_нець пер_оду  В ЕКВ;
Ви можете включити додатков_ поля в файли з даними, якщо вважаєте це необх_дним.
Нам буде необх_дний опис додаткових пол_в та _нформац_я про їх роль в обл_кових системах.

ДОдатково:
      VOSN    b. Баланс на початок пер_оду В ном
      KOSN    c. Оборот по кредиту         В ном;
      DOSN    d. Оборот по деб_ту          В ном;
      IOSN    e. Баланс на к_нець пер_оду  В ном;
*/

  EXECUTE IMMEDIATE
 'create table ' || Tabn_ || ' AS
/*  Первый  мес минус корр пред.мес  */
  select a.KV, a.NLS,
         nvl(m.ostQ,0) + nvl(y.DOSQ,0) - nvl(y.kOSQ,0)  VOSQ,
         nvl(y.kOSQ,0)                                  KOSQ,
         nvl(y.DOSQ,0)                                  DOSQ,
         nvl(m.ostQ,0)                                  IOSQ,
         nvl(m.ost ,0) + nvl(y.DOS ,0) - nvl(y.kOS ,0)  VOSN,
         nvl(y.kOS ,0)                                  KOSN,
         nvl(y.DOS ,0)                                  DOSN,
         nvl(m.ost ,0)                                  IOSN
  from accounts a,
      (select acc, sum(dos -cudos +crdos ) DOS, sum(dosq-cudosq+crdosq) DOSQ,
                   sum(kos -cukos +crkos ) kOS, sum(kosq-cukosq+crkosq) kOSQ
       from ACCM_AGG_MONBALS
       where caldt_id >=
            (select caldt_id from ACCM_CALENDAR
             where caldt_date = to_date('''|| DAT01_ || ''',''dd-mm-yyyy'') )
         and caldt_id <=
            (select caldt_id from ACCM_CALENDAR
             where caldt_date = to_date('''|| DAT12_ || ''',''dd-mm-yyyy'') )
       group by acc
      ) y,
      (select acc, ost -crdos +crkos       OST, ostq-crdosq+crkosq      OSTq
       from ACCM_AGG_MONBALS
       where caldt_id =
            (select caldt_id from ACCM_CALENDAR
             where caldt_date = to_date('''|| DAT12_ || ''',''dd-mm-yyyy'') )
      ) m
   where a.nbs not like ''8%'' and a.acc = m.acc (+) and a.acc=y.acc ' ;

  EXECUTE IMMEDIATE
  'delete from ' || Tabn_ || ' where VOSQ=0 and KOSQ=0 and DOSQ=0 and IOSQ=0 ';

  commit;

   begin
     execute immediate 'grant select, update on '||Tabn_||' to start1';
   exception when others then null;
   end;
  logger.info('DELOIT(mode_=>'||mode_||'s_DAT1=>'''||s_DAT1 ||''', s_DAT2=> '''||s_DAT1 ||''') -- END' );
   RETURN;

end if;

If mode_ = 5 then

   begin     EXECUTE IMMEDIATE 'drop index test1id' ;
   exception  when others then     if sqlcode = -01418 then   null;  else      raise;     end if;      ---ORA-01418: specified index does not exist
   end;
   EXECUTE IMMEDIATE 'CREATE INDEX test1id ON '|| Tabn1_ || ' (kv, nlsd) ';
---------
   begin     EXECUTE IMMEDIATE 'drop index test1ik' ;
   exception  when others then     if sqlcode = -01418 then   null;  else      raise;     end if;      ---ORA-01418: specified index does not exist
   end;
   EXECUTE IMMEDIATE 'CREATE INDEX test1ik ON '|| Tabn1_ || ' (kv, nlsk) ';

-----------
   begin     EXECUTE IMMEDIATE  ' alter table '|| Tabn4_ || ' add (KOSN1 number, DOSN1 number )';
   exception  when others then    if sqlcode = -01430 then   null;  else      raise;     end if;      --ORA-01430: column being added already exists in table
   end;

   EXECUTE IMMEDIATE 'update '|| Tabn4_ || ' t  set
   t.DOSn1= (select nvl(sum(s),0) from '|| Tabn1_ || ' where kv=t.kv and nlsd=t.nls),
   t.KOSn1= (select nvl(sum(s),0) from '|| Tabn1_ || ' where kv=t.kv and nlsk=t.nls)
   ';

   commit;

   begin     EXECUTE IMMEDIATE ' alter table '|| Tabn4_ || ' add (DEL_KN number, DEL_DN number )';
   exception  when others then     if sqlcode = -01430 then   null;  else      raise;     end if;      --ORA-01430: column being added already exists in table
   end;

  EXECUTE IMMEDIATE   'update '|| Tabn4_ || ' set DEL_KN = kOSn1 - kOSn, DEL_dN = DOSn1 - DOSn';
  commit;
end if;
-------------------------------
  SUDA;
  
END Deloit;
/
show err;

PROMPT *** Create  grants  DELOIT ***
grant EXECUTE                                                                on DELOIT          to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on DELOIT          to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/DELOIT.sql =========*** End *** ==
PROMPT ===================================================================================== 
