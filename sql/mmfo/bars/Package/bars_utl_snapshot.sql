PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_utl_snapshot.sql =========*** R
PROMPT ===================================================================================== 

create or replace package BARS_UTL_SNAPSHOT
is
  -- Author  : OLEG.MUZYKA
  -- Created : 07.07.2015 13:05:13
  -- Purpose : Службовий пакет роботи зі знімками балансу

  -- Public constant declarations
  VERSION_HEAD         constant varchar2(64) := 'version 1.6  31.01.2019';

  -- алгоритмы наполнения accm_snap_balances
  ALGORITHM_OLD        constant varchar2(30) := 'OLD';
  ALGORITHM_SALNQC     constant varchar2(30) := 'SALNQC';
  ALGORITHM_MIK        constant varchar2(30) := 'ALGORITMIK';

  -- таблица оборотов в номинале по банковским датам
  TAB_SALDOA           constant varchar2(30) := 'SALDOA';

  -- таблица оборотов в эквиваленте по банковским датам
  TAB_SALDOB           constant varchar2(30) := 'SALDOB';

  -- таблица записей(ключей), удаленных из SALDOA
  TAB_SALDOA_DEL_ROWS  constant varchar2(30) := 'SALDOA_DEL_ROWS';

  -- таблица корегуючих оборотов в номинале по звітним датам
  TAB_SALDOZ           constant varchar2(30) := 'SALDOZ';

  -- таблиця щоденнх знімків балансу
  TAB_SNPBAL           constant varchar2(30) := 'SNAP_BALANCES';

  ------------------------------------------------------------------
  -- HEADER_VERSION
  --
  --
  --
  function header_version return varchar2;

  ------------------------------------------------------------------
  -- BODY_VERSION
  --
  --
  --
  function body_version return varchar2;

  --------------------------------------------------------------------------------
  --
  -- Функція яка повертає признак чи запущено накопичення
  --
  function get_snp_running return number;

  --
  -- Перевірка наявності активного процесу формування знімку
  --
  function CHECK_SNP_RUNNING
  ( p_action  in   v$session.action%type default null
  ) return varchar2;

  --
  --
  --
  function CHECK_SNP_RUNNING
  ( p_action  in   v$session.action%type
  , p_kf      in   varchar2
  ) return varchar2;

  --
  -- Встановлення відмітки про активність процесу формування знімку
  --
  procedure set_running_flag
  ( p_action  in   v$session.action%type default null );

  --
  -- Видадення відмітки про активність процесу формування знімку
  --
  procedure purge_running_flag;

  -------------------------------------------------------------------
  --
  -- Процедура яка встановлює відмітку про старт запуску формування знімку
  --
  --
  procedure start_running;

  -------------------------------------------------------------------
  --
  -- Процедура яка встановлює відмітку про завершення формування знімку
  --
  --
  procedure stop_running;

  -- ==================================================================================================
  -- Процедура Синхронизация снимков объекта
  -- ==================================================================================================
  Procedure sync_snap (p_fdat date);


  -- ==================================================================================================
  -- Процедура Синхронизация снимков объекта sync_month
  -- ==================================================================================================
  Procedure sync_month (p_mdat date);


  -- ==================================================================================================
  -- Процедура Синхронизация снимков объекта за період
  -- ==================================================================================================
  Procedure sync_snap_period (p_fdat1 date, p_fdat2 date);


  -- ==================================================================================================
  -- get_snap_scn - возвращает scn последней генерации снимка баланса по партиции указанной таблицы
  -- ==================================================================================================
  function get_snp_scn(p_table in varchar2, p_date in date
  ) return number;
  
  -- ==================================================================================================
  -- set_snap_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
  -- =================================================================================================
  procedure set_snap_scn(p_date in date);


  -- ==================================================================================================
  -- set_table_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
  -- ==================================================================================================
  procedure SET_TABLE_SCN( p_table in varchar2, p_date in date, p_scn in number );

  --
  --
  --
  procedure SET_TABLE_SCN
  ( p_table in     varchar2
  , p_date  in     date
  , p_kf    in     varchar2
  , p_scn   in     number
  );

  --
  --
  --
  procedure SET_TABLE_SCN
  ( p_table in     varchar2
  , p_date  in     date
  , p_kf    in     varchar2
  );

  -- ======================================================
  -- Modifying Subpartition Template
  -- ======================================================
  procedure SET_SUBPARTITION_TEMPLATES
  ( p_force        in     signtype default 0 );

  -- ==================================================================================================
  -- Переіменовує системно згенеровані імена секцій таблиці відповідно до значень ключів секціонування
  -- ==================================================================================================
  procedure RENAME_PARTITION
  ( p_table_name   in     varchar2
  , p_rename_sub   in     signtype default 0 );


end BARS_UTL_SNAPSHOT;
/
show errors;

