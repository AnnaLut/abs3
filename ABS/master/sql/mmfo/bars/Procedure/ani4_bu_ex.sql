

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/ANI4_BU_EX.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** Create  procedure ANI4_BU_EX ***

  CREATE OR REPLACE PROCEDURE BARS.ANI4_BU_EX 
( TERM_     int
, MODE_     int
, YYYY_MM   varchar2
, DAT_      date DEFAULT bankdate_g
) IS
  /**
  <b>ANI4_BU_EX</b> - Процедура для функций аналитического модуля
  %param TERM_   - 1  за звытний мic з КОР.ОБ,
                   2  за на заданий день
                   31 Середньоденнi баланси з поч месяца
                   32 Середньоденнi баланси з поч кварталу
                   33 Середньоденнi баланси з поч року
  %param MODE_   - 0 GAP
                   ( 1, 2, 3) Бюджет ANI-4. Рентабельнiсть ТОБО по аналiтицi 6-7 кл
                   ( -1, -2 ) перерахунок планiв для бранч 1,2,
                   77 Накопление в архив Бюджета
                   10 Резервування на КР по залученням в розрiзi бранчiв
                   (11,12,13) ANI-11. Баланс в структур_ показник_в ОБ
                   15 Трансфернi цiни. Ефект-рiзниця
  %param YYYY_MM -
  %param DAT_    -

  %version 1.0
  %usage   Перевіка наявності сформованих DM, що необхідні для формування
           згідно довідника залежностей об'єктів
  */
