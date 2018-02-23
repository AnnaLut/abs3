create or replace package BARS_SNAPSHOT
is
  --
  -- constants
  --
  g_header_version        constant varchar2(64) := 'version 1.2 06.02.2017';

  --
  -- HEADER_VERSION
  --
  function header_version return varchar2;

  --
  -- BODY_VERSION
  --
  function body_version return varchar2;

  --
  -- CURRENCY_REVALUATION
  --
  --  Переоцінка вал. позицій коригуючими проводками (аналог проц. PVP_R96)
  --
  procedure CURRENCY_REVALUATION;

  --
  -- CREATE_DAILY_SNAPSHOT
  --
  --   Створення денних знімків балансу.
  --
  PROCEDURE CREATE_DAILY_SNAPSHOT
  ( p_snapshot_dt  in     date );

  --
  -- CREATE_MONTHLY_BALANCE_SNAPSHOT
  --
  --   Створення місячних знімків балансу.
  --
  PROCEDURE CREATE_MONTHLY_SNAPSHOT
  ( p_snapshot_dt  in     date
  , p_auto_daily   in     boolean  default false );

  --
  -- CREATE_ANNUAL_BALANCE_SNAPSHOT
  --
  --   Створення річних знімків балансу.
  --
  procedure CREATE_ANNUAL_SNAPSHOT
  ( p_snapshot_dt  in     date );

  --
  -- REMOVING_OBSOLETE_SNAPSHOTS
  --
  --   Видалення застарілих знімків балансу
  --
  procedure REMOVING_OBSOLETE_SNAPSHOTS;


end BARS_SNAPSHOT;
/

show errors;