CREATE OR REPLACE PACKAGE BODY BARS.BARS_UTL_SNAPSHOT
is
  --
  -- constants
  --
  VERSION_BODY    constant varchar2(64)  := 'version 1.3.5  16.08.2018';

  -- Префикс для трассировки
  PKG_CODE        constant varchar2(100) := 'UTL_SNAPSHOT';

  -- Формат даты
  FMT_DATE        constant varchar2(10)  := 'dd.mm.yyyy';

  -- Формат дата+время
  FMT_DATETIME    constant varchar2(24)  := 'dd.mm.yyyy hh24:mi:ss';

  --
  -- variables
  --

  -- Флаг активності процесу формування знімку
  G_SNP_RUNNING            number;
  G_ALGORITHM              varchar2(30);

  -- COBUMMFO-9690 Begin
  g_module                 varchar2(64);
  g_action                 varchar2(64);
  -- COBUMMFO-9690 End
  ------------------------------------------------------------------
  -- HEADER_VERSION
  --
  function header_version return varchar2 is
  begin
    return 'Package '||$$PLSQL_UNIT||' header '||VERSION_HEAD||'.';
  end header_version;

  ------------------------------------------------------------------
  -- BODY_VERSION
  --
  function body_version return varchar2 is
  begin
    return 'Package '||$$PLSQL_UNIT||' body '||VERSION_BODY||'.';
  end body_version;

  ------------------------------------------------------------------
  -- Повертає признак чи запущено процес по формуванню знімку балансу
  --
  function GET_SNP_RUNNING return number
  is
  begin

    select nvl(max(p.val),0)
      into G_SNP_RUNNING
      from params$base p
     where p.par='SNP_RUN';

    return G_SNP_RUNNING;

  end  get_snp_running;

  --------------------------------------------------------------------------------
  -- Перевірка наявності активного процесу формування знімку
  --
  function CHECK_SNP_RUNNING
  ( p_action  in   v$session.action%type default null
  ) return varchar2
  is
    l_errmsg  varchar2(512);
    l_action  v$session.action%type;
  begin

    l_action := nvl(p_action,'MONBALS');

    begin
      select s.USERNAME || ' (' || s.MACHINE || '/' || s.OSUSER || ')'
        into l_errmsg
        from V$SESSION s
        left
        join V$PX_SESSION px
          on ( px.SID = s.SID and px.QCSID = s.SID )
       where s.TYPE   = 'USER'
         and s.STATUS = 'ACTIVE'
         and s.ACTION = l_action;
    exception
      when NO_DATA_FOUND then
        l_errmsg := null;
      when TOO_MANY_ROWS then
        select listagg( CLIENT_IDENTIFIER, ', ' ) WITHIN GROUP ( order by CLIENT_IDENTIFIER )
          into l_errmsg
          from ( select distinct s.CLIENT_IDENTIFIER
                   from V$SESSION s
                   left
                   join V$PX_SESSION px
                     on ( px.SID = s.SID and px.QCSID = s.SID )
                  where s.TYPE   = 'USER'
                    and s.STATUS = 'ACTIVE'
                    and s.ACTION = l_action
               );
    end;

    return l_errmsg;

  end CHECK_SNP_RUNNING;

  --
  --
  --
  function CHECK_SNP_RUNNING
  ( p_action  in   v$session.action%type
  , p_kf      in   varchar2
  ) return varchar2
  is
    l_errmsg  varchar2(500);
    l_client_identifier_my  varchar2(64);
  begin

    case
    when ( p_action Is Null )
    then raise_application_error( -20666, 'Parameter [p_action] must be specified!' );
    when ( p_kf Is Null )
    then raise_application_error( -20666, 'Parameter [p_kf] must be specified!' );
    else null;
    end case;
    l_client_identifier_my := bars_login.get_session_clientid;
    for i in(select s.CLIENT_IDENTIFIER, s.USERNAME, s.MACHINE, s.OSUSER
               --into l_client_identifier_job, l_uname, l_machine, l_osuser
               from V$SESSION s
              where s.TYPE   = 'USER'
                and s.STATUS = 'ACTIVE'
                and s.ACTION = p_action) loop

      sys.dbms_session.set_identifier(i.client_identifier);

      if sys_context('BARS_CONTEXT', 'USER_MFO') = p_kf then
        l_errmsg := i.USERNAME || ' (' || i.machine || '/' || i.osuser || ')';
        sys.dbms_session.set_identifier(l_client_identifier_my);
        exit;
      else
        l_errmsg := null;
      end if;
      sys.dbms_session.set_identifier(l_client_identifier_my);
    end loop;

    return l_errmsg;

  end CHECK_SNP_RUNNING;

  --------------------------------------------------------------------------------
  --
  -- Встановлення відмітки про активність процесу формування знімку
  --
  procedure SET_RUNNING_FLAG
  ( p_action  in   v$session.action%type default null
  ) is
    l_action  v$session.action%type;
  begin

    l_action := nvl(p_action,'MONBALS');

--  dbms_application_info.set_module( 'SNAPSHOT', l_action );
    dbms_application_info.set_action( l_action );

  end set_running_flag;

  --------------------------------------------------------------------------------
  --
  -- Видадення відмітки про активність процесу формування знімку
  --
  procedure purge_running_flag
  is
  begin