/*
  16.02.2015 Sta Замена таблиц  TEST_ANI4_BU --->  ANI_BU . TEST_BSB ---> ANI_BSB
                 внесение их в policy_......

  23-07-2013 Baa+Sta Расширено понятие "Бал.Сч" до пары "Бал.сч+ОБ22" , т.е. nbs||OB22 as nbs
  22-11-2011 Sta Суммы. Исключить 0-строки из бал по бранч-3
  08-11-2011 Sta Луганск. Подключение отч форм (F13)
  20-10-2011 Sta Луганск. Баланс. Накопить и обороты

  29-07-2011 При расчете <на день> не трогать месячные снапы, а только запрошенного дня.

  26-07-2011 Итоги планов бюджета для MODE_= -1 (уже -2 не используем)
  В т.ч. наперед
  Вместе с Bin\Bars030.apd

  12-02-2011 ОБ22 в accounts

  13-01-2011 Отсечение др.МФО в мульти.вал схеме
  10-01-2011 Бюджет на заданный день первого в году месяца
  08-10-2010 Доп.блок для врем.табл баланс по бранч-3
  28-09-2010 GAP
  26-07-2010 Бюдж з поч мiс по поточ_день = зал_пот - зал_кiнець_поп_мiс
  15-07-2010 Зам.из Ровно - данi "Разом за мiсяць" = даним "Разом за рiк"
  20-05-2010 Зам.из Ровно - планы вводить уже БЕЗ Знака !
  12-05-2010 Новий режим -1, -2 перерахунок планiв для бранч 1,2, -- -1, -2 перерахунок планiв для бранч 1,2,
  05-05-2010 Null значения в итогах
  24-04-2010 Sta Середньоденнi баланси

  22-04-2010 Sta Бюдж одного дня.
  23-03-2010 Для накопления с нач.мес по тек.день убрала условие в тек.дне
  and (OST<>0 or DOS<>0 or KOS<>0)
  15-03-2010 Добавка в бюджет строк IНФОРМАЦIЙНО 2000 2100 2200 2300 2400 2500
  Вместе SQL\ETALON\PROCEDURE\BARS.ANI4_bU_ex.prc
  +
  SQL\patches\PATCHv83.BU1

  02-03-2010 TERM_ = 3 за 1 зв день
  25-02-2010 ANI_DAT - PUL- змiнна "Звiтна дата" - для використання в дин.SQL
  22-02-2010 Бюджет. Все счета (их перечень) беру не по принципу
              вхождения в последний месяц снапов, а из общей таблицы счетов.

   12-02-2010 Нет ! Єто верно
   10-02-2010 Sta                 ost -(kos-dos)              VOST
   --это невенно !!!!            ost+(CUkos-CUdos)-(kos-dos) VOST

  08-02-2010 Sta особенности квартальной колонки в 1-3 месяце
  04.02.2010 Sta Mode_ = 15 резерв
  12-02-2010 Sta Mode_ = 0 GAP / Новый Kl_R020

  24-12-2009 Sta Накопление в архив
*/
  aMFO_    varchar2(15);
  ANI_DAT  date := DAT_;
  dTmp_    date ;
  DATQ_    date ;
  BRANCH_  accounts.branch%type;
  Y_M      char(7);
  ID2_     bu1.id%type;
  ID1_     bu1.id%type;
  dd_      date  ;
  kk_      date  ; -- пред.кв
  mm_      char(2);
  nmm_     int   ;
  kol_     int   ;
  Ki_      number;
  Lik_     varchar2(50);
  nTmp_    int  ;
  K        SYS_REFCURSOR;
  k_BRANCH varchar2(30);
  k_ID2    number;
  k_D6     number;
  k_D7     number;
  k_S6     number;
  k_S7     number;
  k_K6     number;
  k_K7     number;
  Len_     int;
  ---
  --
  ---
  procedure GAP
  ( JDAT_   date
  ) is
    IR_     NUMBER;
    ZNAP_   number;
    PAP_    int;
    l_cnt   int;
    /*
    Накопичення первинних даних виконується в 3-х блоках
    1) Всi данi, шо входять до А7 файлу ( по класиф.НБУ )
    2) Цикл по всем счетам   - проставим % ставку
    3) Капитал (5+6+7 класс)
    */
  BEGIN

    -- 1) Всi данi, шо входять до А7 файлу ( по класиф.НБУ )
    logger.info('ANI-1. Початок блоку 1) '|| JDAT_);

    BARS.P_FA7_NN( JDAT_,1);

    commit;

    delete from RNBU_TRACE1 where fdat is null or fdat=JDAT_ ;

    commit;

    logger.info('ANI-1. Кiнець блоку 1) ');

    -- 2) Цикл по всем счетам
    for k in ( SELECT ACC, nls,kv,nbs, rnk, isp, mdate, tobo
                 FROM accounts
                WHERE substr(nbs,1,1)<'5' and (DAZS is null or DAZS > JDAT_ ))
    LOOP

      IR_:= acrn.fproc(K.acc,JDAT_);

      -- только проставим % ставку
      INSERT
        INTO RNBU_TRACE1
           ( ir, RECID,USERID,NLS,KV,ODATE,KODP,ZNAP,NBUC,ISP,RNK,ACC,REF,COMM,ND,MDATE,FDAT )
      SELECT IR_,RECID,USERID,NLS,KV,ODATE,KODP,ZNAP,NBUC,ISP,RNK,ACC,REF,COMM,ND,MDATE,JDAT_
        FROM RNBU_TRACE
       WHERE acc=k.ACC;

      if ( SQL%rowcount = 0 )
      then -- добавка неохваченных в А7 лиц.счетов

        begin
          SELECT ABS(ostq), decode( SIGN(ostq),1,2,1)
            into ZNAP_, PAP_
            from BARS.SNAP_BALANCES
           where FDAT = JDAT_
             and KF   = BARS.GL.KF()
             and acc  = k.ACC;
        EXCEPTION
          WHEN NO_DATA_FOUND THEN ZNAP_:= 0;
        end;

        If ZNAP_ <> 0
        then
          INSERT INTO rnbu_trace1
              (ir,fdat, nls,kv,  kodp,znap,acc,rnk,mdate,comm,nbuc)    values
              (IR_, JDAT_, k.nls, k.kv,  PAP_||k.NBS||
              ' 1' || fs240_def(k.NBS,2,to_char(PAP_))|| '  ', to_char(ZNAP_),
               k.ACC,k.RNK, k.MDATE, 'Додатково до A7',k.tobo);
        end if;

      end if;

    END LOOP;

    commit;

    logger.info('ANI-1. Кiнець блоку 2) ');

    Insert
      into RNBU_TRACE1 ( FDAT, KODP, KV, NBUC, ZNAP )
    select JDAT_,'25     H', 980, a.tobo, to_char(sum(b.OSTQ))
      from BARS.ACCOUNTS A
      join BARS.SNAP_BALANCES b
        on ( b.KF = a.KF and b.ACC = a.ACC )
     where a.KF = BARS.GL.KF()
       and a.NBS between '5000' and '7999'
       and ( a.DAZS is null or a.DAZS > JDAT_ )
       and b. FDAT = JDAT_
     group by a.tobo;

    commit;

    logger.info('ANI-1. Кiнець блоку 3) ');

    RETURN; -- ???

  end GAP;

  ---
  --
  ---
  procedure Itg
  ( p_BR    varchar2
  , p_ID    int
  , p_d6    number
  , p_d7    number
  , p_s6    number
  , p_s7    number
  , p_k6    number
  , p_k7    number
  ) is
  begin

    update ANI_BU
       set d6 = d6 + nvl(p_D6,0), d7 = d7 + nvl(p_D7,0),
           s6 = s6 + nvl(p_S6,0), s7 = s7 + nvl(p_S7,0),
           k6 = k6 + nvl(p_k6,0), k7 = k7 + nvl(p_k7,0)
     where branch = p_BR
       and id     = p_ID;

    if SQL%rowcount = 0
    then
      INSERT
        INTO ANI_bu ( d6  ,d7  ,s6  ,s7  ,k6  ,k7  ,branch, id )
      values (nvl(p_D6,0),  nvl(p_D7,0),  nvl(p_S6,0),  nvl(p_S7,0),  nvl(p_k6,0),   nvl(p_k7,0),   p_BR  ,p_ID );
    end if;

  end Itg;
  ---