create or replace package body BARS_SNAPSHOT
is
  --
  -- constants
  --
  g_body_version          constant varchar2(64)  := 'version 1.8  06.02.2018';

  --
  -- types
  --

  --
  -- variables
  --
  l_mfo                   varchar2(6);
  l_baseval               number(3);  -- tabval$global%type;
  l_userid                number(38); -- oper.userid%type;
  l_okpo                  oper.id_a%type;
  l_condition             varchar2(300);
  l_first_day             date;
  l_bank_dt               date;
  l_vdat                  oper.vdat%type;

  --
  -- повертає версію заголовка пакета
  --
  function header_version
    return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' header '||g_header_version;
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' body '||g_body_version;
  end body_version;

  --
  -- DAILY_CURRENCY_REVALUATION
  -- for DAILY SNAPSHOT
  --
  PROCEDURE DAILY_CURRENCY_REVALUATION
  IS
  /**
  <b>DAILY_CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій
  %param

  %version 1.0
  %usage   переоцінка валютних позицій коригуючими проводками.
  */
    title  constant  varchar2(64) := $$PLSQL_UNIT||'.DAILY_CURRENCY_REVALUATION';
    l_ref            oper.ref%type;
    l_dk             oper.dk%type;
    l_nd             oper.nd%type;
    l_amnt           oper.s%type;
    l_tt             oper.tt%type   := 'PVP';
    l_vob            oper.vob%type  := 6;
  BEGIN

    bars_audit.trace( '%s: Start running.', title );

    bars_audit.trace( '%s: Exit.', title );

  END DAILY_CURRENCY_REVALUATION;

  --
  -- переоцінка вал. позицій коригуючими проводками (аналог проц. PVP_R96)
  -- для місячних знімків балансу ( для одного МФО )
  --
  procedure CURRENCY_REVALUATION
  ( p_kf           in     agg_monbals.kf%type
  )
  is
  /**
  <b>CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій
  %param

  %version 1.2
  %usage   переоцінка валютних позицій коригуючими проводками.
  */
    title  constant  varchar2(64) := $$PLSQL_UNIT||'.CURRENCY_REVALUATION';
    l_ref            oper.ref%type;
    l_dk             oper.dk%type;
    l_nd             oper.nd%type;
    l_amnt           oper.s%type;
    l_tt             oper.tt%type   := 'PVP';
    l_vob            oper.vob%type  := 96;
  begin

    bars_audit.trace( '%s: Entry with ( kf=%s ).', title, p_kf );

    l_bank_dt   := GL.GBD();
    l_vdat      := DAT_NEXT_U(trunc(l_bank_dt,'MM'),-1);
    l_first_day := trunc(l_vdat,'MM');

    gl.fSOS0 := 1;

    for cur in ( select /*+ NO_PARALLEL */ t.BRANCH, 'Finis/Реал.Курс.Рiзниця для рах.'||t.NLS||'/'||t.KV as PAYMENT_DESC
                      , t.ACC3801, a3.NLS as NLS_A, a3.KV as KV_A, SubStr(a3.NMS,1,38) as NAME_A
                      , t.ACC6204, a6.NLS as NLS_B, a6.KV as KV_B, SubStr(a6.NMS,1,38) as NAME_B
                      , (ADJ_AMNT_3800_UAH - ADJ_AMNT_3801) as DIFF_AMNT
                   from ( select /*+ ORDERED FULL(v) FULL(b0) FULL(b1) USE_HASH( b0 ) USE_HASH( b1 )*/
                                 v.KF, v.ACC3801, v.ACC6204
                               , a.NLS, a.KV, a.BRANCH
                               , b0.OSTQ - b0.CRDOSQ + b0.CRKOSQ as ADJ_AMNT_3800_UAH
                               , b1.OST  - b1.CRDOS  + b1.CRKOS  as ADJ_AMNT_3801
                            from VP_LIST  v
                            join AGG_MONBALS_EXCHANGE b0
                              on ( b0.FDAT = l_first_day and b0.KF = v.KF and b0.ACC = v.ACC3800 )
                            join AGG_MONBALS_EXCHANGE b1
                              on ( b1.FDAT = l_first_day and b1.KF = v.KF and b1.ACC = v.ACC3801 )
                            join ACCOUNTS a
                              on ( a.acc = v.ACC3800 )
                           where v.KF = p_kf
                             and v.ACC6204 Is Not Null
                             and a.DAZS Is Null
                             and ((b0.OSTQ - b0.CRDOSQ + b0.CRKOSQ) + (b1.OST - b1.CRDOS + b1.CRKOS)) <> 0
                        ) t
                   join ACCOUNTS a3
                     on ( a3.KF = t.KF and a3.ACC = t.ACC3801 )
                   join ACCOUNTS a6
                     on ( a6.KF = t.KF and a6.ACC = t.ACC6204 )
               )
    loop

      GL.REF(l_ref);

      dbms_application_info.set_client_info( 'Переоцінка валютних позицій міс. знімку балансу ref #' || to_char(l_ref) );

      l_dk   := case when cur.DIFF_AMNT > 0 then 0 else 1 end;
      l_amnt := ABS(cur.DIFF_AMNT);
      l_nd   := SubStr(to_char(l_ref),1,10);

      insert
        into OPER
        ( REF,  TT,   VOB,   ND,  DK, PDAT,
          VDAT, DATD, USERID,
          MFOA, NLSA, NAM_A, KV,  S,  ID_A,
          MFOB, NLSB, NAM_B, KV2, S2, ID_B,
          NAZN, BRANCH, TOBO )
      values
        ( l_ref,  l_tt, l_vob, l_nd, l_dk, sysdate,
          l_vdat, l_bank_dt, l_userid,
          l_mfo, cur.NLS_A, cur.NAME_A, cur.KV_A, l_amnt, l_okpo,
          l_mfo, cur.NLS_B, cur.NAME_B, cur.KV_B, l_amnt, l_okpo,
          cur.PAYMENT_DESC, cur.BRANCH, cur.BRANCH );

      -- gl.payS = gl.payV
      gl.payS( 1, l_ref, l_bank_dt, l_tt, l_dk
             , cur.KV_A, cur.NLS_A, l_amnt
             , cur.KV_B, cur.NLS_B, l_amnt );

      -- 3801
      update AGG_MONBALS_EXCHANGE
         set CRDOS  = CRDOS  + case when l_dk = 0 then l_amnt else 0 end
           , CRDOSQ = CRDOSQ + case when l_dk = 0 then l_amnt else 0 end
           , CRKOS  = CRKOS  + case when l_dk = 1 then l_amnt else 0 end
           , CRKOSQ = CRKOSQ + case when l_dk = 1 then l_amnt else 0 end
       where FDAT = l_first_day
         and KF   = p_kf
         and ACC  = cur.ACC3801;

      -- 6204
      update AGG_MONBALS_EXCHANGE
         set CRDOS  = CRDOS  + case when l_dk = 0 then 0 else l_amnt end
           , CRDOSQ = CRDOSQ + case when l_dk = 0 then 0 else l_amnt end
           , CRKOS  = CRKOS  + case when l_dk = 1 then 0 else l_amnt end
           , CRKOSQ = CRKOSQ + case when l_dk = 1 then 0 else l_amnt end
       where FDAT = l_first_day
         and KF   = p_kf
         and ACC  = cur.ACC6204;

      bars_audit.trace( '%s: ACC_3801=%s, ACC6204=%s, AMNT=%s.', title,
                        to_char(cur.ACC3801), to_char(cur.ACC6204), to_char(l_amnt) );

    end loop;

    gl.fSOS0 := 0;

    bars_audit.trace( '%s: Exit.', title );

  end CURRENCY_REVALUATION;

  --
  -- переоцінка вал. позицій коригуючими проводками (аналог проц. PVP_R96)
  -- для місячних знімків балансу ( по всіх МФО )
  --
  procedure CURRENCY_REVALUATION
  is
  /**
  <b>CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій по усіх KF
  %param 
  
  %version 1.0
  %usage   переоцінка валютних позицій коригуючими проводками.
  */
    title  constant   varchar2(64) := $$PLSQL_UNIT||'.CURRENCY_REVALUATION';
    l_kf              agg_monbals.kf%type;
  begin

    bars_audit.trace( '%s: Start running.', title );

    l_kf := sys_context('bars_context','user_mfo');

    if ( l_kf Is Null )
    then  -- for all KF

      null;

    else -- for one KF

      CURRENCY_REVALUATION( l_kf );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end CURRENCY_REVALUATION;

  --
  --
  --
  PROCEDURE ANNUAL_CURRENCY_REVALUATION
  IS
  /**
  <b>ANNUAL_CURRENCY_REVALUATION</b> - процедура переоцінки валютних позицій
  %param

  %version 1.0
  %usage   переоцінка валютних позицій коригуючими проводками.
  */
    title  constant  varchar2(60) := $$PLSQL_UNIT||'.annual_currency_revaluation';
  BEGIN

    bars_audit.trace( '%s: Start running.', title );

    bars_audit.trace( '%s: Exit.', title );

  END ANNUAL_CURRENCY_REVALUATION;

  --
  -- CREATE_DAILY_SNAPSHOT
  --
  PROCEDURE CREATE_DAILY_SNAPSHOT
  ( p_snapshot_dt  in     date
  ) IS
  /**
  <b>CREATE_DAILY_SNAPSHOT</b> - процедура створення денних знімків балансу
  %param

  %version 1.0
  %usage   Створення денних знімків балансу.
  */
    title   constant  varchar2(64) := $$PLSQL_UNIT||'.create_daily_snapshot';
    l_errmsg          varchar2(500);
  BEGIN

    bars_audit.trace( '%s: Start running with p_snapshot_dt=%s.', title, to_char(p_snapshot_dt,'dd.mm.yyyy') );

    IF ( p_snapshot_dt Is Null )
    THEN
      raise_application_error( -20666, 'Не вказано дату для формування знімку!' );
    -- ELSE
    --   dat1_ := trunc(p_date,'MM');
    --   dat2_ := last_day(dat1_);
    --   dat3_ := trunc(dat1_-1,'MM');
    END IF;

     -- Перевірка наявності активного процесу формування знімку
    l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING('DAYBALS');

    if (l_errmsg is Not Null)
    then
      raise_application_error( -20666, 'формування денного знімку балансу вже запущено користувачем ' || l_errmsg );
    else -- Блокування від декількох запусків
      BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG('DAYBALS');
    end if;

    dbms_application_info.set_client_info( 'Формування денного знімку балансу за ' || F_MONTH_LIT(p_snapshot_dt,0,0) );

    -- execute immediate 'TRUNCATE TABLE AGG_MONBALS_EXCHANGE';

    -- gl.setp('MONBAL','',NULL); -- deprecated (for compatibility)

    BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();

    bars_audit.trace( '%s: Exit.', title );

  EXCEPTION
    WHEN OTHERS THEN
      -- gl.setp('MONBAL','',NULL); -- deprecated (for compatibility)
      BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      raise;
  END CREATE_DAILY_SNAPSHOT;

  --
  -- CREATE_MONTHLY_BALANCE_SNAPSHOT
  --
  PROCEDURE CREATE_MONTHLY_SNAPSHOT
  ( p_snapshot_dt  in     date
  , p_auto_daily   in     boolean  default false
  ) IS
  /**
  <b>CREATE_MONTHLY_SNAPSHOT</b> - процедура створення місячних знімків балансу
  %param p_snapshot_dt - 
  %param p_auto_daily  - 

  %version 1.0
  %usage   створення місячних знімків балансу.
  */
    -- Місячні драпси Ver: 5.7  12/02/2016
    title       constant   varchar2(60) := $$PLSQL_UNIT||'.CREATE_MONTHLY_SNAPSHOT';
    dat0_                  DATE; -- останній банківський день звітного місяця
    dat1_                  DATE; -- перший   календарний день звітного місяця
    dat2_                  DATE; -- останній календарний день звітного місяця
    dat3_                  DATE; -- перший   календарний день попереднього місяця
    l_errmsg               varchar2(500);
    l_kf                   agg_monbals.kf%type;
    e_result_too_long      exception;
    pragma exception_init( e_result_too_long, -01489 );
  BEGIN

    bars_audit.trace( '%s: Start running with ( p_snapshot_dt=%s, p_auto_daily=%s ).'
                    , title, to_char(p_snapshot_dt,'dd.mm.yyyy'), case when p_auto_daily then 'true' else 'false' end );

    IF ( p_snapshot_dt Is Null )
    THEN
      raise_application_error( -20666, 'Не вказано дату для формування знімку!' );
    ELSE
      dat1_ := trunc(p_snapshot_dt,'MM');
      dat2_ := last_day(dat1_);
      dat3_ := trunc(dat1_-1,'MM');
    END IF;

    l_kf := sys_context('bars_context','user_mfo');

    if ( l_kf Is Null )
    then  -- for all KF

      -- temporarry
      raise_application_error( -20666, 'Не задано код філіалу (МФО) для формування знімку!' );

    else -- for one KF
    /* FDAT, SNAP_BALANCES, SALDOZ
    */

      -- Перевірка на наявність усіх денних знімків місяця
      if ( p_auto_daily )
      then -- автоматичне доформування денних знімків балансу

        for f in ( select k.FDAT
                     from FDAT k
                    where k.FDAT between dat1_ and dat2_
                      and not exists ( select 1 from SNAP_BALANCES where FDAT = k.FDAT )
                    order by k.FDAT )
        loop

       -- CREATE_DAILY_SNAPSHOT( f.FDAT, l_kf );
          DDRAPS( f.FDAT );

          commit;

        end loop;

      else

        select LISTAGG(to_char(k.FDAT,'dd-mm-yyyy'),', ') WITHIN GROUP (order by k.FDAT)
          into l_errmsg
          from FDAT k
         where k.FDAT between dat1_ and dat2_
           and not exists ( select 1 from SNAP_BALANCES where FDAT = k.FDAT );

        if ( l_errmsg Is Not Null )
        then
          raise_application_error( -20666, 'Відсутній щоденний знімок балансу за: ' || l_errmsg );
        end if;

      end if;

      select max(FDAT)
        into dat0_
        from SNAP_BALANCES
       where FDAT between dat1_ and dat2_;

      IF ( dat0_ Is Null )
      THEN
        raise_application_error( -20666, 'Відсутні щоденні знімки балансу за '|| F_MONTH_LIT(dat1_,1,4) );
      END IF;

      -- Перевірка наявності активного процесу формування знімку
      l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING('MONBALS');

      if (l_errmsg is Not Null)
      then
        raise_application_error( -20666, 'формування місячного знімку балансу вже запущено користувачем ' || l_errmsg );
      else -- Блокування від декількох запусків
        BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG('MONBALS');
      end if;

      dbms_application_info.set_client_info( 'Формування місячного знімку балансу за ' || F_MONTH_LIT(dat1_,1,2) || 'міс.' );

      execute immediate 'TRUNCATE TABLE AGG_MONBALS_EXCHANGE';

      -- Фіксуємо SCN на якому формуємо знімок балансу по табл. SALDOZ
      BARS_UTL_SNAPSHOT.SET_TABLE_SCN( 'SALDOZ', dat1_, l_kf, dbms_flashback.get_system_change_number() );

      insert /*+ APPEND */
        into AGG_MONBALS_EXCHANGE
           ( FDAT, KF, ACC, RNK, OST, OSTQ, DOS, KOS, DOSQ, KOSQ,
             CRDOS, CRKOS, CRDOSQ, CRKOSQ, CUDOS, CUKOS, CUDOSQ, CUKOSQ )
      select dat1_,                 NVL(b.KF,z.KF) as KF,
             NVL(b.ACC, z.ACC) acc, NVL(b.RNK,  1) as RNK,
             NVL(b.OST,  0) ost,    NVL(b.OSTQ, 0) as OSTQ,
             NVL(b.DOS,  0) dos,    NVL(b.KOS,  0) as KOS,
             NVL(b.DOSQ, 0) dosq,   NVL(b.KOSQ, 0) as KOSQ,
             NVL(z.RDOS, 0) crdos,  NVL(z.RKOS, 0) as CRKOS,
             NVL(z.RDOSQ,0) crdosq, NVL(z.RKOSQ,0) as CRKOSQ,
             NVL(z.UDOS, 0) cudos,  NVL(z.UKOS, 0) as CUKOS,
             NVL(z.UDOSQ,0) cudosq, NVL(z.UKOSQ,0) as CUKOSQ
        from ( select KF, ACC
                    , sum(decode(fdat, dat0_, ost,  0)) ost
                    , sum(decode(fdat, dat0_, ostq, 0)) ostq
                    , sum(dos) dos, sum(dosq) dosq
                    , sum(kos) kos, sum(kosq) kosq,
                      abs(max(decode(fdat, dat0_, rnk, -rnk))) rnk
                 from SNAP_BALANCES
                where FDAT between dat1_ and dat2_
                group by KF, ACC
             ) b
        full
        join ( select nvl(r.KF, u.KF ) as KF
                    , nvl(r.acc,u.acc) as ACC
                    , r.dos as RDOS, r.dosq as RDOSQ
                    , r.kos as RKOS, r.kosq as RKOSQ
                    , u.dos as UDOS, u.dosq as UDOSQ
                    , u.kos as UKOS, u.kosq as UKOSQ
                 from ( select * from SALDOZ where FDAT = dat1_ ) r
                 full
                 join ( select * from SALDOZ where FDAT = dat3_ ) u
                   on ( u.ACC = r.ACC )
             ) z
          on ( z.ACC = b.ACC );

      bars_audit.trace( '%s: %s row created.', title, to_char(SQL%ROWCOUNT) );

      COMMIT;

      dbms_application_info.set_client_info( 'Переоцінка валютних позицій місячного знімку балансу за ' || F_MONTH_LIT(dat1_,1,2) );

      -- переоцінка валютних позицій (коригуючі проводки + корекція даних в AGG_MONBALS_EXCHANGE)
      BARS_SNAPSHOT.CURRENCY_REVALUATION( l_kf );

      COMMIT;

      l_condition := to_char(dat1_,'ddmmyyyy');
      l_condition := replace( q'[ (to_date('%dt','ddmmyyyy'),'%kf') ]', '%dt', l_condition );
      l_condition := replace( l_condition, '%kf', l_kf );

      -- bypass the RLS policies
      DM_UTL.EXCHANGE_SUBPARTITION_FOR( p_source_table_nm => 'AGG_MONBALS_EXCHANGE'
                                      , p_target_table_nm => 'AGG_MONBALS'
                                      , p_condition       => l_condition );

      execute immediate 'truncate table AGG_MONBALS_EXCHANGE';

    end if;

    BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();

    bars_audit.trace( '%s: Exit.', title );

  EXCEPTION
    WHEN OTHERS THEN
      BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      raise;
  END CREATE_MONTHLY_SNAPSHOT;

  --
  -- CREATE_ANNUAL_BALANCE_SNAPSHOT
  --
  procedure CREATE_ANNUAL_SNAPSHOT
  ( p_snapshot_dt  in     date
  ) IS
  /**
  <b>CREATE_ANNUAL_SNAPSHOT</b> - процедура створення річних знімків балансу
  %param

  %version 1.0
  %usage   створення річних знімків балансу.
  */
    title   constant  varchar2(60) :=  $$PLSQL_UNIT||'.CREATE_ANNUAL_SNAPSHOT';
    l_jan_01_dt       date; -- перший   календарний день звітного року
    l_dec_01_dt       date;
    l_dat3            date;
    l_errmsg          varchar2(500);
    l_kf              agg_monbals.kf%type;
  BEGIN

    bars_audit.trace( '%s: Start running with p_snapshot_dt=%s.', title, to_char(p_snapshot_dt,'dd.mm.yyyy') );

    if ( p_snapshot_dt Is Null )
    then
      raise_application_error( -20666, 'Не вказано дату для формування знімку!' );
    else
      l_jan_01_dt := trunc(p_snapshot_dt,'YEAR');
      l_dec_01_dt := add_months(l_jan_01_dt, 11);
      l_dat3      := add_months(l_jan_01_dt,-12);
    end if;

    l_kf := sys_context('bars_context','user_mfo');

    if ( l_kf Is Null )
    then  -- for all KF

      -- Перевірка на наявність усіх місячних знімків балансу в році



      If ( l_errmsg Is Not Null )
      then
        raise_application_error( -20666, 'Відсутній щомісячний знімок балансу за: ' || l_errmsg );
      end if;

      -- temporarry
      raise_application_error( -20666, 'Не задано код філіалу (МФО) для формування знімку!' );

    else -- for one KF

      bars_audit.trace( '%s: running with kf=%s.', title, l_kf );

      -- Перевірка на наявність усіх місячних знімків балансу в році
      select LISTAGG(to_char(k.FDAT,'dd-mm-yyyy'),', ') WITHIN GROUP (order by k.FDAT)
        into l_errmsg
        from ( select add_months(l_jan_01_dt,level-1) as FDAT
                 from dual
              connect by level <= 12 ) k
       where Not Exists ( select 1 from AGG_MONBALS where FDAT = k.FDAT and KF = l_kf );

      If ( l_errmsg Is Not Null )
      then
        raise_application_error( -20666, 'Відсутній щомісячний знімок балансу за: ' || l_errmsg );
      end if;

      -- Перевірка наявності активного процесу формування знімку
      l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING('YEARBALS');

      if (l_errmsg is Not Null)
      then
        raise_application_error( -20666, 'формування річного знімку балансу вже запущено користувачем ' || l_errmsg );
      else
        -- Блокування від декількох запусків
        BARS_UTL_SNAPSHOT.SET_RUNNING_FLAG('YEARBALS');
      end if;

      dbms_application_info.set_client_info( 'Формування річного знімку балансу за ' || to_char(p_snapshot_dt,'YYYY') || '-й рік.' );

      execute immediate 'truncate table AGG_YEARBALS_EXCHANGE';

    end if;

    -- Фіксуємо SCN на якому формуємо знімок балансу по табл. SALDOY
    BARS_UTL_SNAPSHOT.SET_TABLE_SCN( 'SALDOY', l_jan_01_dt, l_kf, dbms_flashback.get_system_change_number() );

    insert /*+ APPEND */
      into AGG_YEARBALS_EXCHANGE
         ( FDAT, KF, ACC, RNK, OST, OSTQ
         , DOS,   DOSQ,   KOS,   KOSQ
         , CRDOS, CRDOSQ, CRKOS, CRKOSQ
         , CUDOS, CUDOSQ, CUKOS, CUKOSQ
         , WSDOS, WSKOS,  WCDOS, WCKOS )
    select /*+ PARALLEL */
           l_jan_01_dt      as FDAT
         , nvl(b.KF, y.KF ) as KF
         , nvl(b.ACC,y.ACC) as ACC
         , nvl(b.RNK,    1) as RNK
         , NVL(b.ost,  0) as OST
         , NVL(b.ostq, 0) as OSTQ
         , NVL(b.dos,  0) as DOS
         , NVL(b.dosq, 0) as DOSQ
         , NVL(b.kos,  0) as KOS
         , NVL(b.kosq, 0) as KOSQ
         , NVL(y.RDOS, 0) as CRDOS
         , NVL(y.RDOSQ,0) as CRDOSQ
         , NVL(y.RKOS, 0) as CRKOS
         , NVL(y.RKOSQ,0) as CRKOSQ
         , NVL(y.UDOS, 0) as CUDOS
         , NVL(y.UDOSQ,0) as CUDOSQ
         , NVL(y.UKOS, 0) as CUKOS
         , NVL(y.UKOSQ,0) as CUKOSQ
         , 0              as WSDOS
         , 0              as WSKOS
         , 0              as WCDOS
         , 0              as WCKOS
      from ( select KF, ACC
                  , sum(decode(FDAT, l_dec_01_dt, ost,  0)) OST
                  , sum(decode(FDAT, l_dec_01_dt, ostq, 0)) OSTQ
                  , sum(DOS ) as DOS
                  , sum(DOSQ) as DOSQ
                  , sum(KOS ) as KOS
                  , sum(KOSQ) as KOSQ
                  , abs(max(decode(FDAT, l_dec_01_dt, rnk, -rnk))) as RNK
               from AGG_MONBALS
              where FDAT between l_jan_01_dt and l_dec_01_dt
              group by KF, ACC
           ) b
        full -- корегуючі обороти
        join ( select nvl(r.KF, u.KF ) as KF
                    , nvl(r.acc,u.acc) as ACC
                    , r.dos as RDOS, r.dosq as RDOSQ
                    , r.kos as RKOS, r.kosq as RKOSQ
                    , u.dos as UDOS, u.dosq as UDOSQ
                    , u.kos as UKOS, u.kosq as UKOSQ
                 from ( select KF, FDAT, ACC, DOS, DOSQ, KOS, KOSQ
                          from SALDOY
                         where FDAT = l_jan_01_dt
                      ) r -- корегуючі обороти виконані за звітний рік
                 full
                 join ( select KF, FDAT, ACC, DOS, DOSQ, KOS, KOSQ
                          from SALDOY
                         where FDAT = l_dat3
                      ) u -- корегуючі обороти виконані в звітному році (за попередній)
                   on ( u.ACC = r.ACC )
             ) y
          on ( y.ACC = b.ACC );

    bars_audit.trace( '%s: %s row created.', title, to_char(SQL%ROWCOUNT) );

    COMMIT;

    -- переоцінка валютних позицій (коригуючі проводки + корекція даних в AGG_YEARBALS_EXCHANGE)
    BARS_SNAPSHOT.ANNUAL_CURRENCY_REVALUATION;

    COMMIT;

    /*
    -- partition is first locked to ensure that the partition is created
    execute immediate 'LOCK TABLE AGG_YEARBALS PARTITION FOR (to_date('''
                      || to_char(l_jan_01_dt,'ddmmyyyy') || ''',''DDMMYYYY'')) IN SHARE MODE';

    execute immediate 'ALTER TABLE AGG_YEARBALS EXCHANGE PARTITION FOR (to_date('''
                      || to_char(l_jan_01_dt,'ddmmyyyy') || ''',''DDMMYYYY'')) WITH TABLE AGG_YEARBALS_EXCHANGE '
                      || 'INCLUDING INDEXES WITHOUT VALIDATION';

    execute immediate 'ALTER TABLE AGG_YEARBALS RENAME PARTITION FOR (to_date('''
                      || to_char(l_jan_01_dt,'ddmmyyyy') || ''',''ddmmyyyy'')) TO P_'
                      || to_char(l_jan_01_dt,'YYYYMMDD');
    */

    if ( l_kf Is Null )
    then  -- for all KF

      l_condition := replace( q'[ (to_date('%dt','ddmmyyyy')) ]', '%dt', to_char(l_jan_01_dt,'ddmmyyyy') );

      -- bypass the RLS policies
      DM_UTL.EXCHANGE_PARTITION_FOR
      ( p_source_table_nm => 'AGG_YEARBALS_EXCHANGE_KF'
      , p_target_table_nm => 'AGG_YEARBALS'
      , p_condition       => l_condition );

      DM_UTL.RENAME_PARTITION_FOR
      ( p_table_nm        => 'AGG_YEARBALS'
      , p_partition_nm    => 'P_'||to_char(l_jan_01_dt,'YYYYMMDD')
      , p_condition       => l_condition
      , p_rename_sub      => 1 );

      execute immediate 'truncate table AGG_YEARBALS_EXCHANGE_KF';

    else -- for one KF

      l_condition := replace( q'[ (to_date('%dt','ddmmyyyy'),'%kf') ]', '%dt', to_char(l_jan_01_dt,'ddmmyyyy') );
      l_condition := replace( l_condition, '%kf', l_kf );

      -- bypass the RLS policies
      DM_UTL.EXCHANGE_SUBPARTITION_FOR( p_source_table_nm => 'AGG_YEARBALS_EXCHANGE'
                                      , p_target_table_nm => 'AGG_YEARBALS'
                                      , p_condition       => l_condition );

      -- DM_UTL.RENAME_SUBPARTITION_FOR
      -- ( p_table_nm        => 'AGG_YEARBALS'
      -- , p_subpartition_nm => 'P_'||to_char(l_jan_01_dt,'YYYYMMDD')||'_SP_'||l_kf
      -- , p_condition       => l_condition
      -- );

      execute immediate 'truncate table AGG_YEARBALS_EXCHANGE';

    end if;

    DBMS_STATS.GATHER_TABLE_STATS
    ( ownname     => 'BARS'
    , tabname     => 'AGG_YEARBALS'
    , cascade     => TRUE
    , method_opt  => 'FOR ALL COLUMNS SIZE AUTO'
    , degree      => 4
    , granularity => 'ALL' );

    BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();

    bars_audit.trace( '%s: Exit.', title );

  EXCEPTION
    WHEN OTHERS THEN
      BARS_UTL_SNAPSHOT.PURGE_RUNNING_FLAG();
      bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                              chr(10) || dbms_utility.format_error_backtrace() );
      raise;
  END CREATE_ANNUAL_SNAPSHOT;

  --
  --
  --
  procedure REMOVING_OBSOLETE_SNAPSHOTS
  is
  /**
  <b>REMOVING_OBSOLETE_SNAPSHOTS</b> - процедура видалення застарілих
  знімків балансу (заміна проц. DROP_OBSOLETE_PARTITIONS з пакету BARS_ACCM_SNAP)
  %param

  %version 1.1
  %usage   видалення застарілих знімків балансу.
  */
    title         constant varchar2(64) := $$PLSQL_UNIT||'.REMOVING_OBSOLETE_DM';
    l_min_dt               date;
    l_lmt_dt               date;
    PART_NOT_EXISTS        exception;
    pragma exception_init( PART_NOT_EXISTS, -2149 );
  begin

    bars_audit.trace( '%s: Entry.', title );

    -- залишаємо щоденні знімки за поточний і попередній місяць
    l_lmt_dt := add_months( trunc(gl.gbd(),'MM'), -1 );

    select min(FDAT)
      into l_min_dt
      from SNAP_BALANCES
     where FDAT < l_lmt_dt;

    bars_audit.trace( '%s: l_lmt_dt=%s, l_min_dt=%s.', title, to_char(l_lmt_dt,'dd.mm.yyyy'), to_char(l_min_dt,'dd.mm.yyyy') );

    for c in ( select FDAT
                 from FDAT
                where FDAT >= l_min_dt
                  and FDAT < l_lmt_dt )
    loop
      begin
        execute immediate 'alter table SNAP_BALANCES drop partition for (to_date('''||TO_CHAR(c.FDAT,'ddmmyyyy')||''',''ddmmyyyy''))';
        bars_audit.trace( '%s: partition dropped for %.', title, to_char(c.FDAT,'dd.mm.yyyy') );
      exception
        when PART_NOT_EXISTS
        then null;
        when OTHERS
        then bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                     chr(10) || dbms_utility.format_error_backtrace() );
      end;
    end loop;

    -- залишаємо місячні знімки за поточний та попередній рік
    l_lmt_dt := add_months( trunc(gl.gbd(),'YY'), -12 );

    select min(FDAT)
      into l_min_dt
      from AGG_MONBALS
     where FDAT < l_lmt_dt;

    bars_audit.trace( '%s: l_lmt_dt=%s, l_min_dt=%s.', title, to_char(l_lmt_dt,'dd.mm.yyyy'), to_char(l_min_dt,'dd.mm.yyyy') );

    while ( l_lmt_dt > l_min_dt )
    loop
      begin
        execute immediate 'alter table AGG_MONBALS drop partition for (to_date('''||TO_CHAR(l_min_dt,'ddmmyyyy')||''',''ddmmyyyy''))';
        bars_audit.trace( '%s: partition dropped for %.', title, to_char(l_min_dt,'dd.mm.yyyy') );
      exception
        when PART_NOT_EXISTS
        then null;
        when OTHERS
        then bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                     chr(10) || dbms_utility.format_error_backtrace() );
      end;

      l_lmt_dt := add_months( l_lmt_dt, 1 );

    end loop;

    bars_audit.trace( '%s: Exit.', title );

  end REMOVING_OBSOLETE_SNAPSHOTS;



begin

  l_mfo     := gl.aMFO;
  l_baseval := gl.baseval;
  l_userid  := gl.aUID;
  l_okpo    := gl.aOKPO;

END BARS_SNAPSHOT;
/

show errors;

grant EXECUTE on BARS_SNAPSHOT to BARS_ACCESS_DEFROLE;