--  dbms_application_info.set_module(Null,Null);
    dbms_application_info.set_action(g_action /*Null -- COBUMMFO-9690*/);
    dbms_application_info.set_client_info(Null);
  end purge_running_flag;

  ------------------------------------------------------------------
  --
  -- Процедура яка встановлює відмітку про старт запуску формування знімку
  --
  --
  procedure start_running
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin

    update params$base p
       set p.val='1'
     where p.par='SNP_RUN';

    if ( sql%rowcount = 0 )
    then
      insert into params$base(par, val, comm)
      values('SNP_RUN', '1', 'Відмітка про стан запуску формування знімку');
    end if;

    commit;

    set_running_flag;

  end start_running;

  -------------------------------------------------------------------
  --
  -- Процедура яка встановлює відмітку про старт запуску формування знімку
  --
  --
  procedure stop_running
  is
    PRAGMA AUTONOMOUS_TRANSACTION;
  begin
    update params$base p
       set p.val='0'
     where p.par='SNP_RUN';
    commit;
    purge_running_flag;
  end stop_running;

  -- ==================================================================================================
  -- get_snap_scn - возвращает scn последней генерации снимка баланса по партиции указанной таблицы
  -- ==================================================================================================
  function get_snp_scn(p_table in varchar2, p_date in date
  ) return number
  is
    p           constant varchar2(100) := PKG_CODE || '.getsnapscn';
    l_snap_scn  number;
    l_table     varchar2(30);
    l_date      date;
  begin
    --
    if logger.trace_enabled()
    then
      logger.trace('%s: entry point p_table=>%s, p_date=>%s', p, p_table, to_char(p_date, FMT_DATE));
    end if;
    --
    l_table := upper(p_table);
    l_date  := trunc(p_date);
    --
    begin
      select snap_scn
        into l_snap_scn
        from accm_snap_scn
       where fdat = l_date
         and table_name = l_table;
    exception
      when no_data_found then
        l_snap_scn := 0;
    end;
    --
    if logger.trace_enabled()
    then
      logger.trace('%s: succ end, snap_scn=%s', p, to_char(l_snap_scn));
    end if;
    --
    return l_snap_scn;
    --
  end get_snp_scn;


  -- ==================================================================================================
  -- get_mod_scn - возвращает scn последней модификации партиции указанной таблицы
  -- ==================================================================================================
  function GET_MOD_SCN
  ( p_table in varchar2
  , p_date  in date
  , p_kf    in varchar2 default null
  ) return number
  is
  begin

    return DM_UTL.GET_LAST_SCN
           ( p_table_nm  => p_table
           , p_table_own => 'BARS'
           , p_date      => p_date
           , p_kf        => nvl(p_kf,sys_context('bars_context','user_mfo'))
           );

  end get_mod_scn;

  -- ==================================================================================================
  -- set_table_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
  -- ==================================================================================================
  procedure set_table_scn(p_table in varchar2, p_date in date, p_scn in number)
  is
      p           constant varchar2(100) := PKG_CODE || '.settablescn';
      l_table     varchar2(30);
      l_date      date;
  begin
      --
      if logger.trace_enabled()
      then
          logger.trace('%s: entry point p_table=>%s, p_date=>%s, p_scn=>%s',
                        p, p_table, to_char(p_date, FMT_DATE), to_char(p_scn));
      end if;
      --
      l_table := upper(p_table);
      l_date  := trunc(p_date);
      --
      update accm_snap_scn
         set snap_scn = p_scn,
             snap_date = scn_to_timestamp(p_scn)
       where fdat = l_date
         and table_name = l_table;
      --
      if sql%rowcount=0
      then
          insert
            into accm_snap_scn(fdat, table_name, snap_scn, snap_date)
          values (l_date, l_table, p_scn, scn_to_timestamp(p_scn));
      end if;
      --
      if logger.trace_enabled()
      then
          logger.trace('%s: succ end', p);
      end if;
      commit;
  end SET_TABLE_SCN;

  --
  --
  --
  procedure SET_TABLE_SCN
  ( p_table        in     varchar2
  , p_date         in     date
  , p_kf           in     varchar2
  , p_scn          in     number
  ) is
    title    constant     varchar2(64) :=  $$PLSQL_UNIT||'.SET_TAB_SCN';
    l_table               varchar2(30);
    l_date                date;
    l_kf                  varchar2(6);
  begin

    bars_audit.trace( '%s: entry with ( p_table=>%s, p_date=>%s, p_kf=>%s, p_scn=>%s ).'
                      , title, p_table, to_char(p_date, FMT_DATE), p_kf, to_char(p_scn) );

    l_table := upper( p_table );
    l_date  := trunc( p_date );
    l_kf    := nvl( p_kf, SYS_CONTEXT('BARS_CONTEXT','USER_MFO') );

    update ACCM_SNAP_SCN
       set SNAP_SCN   = p_scn
         , SNAP_DATE  = scn_to_timestamp(p_scn)
     where FDAT       = l_date
       and TABLE_NAME = l_table
       and KF         = l_kf;

    if ( sql%rowcount = 0 )
    then
        insert
          into ACCM_SNAP_SCN ( KF, FDAT, TABLE_NAME, SNAP_SCN, SNAP_DATE )
        values ( l_kf, l_date, l_table, p_scn, scn_to_timestamp(p_scn) );
    end if;

    bars_audit.trace( '%s: Exit.', title );

    commit;

  end SET_TABLE_SCN;

  --
  --
  --
  procedure SET_TABLE_SCN
  ( p_table in     varchar2
  , p_date  in     date
  , p_kf    in     varchar2
  ) is
    title    constant     varchar2(64) :=  $$PLSQL_UNIT||'.SET_TAB_SCN';
    l_table               varchar2(30);
    l_date                date;
    l_kf                  varchar2(6);
  begin

    bars_audit.trace( '%s: entry with ( p_table=>%s, p_date=>%s, p_kf=>%s ).'
                      , title, p_table, to_char(p_date, FMT_DATE), p_kf );

    l_table := upper( p_table );
    l_date  := trunc( p_date );
    l_kf    := nvl( p_kf, SYS_CONTEXT('BARS_CONTEXT','USER_MFO') );

    update ACCM_SNAP_SCN
       set SNAP_SCN   = USERENV('COMMITSCN')
         , SNAP_DATE  = scn_to_timestamp(USERENV('COMMITSCN'))
     where FDAT       = l_date
       and TABLE_NAME = l_table
       and KF         = l_kf;

    if ( sql%rowcount = 0 )
    then
      insert
        into ACCM_SNAP_SCN ( KF, FDAT, TABLE_NAME, SNAP_SCN, SNAP_DATE )
      values ( l_kf, l_date, l_table, USERENV('COMMITSCN'), scn_to_timestamp(USERENV('COMMITSCN')) );
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_TABLE_SCN;

  --==================================================================================================
  -- is_partition_modified - возвращает флаг 0/1 модификации партиции таблицы с момента p_scn
  --==================================================================================================
  function IS_PARTITION_MODIFIED
  ( p_table     in     varchar2
  , p_date      in     date
  ) return number
  is
    l_crn_tbl_scn      number;
    l_prv_tbl_scn      number;
    l_mod              number(1);
  begin

    bars_audit.trace( '%s.IS_PARTITION_MODIFIED: Entry with ( p_table = %s, p_date = %s ).'
                    , PKG_CODE, p_table, to_char(p_date,FMT_DATE) );

    l_crn_tbl_scn := get_mod_scn( p_table, p_date ); -- max(ora_rowscn)
    l_prv_tbl_scn := get_snp_scn( p_table, p_date ); -- bars.accm_snap_scn

    bars_audit.trace( '%s.IS_PARTITION_MODIFIED: ( l_crn_tbl_scn = %s, l_prv_tbl_scn = %s ).'
                    , PKG_CODE, to_char(l_crn_tbl_scn), to_char(l_prv_tbl_scn) );

    if ( l_crn_tbl_scn > l_prv_tbl_scn )
    then
      l_mod := 1;
      bars_audit.info( PKG_CODE||'.IS_PARTITION_MODIFIED: ( tbl_nm='||p_table||', date='||to_char(p_date,FMT_DATE)
                               ||', crn_tbl_scn='||to_char(l_crn_tbl_scn)||', tabl_scn_h='||to_char(l_prv_tbl_scn)||' ).' );
    else
      l_mod := 0;
    end if;

    bars_audit.trace( '%s.IS_PARTITION_MODIFIED: Exit with ( %s ).', PKG_CODE, to_char(l_mod) );

    return l_mod;

  end IS_PARTITION_MODIFIED;


  --==================================================================================================
  -- is_bday_modified  перевіряєм чи були зміни за дату формування снимка
  --==================================================================================================
  function IS_BDAY_MODIFIED
  ( p_fdat date
  ) return boolean
  is
    l_create_snap      boolean := false;
    l_saldoa_snap_scn  number;
  Begin

    bars_audit.trace( PKG_CODE||'IS_BDAY_MODIFIED: Start scn '|| 'fdat '||to_char(p_fdat, FMT_DATE) );

    -- снимок уже создавался раньше, необходимо его перенакопить
    -- для этого:
    -- получим scn последних снимков балансов по партиции saldoa
    l_saldoa_snap_scn := is_partition_modified(TAB_SALDOA,           p_fdat);

    /*
    if ( get_mod_scn( TAB_SALDOA, p_fdat ) > get_mod_scn( TAB_SNPBAL, p_fdat ) )
    then l_saldoa_snap_scn := 1;
    else l_saldoa_snap_scn := 0;
    end if;
    */

    bars_audit.trace( PKG_CODE||' saldoa_snap_scn='||l_saldoa_snap_scn||', fdat='||to_char(p_fdat, FMT_DATE) );

    -- и проверим модифицировались ли партиции за указанную дату с этого момента
    if ( l_saldoa_snap_scn = 1 )
    then

      bars_audit.trace( PKG_CODE||' l_create_snap = true, fdat = '||to_char(p_fdat, FMT_DATE) );

      l_create_snap := true;

    end if;

    return l_create_snap;

  end is_bday_modified;

  -- ==================================================================================================
  -- is_month_modified - перевіряєм чи були зміни за звітну дату коригуючі проводки
  -- ==================================================================================================
  function is_month_modified( p_fdat date -- завжди має бути 01 число місяця
  ) return boolean
  is
    l_create_snap     boolean; --
    l_saldoz_snap_scn number;  --
    l_tabl_scn        number;  --
    l_snap_scn        number;  --
    l_last_bdt        date;    -- останній робочий день міс.
  Begin

    bars_audit.trace( '%s: Start with p_fdat=%s.', PKG_CODE, to_char(p_fdat,FMT_DATE) );

    -- снимок уже создавался раньше, необходимо его перенакопить, для этого:

    -- получим scn последних снимков короборотів
    l_saldoz_snap_scn := is_partition_modified( TAB_SALDOZ, p_fdat );

    -- и проверим модифицировались ли партиции за указанную дату с этого момента
    if ( l_saldoz_snap_scn = 1 )
    then
      l_create_snap := true;
    else -- перевірка на модифікацію даних в партиції табл.SNAP_BALANCES за останній робочий день міс.

      l_last_bdt := DAT_NEXT_U(add_months(p_fdat,1),-1);
      l_tabl_scn := get_mod_scn( TAB_SNPBAL, l_last_bdt );
      l_snap_scn := get_snp_scn( TAB_SALDOZ, p_fdat     );

      if ( l_snap_scn < l_tabl_scn )
      then
        l_create_snap := true;
      else
        l_create_snap := false;
      end if;

    end if;

    bars_audit.trace( '%s: Exit with %s.', PKG_CODE, case l_create_snap when true then 'TRUER' else 'FALSE' end );

    return l_create_snap;

  end;

  -- ==================================================================================================
  -- set_snap_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
  -- ==================================================================================================
  procedure set_snap_scn(p_date in date)
  is
    l_now_scn   number;
  Begin
    l_now_scn := dbms_flashback.get_system_change_number();
    logger.trace(PKG_CODE||' set_snap_scn >'||l_now_scn);
    -- сохраняем scn'ы
    set_table_scn(TAB_SALDOA,          p_date, l_now_scn);