begin

  logger.info('ANI4_bU_ex -1: TERM_ = '|| TERM_   ||
                            ' MODE_ = '|| MODE_   ||
                            ' YYYY_MM='|| YYYY_MM ||
                            ' DAT_ ='  || DAT_ ) ;
  aMFO_ := '/' || gl.KF || '/%' ;

  -- НАЧАЛО ОСН.ПРОЦЕДУРЫ
  If MODE_ = 15
  then
    null;
  Elsif mode_ in ( -1, -2 )
  then

    -- -1, перерахунок ИТОГОВЫХ планiв для бранч 1,2,

    Logger.info('ANI4_bU_ex План бюджету на ' || DAT_ );

    -- Сначала обнулим все итоги
    Update BU_PLAN
       set SP=0
     where PDAT= DAT_ and length(branch) in (8,15) and mod(ID,100)=0;

    -- а затем пересчитаем их наново
    for k in ( select p.id, decode( b.namber,-1,-1,1) * (p.SP) SP,   p.branch BR
                 from BU_PLAN p, bu1 b   where p.PDAT = DAT_   and p.sp<>0
                 and length(p.branch) in (8,15)      and mod(p.ID,100) >0
                 and p.id in (select id from bu2)    and b.id=p.id
             )
    loop
      -- заголовки -1
      ID1_:= k.ID - mod(k.ID,100);

      Update BU_PLAN set SP=SP+k.SP where PDAT=DAT_ and branch=k.br and id=ID1_;

      if SQL%rowcount = 0 then
         insert into bu_plan ( PDAT, ID, SP, BRANCH  ) values ( DAT_, ID1_, k.SP, k.br);
      end if;

      -- выложить заголовки-2 300, 600
      If ID1_ in (100,200,400,500)
      then

        ID1_:= iif_n (ID1_,200, 300, 300, 600);

        Update BU_PLAN set SP=SP+k.SP
         where PDAT=DAT_ and branch=k.br and id=ID1_;

        if SQL%rowcount = 0
        then
          insert into bu_plan ( PDAT, ID, SP, BRANCH  ) values ( DAT_, ID1_, k.SP, k.br);
        end if;

      end if;

      -- выложить заголовки 900
      If ID1_ in (300,600,700,800) then ID1_:=900;
         Update BU_PLAN set SP=SP+k.SP where PDAT=DAT_ and branch=k.br and id=ID1_;
         if SQL%rowcount = 0 then
            insert into bu_plan ( PDAT, ID, SP, BRANCH  ) values ( DAT_, ID1_, k.SP, k.br);
         end if;
      end if;

      -- выложить заголовки 1200
      If ID1_ in (900,1000,1100) then   ID1_:=1200;
         Update BU_PLAN set SP=SP+k.SP where PDAT=DAT_ and branch=k.br and id=ID1_;
         if SQL%rowcount = 0 then
            insert into bu_plan ( PDAT, ID, SP, BRANCH  ) values ( DAT_, ID1_, k.SP, k.br);
         end if;
      end if;

      -- выложить заголовки 1400
      If ID1_ in (1200,1300) then       ID1_:=1400;
         Update BU_PLAN set SP=SP+k.SP where PDAT=DAT_ and branch=k.br and id=ID1_;
         if SQL%rowcount = 0 then
            insert into bu_plan ( PDAT, ID, SP, BRANCH  ) values ( DAT_, ID1_, k.SP, k.br);
         end if;
      end if;

      -- выложить заголовки 1600
      If ID1_ in (1400,1500) then       ID1_:=1600;
         Update BU_PLAN set SP=SP+k.SP where PDAT=DAT_ and branch=k.br and id=ID1_;
         if SQL%rowcount = 0 then
            insert into bu_plan ( PDAT, ID, SP, BRANCH  ) values ( DAT_, ID1_, k.SP, k.br);
         end if;
      end if;

    end loop;

    update bu_plan
       set sp = -sp
     where sp < 0
       and pdat = DAT_;

    commit;

    RETURN; -- ???

  elsIf MODE_ = 0
  then -- GAP

     GAP(DAT_);

  ElsIf MODE_ = 77
  then -- Накопление в архив Бюджета
    declare
      y_ char(4) := substr(YYYY_MM,1,4);
      m_ char(2) := substr(YYYY_MM,6,2);
      sSql_  varchar2(1000);
    begin
      for k  in (select * from bsb where length(branch)=8 and s is not null)
      loop
         sSql_ :=
         'begin
            update bsx set m'||M_||'='||k.S||' where yyyy='||y_||' and id='||k.id||';
            if SQL%rowcount = 0 then
               insert into bsx (yyyy,id,m'||M_||') values('||y_||','||k.id||','||k.s||');
            end if;
          end;';
         EXECUTE IMMEDIATE sSql_;
      end loop;

      commit;

      RETURN; -- ???

    end;

  end if;
  -- Конец
  -- Накопление в архив
  -- страховочная синхронизация

  If TERM_ = 1
  then -- за звітний мic. з кор. обор.

    If ( YYYY_MM is null )
    then Y_M := to_char(DAT_,'YYYY-MM');
    else Y_M := YYYY_MM;
    end if;

    dd_ := trunc( DAT_, 'MM' );

    select max(FDAT)
      into ANI_DAT
      from fdat
     where to_char(fdat,'YYYY-MM') = Y_M;
 -- RESOLVE PROBLEM ANNY (OUT OF PROCESS MEM)
