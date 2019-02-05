CREATE OR REPLACE PROCEDURE BARS.DDRAPS
( dat_    in      DATE
, mode_   in      SMALLINT DEFAULT 0
) IS
  /**
  <b>CREATE_DAILY_SNAPSHOT</b> - процедура створення денних знімків балансу
  %param

  %version 2.3  31/01/2019 (06.03.2018)
  %usage   створення денних знімків балансу.
  */
  l_errmsg          varchar2(500);

  dat#              DATE;
  l_mode            SMALLINT := mode_;

  l_pvp_uid         NUMBER(38);
  uid#              NUMBER := gl.aUID;
  l_bank_dt         DATE   := gl.bDATE;

  dlta_             accounts.ostc%type;
  ost1_             accounts.ostc%type;
  ost2_             accounts.ostc%type;
  dosq_             accounts.dos%type;
  kosq_             accounts.kos%type;

  l_acc             accounts.acc%type;
  l_ref             NUMBER;
  l_allowed_dt      DATE; -- Дата раніше якої заборонено формування
  l_kf              snap_balances.kf%type;
  l_condition       varchar2(200);

  x                 SYS_REFCURSOR;

  l_cur_scn         NUMBER;
             
  -- тип для вичитки вхідних даних
  TYPE imp_rec IS RECORD( kf    char(6)
                        , acc   NUMBER
                        , rnk   NUMBER
                        , nbs   VARCHAR2(4)
                        , nls   VARCHAR2(15)
                        , kv    SMALLINT
                        , tip   VARCHAR2(3)
                        , ostf  NUMBER(24)
                        , dos   NUMBER(24)
                        , kos   NUMBER(24) );
  c imp_rec;

  -- типы для накопления вешалок в Нових драпсах
  TYPE ves_rec IS RECORD( kf   char(6),
                          acc  NUMBER,     rnk  NUMBER,
                          ost  NUMBER(24), dos  NUMBER(24), kos  NUMBER(24),
                          ost0 NUMBER(24), dos0 NUMBER(24), kos0 NUMBER(24),
                          ostq NUMBER(24), dosq NUMBER(24), kosq NUMBER(24) );
  TYPE ves_tab IS TABLE OF ves_rec INDEX BY BINARY_INTEGER;

  ves  ves_tab;
  i                   BINARY_INTEGER;

  -- Вирахування еквівалентів
  TYPE rat_rec IS RECORD( dig  SMALLINT
                        , rat1 NUMBER
                        , rat2 NUMBER );
  TYPE rat_tab IS TABLE OF rat_rec INDEX BY BINARY_INTEGER;
  q    rat_tab;

  -- Ініціалізація курсів по даті
  PROCEDURE get_rat(dat_ DATE)
  IS
  BEGIN
     FOR x IN ( select kv, dig
                     , ( SELECT rate_o/bsum
                           FROM cur_rates
                          WHERE ( kv,vdate ) = ( SELECT kv,MAX(vdate) FROM cur_rates WHERE vdate <  dat_ AND kv = t.kv GROUP BY kv )
                       ) rat1
                     , ( SELECT rate_o/bsum
                           FROM cur_rates
                          WHERE ( kv,vdate ) = ( SELECT kv,MAX(vdate) FROM cur_rates WHERE vdate <= dat_ AND kv = t.kv GROUP BY kv )
                       ) rat2
           from TABVAL$GLOBAL t )
     LOOP
        q(x.kv).dig := x.dig;
        q(x.kv).rat1 := NVL(x.rat1,0);
        q(x.kv).rat2 := NVL(x.rat2,0);
     END LOOP;
  END;

  -- Еквівалент по курсу1
  FUNCTION eqv1
  ( kv_    SMALLINT
  , s_     NUMBER
  ) RETURN NUMBER
  IS
    s NUMBER;
  BEGIN
    s := ROUND(q(kv_).rat1*s_*POWER(10,2-q(kv_).dig));
    RETURN CASE s WHEN 0 THEN SIGN(s_) ELSE s END;
  END;

  -- Еквівалент по курсу2
  FUNCTION eqv2
  ( kv_    SMALLINT
  , s_     NUMBER
  ) RETURN NUMBER
  IS
    s NUMBER;
  BEGIN
    s := ROUND(q(kv_).rat2*s_*POWER(10,2-q(kv_).dig));
    RETURN CASE s WHEN 0 THEN SIGN(s_) ELSE s END;
  END;