--  set_table_scn(TAB_SALDOB,          p_date, l_now_scn);
    set_table_scn(TAB_SALDOA_DEL_ROWS, p_date, l_now_scn);
    commit;
  End;

  -- ==================================================================================================
  -- load_algorithm - вичитуєм алгоритм наполнения accm_snap_balances
  -- ==================================================================================================
  procedure load_algorithm
  is
  begin
    begin
      select val
        into g_algorithm
        from params
       where par='SNAP_ALG';
    exception
      when no_data_found then
        raise_application_error(-20000, 'Не задан параметр SNAP_ALG');
    end;
     if g_algorithm not in (ALGORITHM_OLD, ALGORITHM_SALNQC, ALGORITHM_MIK)
     then
        raise_application_error(-20000, 'Недопустимое значение параметра SNAP_ALG='||g_algorithm||', ожидалось '
        ||ALGORITHM_OLD||' или '||ALGORITHM_SALNQC||' или '||ALGORITHM_MIK);
     end if;
  end load_algorithm;

  -- ==================================================================================================
  -- Возвращает алгоритм наполнения accm_snap_balances
  -- ==================================================================================================
  function get_algorithm
    return varchar2
  is
  begin
    return g_algorithm;
  end get_algorithm;

  -- ==================================================================================================
  -- Процедура Синхронизация снимков объекта
  -- ==================================================================================================
  Procedure sync_snap (p_fdat date)
  is
    l_create_snap      boolean := false;
    l_saldoa_snap_scn  number;
    l_delrow_snap_scn  number;
    l_saldob_snap_scn  number;
    l_bankday          varchar2(1);
    l_snap_balance     varchar2(1);
    dats_              date;

    sess_   varchar2(64) := bars_login.get_session_clientid;
    sid_    varchar2(64);

    l_previous_day        date;
    l_previous_day_modif  number;
    l_snap_balance_previous varchar2(1);

  Begin

    bars_audit.trace( PKG_CODE||'.SYNC_SNAP Entry with p_fdat = '||to_char(p_fdat,FMT_DATE) );

    -- Якщо формується снімок то немає і даних для звіту.
    if g_algorithm = ALGORITHM_MIK
    then

      begin

        SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
        sid_:=SYS_CONTEXT('BARS_GLPARAM','SNPBAL');
        SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

        select sid into sid_
          from v$session
         where sid=sid_
           and sid<>SYS_CONTEXT ('USERENV', 'SID');

        raise_application_error(-20000,'Повторіть формуваня звіту через 10хв.'||CHR(10)||'Формується знімок балансу  SID='|| sid_);

      exception
        when no_data_found THEN NULL;
      end;

    end if;

    -- Визначимо дату снимка чи банківський день.
    begin
      Select 'Y'
        Into l_bankday
        From BARS.FDAT
       Where FDAT = p_fdat;
    exception
      when no_data_found then
        l_bankday := 'N';
    end;

    bars_audit.trace( PKG_CODE||' l_bankday='||l_bankday );

    begin
      Select 'Y'
        Into l_snap_balance
        From BARS.SNAP_BALANCES
       Where fdat = p_fdat
         and rownum=1;
    exception
      when no_data_found then
        l_snap_balance := 'N';
    end;

    bars_audit.trace( PKG_CODE||' l_snap_balance='||l_snap_balance );

    -- для драпсів неможна формувати снимки раніше вказаної дати
    begin
      SELECT TO_DATE(val,'DDMMYYYY') INTO dats_ FROM params WHERE par='DATRAPS';
      IF dats_>p_fdat
      THEN
        l_bankday := 'N';
      END IF;
    exception
      when NO_DATA_FOUND then NULL;
    end;

    -- Якщо не банківський день то знімки не формуємо
    If ( l_bankday = 'N' )
    then
      l_create_snap := false;
    else

      if ( l_snap_balance = 'Y' )
      then -- перевіряєм чи були зміни за дату формування снимка
        l_create_snap := is_bday_modified(p_fdat);
      else
        l_create_snap := true;
      end if;

    end if;

    -- Формуємо знімок
    if l_create_snap
    then

      l_previous_day := DAT_NEXT_U(p_fdat, -1); -- попередня банківська даня

      begin
        Select 'Y'
          Into l_snap_balance_previous
          From SNAP_BALANCES
         Where FDAT = l_previous_day
           and rownum=1;
      exception
        when no_data_found then
          l_snap_balance_previous := 'N';
      end;

      if ( is_bday_modified(l_previous_day) and l_snap_balance_previous='N' )
      then -- повне формування
        l_previous_day_modif := 0;
      else -- спрощене формування
        l_previous_day_modif := 1;
      end if;

      bars_audit.trace( PKG_CODE||'.sync_snap: Попередній банківськй день '||to_char(l_previous_day,FMT_DATE)||' l_previous_day_modif='||l_previous_day_modif);

      bars_audit.trace( PKG_CODE||'.sync_snap: create_snap = TRUE on '||to_char(p_fdat,FMT_DATE) );

      BARS.DDRAPS( p_fdat, l_previous_day_modif );

    else
      bars_audit.info( PKG_CODE||'.sync_snap: create_snap = FALSE on '||to_char(p_fdat,FMT_DATE) );
    End if;

    bars_audit.trace( '%s: Exit.', PKG_CODE||'.sync_snap' );

  End sync_snap;

  -- ==================================================================================================
  -- Процедура Синхронизация снимков объекта sync_month
  -- ==================================================================================================
  Procedure sync_month
  ( p_mdat  in date
--  , p_mode  in number default 0  -- режим формування знімку: 1 - безумовне переформування / 0 - при необхідності
  ) is
    l_create_snap      boolean := false;
    l_snap_balance     varchar2(1);
    l_fdat             date;
    l_errmsg           varchar2(500);
    sess_              varchar2(64) := bars_login.get_session_clientid;
    sid_               varchar2(64);
    /*
    ----------------------------------------------------------
    --   l_           bars.accm_snap_scn.snap_date%type;
    -- if ( p_mode = 0 )
    -- then
    --   select max(SNAP_DATE)
    --     into l_
    --     from BARS.ACCM_SNAP_SCN
    --    where TABLE_NAME = 'SALDOZ'
    --      and FDAT between dat1_ and dat2_;
    --
    -- end if;
    ----------------------------------------------------------
    */
  Begin

    l_fdat := trunc(p_mdat,'MM');

    bars_audit.trace( PKG_CODE ||' start := sync_month '||' fdat '||to_char(l_fdat,FMT_DATE) );

    -- Перевірка наявності активного процесу формування знімку
    l_errmsg := BARS_UTL_SNAPSHOT.CHECK_SNP_RUNNING('MONBALS');

    if (l_errmsg is Not Null)
    then
      raise_application_error( -20666, 'формування місячного знімку балансу вже запущено користувачем ' || l_errmsg );
    else

      if ( g_algorithm = ALGORITHM_MIK )
      then -- Якщо формується то немає і даних для звіту
        begin

          SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
          sid_:=SYS_CONTEXT('BARS_GLPARAM','MONBAL');
          SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

          select USERNAME || ' (' || MACHINE || '/' || OSUSER || ')' -- sid
            into l_errmsg
            from V$SESSION
           where sid = sid_
             and sid <> SYS_CONTEXT ('USERENV','SID');

          raise_application_error( -20000, 'Повторіть формуваня звіту через 10 хв.' || CHR(10) ||
                                           'формування місячного знімку балансу вже запущено користувачем ' || l_errmsg );

        exception
           when no_data_found THEN
             NULL;
        end;
      end if;

    end if;