--     BARS.BARS_UTL_SNAPSHOT.SYNC_MONTH( dd_ );

  else -- TERM_ = 2 за на заданий день
       -- = 31 Середньоденнi баланси з поч месяца
       -- = 32 Середньоденнi баланси з поч кварталу
       -- = 33 Середньоденнi баланси з поч року

     Y_M := to_char(DAT_,'YYYY-MM');

     DD_ := DAT_;

     logger.info('ANI4_bU_ex -2: Y_M = '|| Y_M   || ' DD_ = '|| DD_);

    If TERM_ = 2 and MODE_ not in ( -1, -2 )
    then

      begin
        select 1
          into nTmp_
          from fdat
         where fdat=DD_;
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          raise_application_error( -20203, 'Дату ' || to_char(dd_,'dd/mm/yyyy') || ' не знайдено !', TRUE );
      end;

    end if;

   -- BARS.BARS_UTL_SNAPSHOT.SYNC_SNAP( dd_ );

  end if;

  commit;

  DATQ_ := trunc(DD_,'Q') ; -- квартальная дата

  bars_audit.info( 'ANI4_bU_ex -3: DATQ_='||to_char(DATQ_,'dd.mm.yyyy') );

  -- Начало ( резерв на корсчете по группам залучень )

  If MODE_ = 10
  then

    EXECUTE IMMEDIATE 'TRUNCATE TABLE TMP_REZ0';

    insert into TMP_REZ0 (ID, NAME, PR_NV, PR_IV, NAM1, OST0, OST1)
    select r.iD,r.NAME,r.PR_NV,r.PR_IV,i.BR,GREATEST(i.s0/100,0),GREATEST(i.s1/100,0)
      from rez0 r,
           ( SELECT ID,BR,sum(decode(KV,980,S,0)) S0,sum(decode(KV,980,0,S)) S1
               FROM (select a.ID,a.BR,a.KV,Sum(decode(a.P,2,DECODE(b.Z, 1, b.S,0),1,DECODE(b.Z,-1,-b.S,0),b.S)) S
                       from ( select a.acc,r.ID, substr(a.BRANCH,1,15) br,NVL(r.pap,3) P, a.kv
                              from accounts a, rezerv r where a.nbs=r.nbs
                            ) A,
                            ( select ACC,sign(ostQ+(CRkosQ-CRdosQ)) Z,ostQ+(CRkosQ-CRdosQ) S
                                From BARS.AGG_MONBALS
                               where FDAT = DD_
                                 and KF = BARS.GL.KF()
                                 and ostQ+(CRkosQ-CRdosQ) <> 0
                            ) B
                      where a.ACC=b.ACC  group by a.ID, a.BR, a.KV
                    )
              GROUP by ID, BR
           ) i
     WHERE r.ID= i.ID;

     RETURN; -- ???

  end if;

--------- Конец   -- резерв на корсчете по группам залучень

  Lik_ :=SYS_CONTEXT('bars_context','user_branch_mask');

  If    Mode_ in (1,11) then len_:=  8;
  elsIf Mode_ in (2,12) then len_:= 15;
  else                       len_:= 22;
  end if;



If MODE_ in (1,2,3) then

  execute immediate ' truncate table Bars.ANI_bu ';
  If TERM_ =1 then
     mm_ := substr(Y_M,-2);

     If    MM_ in ( '01','04','07','10') then   kol_:= 1;
     elsIf MM_ in ( '02','05','08','11') then   kol_:= 2;
     elsIf MM_ in ( '03','06','09','12') then   kol_:= 3;
     end if;
     KK_  := add_months(DD_, -KOL_ );
     nmm_ := to_number(mm_);

     begin
       select caldt_ID into Ki_ from accm_calendar  where caldt_DATE=KK_ ;
     EXCEPTION WHEN NO_DATA_FOUND THEN ki_ := null;
     end;

  end if;
