
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/bars_utl_snapshot.sql =========*** R
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.BARS_UTL_SNAPSHOT 
is
  -- Author  : OLEG.MUZYKA
  -- Created : 07.07.2015 13:05:13
  -- Purpose : Службовий пакет роботи зі знімками балансу

  -- Public constant declarations
  VERSION_HEAD         constant varchar2(64) := 'version 1.1 12.02.2016';
  PKG_NAME             constant varchar2(64) := 'BARS_UTL_SNAPSHOT';

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
  TAB_SNAP_BALANCES    constant varchar2(30) := 'SNAP_BALANCES';

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
  function check_snp_running
  ( p_action  in   v$session.action%type default null
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
  -- set_snap_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
  -- =================================================================================================
  procedure set_snap_scn(p_date in date);


  -- ==================================================================================================
  -- set_table_scn - устанавливает scn последней генерации снимка баланса по партиции указанной таблицы
  -- ==================================================================================================
  procedure set_table_scn(p_table in varchar2, p_date in date, p_scn in number);


end bars_utl_snapshot;
/
CREATE OR REPLACE PACKAGE BODY BARS.BARS_UTL_SNAPSHOT 
is

  -- Private constant declarations
  VERSION_BODY      constant varchar2(64)  := 'version 1.1 12.02.2016';

  --Признак формування знімку
  G_SNP_RUNNING   number;
  g_algorithm     varchar2(30);

  -- Префикс для трассировки
  PKG_CODE           constant varchar2(100) := 'UTL_SNAPSHOT ';

  -- Формат даты
  FMT_DATE           constant varchar2(20)  := 'dd.mm.yyyy';

  -- Формат дата+время
  FMT_DATETIME       constant varchar2(30)  := 'dd.mm.yyyy hh24:mi:ss';

  ------------------------------------------------------------------
  -- HEADER_VERSION
  --
  function header_version return varchar2 is
  begin
    return 'Package header '||PKG_NAME||': '||VERSION_HEAD;
  end header_version;

  ------------------------------------------------------------------
  -- BODY_VERSION
  --
  function body_version return varchar2 is
  begin
    return 'Package body '||PKG_NAME||': '||VERSION_BODY;
  end body_version;

  ------------------------------------------------------------------
  -- Повертає признак чи запущено процес по формуванню знімку балансу
  --
  function get_snp_running return number
  is
  begin
    select nvl(max(p.val),0) into G_SNP_RUNNING
      from params$base p where p.par='SNP_RUN';
    return G_SNP_RUNNING;
  end  get_snp_running;

  --------------------------------------------------------------------------------
  -- Перевірка наявності активного процесу формування знімку
  --
  function check_snp_running
  ( p_action  in   v$session.action%type default null
  ) return varchar2
  is
    l_errmsg  varchar2(500);
    l_action  v$session.action%type;
  begin

    l_action := nvl(p_action,'MONBALS');

    begin
      select USERNAME || ' (' || MACHINE || '/' || OSUSER || ')'
        into l_errmsg
        from V$SESSION
       where TYPE   = 'USER'
         and STATUS = 'ACTIVE'
         and module = 'SNAPSHOT'
         and action = l_action;
    exception
      when NO_DATA_FOUND then
        l_errmsg := null;
    end;

    return l_errmsg;

  end check_snp_running;

  --------------------------------------------------------------------------------
  --
  -- Встановлення відмітки про активність процесу формування знімку
  --
  procedure set_running_flag
  ( p_action  in   v$session.action%type default null
  ) is
    l_action  v$session.action%type;
  begin

    l_action := nvl(p_action,'MONBALS');

    dbms_application_info.set_module( 'SNAPSHOT', l_action );

  end set_running_flag;

  --------------------------------------------------------------------------------
  --
  -- Видадення відмітки про активність процесу формування знімку
  --
  procedure purge_running_flag
  is
  begin
    dbms_application_info.set_module(Null,Null);
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
  function get_snap_scn(p_table in varchar2, p_date in date)
  return number
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
  end get_snap_scn;


  -- ==================================================================================================
  -- get_mod_scn - возвращает scn последней модификации партиции указанной таблицы
  -- ==================================================================================================
  function get_mod_scn
  ( p_table in varchar2
  , p_date in date
  ) return number
  is
    p          constant varchar2(100) := PKG_CODE || '.getmodscn';
    l_mod_scn  number;
    l_part     number;
  begin

    bars_audit.trace('%s: entry point p_table=>%s, p_date=>%s', p, p_table, to_char(p_date,FMT_DATE) );

    Begin
      select 1
        into l_part
        from ALL_PART_TABLES
       where table_name = upper(p_table);
    exception
       when NO_DATA_FOUND then
         l_part := 0;
    End;

    CASE
      WHEN l_part = 1
      then -- партиционировани таблиці
        execute immediate 'Select nvl(max(ora_rowscn),0) from ' || p_table
                ||' partition for (to_date('''||to_char(p_date,'DD.MM.YYYY')||''',''DD.MM.YYYY''))'
        into l_mod_scn;
      ELSE -- не партиционировани таблиці по FDAT
        execute immediate 'Select nvl(max(ora_rowscn),0) from ' || p_table
                ||' Where fdat = to_date('''||to_char(p_date,'DD.MM.YYYY')||''',''DD.MM.YYYY'')'
        into l_mod_scn;
    END CASE;

    bars_audit.trace('%s: succ end, mod_scn=%s', p, to_char(l_mod_scn));

    return l_mod_scn;

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
    end set_table_scn;

    --==================================================================================================
    -- is_partition_modified - возвращает флаг 0/1 модификации партиции таблицы с момента p_scn
    --==================================================================================================
    function is_partition_modified
    ( p_table in varchar2
    , p_date  in date
    ) return number
    is
      l_tabl_scn    number;
      l_tabl_scn_h  number;
    begin

      l_tabl_scn   := get_mod_scn(p_table, p_date);
      l_tabl_scn_h := get_snap_scn(p_table, p_date);

      if ( l_tabl_scn_h < l_tabl_scn )
      then return 1;
      else return 0;
      end if;

    end is_partition_modified;


  --==================================================================================================
  -- is_bday_modified  перевіряєм чи були зміни за дату формування снимка
  --==================================================================================================
  function is_bday_modified( p_fdat date
  ) return boolean
  is
    l_create_snap       boolean := false;

    l_saldoa_snap_scn number;
    l_delrow_snap_scn number;
    l_saldob_snap_scn number;

  Begin

    logger.trace(PKG_CODE||' Start scn '|| 'fdat '||to_char(p_fdat, FMT_DATE));
             -- снимок уже создавался раньше, необходимо его перенакопить
             -- для этого:
             -- получим scn последних снимков балансов по партиции saldoa, saldob
             l_saldoa_snap_scn := is_partition_modified(TAB_SALDOA,           p_fdat);
             l_delrow_snap_scn := is_partition_modified(TAB_SALDOA_DEL_ROWS,  p_fdat);

              logger.trace(PKG_CODE||' l_saldoa_snap_scn = '||l_saldoa_snap_scn||' fdat '||to_char(p_fdat, FMT_DATE));
              logger.trace(PKG_CODE||' l_delrow_snap_scn = '||l_delrow_snap_scn||' fdat '||to_char(p_fdat, FMT_DATE));

    if g_algorithm <> ALGORITHM_MIK
    then
      l_saldob_snap_scn := is_partition_modified( TAB_SALDOB, p_fdat );
    end if;

             -- и проверим модифицировались ли партиции за указанную дату с этого момента
             if ( l_saldoa_snap_scn = 1
                  or  (g_algorithm <> ALGORITHM_MIK and  l_saldob_snap_scn = 1)
                  or  l_delrow_snap_scn = 1
                )
             then
                  logger.trace(PKG_CODE||' l_create_snap := true; '||' fdat '||to_char(p_fdat, FMT_DATE));
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
      l_tabl_scn := get_mod_scn( TAB_SNAP_BALANCES, l_last_bdt);
      l_snap_scn := get_snap_scn(TAB_SALDOZ, p_fdat);

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
    set_table_scn(TAB_SALDOB,          p_date, l_now_scn);
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

  --==================================================================================================
  -- get_algorithm - возвращает алгоритм наполнения accm_snap_balances
  --==================================================================================================
  function get_algorithm return varchar2
  is
  begin
    return g_algorithm;
  end get_algorithm;

    ----

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

    sess_   varchar2(64) :=bars_login.get_session_clientid;
    sid_    varchar2(64);

    l_previous_day        date;
    l_previous_day_modif  number;
    l_snap_balance_previous varchar2(1);

  Begin
    logger.trace(PKG_CODE||' start := sync_snap '||' fdat '||to_char(p_fdat, FMT_DATE));
    -- Якщо формується снімок то немає і даних для звіту.
     if g_algorithm = ALGORITHM_MIK
       then

           begin
              SYS.DBMS_SESSION.CLEAR_IDENTIFIER;
              sid_:=SYS_CONTEXT('BARS_GLPARAM','SNPBAL');
              SYS.DBMS_SESSION.SET_IDENTIFIER(sess_);

              select sid into sid_ from v$session
               where sid=sid_ and sid<>SYS_CONTEXT ('USERENV', 'SID');
              raise_application_error(-20000,'Повторіть формуваня звіту через 10хв.'||CHR(10)||'Формується знімок балансу  SID='|| sid_);

           exception
              when no_data_found THEN NULL;
           end;
       end if;

      -- Визначимо дату снимка чи банківський день.
       begin
         Select 'Y'
           Into l_bankday
           From fdat
          Where fdat = p_fdat;
       exception when no_data_found then
          l_bankday := 'N';
       end;

       logger.trace(PKG_CODE||' l_bankday='||l_bankday);

       begin
         Select 'Y'
           Into l_snap_balance
           From snap_balances
          Where fdat = p_fdat
            and rownum=1;
       exception when no_data_found then
          l_snap_balance := 'N';
       end;

       logger.trace(PKG_CODE||' l_snap_balance='||l_snap_balance);


       -- для драпсів неможна формувати снимки раніше вказаної дати
       begin
          SELECT TO_DATE(val,'DDMMYYYY') INTO dats_ FROM params WHERE par='DATRAPS';
          IF dats_>p_fdat THEN
            l_bankday := 'N';
          END IF;
       exception when no_data_found then NULL;
       end;

              -- Якщо не банківський день то снимки не формуємо
      If l_bankday = 'N' then   l_create_snap := false;
         else


              if l_snap_balance <> 'Y'
                    then
                        l_create_snap := true;
                    else
                          -- перевіряєм чи були зміни за дату формування снимка
                        l_create_snap := is_bday_modified(P_FDAT);

              end if;


       End if;



                -- Формуємо снимок
               if l_create_snap then

                  if g_algorithm = ALGORITHM_MIK
                        then


                         l_previous_day_modif := 0;
                         l_previous_day := DAT_NEXT_U(p_fdat, -1);    -- попередня банківська даня


                                  begin
                                     Select 'Y'
                                       Into l_snap_balance_previous
                                       From snap_balances
                                      Where fdat = l_previous_day
                                        and rownum=1;
                                   exception when no_data_found then
                                      l_snap_balance_previous := 'N';
                                   end;

                         if   is_bday_modified(l_previous_day)  and l_snap_balance_previous='N'
                              then  l_previous_day_modif := 0;   -- повне формування
                              else  l_previous_day_modif := 1;   -- спрощене формування
                         end if;
                           logger.trace(PKG_CODE||' Попередній банківськй день '||' dat '||to_char(l_previous_day, FMT_DATE)||' l_previous_day_modif='||l_previous_day_modif);


                           logger.trace(PKG_CODE||' start := ddraps; '||' fdat '||to_char(p_fdat, FMT_DATE));
                           ddraps(p_fdat,l_previous_day_modif);


                  end if;

               End if;

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
    sess_              varchar2(64) :=bars_login.get_session_clientid;
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

    bars_audit.trace( PKG_CODE ||' start := sync_snap '||' fdat '||to_char(l_fdat,FMT_DATE) );

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
  Procedure sync_snap_period (p_fdat1 date, p_fdat2 date)
  is
  begin
    for x in ( select fdat from fdat where fdat between p_fdat1 and  p_fdat2 order by fdat )
    loop
      sync_snap(x.fdat);
    end loop;
  end sync_snap_period;


begin
  load_algorithm();
end bars_utl_snapshot;
/
 show err;
 
PROMPT *** Create  grants  BARS_UTL_SNAPSHOT ***
grant EXECUTE                                                                on BARS_UTL_SNAPSHOT to BARSUPL;
grant EXECUTE                                                                on BARS_UTL_SNAPSHOT to UPLD;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/bars_utl_snapshot.sql =========*** E
 PROMPT ===================================================================================== 
 