BEGIN

  BARS_AUDIT.INFO( $$PLSQL_UNIT||': Start running with (dat_='||to_char(dat_,'dd.mm.yyyy')||', mode_='||to_char(mode_)||').' );

  IF ( sys_context('bars_global','application_name') = 'BARSWEB_JOBS' )
  THEN -- При запуску з ВЕБ формування драпсів не виконуємо (мовчки)
    RETURN;
  END IF;

  if ( dat_ Is Null )
  then
    raise_application_error( -20666, 'Не вказано дату для формування знімку!' );
  end if;

  l_kf := sys_context('bars_context','user_mfo');

  if ( l_kf Is Null )
  then
    raise_application_error( -20666, 'Не вказано МФО ( l_kf Is Null ) для формування знімку!' );
  end if;

  begin

    select to_date(val,'DDMMYYYY')
      into l_allowed_dt
      from PARAMS
     where PAR = 'DATRAPS';

    if ( l_allowed_dt > dat_ )
    then
      raise_application_error( -20666, 'Заборонено формування знімків за дату меншу ніж '||to_char(l_allowed_dt,'dd.mm.yyyy') );
    end if;

  exception
    when NO_DATA_FOUND then
      NULL;
  end;

  -- Перевірка на операційну дату
  begin
    select FDAT
      into l_allowed_dt
      from FDAT
     where FDAT = dat_;
  exception
    when NO_DATA_FOUND then
     raise_application_error( -20666,'Заборонено формування знімків за неопераційну дату '||to_char(dat_,'dd.mm.yyyy') );
  end;

  -- Перевірка наявності активного процесу формування знімку
  l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING( 'DAYBALS', l_kf );

  if (l_errmsg is Not Null)
  then
    RAISE_APPLICATION_ERROR( -20666, 'формування денного знімку балансу вже запущено користувачем ' || l_errmsg );
  else -- Блокування від декількох запусків
    BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG( 'DAYBALS' );
  end if;

  dbms_application_info.set_client_info( 'Формування денного знімку балансу для '||l_kf||' за ' || F_MONTH_LIT(dat_,0,0) );

  -- Отримати дату попередніх драпсів для прискореного режиму mode=1
  IF ( l_mode = 1 )
  THEN

    SELECT MAX(FDAT)
      INTO dat#
      FROM FDAT
     WHERE FDAT < dat_;

    l_mode := CASE WHEN dat# IS NULL THEN 0 ELSE 1 END;

  END IF;

  bars_audit.info( $$PLSQL_UNIT||': l_kf='||l_kf||', dat#='||to_char(dat#,'dd.mm.yyyy')||', mode='||to_char(l_mode)||'.' );

  -- --
  -- -- Превентивно прибити переоцінку з цей день
  -- --
  -- FOR x IN (SELECT ref FROM oper WHERE tt='PVP' AND vdat=dat_ AND sos>0)
  -- LOOP
  --   gl.bck( x.ref, 9 );
  -- END LOOP;
  --
  -- bars_audit.info( $$PLSQL_UNIT||': gl.bck -> Ok.' );

  -- Превентивно доплатити пакетні проводки
  GL.PAYSOS0;
  commit;

  bars_audit.trace( $$PLSQL_UNIT||': gl.paysos0 -> Ok.' );

  --execute immediate 'alter table SNAP_BALANCES_INTR_TBL truncate partition for ( '''||l_kf||''' )';
  execute immediate 'alter table SNAP_BALANCES_INTR_TBL truncate partition P_'||l_kf;

  l_condition := q'[ (to_date('%dt','ddmmyyyy'),'%kf') ]';
  l_condition := replace( l_condition, '%dt', to_char(dat_,'ddmmyyyy') );
  l_condition := replace( l_condition, '%kf', l_kf );

  if ( dat_ < GL.GBD() )
  then
    execute immediate 'lock table SALDOA subpartition for '||l_condition||' IN EXCLUSIVE MODE';
    bars_audit.info( $$PLSQL_UNIT||': SALDOA subpartition locked.' );
  end if;

  -- Вибрати підходящий курсор
  IF ( l_mode = 0 )
  THEN
    OPEN x FOR
        'select /*+ NO_PARALLEL FULL(a) */ a.KF
              , a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip
              , NVL(s.ostf,0) ostf
              , NVL(s.dos, 0) dos
              , NVL(s.kos, 0) kos
           from ACCOUNTS a
           left
           join ( SELECT sa1.KF,
                         sa1.ACC,
                         DECODE(sa1.fdat, :l_dt, sa1.ostf, sa1.OSTF-sa1.DOS+sa1.KOS) ostf,
                         DECODE(sa1.fdat, :l_dt, sa1.dos, 0) dos,
                         DECODE(sa1.fdat, :l_dt, sa1.kos, 0) kos
                    FROM saldoa sa1,
                        ( select ACC, max(FDAT) as FDAT
                            from SALDOA
                           where FDAT <= :l_dt
                             and KF = :l_kf
                           group by ACC
                        ) sa2
                   WHERE sa1.fdat = sa2.fdat
                     AND sa1.acc  = sa2.acc
                ) s
             on ( s.KF = a.KF and s.ACC = a.ACC )
          WHERE a.KF = :l_kf
            and a.DAOS <= :l_dt
            AND ( a.dazs is null OR a.dazs >= :l_dt )'
    USING dat_, dat_, dat_, dat_, l_kf, l_kf, dat_, dat_;

  ELSE -- ( l_mode = 1 )

    OPEN x FOR
          'SELECT a.KF, a.acc, a.rnk, a.nbs, a.nls, a.kv, a.tip
                , NVL(s.ostf,0) OSTF
                , NVL(s.dos, 0) DOS
                , NVL(s.kos, 0) KOS
            from ACCOUNTS a
            left
            join ( select nvl(c.KF,   b.KF ) as KF,
                          NVL(c.acc,  b.acc) as ACC,
                          NVL(c.ostf, b.ost) as OSTF,
                          NVL(c.dos,  0    ) as DOS,
                          NVL(c.kos,  0    ) as KOS
                     from ( select *
                              from SNAP_BALANCES
                             where FDAT = :1
                               and KF   = :p_kf
                          ) b
                     full
                     join ( select *
                              from SALDOA
                             where FDAT = :2
                               and KF   = :p_kf
                          ) c
                       on ( c.KF = b.KF and c.ACC = b.ACC )
                ) s
             on ( s.KF = a.KF and s.ACC = a.ACC )
            WHERE a.KF = :p_kf
              and a.DAOS <= :3
              and ( a.dazs is null OR a.dazs >= :4 )'
    USING dat#, l_kf, dat_, l_kf, l_kf, dat_, dat_;

  END IF;

  GET_RAT(dat_);

  LOOP

    FETCH x INTO c;

    EXIT WHEN x%NOTFOUND;

    -- Вычисление эквивалента остатка и обортов

    IF ( c.kv = 980 )
    THEN
      ost1_ := c.ostf;
      dosq_ := c.dos;
      kosq_ := c.kos;
    ELSE
      ost1_ := eqv1 (c.kv, c.ostf);
      ost2_ := eqv2 (c.kv, c.ostf - c.dos + c.kos);
      dosq_ := eqv2 (c.kv, c.dos);
      kosq_ := eqv2 (c.kv, c.kos);

      dlta_ := ost2_ - (ost1_ - dosq_ + kosq_);

      IF dlta_ < 0 THEN
         dosq_ := dosq_ - dlta_;
      ELSE
         kosq_ := kosq_ + dlta_;
      END IF;

    END IF;

    -- Опеределение номера вешалки
    i := CASE
           WHEN c.nbs BETWEEN '1000' and '7999'
           THEN c.kv*10+1
           WHEN c.nbs BETWEEN '9000' and '9599' OR c.nbs IN ('9900','9920')
           THEN c.kv*10+2
           WHEN c.nbs BETWEEN '9600' and '9899' OR c.nbs ='9910'
           THEN c.kv*10+3 ELSE 9999
         END;

    -- Накопление вешалок
    IF ves.EXISTS(i)
    THEN
       ves(i).ostq:=ves(i).ostq - (ost1_-dosq_+kosq_);
       ves(i).dosq:=ves(i).dosq+kosq_;
       ves(i).kosq:=ves(i).kosq+dosq_;
    ELSE
       ves(i).ostq:= - (ost1_-dosq_+kosq_);
       ves(i).dosq:= kosq_;
       ves(i).kosq:= dosq_;
    END IF;

    -- Запомнить счет вешалки (tip VE1-3)
    IF c.tip LIKE 'VE_'
    THEN
      ves(i).acc  := c.acc;
      ves(i).kf   := c.kf;
      ves(i).rnk  := c.rnk;
      ves(i).ost  := c.ostf-c.dos+c.kos;
      ves(i).dos  := c.dos;
      ves(i).kos  := c.kos;
      ves(i).ost0 := ost1_-dosq_+kosq_;
      ves(i).dos0 := dosq_;
      ves(i).kos0 := kosq_;
    ELSE

      insert -- вставка простых счетов
        into SNAP_BALANCES_INTR_TBL
        ( FDAT, KF, ACC, RNK, OST, DOS, KOS, OSTQ, DOSQ, KOSQ )
      values
        ( dat_, c.KF, c.acc, c.rnk
        , c.ostf-c.dos+c.kos, c.dos, c.kos
        , ost1_ -dosq_+kosq_, dosq_, kosq_ );

    END IF;

  END LOOP;

  -- Теперь повесить ошибки округления на вешалки4
  i := ves.FIRST;

  WHILE i IS NOT NULL
  LOOP
    IF i > 2 AND TRUNC(i/10) NOT IN (980,999)
             AND (ves(i).ost<>0  OR ves(i).dos<>0  OR ves(i).kos<>0  OR
                  ves(i).ost0<>0 OR ves(i).dos0<>0 OR ves(i).kos0<>0 OR
                  ves(i).ostq<>0 OR ves(i).dosq<>0 OR ves(i).kosq<>0)
    THEN

      IF ves(i).acc IS NOT NULL
      THEN
        insert -- вставка вешалок
          into SNAP_BALANCES_INTR_TBL
          ( FDAT, KF, ACC, RNK, OST, DOS, KOS, OSTQ, DOSQ, KOSQ )
        VALUES
          ( dat_, ves(i).kf,
            ves(i).acc, ves(i).rnk, ves(i).ost, ves(i).dos, ves(i).kos,
            ves(i).ost0+ves(i).ostq,
            ves(i).dos0+greatest(ves(i).dosq-ves(i).kosq,0),
            ves(i).kos0+greatest(ves(i).kosq-ves(i).dosq,0));
      ELSE
        raise_application_error(-20666, 'Не знайдно рахунок "вішалки" VE'||MOD(i,10)||' для вал. '||TRUNC(i/10));
      END IF;

    END IF;

    i := ves.NEXT(i);

  END LOOP;

  --
  -- переоцінка валютних позицій (коригуючі проводки + корекція даних в AGG_MONBALS_EXCHANGE)
  -- BARS_SNAPSHOT.DAILY_CURRENCY_REVALUATION;
  --

  -- Код юзера для проведень переоцінки ВП
  begin
    select trim(VAL)
      into l_pvp_uid
      from PARAMS
     where PAR = 'PVPUSER';
  exception
    when NO_DATA_FOUND then
      l_pvp_uid := gl.aUID;
  end;

  if ( dat_ = DAT_NEXT_U( GL.GBD(), -1 ) )
  then --
    gl.bDATE := dat_;
  else --
    GL.PL_DAT( dat_ );
  end if;

  gl.aUID := l_pvp_uid;

  FOR v IN ( SELECT /*+ LEADING(vp b0) FULL(vp) INDEX(b1 UK_SNAP_BALANCES_EXCHANGE) */
                    vp.acc3800, (SELECT nls||'/'||LPAD(kv,3,'0') FROM accounts WHERE acc=acc3800) nls3800,
                    vp.acc3801, (SELECT RPAD(nls,14)||nms        FROM accounts WHERE acc=acc3801) nls3801,
                    vp.acc6204, (SELECT RPAD(nls,14)||nms        FROM accounts WHERE acc=acc6204) nls6204
                  , CASE WHEN b0.ostq+NVL(b1.ostq,0)>0 THEN 1 ELSE 0 END as DK
                  , b0.RNK, b0.KF
                  , ABS(b0.ostq+NVL(b1.ostq,0)) as S
               FROM VP_LIST vp
               JOIN SNAP_BALANCES_INTR_TBL b0
                 on ( b0.FDAT = dat_   and b0.KF = vp.KF  and b0.ACC = vp.ACC3800 )
               left
               join SNAP_BALANCES_INTR_TBL b1
                 on ( b1.FDAT = b0.FDAT and b1.KF = b0.KF and b1.ACC = vp.ACC3801 )
              WHERE vp.KF = l_kf
                AND b0.ostq + NVL(b1.ostq,0) <> 0 )
  LOOP

    bars_audit.trace( $$PLSQL_UNIT||': ВП '||v.nls3800||', DK='||v.DK||', S='||v.s );

    GL.REF( l_ref );

    insert
      into OPER
      ( REF,  TT,   VOB,   ND,  DK, PDAT
      , VDAT, DATD, USERID
      , MFOA, NLSA, NAM_A, KV,  S,  ID_A
      , MFOB, NLSB, NAM_B, KV2, S2, ID_B
      , NAZN, BRANCH, TOBO, KF )
    VALUES
      ( l_ref, 'PVP', 6, SubStr(l_ref,-10), v.dk, SYSDATE, dat_, dat_, l_pvp_uid
      , gl.aMFO, TRIM(SUBSTR(v.nls3801,1,14)), SUBSTR(v.nls3801,15,38), 980, v.s, gl.aOKPO
      , gl.aMFO, TRIM(SUBSTR(v.nls6204,1,14)), SUBSTR(v.nls6204,15,38), 980, v.s, gl.aOKPO
      , 'Переоцінка валютної позиції '||v.nls3800, null, null, v.KF );

    GL.PAYV( 1, l_ref, dat_, 'PVP', v.dk
           , 980, TRIM(SUBSTR(v.nls3801,1,14)), v.s
           , 980, TRIM(SUBSTR(v.nls6204,1,14)), v.s );

    FOR i IN 0..1
    LOOP

      if i=0
      then
        l_acc:= v.acc3801;
      else
        v.dk := 1-v.dk;
        l_acc:= v.acc6204;
      end if;

      update SNAP_BALANCES_INTR_TBL
         set OST  = OST  + CASE WHEN v.dk = 1 THEN 0-v.s ELSE v.s END
           , OSTQ = OSTQ + CASE WHEN v.dk = 1 THEN 0-v.s ELSE v.s END
           , DOS  = DOS  + CASE WHEN v.dk = 1 THEN v.s   ELSE 0   END
           , DOSQ = DOSQ + CASE WHEN v.dk = 1 THEN v.s   ELSE 0   END
           , KOS  = KOS  + CASE WHEN v.dk = 1 THEN 0     ELSE v.s END
           , KOSQ = KOSQ + CASE WHEN v.dk = 1 THEN 0     ELSE v.s END
       where FDAT = dat_
         and KF   = v.KF
         and ACC  = l_acc;

      if ( sql%rowcount = 0 )
      then
        insert
          into SNAP_BALANCES_INTR_TBL
          ( FDAT, KF, ACC, RNK, OST, DOS, KOS, OSTQ, DOSQ, KOSQ )
        values
          ( dat_, v.KF, l_acc, v.rnk,
            CASE WHEN v.dk=1 THEN 0-v.s ELSE v.s END,
            CASE WHEN v.dk=1 THEN v.s   ELSE 0   END,
            CASE WHEN v.dk=1 THEN 0     ELSE v.s END,
            CASE WHEN v.dk=1 THEN 0-v.s ELSE v.s END,
            CASE WHEN v.dk=1 THEN v.s   ELSE 0   END,
            CASE WHEN v.dk=1 THEN 0     ELSE v.s END);
      END IF;

    END LOOP;

  END LOOP;

  -- Back to
  GL.PL_DAT( l_bank_dt );

  gl.aUID  := uid#;

  q.delete;
  ves.delete;

  if ( dat_ = DAT_NEXT_U( GL.GBD(), -1 ) )
  then -- Доплата проводок переоцінки породжених при формуванні знімків балансу
    GL.OVERPAY_PVP;
  end if;

  COMMIT;

  -- Фіксуємо SCN , що був до формування знімку балансу для можливого відкату
  l_cur_scn := BARS_UTL_SNAPSHOT.GET_SNP_SCN(p_table => 'SALDOA', p_date  => dat_); 

  -- Фіксуємо SCN на якому формуємо знімок балансу по табл. SALDOA
  BARS_UTL_SNAPSHOT.SET_TABLE_SCN( p_table => 'SALDOA'
                                 , p_date  => dat_
                                 , p_kf    => l_kf
                                 , p_scn   => DM_UTL.GET_LAST_SCN( 'SNAP_BALANCES_INTR_TBL', 'BARS', null, l_kf ) );

  BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock requested.' );

  if ( DBMS_LOCK.REQUEST( to_number( l_kf ), dbms_lock.x_mode, 600, FALSE ) = 0 )
  then

    BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock acquired.' );

    execute immediate 'truncate table SNAP_BALANCES_EXCHANGE';

    -- bypass the RLS policies
    DM_UTL.EXCHANGE_PARTITION( p_source_table_nm => 'SNAP_BALANCES_EXCHANGE'
                             , p_target_table_nm => 'SNAP_BALANCES_INTR_TBL'
                             , p_partition_nm    => 'P_'||l_kf
                             , p_novalidate      => true );

    -- bypass the RLS policies
    DM_UTL.EXCHANGE_SUBPARTITION_FOR( p_source_table_nm => 'SNAP_BALANCES_EXCHANGE'
                                    , p_target_table_nm => 'SNAP_BALANCES'
                                    , p_condition       => l_condition );

    if ( DBMS_LOCK.RELEASE( to_number( l_kf ) ) = 0 )
    then
      BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock released.' );
    end if;

  else
    BARS_AUDIT.INFO( $$PLSQL_UNIT||': lock was not acquired.' );
  end if;

  BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();

  BARS_AUDIT.INFO( $$PLSQL_UNIT||': Exit.' );

EXCEPTION
  WHEN OTHERS THEN
    -- Back to
    if l_cur_scn is not null then
        -- відкочуємо зміни по збереженим SCN
        BARS_UTL_SNAPSHOT.SET_TABLE_SCN( p_table => 'SALDOA'
                                     , p_date  => dat_
                                     , p_kf    => l_kf
                                     , p_scn   => l_cur_scn );    
        commit;
    end if;
    
    GL.PL_DAT( l_bank_dt );
    gl.aUID  := uid#;
    BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();
    bars_audit.error( $$PLSQL_UNIT|| ': ' || dbms_utility.format_error_stack() ||
                                  chr(10) || dbms_utility.format_error_backtrace() );
    raise;
END DDRAPS;
/
show errors;