-------------------------------------------------------------
  If TERM_ = 1 then
     -- Бюджет за звытний мic з КОР.ОБ
     OPEN K FOR
        select BRANCH, ID2,
               SUM(decode( sign(VOST_M),1, VOST_M, 0)  ) D6,
               SUM(decode( sign(VOST_M),1, 0,-VOST_M)  ) D7,
               SUM(decode( sign(IOST_M),1, IOST_M, 0)  ) S6,
               SUM(decode( sign(IOST_M),1, 0,-IOST_M)  ) S7,
               SUM(decode( sign(IOST_K),1, IOST_K, 0)  ) K6,
              SUM(decode( sign(IOST_K),1, 0,-IOST_K)  ) K7
        from (SELECT b.ID id2,b.NBS,b.PAP,a.BRANCH,
                     decode(sign(sum(Nvl(m.IOST,0))),1,2,1) PAP,
                     sum(Nvl(m.VOST,0)) VOST_M,
                     sum(Nvl(m.IOST,0)) IOST_M,
                     sum(nvl(k.IOST,0)) IOST_K
              FROM BU2 b,
                   (select acc,
                           nbs||OB22 as nbs,
                           Substr(branch, 1, len_) as BRANCH
                      from accounts
                     where (nbs like '6%' or nbs like '7%')
                       and BRANCH LIKE Lik_
                   ) A,
                   (select ACC
                         , ost+(CRkos-CRdos)           IOST
                         , ost+(CUkos-CUdos)-(kos-dos) VOST
                      From AGG_MONBALS
                     where FDAT = DD_
                       and KF = BARS.GL.KF()
                   ) M,
                   (select ACC,ost+(CRkos-CRdos) IOST
                      From ACCM_AGG_MONBALS
                     where caldt_ID=Ki_
                       and nmm_>3
                   ) K
              WHERE A.acc=M.acc (+)
                --and (M.VOST<>0 or m.IOST<>0 or nvl(k.IOST,0)<>0 )
                and a.acc=K.acc(+)
                and a.nbs like trim(b.nbs)||'%'
             GROUP BY b.ID, b.NBS, b.PAP, a.BRANCH
             HAVING b.pap in (3, decode(sign(sum(m.IOST)),1,2,1) )
             )
        group by BRANCH, ID2;

  -------------------------------------------
  elsIf TERM_ = 2 then
     -- TERM_ = 2 Бюджет на заданий день
     If to_char(DD_,'mm') ='01' then
        OPEN K FOR
        select BRANCH, ID2,  0 D6, 0 D7,
               SUM(decode( sign(IOST_M),1, IOST_M, 0)  ) S6,
               SUM(decode( sign(IOST_M),1, 0,-IOST_M)  ) S7,
               null K6, null K7
        from (SELECT b.ID id2,b.NBS,b.PAP,a.BRANCH,
                     decode(sign(sum(m.OST)),1,2,1) PAP,
                     sum(m.OST)   IOST_M
                FROM BU2 b,
                     (select acc,
                             nbs||OB22 as nbs,
                             SubStr(branch, 1, len_) as BRANCH
                        from accounts
                       where (nbs like '6%' or nbs like '7%')
                         and BRANCH LIKE Lik_
                      ) A,
                     (select ACC, OST
                        From BARS.SNAP_BALANCES
                       where FDAT = DD_
                         and KF = BARS.GL.KF()
                      ) M
              WHERE A.acc= M.acc (+)
                and a.nbs like trim(b.nbs)||'%'
              GROUP BY b.ID, b.NBS, b.PAP, a.BRANCH
             HAVING b.pap in ( 3, decode(sign(sum(m.OST)),1,2,1) )
             )
        group by BRANCH, ID2;

     else
        OPEN K FOR
        select BRANCH, ID2,
               SUM(decode( sign(VOST_M),1, VOST_M, 0)  ) D6,
               SUM(decode( sign(VOST_M),1, 0,-VOST_M)  ) D7,
               SUM(decode( sign(IOST_M),1, IOST_M, 0)  ) S6,
               SUM(decode( sign(IOST_M),1, 0,-IOST_M)  ) S7,
               null K6, null K7
        from (SELECT b.ID id2,b.NBS,b.PAP,a.BRANCH,
                     decode(sign(sum(b.OST)),1,2,1) PAP,
                     sum(b.OST)   IOST_M,
                     sum(m.VOST) VOST_M
              FROM BU2 b,
                   ( select acc, nbs||OB22 as nbs, substr(branch,1,len_) BRANCH
                      from accounts
                     where (nbs like '6%' or nbs like '7%')
                       and BRANCH LIKE Lik_
                   ) a,
                   ( select ACC, OST
                       From snap_balances
                      where FDAT = DD_
                        and KF = BARS.GL.KF()
                   ) b,
                   ( select ACC, ost+(CRkos-CRdos) VOST
                       From AGG_MONBALS
                      where FDAT = trunc(add_months(DD_,-1),'MM')
                        and KF = BARS.GL.KF()
                   ) m
              WHERE a.acc = b.acc(+)
                and a.acc = m.acc(+)
                and a.nbs like trim(b.nbs)||'%'
              GROUP BY b.ID, b.NBS, b.PAP, a.BRANCH
              HAVING b.pap in (3, decode(sign(sum(b.OST)),1,2,1) )
             )
        group by BRANCH, ID2;

     end if;