--  if ( p_mode = 0 )
--  then

      begin
        Select 'Y'
          Into l_snap_balance
          From AGG_MONBALS
         Where fdat = l_fdat
           and rownum = 1;
      exception
        when NO_DATA_FOUND then
          l_snap_balance := 'N';
      end;

      bars_audit.trace( PKG_CODE ||' l_snap_balance='|| l_snap_balance );

      if ( l_snap_balance <> 'Y' )
      then
        l_create_snap := true;
      else
        -- перевіряєм чи були зміни за дату формування снимка
        l_create_snap := is_month_modified(l_fdat);
      end if;

--  else
--    l_create_snap := true;
--  end if;

    if l_create_snap
    then -- Формуємо знімок

      if ( g_algorithm = ALGORITHM_MIK )
      then

        if ( get_snp_running = 1 )
        then
          raise_application_error( -20000, 'Формування снімку балансу не можливо. Проводиться нарахування резервів.' );
        else
          bars_audit.trace( '%s run MDRAPS( fdat => %s);', PKG_CODE, to_char(l_fdat,FMT_DATE) );
          MDRAPS( l_fdat );
        end if;

      end if;

    End if;

  End sync_month;

  -- ==================================================================================================
  -- Процедура Синхронизация снимков объекта за період
  -- ==================================================================================================
  Procedure sync_snap_period
  ( p_fdat1    in     date
  , p_fdat2    in     date
  ) is
  begin
    bars_audit.trace( PKG_CODE ||'.sync_snap_period: start with ( p_fdat1=%s, p_fdat2=%s ).'
                    , to_char(p_fdat1,FMT_DATE), to_char(p_fdat2,FMT_DATE) );
    for x in
    ( select FDAT from FDAT
       where FDAT between p_fdat1
                      and p_fdat2
       order by FDAT )
    loop
      sync_snap( x.FDAT );
    end loop;
  end sync_snap_period;

  -- ======================================================
  -- Modifying Subpartition Template
  -- ======================================================
  procedure SET_SUBPARTITION_TEMPLATES
  ( p_force     in     signtype default 0
  ) is
    title    constant  varchar2(60) := PKG_CODE ||'.set_subpartition_templates';
    l_ddl_stmt         varchar(3000);
    l_spt_stmt         varchar(2000);
    l_qty              number(3);
  begin

    bars_audit.trace( '%s: start with ( p_force=%s ).', title, to_char(p_force) );

    l_spt_stmt :=  q'[SUBPARTITION SP_%kf VALUES ('%kf')]';

    select listagg( replace( l_spt_stmt, '%kf', KF ), CHR(10)||', ' ) WITHIN GROUP ( order by KF )
         , count(1)
      into l_spt_stmt, l_qty
      from BARS.MV_KF;

    l_ddl_stmt := 'ALTER TABLE BARS.%tab SET SUBPARTITION TEMPLATE' || chr(10) || '( ' || l_spt_stmt || chr(10) || ')';

    bars_audit.trace( '%s: ddl_stmt=%s.', title, l_ddl_stmt );

    for tab in
    ( select TABLE_NAME, SUBPARTITION_COUNT
        from ALL_TAB_PARTITIONS
       where ( TABLE_OWNER
             , TABLE_NAME
             , PARTITION_POSITION ) in ( select TABLE_OWNER
                                              , TABLE_NAME
                                              , max(PARTITION_POSITION)
                                           from ALL_TAB_PARTITIONS
                                          where TABLE_OWNER = 'BARS'
                                            and TABLE_NAME  in ( 'SNAP_BALANCES', 'AGG_MONBALS', 'AGG_YEARBALS' )
                                          group by TABLE_OWNER, TABLE_NAME )
    )
    loop

      if ( l_qty > tab.SUBPARTITION_COUNT OR p_force = 1 )
      then

        l_ddl_stmt := replace( l_ddl_stmt, '%tab', tab.TABLE_NAME );

        begin
          execute immediate l_ddl_stmt;
        exception
          when OTHERS then
            bars_audit.error( title || ': ' || dbms_utility.format_error_stack() ||
                                    chr(10) || dbms_utility.format_error_backtrace() );
            raise;
        end;

      else

        bars_audit.info( title ||': subpartition quantity equal to existing KF quantity.' );

      end if;

    end loop;

  end SET_SUBPARTITION_TEMPLATES;

  -- ======================================================
  -- Renaming PARTITION (and SUBPARTITION)
  -- Переіменування системно згенерованих секцій (та підсекцій) таблиці
  -- ======================================================
  procedure RENAME_PARTITION
  ( p_table_name   in     varchar2
  , p_rename_sub   in     signtype default 0
  ) is
    title       constant  varchar2(60) := PKG_CODE ||'.rename_partition';
    cur_p                 sys_refcursor; -- cursor for Partitions
    cur_s                 sys_refcursor; -- cursor for SubPartitions
    l_fdat                varchar2(8);   -- PARTITION    key value
    l_kf                  varchar2(6);   -- SUBPARTITION key value
    l_tab_nm              varchar2(30);
    l_query               varchar(1000);
    l_ddl_stmt            varchar(1000);
  begin

    l_tab_nm := upper(p_table_name);

    l_query := q'[select to_char(f.FDAT,'yyyymmdd') as FDAT
  from ( select unique FDAT
           from BARS.%tab
       ) f
  left
  join ( select PARTITION_NAME
           from ALL_TAB_PARTITIONS
          where TABLE_OWNER = 'BARS'
            and TABLE_NAME  = '%tab'
            and PARTITION_NAME <> 'P_MINVALUE'
       ) p
    on ( p.PARTITION_NAME = 'P_' || to_char(FDAT,'YYYYMMDD') )
 where p.PARTITION_NAME Is Null]';

    l_query := replace( l_query, '%tab', l_tab_nm );

    OPEN cur_p FOR l_query;

    LOOP

      FETCH cur_p INTO l_fdat;
      EXIT WHEN cur_p%NOTFOUND;

      l_ddl_stmt := 'ALTER TABLE BARS.' || l_tab_nm || ' RENAME ' || replace( q'[PARTITION FOR (to_date('%p','YYYYMMDD')) TO P_%p]', '%p', l_fdat );

      -- rename partition
      begin
        execute immediate l_ddl_stmt;
      exception
        when OTHERS then
          if ( sqlcode = -14081 )
          then null; -- new partition name must differ from the old partition name
          else bars_audit.error( title   || ': ddl_stmt ="' || l_ddl_stmt || '"' ||
                                 chr(10) || dbms_utility.format_error_stack()    ||
                                 chr(10) || dbms_utility.format_error_backtrace() );
          end if;
      end;

      if ( p_rename_sub = 1 )
      then -- rename subpartition

        l_query := replace( q'[select unique KF from BARS.%tab PARTITION FOR (to_date('%p','YYYYMMDD'))]', '%p', l_fdat );
        l_query := replace( l_query, '%tab', l_tab_nm );

        l_ddl_stmt := 'ALTER TABLE BARS.' || l_tab_nm || ' RENAME '  || replace( q'[SUBPARTITION FOR (to_date('%p','YYYYMMDD'),'%sp') TO P_%p_SP_%sp]', '%p',l_fdat );

        OPEN cur_s FOR l_query;

        LOOP

          FETCH cur_s INTO l_kf;
          EXIT WHEN cur_s%NOTFOUND;

          l_ddl_stmt := replace( l_ddl_stmt, '%sp', l_kf );

          begin
            execute immediate l_ddl_stmt;
          exception
            when OTHERS then
              if (sqlcode = -14262 )
              then null; -- new subpartition name must differ from the old subpartition name
              else raise;
              end if;
          end;

        END LOOP;

        CLOSE cur_s;

      end if;

    END LOOP;

    CLOSE cur_p;

  end RENAME_PARTITION;

  --
  --
  --
  procedure GATHER_STATS
  ( p_owner       in     varchar2 default 'BARS'
  , p_table       in     varchar2
  , p_key         in     varchar2 default null
  , p_subkey      in     varchar2 default null
  ) is
    l_owner              varchar2(30) := upper(p_owner);
    l_table              varchar2(30) := upper(p_table);
    l_pkey               varchar2(30);
    l_skey               varchar2(30);
    l_name               varchar2(30);
    l_level              number(1);
  begin

    if ( p_key Is Not Null )
    then -- збір статистики для PARTITION

      l_pkey := upper(p_key);
      l_name := 'P_'||l_pkey;

      if ( p_subkey Is Not Null )
      then -- збір статистики для SUBPARTITION

        l_skey := upper(p_subkey);
        l_name := l_name||'_SP_'||l_skey;

        -- ищем SUBPARTITION с именем l_name
        begin

          select 2
            into l_level
            from ALL_TAB_SUBPARTITIONS
           where TABLE_OWNER = l_owner
             and TABLE_NAME  = l_table
             and subpartition_name = l_name;

        exception
          when NO_DATA_FOUND
          then -- если нет субпартиции (предполагаем что она носит системное имя)
            -- переименуем ее
            execute immediate 'alter table '||l_owner||'.'||l_table||' rename SUBPARTITION for ('||l_pkey||','||l_skey||') to '||l_name;
        end;

      else -- збір статистики для PARTITION

        -- ищем PARTITION с именем l_name
        begin

          select 1
            into l_level
            from ALL_TAB_PARTITIONS
           where TABLE_OWNER    = l_owner
             and TABLE_NAME     = l_table
             and PARTITION_NAME = l_name;

        exception
          when NO_DATA_FOUND
          then -- если нет партиции (предполагаем что она носит системное имя)
            -- переименуем ее
            execute immediate 'alter table '||l_owner||'.'||l_table||' rename PARTITION for ('||l_pkey||') to '||l_name;
        end;
      end if;

    else -- збір статистики для TABLE
      l_level := 0;
    end if;

    -- после переименования (суб)партиция должна существовать
    DBMS_STATS.gather_table_stats
    ( ownname          => l_owner
    , tabname          => l_table
    , method_opt       => 'FOR ALL COLUMNS SIZE AUTO'
    , degree           => DBMS_STATS.AUTO_DEGREE
    , estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE
    , cascade          => TRUE );

  end gather_stats;



begin
   dbms_application_info.read_module(g_module, g_action); -- COBUMMFO-9690

  load_algorithm();
end BARS_UTL_SNAPSHOT;
/
show errors;

grant EXECUTE on BARS_UTL_SNAPSHOT to BARSUPL;
grant EXECUTE on BARS_UTL_SNAPSHOT to BARS_ACCESS_DEFROLE;
grant EXECUTE on BARS_UTL_SNAPSHOT to UPLD;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_utl_snapshot.sql =========*** E
PROMPT ===================================================================================== 