--logger.info('ANI - 4' );

  elsIf TERM_ = 3 then
     -- TERM_ = 3 Бюджет за 1 заданий день
  OPEN K FOR
  select BR, ID2,
         SUM(decode( sign(OST),1, OST, 0)  ) D6,
         SUM(decode( sign(OST),1, 0,-OST)  ) D7,
         0 S6, 0 S7, null K6, null K7
  from (SELECT b.ID id2,b.NBS,b.PAP,a.BR,
               decode(sign(sum(a.OST)),1,2,1) PAP, sum(a.OST) OST
        FROM BU2 b,
             (select nbs||OB22 as nbs,
                     substr(c.branch,1,len_) BR,
                     sum((2*o.dk-1)*o.S) OST
                from accounts c,
                     opldok o
               where (c.nbs like '6%' or c.nbs like '7%')
                 and c.BRANCH LIKE Lik_ and c.acc=o.acc and o.fdat= DD_ and o.sos=5
                 and not exists (select 1 from oper where ref=o.REF and vob in (96,99) )
               group by c.nbs,substr(c.branch,1,len_)
             ) A
        WHERE a.nbs like trim(b.nbs) ||'%'
        GROUP BY b.ID, b.NBS, b.PAP, a.BR
        HAVING b.pap in (3, decode(sign(sum(a.OST)),1,2,1) )
         )
  group by BR, ID2;


  end if;
  ---------------
  -- курсор д.б.открыть к моменту вызова процедуры
  IF NOT K%ISOPEN THEN
     RETURN;
  END IF;

  loop
    <<nextrec>> -- переход на другую строку курсора

    FETCH K INTO  k_BRANCH, k_ID2, k_D6, k_D7, k_S6, k_S7, k_K6, k_K7 ;
    EXIT WHEN K%NOTFOUND;

    ID2_ := k_ID2;    branch_:=        k_branch;
    -- выложить строку
    Itg (BRANCH_,ID2_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);

    -- заголовки -1
    If mod(ID2_,100) >0  then
       ID1_:= ID2_ - mod(ID2_,100);
       Itg (BRANCH_,ID1_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);
       -- выложить заголовки-2 300, 600
       If ID1_ in (100,200,400,500) then
          ID1_:= iif_n (ID1_,200, 300, 300, 600);
          Itg (BRANCH_,ID1_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);
       end if;
       -- выложить заголовки 900
       If ID1_ in (300,600,700,800) then
          ID1_:=900;
          Itg (BRANCH_,ID1_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);
       end if;
       -- выложить заголовки 1200
       If ID1_ in (900,1000,1100) then
          ID1_:=1200;
          Itg (BRANCH_,ID1_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);
       end if;
       -- выложить заголовки 1400
       If ID1_ in (1200,1300) then
          ID1_:=1400;
          Itg (BRANCH_,ID1_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);
       end if;
       -- выложить заголовки 1600
       If ID1_ in (1400,1500) then
          ID1_:=1600;
          Itg (BRANCH_,ID1_,k_d6,k_d7,k_S6,k_s7,k_k6,k_k7);
       end if;
    end if;

  end loop;

  INSERT INTO ANI_bu (branch, id, s6,  d6, k6  )
  select branch, ID,
    -decode (Yz, 0, 0, Yc*10000/Yz) s6,
    -decode (Mz, 0, 0, Mc*10000/Mz) d6,
    -decode (Kz, 0, 0, Kc*10000/Kz) k6
  from ( select branch, 2300 ID,
            sum (decode(id, 900,(s6-s7)        , 0               )) Yz,
            sum (decode(id, 900,0              , (s6-s7)         )) Yc,
            sum (decode(id, 900,(s6-s7)-(d6-d7), 0               )) Mz,
            sum (decode(id, 900,0              , (s6-s7)-(d6-d7) )) Mc,
            sum (decode(id, 900,(s6-s7)-(k6-k7), 0               )) Kz,
            sum (decode(id, 900,0              , (s6-s7)-(k6-k7))) Kc
         from ANI_bu  where id in (1000,900)   group by branch
         union all
         select branch, 2400 ID,
            sum (decode(id, 900,(s6-s7)        , 0               )) Yz,
            sum (decode(id, 900,0              , (s6-s7)         )) Yc,
            sum (decode(id, 900,(s6-s7)-(d6-d7), 0               )) Mz,
            sum (decode(id, 900,0              , (s6-s7)-(d6-d7) )) Mc,
            sum (decode(id, 900,(s6-s7)-(k6-k7), 0               )) Kz,
            sum (decode(id, 900,0              , (s6-s7)-(k6-k7))) Kc
         from ANI_bu  where id in (1100,900)   group by branch
         union all
         select branch, 2500 ID,
            sum (decode(id, 900,(s6-s7)        , 0               )) Yz,
            sum (decode(id, 900,0              , (s6-s7)         )) Yc,
            sum (decode(id, 900,(s6-s7)-(d6-d7), 0               )) Mz,
            sum (decode(id, 900,0              , (s6-s7)-(d6-d7) )) Mc,
            sum (decode(id, 900,(s6-s7)-(k6-k7), 0               )) Kz,
            sum (decode(id, 900,0              , (s6-s7)-(k6-k7) )) Kc
         from ANI_bu  where id in (1100,900,1000)   group by branch
          );

  INSERT INTO ANI_bu (branch, id )
  select distinct a.branch, b.ID  from ANI_bu a, bu1 b  where b.id in (2000,2100,2200) ;

  commit;

  RETURN;
----------- Конец Бюджет-----------------

----------- Начало Баланс ------------------
ElsIf Mode_ in (11,12,13) then
   execute immediate ' truncate table Bars.BSB ';
   execute immediate ' truncate table Bars.BSA ';
   -- заготовка сырца для расчета показателей

   If TERM_ = 1 then

      --за звытний мic з КОР.ОБ
      insert into BSA (BRANCH,AP,BS,OB,D5,KV,S, DM, KM)
      select i.BR, decode(i.AP,1,2,1) AP, i.nbs bs, i.ob22 OB, k.s183 D5, i.KV,
             sum(i.S) S, sum(i.DM) DM, sum(i.KM ) Km
      from kl_s180 k,
          (select substr(branch,1,len_) BR, a.ap,a.nbs, a.ob22, s.s180,a.KV,
                  sum(a.S) S, sum(a.DM) DM, sum(a.KM ) Km
           from (select a.acc, decode(a.kv,980,0,1) KV, a.ob22,
                      a.branch||decode(length(a.branch),8,'000000/','') BRANCH,
                      a.nbs,sign(b.S) ap, Abs(b.S) S, b.DM, b.KM
                 from accounts a,
                      ( select acc,ostQ+(CRkosQ-CRdosQ) S,
                               dosq +crdosq-cudosq  DM,
                               kosq +crkosq-cukosq  KM
                          from AGG_MONBALS
                         where FDAT = DD_
                           and KF = BARS.GL.KF()
                      ) b
                 where a.acc=b.acc and a.nbs not like '8%'
                ) a,
                specparam s
           where a.acc= s.acc (+) and a.S>0
           group by substr(branch,1,len_), a.ap, a.nbs, a.ob22, s.s180, a.kv
          ) i
      where i.s180= k.s180 (+)
      group by i.BR, i.AP, i.nbs, i.ob22, k.s183, i.KV;

      If len_ =  8 then
         -- доделать 13 форму
         declare
           l_datf TMP_NBU.datf%type;
         begin
           select max(datf)
           into l_datf
           from TMP_NBU
           where kodf = '13'
             and datf > dd_
             and datf < add_months(DD_, 1);

           if l_datf is not null then
              insert into BSA (BRANCH,     AP,   BS,   OB, KV,S, DM, KM)
              select '/' || gl.amfo || '/', 2, kodp, kodf, 0, 0, 0 , znap
              from TMP_NBU
              where kodf = '13'
                and datf = l_datf
                and kodp in ('84','87','86','88' );
           end if;

         end;
      end if;


   elsIf TERM_ = 2 then

      --TERM_ = 2 за на заданий день
      insert into BSA (BRANCH,AP,BS,OB,D5,KV,S)
      select i.BR, decode(i.AP,1,2,1) AP, i.nbs bs, i.ob22 OB,
             k.s183 D5, i.KV, sum(i.S) S
      from kl_s180 k,
          (select substr(branch,1,len_) BR, a.ap,a.nbs,a.ob22, s.s180,a.KV, sum(a.S) S
           from (select a.acc, decode(a.kv,980,0,1) KV, a.ob22,
                      a.branch||decode(length(a.branch),8,'000000/','') BRANCH,
                      a.nbs,sign(b.S) ap, Abs(b.S) S
                 from accounts a,
                      ( select ACC, ostq S
                          From snap_balances
                         where FDAT = DD_
                           and KF = BARS.GL.KF()
                           and OSTQ <> 0
                      ) b
                 where a.acc=b.acc and a.nbs not like '8%'
                ) a,
                specparam s
           where a.acc= s.acc (+) and a.S>0
           group by substr(branch,1,len_), a.ap, a.nbs, a.ob22, s.s180, a.kv
          ) i
      where i.s180= k.s180 (+)
      group by i.BR, i.AP, i.nbs, i.ob22, k.s183, i.KV;

   elsif TERM_ in (31,32,33)
   then
      -- 31 - Середньоденнi баланси з поч месяца
      -- 32 - Середньоденнi баланси з поч кварталу
      -- 33 - Середньоденнi баланси з поч року

      select trunc(DAT_,decode(TERM_,31,'MM',32,'Q',33,'YYYY','DD'))
        into dTmp_
        from dual;

      nTmp_ := DAT_ - dTmp_ + 1;

      insert into BSA (BRANCH,AP,BS,OB,D5,KV,S)
      select i.BR, decode(i.AP,1,2,1) AP, i.nbs bs, i.ob22 OB,
             k.s183 D5, i.KV, sum(i.S) S
        from kl_s180 k,
             ( select substr(branch,1,len_) BR, a.ap,a.nbs,a.ob22, s.s180,a.KV, sum(a.S) S
                 from ( select a.acc, decode(a.kv,980,0,1) KV, a.ob22,
                               a.branch||decode( length(a.branch), 8,'000000/','') BRANCH,
                               a.nbs, sign(b.S) ap, Abs(b.S) S
                          from accounts a,
                               ( select acc, round(sum(ostQ)/ nTmp_ ,0) S
                                   from SNAP_BALANCES
                                  where FDAT between dTmp_ and DAT_
                                    and KF = BARS.GL.KF()
                                  group by ACC
                               ) b
                          where a.acc=b.acc and a.nbs not like '8%'
                      ) a,
                      specparam s
                where a.acc= s.acc (+) and a.S>0
                group by substr(branch,1,len_), a.ap, a.nbs, a.ob22, s.s180, a.kv
             ) i
       where i.s180= k.s180(+)
       group by i.BR, i.AP, i.nbs, i.ob22, k.s183, i.KV;

   end if;

   -- расчет первичных(1) и вторичных (2)  показателей
   declare
      c int; i int; S_ number;
   begin
      c:=DBMS_SQL.OPEN_CURSOR;              --открыть курсор
      -- цикл по бранчам
      for b in (select * from branch
                where branch like  aMFO_ and length(branch)=LEN_)
      loop
         -- прикинуться бранчем
         bars_context.subst_branch(b.branch);

         Insert into BSB (branch,id) select b.branch,id from bs1 where nvl(pu,0)=0;

         -- цикл по первичным показателям
         for f in (select * from bs1 where form is not null and pu in (1,-1) )
         loop
            begin
              DBMS_SQL.PARSE(c, f.Form, DBMS_SQL.NATIVE); --приготовить дин.SQL
              DBMS_SQL.DEFINE_COLUMN(c,1,S_);        --установить знач колонки в SELECT
              i:=DBMS_SQL.EXECUTE(c);                 --выполнить приготовленный SQL
              IF DBMS_SQL.FETCH_ROWS(c)>0 THEN        --прочитать
                 DBMS_SQL.COLUMN_VALUE(c,1,S_);      --снять результирующую переменную
              else                         S_ :=0 ;
              end if;
            EXCEPTION WHEN NO_DATA_FOUND then s_:=0;
                      WHEN others        then
              -- откинуться
              bc.set_context;
              DBMS_SQL.CLOSE_CURSOR(c);                -- закрыть курсор
              raise_application_error( -(20000+333),
                '\ош.SQL-формула пок=' || f.id ||' '|| f.name, TRUE);
            end;
            S_:= nvl(S_,0);
            insert into BSB(branch,id,s) values (b.BRANCH, F.ID, S_);
         end loop;  -- конец цикла F по формулам

         -- цикл по вторичным показателям
         for f in (select * from bs1 where form is not null and pu=2)
         loop
            begin
              DBMS_SQL.PARSE(c, f.Form, DBMS_SQL.NATIVE); --приготовить дин.SQL
              DBMS_SQL.DEFINE_COLUMN(c,1,S_);        --установить знач колонки в SELECT
              i:=DBMS_SQL.EXECUTE(c);                 --выполнить приготовленный SQL
              IF DBMS_SQL.FETCH_ROWS(c)>0 THEN        --прочитать
                 DBMS_SQL.COLUMN_VALUE(c,1,S_);      --снять результирующую переменную
              else                         S_ :=0 ;
              end if;
            EXCEPTION WHEN NO_DATA_FOUND then s_:=0;
                      WHEN others        then
              -- откинуться
              bc.set_context;
              DBMS_SQL.CLOSE_CURSOR(c);                -- закрыть курсор
              raise_application_error( -(20000+333),
                '\ош.SQL-формула пок=' || f.id ||' '|| f.name, TRUE);
            end;
            S_:= nvl(S_,0);
            insert into BSB(branch,id,s) values (b.BRANCH, F.ID, S_);
         end loop;  -- конец цикла F по формулам

         bc.set_context;
      end loop; -- конец цикла B по branch

      DBMS_SQL.CLOSE_CURSOR(c);                -- закрыть курсор
      commit;
   end;

  If MODE_ <> 13
  then
     Return; -- ???
  end if;

  -- 08-01-2010 Доп.блок для врем.табл баланс по бранч-3
  declare
    TEST_ char(8) :='ANI_BSB';
  begin

    begin
      execute immediate 'drop table '|| TEST_ ;
    exception
      when others then
        if sqlcode = -00942
        then null;
        else raise;
        end if;
    end;

    execute immediate 'create table '|| TEST_||' as select KOD, ID, NAME, ORD from BS1';

    execute immediate 'alter table ' || TEST_||' add ( PA3OM number(24,2) )';

    for b in ( select substr(branch,9,6) ||'_'|| substr(branch,16,6) BR
                 from branch
                where length(branch)=22
                order by 1 )
    loop
      execute immediate 'alter table ' || TEST_||' add ( s_'||b.BR||' number(24,2) )';
    end loop;

    for k in ( select id, substr(branch,9,6) ||'_'|| substr(branch,16,6) BR, s
                 from bsb
                where s <> 0
                  and length(branch)=22 )
    LOOP
      execute immediate 'update '||TEST_||' set PA3OM= nvl(PA3OM,0) + '|| k.S||'/ 100, s_'||k.br||'='||k.S||'/100   where id='||k.ID;
    end loop;

    -- удаление 0-строк
    execute immediate 'delete from '||TEST_||' where PA3OM is null';

    commit;

    execute immediate 'grant select  on '|| TEST_ || ' to SALGL';

  end;

end if;

  Return; -- ???

end ANI4_BU_EX;
/
show err;

PROMPT *** Create  grants  ANI4_BU_EX ***
grant EXECUTE                                                                on ANI4_BU_EX      to BARS_ACCESS_DEFROLE;
grant EXECUTE                                                                on ANI4_BU_EX      to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/ANI4_BU_EX.sql =========*** End **
PROMPT ===================================================================================== 
