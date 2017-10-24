create or replace package bars_accm_snap
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             ����� ���������� ������ ������ ���������        --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------


    -----------------------------------------------------------------
    --                                                             --
    -- ���� ������                                                 --
    --                                                             --
    -----------------------------------------------------------------
    --
    -- ������ ������� ��� ������������ ������� �������, ��������������� ����� YYYYMMDD
    -- 
    type t_joblist      is table of varchar2(30) index by varchar2(8);

    -----------------------------------------------------------------
    --                                                             --
    -- ���������                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- ������������� ������
    --

    VERSION_HEADER       constant varchar2(64)  := 'version 1.11 21.06.2017';
    VERSION_HEADER_DEFS  constant varchar2(512) := '';

    -- ��������� ���������� accm_snap_balances
    ALGORITHM_OLD        constant varchar2(30)  := 'OLD';
    ALGORITHM_SALNQC     constant varchar2(30)  := 'SALNQC';
    ALGORITHM_MIK        constant varchar2(30)  := 'ALGORITMIK';
    
    -- ������� �������� � �������� �� ���������� �����
    TAB_SALDOA           constant varchar2(30)  := 'SALDOA';
    -- ������� �������� � ����������� �� ���������� �����
    TAB_SALDOB           constant varchar2(30)  := 'SALDOB';
    -- ������� �������(������), ��������� �� SALDOA
    TAB_SALDOA_DEL_ROWS  constant varchar2(30)  := 'SALDOA_DEL_ROWS';

    -- ����� ��������� ������� �������
    FLAG_CREATED        constant varchar2(30)   := 'CREATED';
    FLAG_RECREATED      constant varchar2(30)   := 'RECREATED';
    FLAG_REUSED         constant varchar2(30)   := 'REUSED';

    ----
    -- lock_day_snap - ���������� �������� ������ �������
    --
    procedure lock_day_snap(
                  p_snapdtid in  number );
    
    ----
    -- unlock_day_snap - ��������������� �������� ������ �������
    --
    procedure unlock_day_snap(
                  p_snapdtid in  number );                       

    ----
    -- lock_month_snap - ��������� �������� ������ ������� 
    --
    procedure lock_month_snap(
                  p_snapdtid in  number );                           
    
    ----
    -- unlock_month_snap - ������������ �������� ������ �������
    --
    procedure unlock_month_snap(
                  p_snapdtid in  number );                       

    ----
    -- lock_year_snap - ��������� ������� ������ ������� 
    --
    procedure lock_year_snap(
                  p_snapdtid in  number );                       
    
    ----
    -- unlock_year_snap - ������������ ������� ������ �������
    --
    procedure unlock_year_snap(
                  p_snapdtid in  number );                       

    ----
    -- set_day_snap_state - ��������� ��������� ������ �������
    --
    procedure set_day_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    );
    
    ----
    -- set_month_snap_state - ��������� ��������� ������ �������
    --
    procedure set_month_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    );
    
    ----
    -- set_year_snap_state - ��������� ��������� ������ �������
    --
    procedure set_year_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    );

    ----
    -- ask_day_snap_state - ����������� ��������� �������� ������ ������� � scn ��� ��������
    --
    procedure ask_day_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    );
    
    ----
    -- ask_month_snap_state - ����������� ��������� ��������� ������ ������� � scn ��� ��������
    --
    procedure ask_month_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    );
    
    ----
    -- ask_year_snap_state - ����������� ��������� �������� ������ ������� � scn ��� ��������
    --
    procedure ask_year_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    );

    ----
    -- set_day_call - ��������� scn, ���� � ������� ��������� � �������� ������ �������
    --
    procedure set_day_call(        
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    );
    
    ----
    -- set_month_call - ��������� scn, ���� � ������� ��������� � ��������� ������ �������
    --
    procedure set_month_call(        
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    );
    
    ----
    -- set_year_call - ��������� scn, ���� � ������� ��������� � �������� ������ �������
    --
    procedure set_year_call(        
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    );

    ----
    -- drop_obsolete_partitions - �������� ���������� �������� � accm_snap_balances
    --
    procedure drop_obsolete_partitions;

    ----
    -- get_algorithm - ���������� �������� ���������� accm_snap_balances 
    --
    function get_algorithm return varchar2;
    
    ----
    -- set_algorithm - ������������� �������� ���������� accm_snap_balances 
    --
    procedure set_algorithm(p_algorithm in varchar2);    
    
    ----
    -- is_partition_modified - ���������� ���� 0/1 ����������� �������� ������� � ������� p_scn
    --                         ������������� ������������ ����� ������� �������������� �����  
    --
    function is_partition_modified(p_table in varchar2, p_date in date, p_scn in number)
    return number;
    
    ----
    -- get_snap_scn - ���������� scn ��������� ��������� ������ ������� �� �������� ��������� �������
    --
    function get_snap_scn(p_table in varchar2, p_date in date)
    return number;
    
    ----
    -- set_snap_scn - ������������� scn ��������� ��������� ������ ������� �� �������� ��������� �������
    --
    procedure set_snap_scn(p_table in varchar2, p_date in date, p_scn in number);    

    -----------------------------------------------------------------
    -- SNAP_BALANCE()
    --
    --     ��������/���������� ������� �������
    --
    --     ���������:
    --
    --         p_mode      ����� ��������/����������
    --
    --         p_bankdate  ���������� ���� ������ 
    --                     (��� ������� ������)
    --
    procedure snap_balance(
                  p_snapdate    in  date,
                  p_snapmode    in  number,
                  p_requestscn  in number default null);


    -----------------------------------------------------------------
    -- SNAP_BALANCE_IN_JOB()
    --
    --     ��������/���������� ������� ������� � ��������� �������
    --
    --     ���������:
    --
    --         p_mode      ����� ��������/����������
    --
    --         p_bankdate  ���������� ���� ������
    --                     (��� ������� ������)
    --
    --         p_requestscn ������ ����� �� ���� ������� SCN 
    --
    --         p_jobname    ��� �������
    --
    procedure snap_balance_in_job(
                  p_snapdate    in  date,
                  p_snapmode    in  number,
                  p_requestscn  in  number default null,
                  p_jobname     out varchar2);
                  
    -----------------------------------------------------------------
    -- SNAP_BALANCE_PERIOD()
    --
    --     ��������/���������� ������� ������� �� ������
    --
    --     ���������:
    --
    --         p_startdate  ���� ������ �������
    --
    --         p_finishdate ���� ��������� �������
    -- 
    --         p_snapmode   ����� ��������/���������� 
    --                      0-������, 1-���������
    --
    procedure snap_balance_period(
                  p_startdate   in  date,
                  p_finishdate  in  date,
                  p_snapmode    in  number );



    -----------------------------------------------------------------
    --                                                             --
    --  ������ ������������� ������                                --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ��������� ������ ��������� ������
    --
    --
    --
    function header_version return varchar2;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ��������� ������ ���� ������
    --
    --
    --
    function body_version return varchar2;


    ----
    -- get_max_bankdate - ���������� ����. ����. ���� �� ���� ��������
    --
    function get_max_bankdate return date
    result_cache;
    
    ----
    -- get_prev_bankdate - ���������� ���������� ���������� ���� �� ��������� � ����������
    --
    function get_prev_bankdate(p_bankdate date) return date
    result_cache;

end BARS_ACCM_SNAP;
/

show error

----------------------------------------------------------------------------------------------------

create or replace package body BARS_ACCM_SNAP
is

    -----------------------------------------------------------------
    --                                                             --
    --                                                             --
    --             ����� ���������� ������ ���������               --
    --                                                             --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    --                                                             --
    -- ���������                                                   --
    --                                                             --
    -----------------------------------------------------------------

    --
    -- ������������� ������
    --

    VERSION_BODY       constant varchar2(64)  := 'version 1.26 21.06.2017';
    VERSION_BODY_DEFS  constant varchar2(512) := '';

    -- ��� ������
    MODCODE            constant varchar2(3)   := 'ACM';

    -- ������� ��� �����������
    PKG_CODE           constant varchar2(100) := 'accmsnp';

    -- ��� ������ (������� � ����������)
    OUR_BASEVAL        constant number        := 980;

    -- ������ ����
    FMT_DATE           constant varchar2(20)  := 'dd.mm.yyyy';
    
    -- ������ ����+�����
    FMT_DATETIME       constant varchar2(30)  := 'dd.mm.yyyy hh24:mi:ss';

    -- ����� �������� ��������� �������
    SLEEP_TIMEOUT      constant number        := 10;
    
    -- ����� �������� ���������� ������ ������� �� ������������ ������� ������� � ������� 
    WAIT_JOBS_TIMEOUT   constant number        := 10;
    
    -- ����� �������� ���������� �� ������ ������� � ��������
    WAIT_SNAP_LOCK_TIMEOUT constant number := 300;
    
    WAIT_TIMEOUT_EXPIRED   exception;
    pragma exception_init(WAIT_TIMEOUT_EXPIRED, -30006);
    
    PART_NOT_EXISTS exception;
    pragma exception_init(PART_NOT_EXISTS, -2149);
    
    RESOURCE_BUSY   exception;   
    pragma exception_init(RESOURCE_BUSY,   -54  ); 
    
    MQ_EMPTY_OR_TIMEOUT_EXCEPTION EXCEPTION;
    PRAGMA EXCEPTION_INIT(MQ_EMPTY_OR_TIMEOUT_EXCEPTION, -25228);
       
    
    -- �������� ���������� accm_snap_balances
    g_algorithm     varchar2(30);
    
    -- sid � serial# ����������� ������
    g_own_sid       number := sys_context('userenv','sid');
    g_own_serial#   number;
    
    -- ����� ����� ��������������� ������ � ����
    g_snap_life_time    number;
    
    -- ������� ��� ������� �� ����������� �������� ������ SALDOA, SALDOB, SALDOA_DEL_ROWS 
    -- (PMQC = Partition Modification Query Condition) 
    g_snap_pmqc          varchar2(4000);
    
    
    ----
    -- load_snap_life_time - ������ ����� ����� ��������������� ������ � ���� �� ������� ����������
    --
    procedure load_snap_life_time
    is
    begin
        if g_snap_life_time is null
        then
            begin
                select to_number(val)
                  into g_snap_life_time
                  from params
                 where par = 'SNAP_LT';
            exception when no_data_found then
                g_snap_life_time := 30; -- default
            end;
        end if;
        --
    end load_snap_life_time;

    ----
    -- load_snap_pmqc - ������ �������� SNAP_PMQC
    --
    procedure load_snap_pmqc
    is
    begin
        if g_snap_pmqc is null
        then
            begin
                select val
                  into g_snap_pmqc
                  from params
                 where par = 'SNAP_PMQC';
            exception when no_data_found then
                g_snap_pmqc := '1=1'; -- default
            end;
        end if;
        --
    end load_snap_pmqc;
    
    ----
    -- drop_obsolete_partitions - �������� ���������� �������� � accm_snap_balances
    --
    procedure drop_obsolete_partitions
    is
        p               constant varchar2(100) := PKG_CODE || '.dropobspart';
        l_snap_balance  accm_state_snap.snap_balance%type;
        l_isclear       boolean;
    begin
        --
        logger.trace('%s: entry point', p);
        --
        load_snap_life_time();
        --
        for c in (  select s.caldt_id, s.snap_balance, c.caldt_date 
                      from accm_state_snap s, accm_calendar c
                     where s.caldt_id = c.caldt_id
                       and sysdate - nvl(s.call_date,to_date('01.01.1900','dd.mm.yyyy')) > g_snap_life_time
                     order by caldt_date
                 )
        loop
            -- ����� ������ �������
            lock_day_snap(c.caldt_id);
            --
            begin                                
                --
                logger.trace('%s: partition #'||to_char(c.caldt_id)||'('||to_char(c.caldt_date, FMT_DATE)||') locked', p);
                --
                l_isclear := false;
                loop
                   begin
                      IF g_algorithm = ALGORITHM_MIK THEN
                        execute immediate 'alter table snap_balances drop partition for (to_date('''||TO_CHAR(c.caldt_date,'ddmmyyyy')||''',''DDMMYYYY''))';

                      ELSE
                        execute immediate 'alter table accm_snap_balances drop partition for (' || to_char(c.caldt_id) || ')';
                      END IF;
                      l_isclear := true;
                    exception
                        when PART_NOT_EXISTS then l_isclear := true;
                        when RESOURCE_BUSY   then dbms_lock.sleep(SLEEP_TIMEOUT);
                    end;
                    exit when (l_isclear);
                end loop;
                logger.trace('%s: snap partition dropped', p);
                --
                -- ������� ������ �� accm_state_snap
                delete 
                  from accm_state_snap
                 where caldt_id = c.caldt_id;
                --
                commit;
                --
                logger.info(p||' ������� �������� #'
                        ||to_char(c.caldt_id)||' �� ���� '||to_char(c.caldt_date, FMT_DATE)
                        ||' � ������� accm_snap_balances');
                --
            exception
                when others then
                    rollback;                    
                    --
                    logger.error(p||' ������ ��� ������ �� ������� ������� #'
                        ||to_char(c.caldt_id)||' �� ���� '||to_char(c.caldt_date, FMT_DATE)||' : '
                        ||dbms_utility.format_error_stack()||chr(10)||dbms_utility.format_error_backtrace()
                    );
                    --
                    unlock_day_snap(c.caldt_id);
            end;
        end loop;
        --
        logger.trace('%s: succ end', p);
        --
    end drop_obsolete_partitions;

    ----
    -- get_algorithm - ���������� �������� ���������� accm_snap_balances 
    --
    function get_algorithm return varchar2
    is
    begin
        return g_algorithm; 
    end get_algorithm;  
    
    ----
    -- set_algorithm - ������������� �������� ���������� accm_snap_balances 
    --
    procedure set_algorithm(p_algorithm in varchar2)
    is
    begin
         g_algorithm := p_algorithm;
    end set_algorithm;

    ----
    -- load_algorithm - ������ �������� ���������� accm_snap_balances 
    --
    procedure load_algorithm
    is
    begin
         begin
              select val
                into g_algorithm
                from params
               where par='SNAP_ALG';
         exception when no_data_found then
              raise_application_error(-20000, '�� ����� �������� SNAP_ALG');
         end;
       if g_algorithm not in (ALGORITHM_OLD, ALGORITHM_SALNQC, ALGORITHM_MIK)
       then
          raise_application_error(-20000, '������������ �������� ��������� SNAP_ALG='||g_algorithm||', ��������� '
          ||ALGORITHM_OLD||' ��� '||ALGORITHM_SALNQC||' ��� '||ALGORITHM_MIK);
       end if;
    end load_algorithm;
    
    ----
    -- ilock_snap - ���������� ������ �������
    --
    --      p_statetab      - ������� ��������� ������� ACCM_STATE_SNAP, ACCM_STATE_MONTH, ACCM_STATE_YEAR
    --      p_snapdtid      - id ������ �������  
    --      p_locked        - ������� ���������� Y/null
    --
    procedure ilock_snap(
                  p_statetab    in  varchar2, 
                  p_snapdtid    in  number,
                  p_locked      in  varchar2
    )
    is
    pragma autonomous_transaction;
    p               constant varchar2(100) := PKG_CODE || '.ilocksnap';
    -- ���-�� ������ � ������ 
    c_day_secs      constant number := 86400; --24*60*60;
    --
    l_locked        varchar2(1);           
    l_sid           number;           
    l_serial#       number;           
    l_time1         date;
    l_time2         date;
    l_num           number;    
    --
    begin
        if logger.trace_enabled()
        then
            logger.trace('%s: entry point p_snapdtid=>%s, p_locked=>%s', p, to_char(p_snapdtid), nvl(p_locked,'null'));
        end if;
        -- ��� ������������� �������������� sid � serial# ��� ����� ������
        if g_own_sid is null or g_own_serial# is null
        then
            g_own_sid := sys_context('userenv','sid');
            select serial#
              into g_own_serial#
              from v$session
             where sid = g_own_sid;
        end if;
        if logger.trace_enabled()
        then
            logger.trace('%s: own_sid=%s, own_serial#=%s', p, to_char(g_own_sid), to_char(g_own_serial#));
        end if;
        --
        l_time1 := sysdate;
        --
        loop
            begin
                savepoint spl;
                --
                execute immediate
                'select locked, sid, serial#
                   from '||p_statetab||'
                  where caldt_id = :p_snapdtid
                    for update wait 60'                  
                   into l_locked, l_sid, l_serial#
                  using p_snapdtid;
                --
                if logger.trace_enabled()
                then
                    logger.trace('%s: locked=%s, sid=%s, serial#=%s', p, 
                    nvl(l_locked,'null'), nvl(to_char(l_sid),'null'), nvl(to_char(l_serial#),'null'));
                end if;
                --
                if l_locked='Y'
                then
                    begin
                        select 1
                          into l_num
                          from v$session
                         where sid = l_sid
                           and serial# = l_serial#; 
                    exception 
                        when no_data_found then
                            -- ���� ������, ��������������� ������ ������� ��� �� ����������,
                            -- ������� ����������
                            execute immediate
                            'update '||p_statetab||'
                               set locked  = null,
                                   sid     = null,
                                   serial# = null
                             where caldt_id = :p_snapdtid
                             returning locked, sid, serial# into :l_locked, :l_sid, :l_serial#'           
                             using p_snapdtid, out l_locked, out l_sid, out l_serial#;
                            --
                            if logger.trace_enabled()
                            then
                               logger.trace('%s: orphan lock released, snap# %s', p, to_char(p_snapdtid));
                            end if;
                    end;
                end if;
                --
                if l_locked='Y' and p_locked='Y'                 
                then
                    rollback to spl;
                    -- ���� ��� ������� ����� ������� ������, ������� ��� �����
                    if l_sid = g_own_sid and l_serial# = g_own_serial#
                    then                        
                        if logger.trace_enabled()
                        then
                            logger.trace('%s: secondary lock on snap# %s', p, to_char(p_snapdtid));
                        end if;
                        commit;
                        exit;
                    end if;
                    -- ����� ��� ���� 1 �������
                    dbms_lock.sleep(1);
                    --
                elsif l_locked is null and p_locked is null
                then
                    rollback to spl;
                    raise_application_error(-20000, 
                    '������ ������� #'||to_char(p_snapdtid)||' �� '
                    ||to_char(bars_accm_calendar.get_calendar_date(p_snapdtid), 'dd.mm.yyyy')
                    ||' ��� �������������.');
                    --
                elsif l_locked='Y' and p_locked is null
                then
                    -- ���� ��� ������� ����� ������� ������, ����������� ���
                    if l_sid = g_own_sid and l_serial# = g_own_serial#
                    then
                        execute immediate                                                
                        'update '||p_statetab||'
                            set locked  = :p_locked,
                                sid     = null,
                                serial# = null
                         where caldt_id = :p_snapdtid'
                        using p_locked, p_snapdtid;
                        --
                        commit;
                        --
                        if logger.trace_enabled()
                        then
                            logger.trace('%s: remove own lock on snap# %s', p, to_char(p_snapdtid));
                        end if;
                        --
                        exit;
                    else
                        rollback to spl;
                        raise_application_error(-20000, 
                        '������ ������� #'||to_char(p_snapdtid)||' �� '
                        ||to_char(bars_accm_calendar.get_calendar_date(p_snapdtid), 'dd.mm.yyyy')
                        ||' ���������� �������������� � ������ ������, �.�. �� ��� ������������ � ������ ������.');
                    end if; 
                elsif l_locked is null and p_locked='Y'
                then
                    -- ������ ����������
                    execute immediate
                    'update '||p_statetab||'
                        set locked  = :p_locked, 
                            sid     = :g_own_sid, 
                            serial# = :g_own_serial#
                      where caldt_id = :p_snapdtid'
                    using p_locked, g_own_sid, g_own_serial#, p_snapdtid;
                    --
                    commit;
                    --
                    exit;
                end if;                   
            exception 
                when NO_DATA_FOUND then
                    raise_application_error(-20000, '������ ������� #'||to_char(p_snapdtid)||' �� '
                    ||to_char(bars_accm_calendar.get_calendar_date(p_snapdtid), 'dd.mm.yyyy')
                    ||' �� ������(�� �������� � '||p_statetab||').');
                when RESOURCE_BUSY then
                    -- �� ��������� ����������
                    null;                     
            end;        
            l_time2 := sysdate;
            if l_time2 - l_time1 >= WAIT_SNAP_LOCK_TIMEOUT/c_day_secs
            then
                raise_application_error(-20000, '�������� �������� ��������('||to_char(WAIT_SNAP_LOCK_TIMEOUT)
                ||' ���) '||case when p_locked is null then '�������������' else '����������' end
                ||' ������ ������� #'||to_char(p_snapdtid)
                ||' �� '||to_char(bars_accm_calendar.get_calendar_date(p_snapdtid), 'dd.mm.yyyy')
                );
            end if;
        end loop;
        --
        if logger.trace_enabled()
        then
            logger.trace('%s: succ end, balance snap %s.', p, case when p_locked='Y' then 'locked' else 'unlocked' end);
        end if;
        --
    end ilock_snap;
    
    ----
    -- lock_day_snap - ���������� �������� ������ �������
    --
    procedure lock_day_snap(
                  p_snapdtid in  number )                       
    is
    --
    begin
        --
        ilock_snap('ACCM_STATE_SNAP', p_snapdtid, 'Y');
        --
    end lock_day_snap;
    
    ----
    -- unlock_day_snap - ��������������� �������� ������ �������
    --
    procedure unlock_day_snap(
                  p_snapdtid in  number )                       
    is
    --
    begin
        --
        ilock_snap('ACCM_STATE_SNAP', p_snapdtid, null);
        --
    end unlock_day_snap;
    
    ----
    -- lock_month_snap - ��������� �������� ������ ������� 
    --
    procedure lock_month_snap(
                  p_snapdtid in  number )                       
    is
    --
    begin
        --
        ilock_snap('ACCM_STATE_MONTH', p_snapdtid, 'Y');
        --
    end lock_month_snap;
    
    ----
    -- unlock_month_snap - ������������ �������� ������ �������
    --
    procedure unlock_month_snap(
                  p_snapdtid in  number )                       
    is
    --
    begin
        --
        ilock_snap('ACCM_STATE_MONTH', p_snapdtid, null);
        --
    end unlock_month_snap;

    ----
    -- lock_year_snap - ��������� ������� ������ ������� 
    --
    procedure lock_year_snap(
                  p_snapdtid in  number )                       
    is
    --
    begin
        --
        ilock_snap('ACCM_STATE_YEAR', p_snapdtid, 'Y');
        --
    end lock_year_snap;
    
    ----
    -- unlock_year_snap - ������������ ������� ������ �������
    --
    procedure unlock_year_snap(
                  p_snapdtid in  number )                       
    is
    --
    begin
        --
        ilock_snap('ACCM_STATE_YEAR', p_snapdtid, null);
        --
    end unlock_year_snap;
    
    ----
    -- iset_snap_state - ��������� ��������� ������ �������
    --
    procedure iset_snap_state(
        p_statetab      in varchar2,
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    )
    is
    begin
        execute immediate
       'update '||p_statetab||'
           set snap_balance = :p_snapbalance,
               snap_scn     = :p_snapscn,
               snap_date    = :p_snapdate 
         where caldt_id = :p_caldtid'
        using p_snapbalance, p_snapscn, p_snapdate, p_caldtid;
        --
    end iset_snap_state;
    
    ----
    -- set_day_snap_state - ��������� ��������� �������� ������ �������
    --
    procedure set_day_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    )
    is
    begin
        --
        iset_snap_state('ACCM_STATE_SNAP', p_caldtid, p_snapbalance, p_snapscn, p_snapdate);
        --
    end set_day_snap_state; 
    
    ----
    -- set_month_snap_state - ��������� ��������� ��������� ������ �������
    --
    procedure set_month_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    )
    is
    begin
        --
        iset_snap_state('ACCM_STATE_MONTH', p_caldtid, p_snapbalance, p_snapscn, p_snapdate);
        --
    end set_month_snap_state;
    
    ----
    -- set_year_snap_state - ��������� ��������� �������� ������ �������
    --
    procedure set_year_snap_state(
        p_caldtid       in number,
        p_snapbalance   in varchar2,
        p_snapscn       in number,
        p_snapdate      in date
    )
    is
    begin
        --
        iset_snap_state('ACCM_STATE_YEAR', p_caldtid, p_snapbalance, p_snapscn, p_snapdate);
        --
    end set_year_snap_state;
    
    ----
    -- iask_snap_state - ����������� ��������� ������ ������� � scn ��� ��������
    --
    procedure iask_snap_state(
        p_statetab       in varchar2,
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date
    )
    is
    begin
        execute immediate
       'select snap_balance, snap_scn, snap_date          
          from '||p_statetab||'
         where caldt_id = :p_caldtid'
          into p_snapbalance, p_snapscn, p_snapdate
         using p_caldtid; 
        --
    end iask_snap_state;

    ----
    -- ask_day_snap_state - ����������� ��������� �������� ������ ������� � scn ��� ��������
    --
    procedure ask_day_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    )
    is
    begin
        --
        iask_snap_state('ACCM_STATE_SNAP', p_caldtid, p_snapbalance, p_snapscn, p_snapdate);
        --
    end ask_day_snap_state;
    
    ----
    -- ask_month_snap_state - ����������� ��������� ��������� ������ ������� � scn ��� ��������
    --
    procedure ask_month_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    )
    is
    begin
        --
        iask_snap_state('ACCM_STATE_MONTH', p_caldtid, p_snapbalance, p_snapscn, p_snapdate);
        --
    end ask_month_snap_state;
    
    ----
    -- ask_year_snap_state - ����������� ��������� �������� ������ ������� � scn ��� ��������
    --
    procedure ask_year_snap_state(
        p_caldtid        in number,
        p_snapbalance   out varchar2,
        p_snapscn       out number,
        p_snapdate      out date    )
    is
    begin
        --
        iask_snap_state('ACCM_STATE_YEAR', p_caldtid, p_snapbalance, p_snapscn, p_snapdate);
        --
    end ask_year_snap_state;

    ----
    -- iset_call - ��������� scn, ���� � ������� ��������� � ������ �������
    --
    procedure iset_call(
        p_statetab       in varchar2,
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    )
    is
    pragma autonomous_transaction;
        l_caldtid   number;
        l_errmsg    varchar2(4000);
    begin
        begin
            execute immediate
            'select caldt_id              
               from '||p_statetab||'
              where caldt_id = :p_caldtid
                for update wait 10'
               into l_caldtid
              using p_caldtid;
        exception
            when WAIT_TIMEOUT_EXPIRED then
                l_errmsg := '���������� ���������� ����� ��������� � ������ ������� #'||to_char(l_caldtid)
                ||' � ������� '||p_statetab||'. ������ �������������.';
                logger.error(l_errmsg);
                raise_application_error(-20000, l_errmsg); 
        end;
        --
        execute immediate
       'update '||p_statetab||'
           set call_scn  = :p_callscn,
               call_date = :p_calldate,
               call_flag = :p_callflag  
         where caldt_id  = :p_caldtid'
         using p_callscn, p_calldate, p_callflag, p_caldtid;
        --
        commit;
        -- 
    end iset_call; 
    
    ----
    -- set_day_call - ��������� scn, ���� � ������� ��������� � �������� ������ �������
    --
    procedure set_day_call(        
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    )
    is
    begin
        --
        iset_call('ACCM_STATE_SNAP', p_caldtid, p_callscn, p_calldate, p_callflag);
        --
    end set_day_call;    
    
    ----
    -- set_month_call - ��������� scn, ���� � ������� ��������� � ��������� ������ �������
    --
    procedure set_month_call(        
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    )
    is
    begin
        --
        iset_call('ACCM_STATE_MONTH', p_caldtid, p_callscn, p_calldate, p_callflag);
        --
    end set_month_call;
    
    ----
    -- set_year_call - ��������� scn, ���� � ������� ��������� � �������� ������ �������
    --
    procedure set_year_call(        
        p_caldtid        in number,        
        p_callscn        in number,
        p_calldate       in date,
        p_callflag       in varchar2
    )
    is
    begin
        --
        iset_call('ACCM_STATE_YEAR', p_caldtid, p_callscn, p_calldate, p_callflag);
        --
    end set_year_call;
    
    -----------------------------------------------------------------
    -- CREATE_SNAP_BALANCE()
    --
    --     �������� ������ �������
    --
    --     ���������:
    --
    --         p_snapdate  ���� ������
    --
    procedure create_snap_balance(
                  p_snapdtid    in  number,
                  p_snapdate    in  date,
                  p_requestscn  in  number default null,
                  p_state       out varchar2,
                  p_stateinfo   out varchar2     
    ) is
    --
    p                   constant varchar2(100) := PKG_CODE || '.crsnpbal';    
    --
    l_isclear           boolean;    -- ������� ��������� ������
    l_now_scn           number;
    l_before_lock_scn   number;
    l_snap_balance      accm_state_snap.snap_balance%type;    
    l_snap_scn          accm_state_snap.snap_scn%type;
    l_snap_date         accm_state_snap.snap_date%type;
    --
    begin
        bars_audit.trace('%s: entry point par[0]=>%s par[1]=>%s', p, to_char(p_snapdtid), to_char(p_snapdate, FMT_DATE));
        --
        p_state     := null;
        p_stateinfo := null;
        --
        -- scn �� ����������
        l_before_lock_scn := dbms_flashback.get_system_change_number();
        --
        -- ����� ������ �������
        lock_day_snap(p_snapdtid);        
        --
        begin
            -- ��������� ��������: 
            -- ���� ������ �������� ����� ������ �������� ����������, ������ ������ ������� ��� �� ����
            ask_day_snap_state(p_snapdtid, l_snap_balance, l_snap_scn, l_snap_date);
            --
            if  l_snap_balance = 'Y' 
            and l_snap_scn is not null 
            and (l_snap_scn > l_before_lock_scn or p_requestscn is not null and l_snap_scn > p_requestscn) 
            then
                p_state     := 'N';
                --
                if l_snap_scn > l_before_lock_scn
                then                    
                    p_stateinfo := '�������� �������� ������ #'||to_char(p_snapdtid)||' �� '||to_char(p_snapdate, FMT_DATE)||' ���������, '
                        ||'�.�. �� ��� ������ ������ ������� �� ����� �������� ����������'
                        ||chr(10)||'snap_scn='||to_char(l_snap_scn)||'('||to_char(scn2ts(l_snap_scn), FMT_DATETIME)||')' 
                        ||chr(10)||'before_lock_scn='||to_char(l_before_lock_scn)||'('||to_char(scn2ts(l_before_lock_scn), FMT_DATETIME)||')';
                end if;
                --
                if p_requestscn is not null and l_snap_scn > p_requestscn
                then
                    p_stateinfo := '�������� �������� ������ #'||to_char(p_snapdtid)||' �� '||to_char(p_snapdate, FMT_DATE)||' ���������, '
                        ||'�.�. �� ��� ������ ������ ������� ����� �������������� scn'
                        ||chr(10)||'snap_scn='||to_char(l_snap_scn)||'('||to_char(scn2ts(l_snap_scn), FMT_DATETIME)||')' 
                        ||chr(10)||'requestscn='||to_char(p_requestscn)||'('||to_char(scn2ts(p_requestscn), FMT_DATETIME)||')';
                end if;
                -- ������� ����������
                unlock_day_snap(p_snapdtid);
                -- � �������
                return;
            end if;
            -- ���������� ������� �������� ������
            set_day_snap_state(p_snapdtid, 'N', null, null);
            --
            commit;
            -- ������ �������� ��� �������������
            if g_algorithm is null
            then
                load_algorithm();
            end if;
            --

IF g_algorithm = ALGORITHM_MIK 
THEN NULL;
ELSE
            l_isclear := false;
            loop
                begin
                    execute immediate 'alter table accm_snap_balances truncate partition for (' || to_char(p_snapdtid) || ')';
                    l_isclear := true;
                exception
                    when PART_NOT_EXISTS then l_isclear := true;
                    when RESOURCE_BUSY   then dbms_lock.sleep(SLEEP_TIMEOUT);
                end;
                exit when (l_isclear);
            end loop;
            bars_audit.trace('%s: snap partition truncated', p);
            -- �����! ����� TRUNCATE ��� ������� COMMIT
END IF;            
            -- ������� ������� scn
            l_now_scn := dbms_flashback.get_system_change_number(); 
            --                        
            -- �������� �� ��������� � �������������� SALNQC
            if g_algorithm = ALGORITHM_SALNQC
            then
                bars_audit.trace('%s: new algorithm = %s', p, nvl(g_algorithm,'null'));
                --            
                insert into accm_snap_balances(caldt_id, acc, rnk, ost, dos, kos, ostq, dosq, kosq)
                select p_snapdtid, acc, rnk, ost, dos, kos, ostq, dosq, kosq
                  from salnqc
                 where fdat = p_snapdate
                   and (daos <= p_snapdate and (dazs is null or dazs >= p_snapdate)
                         or ost  != 0
                         or ostq != 0
                       );
            elsif g_algorithm = ALGORITHM_OLD
            then 
                -- �������� �� ������� ���������
                bars_audit.trace('%s: old algorithm = %s', p, nvl(g_algorithm,'null'));
                --
                insert into accm_snap_balances(caldt_id, acc, rnk, ost, dos, kos, ostq, dosq, kosq)
                select p_snapdtid, acc, rnk, ost, dos, kos, ostq, dosq, kosq
                  from (select a.acc, a.rnk, a.daos, a.dazs,
                               nvl(sa.ost, 0) ost, nvl(sa.dos, 0) dos, nvl(sa.kos, 0) kos,
                               decode(a.kv, OUR_BASEVAL, nvl(sa.ost, 0), nvl(sb.ost, 0)) ostq,
                               decode(a.kv, OUR_BASEVAL, nvl(sa.dos, 0), nvl(sb.dos, 0)) dosq,
                               decode(a.kv, OUR_BASEVAL, nvl(sa.kos, 0), nvl(sb.kos, 0)) kosq
                          from accounts a,
                               (select sa1.acc,
                                       sa1.ostf - sa1.dos + sa1.kos ost,
                                       decode(sa1.fdat, p_snapdate, sa1.dos, 0) dos,
                                       decode(sa1.fdat, p_snapdate, sa1.kos, 0) kos
                                  from saldoa sa1,
                                       (select acc, max(fdat) fdat
                                          from saldoa
                                         where fdat <= p_snapdate
                                        group by acc) sa2
                                 where sa1.fdat = sa2.fdat
                                   and sa1.acc  = sa2.acc) sa,
                               (select sb1.acc,
                                       sb1.ostf - sb1.dos + sb1.kos ost,
                                       decode(sb1.fdat, p_snapdate, sb1.dos, 0) dos,
                                       decode(sb1.fdat, p_snapdate, sb1.kos, 0) kos
                                  from saldob sb1,
                                       (select acc, max(fdat) fdat
                                          from saldob
                                         where fdat <= p_snapdate
                                        group by acc) sb2
                                 where sb1.fdat = sb2.fdat
                                   and sb1.acc  = sb2.acc) sb
                         where a.acc = sa.acc(+)
                           and a.acc = sb.acc(+))
                 where (daos <= p_snapdate
                        and (dazs is null or dazs >= p_snapdate))
                    or ost  != 0
                    or ostq != 0;
            elsif g_algorithm = ALGORITHM_MIK
            then 
                bars_audit.trace('%s: old algorithm = %s', p, nvl(g_algorithm,'null'));
-- ��� ������ 
                --draps(p_snapdate);
-- ʳ���� ����� ������
            else
                raise_application_error(-20000, '������������ �������� ��������� SNAP_ALG='||g_algorithm
                 ||', ��������� '
             	 ||ALGORITHM_OLD||' ��� '||ALGORITHM_SALNQC||' ��� '||ALGORITHM_MIK
);
            end if;            
                         
            -- ��������� scn'�
            set_snap_scn(TAB_SALDOA,            p_snapdate, l_now_scn);
            set_snap_scn(TAB_SALDOB,            p_snapdate, l_now_scn);
            set_snap_scn(TAB_SALDOA_DEL_ROWS,   p_snapdate, l_now_scn);
            
            -- ����������� ������� ���������� ������ ������� � scn ��� ��������
            set_day_snap_state(p_snapdtid, 'Y', dbms_flashback.get_system_change_number(), sysdate);
            
            --
            commit;
            --
            unlock_day_snap(p_snapdtid);
            --
        exception 
            when others then
                rollback;
                --
                unlock_day_snap(p_snapdtid);
                --                
                raise_application_error(-20000, dbms_utility.format_error_stack()||chr(10)
                    ||dbms_utility.format_error_backtrace());
        end;
        --
        p_state := 'Y';
        p_stateinfo := '������� ������ #'||to_char(p_snapdtid)||' �� '||to_char(p_snapdate, FMT_DATE)||' ������� ������'; 
        --
        bars_audit.trace('%s: succ end', p);
        --
    end create_snap_balance;
    
    ----
    -- map_scn_to_dateinfo - ���������� ���� �����. scn ��� ??? < min_date
    --
    function map_scn_to_dateinfo(p_scn number) return varchar2
    is
        l_dateinfo  varchar2(30);
    begin
        begin
            l_dateinfo := to_char(scn_to_timestamp(p_scn),'DD.MM.YYYY HH24:MI:SS');
        exception when others then
            select '??? < '||
                to_char(
                    cast(from_tz(cast(min(time_dp) as timestamp),'GMT') at time zone sessiontimezone as date),
                    'DD.MM.YYYY HH24:MI:SS')
              into l_dateinfo
              from sys.smon_scn_time;                 
        end;
        --
        return l_dateinfo;
        --
    end map_scn_to_dateinfo;

    ----
    -- get_max_bankdate - ���������� ����. ����. ���� �� ���� ��������
    --
    function get_max_bankdate return date
    result_cache
    is
        l_max_dat   date;
    begin
        select max(to_date(val,'MM/DD/YYYY'))
          into l_max_dat
          from params$base
         where par='BANKDATE';
        --
        logger.trace('get_max_bankdate() return value %s', to_char(l_max_dat,'dd.mm.yyyy'));
        --
        return l_max_dat;
        --
    end get_max_bankdate;

    
    ----
    -- get_prev_bankdate - ���������� ���������� ���������� ���� �� ��������� � ����������
    --
    function get_prev_bankdate(p_bankdate date) return date
    result_cache
    is
        l_bd    date;
    begin
        select nvl(max(fdat),to_date('01.01.1900','dd.mm.yyyy'))
          into l_bd
          from fdat
         where fdat<p_bankdate;
        return l_bd;
    end get_prev_bankdate; 
    
    ----
    -- is_partition_modified - ���������� ���� 0/1 ����������� �������� ������� � ������� p_scn
    --                         ������������� ������������ ����� ����, ��� ������ ������ ���������� ����  
    --
    function is_partition_modified(p_table in varchar2, p_date in date, p_scn in number)
    return number
    is
        p               constant varchar2(100) := PKG_CODE || '.ispartmod';        
        l_result        integer;
        l_acc           accounts.acc%type;
        l_nls           accounts.nls%type;
        l_kv            accounts.kv%type;
        l_dateinfo      varchar2(30);
        l_rowscn        number;
        l_workdate      date; -- ������� ����(���������� ��� ��������� ��� ��������� ���������)
        l_prevdate      date;
        l_scan          accm_snap_scan%rowtype;
    begin
        --
        if logger.trace_enabled()
        then
            l_dateinfo := map_scn_to_dateinfo(p_scn);
            logger.trace('%s: entry point p_table=>%s, p_date=>%s, p_scn=>%s(%s)', 
                p, p_table, to_char(p_date, FMT_DATE), to_char(p_scn), l_dateinfo);
        end if;            
        --    
        -- ������ �������� SNAP_PMQC (Partition Modification Query Condition)  
        load_snap_pmqc();
        --
        if logger.trace_enabled()
        then
            logger.trace('%s: SNAP_PMQC = %s', p, g_snap_pmqc);
        end if;
        --
        -- ��������� ������ ������������
        l_scan.scan_scn := dbms_flashback.get_system_change_number();
        --
        -- ��������� ������������      
        begin
            -- ���� ������ ���������������� � ������� p_scn ���� � �������� g_snap_pmqc 
            execute immediate 
                  'select a.acc, a.nls, a.kv, t.ora_rowscn from '||p_table
                ||' partition for (to_date('''||to_char(p_date,'DD.MM.YYYY')||''',''DD.MM.YYYY'')) t, accounts a'
                ||' where t.ora_rowscn > '||to_char(p_scn)||' and rownum=1'
                ||'   and a.acc=t.acc'
                ||'   and ('||g_snap_pmqc||')'
            into l_acc, l_nls, l_kv, l_rowscn;
            --
            l_result := 1;
        exception
            when no_data_found then
                l_result := 0;
        end;
        --
        if l_result=1
        then
            -- ������� ������� ����
            l_workdate := nvl(bars_accm_snap.get_max_bankdate(), trunc(sysdate));
            -- ���������� ���������� ����
            l_prevdate := bars_accm_snap.get_prev_bankdate(l_workdate);
            -- ��������� ������� � ������ ���������� ���� (������� 2 ���������� ��� �����)? 
            if p_date < l_prevdate
            then
                -- �������� �� ���� ��� ����������
                l_scan.scan_id              := s_accm_snap_scan.nextval;
                l_scan.fdat                 := p_date;
                l_scan.table_name           := p_table;
                l_scan.scan_date            := scn_to_timestamp(l_scan.scan_scn);
                l_scan.threshold_scn        := p_scn;
                l_scan.threshold_dateinfo   := map_scn_to_dateinfo(p_scn);
                l_scan.mod_acc              := l_acc;
                l_scan.mod_scn              := l_rowscn;
                l_scan.mod_dateinfo         := map_scn_to_dateinfo(l_rowscn);
                l_scan.query_condition      := g_snap_pmqc;
                --
            end if;
            
            if logger.trace_enabled()
            then
                l_dateinfo := nvl(l_scan.mod_dateinfo, map_scn_to_dateinfo(l_rowscn)); 
                logger.trace('%s: � ������� %s ������� ��������� �� ����� acc=%s, nls=%s, kv=%s �� ����.���� %s � ������ scn=%s(%s)', 
                    p, p_table, to_char(l_acc), l_nls, to_char(l_kv), to_char(p_date, FMT_DATE), 
                    to_char(l_rowscn), to_char(l_dateinfo)
                );
            end if;
        end if;
        --
        if logger.trace_enabled()
        then            
            logger.trace('%s: succ end, result=%s', p, to_char(l_result));
        end if;
        -- 
        return l_result;
        --
    end is_partition_modified;

    ----
    -- get_snap_scn - ���������� scn ��������� ��������� ������ ������� �� �������� ��������� �������
    --
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
    
    ----
    -- set_snap_scn - ������������� scn ��������� ��������� ������ ������� �� �������� ��������� �������
    --
    procedure set_snap_scn(p_table in varchar2, p_date in date, p_scn in number)
    is
        p           constant varchar2(100) := PKG_CODE || '.setsnapscn';
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
        --
    end set_snap_scn;    
    
    -----------------------------------------------------------------
    -- SNAP_BALANCE()
    --
    --     ��������/���������� ������� �������
    --
    --     ���������:
    --
    --         p_mode      ����� ��������/����������
    --
    --         p_bankdate  ���������� ���� ������
    --                     (��� ������� ������)
    --
    procedure snap_balance(
                  p_snapdate    in  date,
                  p_snapmode    in  number,
                  p_requestscn  in number default null)
    is
    --
    p                constant varchar2(100) := PKG_CODE || '.snpbal';
    --
    l_snapdate          date;       -- ���� ������
    l_snapdtid          number;     -- ��. ���� ������
    l_caldtid           number;     -- ��. ������� ���� �������
    l_saldoa_snap_scn   number;
    l_saldob_snap_scn   number;
    l_delrow_snap_scn   number;
    l_create_snap       boolean := false;
    l_snap_balance      accm_state_snap.snap_balance%type;
    l_callscn           accm_state_snap.call_scn%type  := dbms_flashback.get_system_change_number();
    l_calldate          accm_state_snap.call_date%type := sysdate;
    l_callflag          accm_state_snap.call_flag%type;
    l_locked            accm_state_snap.locked%type;
    l_state             varchar2(1);
    l_stateinfo         varchar2(4000);     
    --
    begin
        bars_audit.trace('%s: entry point p_snapdate=>%s, p_snapmode=>%s', p, to_char(p_snapdate, FMT_DATE), to_char(p_snapmode));

        --raise_application_error(-20000, '�������������� ������');
        
        -- ������������� ������� ����� �� ���������� ����
        l_snapdate := trunc(p_snapdate);

        -- �������� ��. ���������� ����
        l_snapdtid := bars_accm_calendar.get_calendar_id(l_snapdate);

        -- ��������� ������ �� ��� ������
        begin
            select snap_balance, locked
              into l_snap_balance, l_locked
              from accm_state_snap
             where caldt_id = l_snapdtid;
        exception
            when no_data_found then
                -- ���� ������ ��������� ������ �� �������, �������� ��
                insert
                  into accm_state_snap(caldt_id)
                values (l_snapdtid);
                --
                commit;
                --
                l_snap_balance := 'N';
                l_locked       := null;
        end;        
        --
        if p_snapmode = 0
        then
            l_create_snap := true;
        else
            -- ���� ������ �� ������, �������
            if l_snap_balance <> 'Y'
            then
                l_create_snap := true;
            else
                -- ������ ��� ���������� ������, ���������� ��� ������������
                -- ��� �����:
                -- ������� scn ��������� ������� �������� �� �������� saldoa, saldob
                l_saldoa_snap_scn := get_snap_scn(TAB_SALDOA,           l_snapdate);
if g_algorithm <> ALGORITHM_MIK then
                l_saldob_snap_scn := get_snap_scn(TAB_SALDOB,           l_snapdate);
end if;
                l_delrow_snap_scn := get_snap_scn(TAB_SALDOA_DEL_ROWS,  l_snapdate);
                -- � �������� ���������������� �� �������� �� ��������� ���� � ����� �������
                if ( is_partition_modified(TAB_SALDOA,          l_snapdate, l_saldoa_snap_scn) = 1
                 or  g_algorithm <> ALGORITHM_MIK and
                     is_partition_modified(TAB_SALDOB,          l_snapdate, l_saldob_snap_scn) = 1
                 or  is_partition_modified(TAB_SALDOA_DEL_ROWS, l_snapdate, l_delrow_snap_scn) = 1
                   )
                then
                    l_create_snap := true;
                end if;            
                --
            end if;              
        end if;
        --
        if l_create_snap
        then
            -- ������� ������ �������
            create_snap_balance(
                p_snapdtid      => l_snapdtid, 
                p_snapdate      => l_snapdate, 
                p_requestscn    => p_requestscn, 
                p_state         => l_state, 
                p_stateinfo     => l_stateinfo
            );
            --
            l_stateinfo := l_stateinfo || chr(10) 
            ||'����� �������������� - '||case when p_snapmode=0 then '�����������' else '��������' end;
            --                         
            logger.info(l_stateinfo);
        else
            logger.info('������ ������� #'||to_char(l_snapdtid)||' �� ���� '||to_char(p_snapdate, FMT_DATE)
                      ||' ����������������� �� �����, �.�. �� ������������� ����������� �����. �������� SALDOA, SALDOB.');
        end if;                
        --
        -- ��������� scn, ���� � ����� ��������� � ������ ������� 
        --
        set_day_call(l_snapdtid, l_callscn, l_calldate,
            case
            when not l_create_snap 
            then 
                FLAG_REUSED
            when l_create_snap and nvl(l_snap_balance,'N')='N' and l_locked is null 
            then 
                FLAG_CREATED
            else 
                FLAG_RECREATED
            end 
        );
        --
        bars_audit.trace('%s: succ end', p);

    end snap_balance;

    -----------------------------------------------------------------
    -- SNAP_BALANCE_IN_JOB()
    --
    --     ��������/���������� ������� ������� � ��������� �������
    --
    --     ���������:
    --
    --         p_mode      ����� ��������/����������
    --
    --         p_bankdate  ���������� ���� ������
    --                     (��� ������� ������)
    --
    --         p_requestscn ������ ����� �� ���� ������� SCN 
    --
    --         p_jobname    ��� �������
    --
    procedure snap_balance_in_job(
                  p_snapdate    in  date,
                  p_snapmode    in  number,
                  p_requestscn  in  number default null,
                  p_jobname     out varchar2)
    is        
        p  constant varchar2(100) := PKG_CODE || '.snapbalinjob';
        l_jobaction     varchar2(4000);
    begin
        logger.trace('%s: started snap_balance_in_job(p_startdate=>''%s'', p_snapmode=>%s, p_requestscn=>%s)',
            p, to_char(p_snapdate, FMT_DATE), to_char(p_snapmode), to_char(p_requestscn));
        --
        p_jobname := dbms_scheduler.generate_job_name('SNAP_'||to_char(p_snapdate,'YYYYMMDD')||'_');
        --
        logger.trace('%s: generated job_name=''%s''', p, p_jobname);
        --
        l_jobaction := 
        'begin
            bars_accm_snap.snap_balance(                 
                p_snapdate      => to_date('''||to_char(p_snapdate, FMT_DATE)||''',''dd.mm.yyyy''),
                p_snapmode      => '||to_char(p_snapmode)||', 
                p_requestscn    => '||case when p_requestscn is null then 'null' else to_char(p_requestscn) end||'
            );
        end;';
        --
        dbms_scheduler.create_job
        (
           job_name        => p_jobname
          ,start_date      => sysdate
          ,repeat_interval => null
          ,end_date        => null
          ,job_class       => 'DEFAULT_JOB_CLASS'
          ,job_type        => 'PLSQL_BLOCK'
          ,job_action      => l_jobaction 
          ,comments        => '������������ �������� ������ ������� �� '||to_char(p_snapdate, FMT_DATE)
        );
        dbms_scheduler.set_attribute
            ( name         => p_jobname
             ,attribute    => 'RAISE_EVENTS'
             ,value        => dbms_scheduler.job_succeeded + dbms_scheduler.job_failed + dbms_scheduler.job_stopped
        );
        dbms_scheduler.enable
            ( name         => p_jobname
        );
        --
        logger.trace('%s: finished', p);
        --
    end snap_balance_in_job;

    ----
    -- conv_joblist2enum - ���������� ������ � ������ ��������, ����������� �������
    --
    function conv_joblist2enum(p_joblist in t_joblist) return varchar2
    is
        l_jobenum varchar2(2000);
        l_index   varchar2(8);
    begin
        l_index := p_joblist.first;
        --
        while l_index is not null
        loop
            if l_jobenum is not null
            then
                l_jobenum := l_jobenum || ',';
            end if;
            l_jobenum := l_jobenum || ''''||p_joblist(l_index)||'''';
            l_index := p_joblist.next(l_index);  
        end loop;
        --
        return l_jobenum;
        --
    end conv_joblist2enum;

    ----
    -- wait_for_snap_jobs - ������� ���������� ������� �� ������������ ������� �������
    --      p_joblist - ������ ���� �������, ��������������� �����
    --
    procedure wait_for_snap_jobs(p_joblist in t_joblist)
    is
        pragma autonomous_transaction;
        --
        p  constant varchar2(100) := PKG_CODE || '.wait4jobs';
        --
        l_jobenum                 varchar2(2000);
        l_joblist                 t_joblist := p_joblist;
        --        
        l_dequeue_options         dbms_aq.dequeue_options_t;
        l_msgprops                dbms_aq.message_properties_t;
        l_msgid                   RAW(16);
        l_event                   sys.scheduler$_event_info;
        l_starttime               date := sysdate;
        l_cnt                     number := 0;
        l_index                   varchar2(8);
        l_jobstatuses             t_joblist;
        l_errmsg                  varchar2(4000);        
    begin
        logger.trace('%s: started', p);
        --
        logger.trace('%s: p_joblist.count=%s', p, to_char(l_joblist.count));
        --
        if p_joblist.count=0
        then
            logger.trace('%s: finished (because p_joblist.count=0)', p);
            return;
        end if;
        --
        -- ��������� ������ ���� ������� �� ������
        l_jobenum := conv_joblist2enum(l_joblist);
        logger.trace('%s: jobenum = %s', p, l_jobenum);
        --
        l_dequeue_options.consumer_name   := 'BARS';
        l_dequeue_options.wait            := dbms_aq.no_wait;
        l_dequeue_options.navigation      := dbms_aq.first_message;        
        --       
        while (sysdate-l_starttime) < WAIT_JOBS_TIMEOUT/24.0/60.0 
          and l_joblist.count > 0
        loop
            l_index := l_joblist.first;
            --
            while l_index is not null
            loop
                l_dequeue_options.deq_condition := 
                    'tab.user_data.object_name='''||l_joblist(l_index)||''''
                    ||' and tab.user_data.event_type in (''JOB_SUCCEEDED'',''JOB_FAILED'')';
                begin
                    dbms_aq.dequeue(
                        queue_name          => 'SYS.SCHEDULER$_EVENT_QUEUE',
                        dequeue_options     => l_dequeue_options,
                        message_properties  => l_msgprops,
                        payload             => l_event,
                        msgid               => l_msgid
                    );
                    --
                    if l_event.event_type='JOB_FAILED'
                    then
                        -- ��������� ������ �� �������
                        commit;
                        -- ����������� ������
                        l_errmsg := '������� '||l_event.object_name||' ��������� � �������: '||l_event.error_msg;
                        logger.error(l_errmsg);
                        raise_application_error(-20000, l_errmsg);
                        --
                    elsif l_event.event_type='JOB_SUCCEEDED'
                    then
                        logger.info('������� '||l_event.object_name||' ��������� ������� �� '
                            ||to_char(round((sysdate-l_starttime)*3600*24))||' ������'
                        );
                    end if;
                    --
                    l_joblist.delete(l_index);
                    --
                exception 
                    when MQ_EMPTY_OR_TIMEOUT_EXCEPTION then
                        logger.trace('%s: ��������� ������� %s �� ������� � �������(�.�. ��� ��� ����������� %s ������)', 
                            p, l_joblist(l_index), to_char(round((sysdate-l_starttime)*3600*24))
                        );
                end;                
                --
                if l_dequeue_options.navigation = dbms_aq.first_message
                then
                    l_dequeue_options.navigation := dbms_aq.next_message;
                end if;
                --
                l_index := l_joblist.next(l_index);
                --  
            end loop;
            --
            if l_joblist.count > 0
            then
                logger.trace('%s: ���� 1 �������', p);
                --
                dbms_lock.sleep(1);
                --
            end if;
            --
        end loop;            
        --
        commit;
        --
        -- ���� �� ���������, ����������� ������
        if l_joblist.count>0
        then
            raise_application_error(-20000, '�� ��������� ���������� '||l_joblist.count||' ������� �� '||
            p_joblist.count||' �� ����� '||WAIT_JOBS_TIMEOUT||' �����.');
        end if;
        --
        logger.trace('%s: finished', p);
        --
    end wait_for_snap_jobs;
                      
    -----------------------------------------------------------------
    -- SNAP_BALANCE_PERIOD()
    --
    --     ��������/���������� ������� ������� �� ������
    --
    --     ���������:
    --
    --         p_startdate  ���� ������ �������
    --
    --         p_finishdate ���� ��������� �������
    -- 
    --         p_snapmode   ����� ��������/���������� 
    --                      0-������, 1-���������
    --
    procedure snap_balance_period(
                  p_startdate   in  date,
                  p_finishdate  in  date,
                  p_snapmode    in  number )
    is
        --
        l_startdate         date;
        l_finishdate        date;        
        l_found             boolean := false;
        l_saldoa_snap_scn   number;
        l_saldob_snap_scn   number;
        l_delrow_snap_scn   number;
        l_callscn           accm_state_snap.call_scn%type;
        l_calldate          accm_state_snap.call_date%type;
        l_jobname           varchar2(30);
        l_joblist           t_joblist;                
    begin
        logger.info('�������� ��������� ���������� ������� �������� �� ������ � '
                   ||to_char(p_startdate, FMT_DATE)||' �� '||to_char(p_finishdate, FMT_DATE)
                   ||' � ������ '||case when p_snapmode=0 then '�������' else '����������' end||' ����������.'
                   );
        -- �������� ����� ��� �������
        l_startdate  := trunc(p_startdate);
        l_finishdate := trunc(p_finishdate);
        --
        -- ������ �� ������ ���� ������ 31 ���
        --
        if l_finishdate-l_startdate+1>31
        then
            raise_application_error(-20000, '������� ������� ������������� ������� ������� ������ 31 ��� ���������!');
        end if;
        --
        -- ���� ������ ��������� ����������, 
        -- ���� ������ ������������� ������ ���� ����������� �������� � ����������� �����
        -- ������ ��������������� ��� ������ ����� ����������, 
        -- �.�. �� ������� � ������� ������ ������� � �������
        if p_snapmode = 1
        then
            for c in (select c.caldt_id, c.caldt_date, s.snap_balance, 
                             s.locked, s.snap_scn, s.sid, s.serial#, s.call_scn 
                        from accm_state_snap s, accm_calendar c
                       where s.caldt_id(+) = c.caldt_id
                         and c.caldt_date = c.bankdt_date -- ������ �� ���������� ����
                         and c.caldt_date between l_startdate and l_finishdate
                       order by c.caldt_date
                     )
            loop  
                --              
                if c.snap_balance is null 
                or c.snap_balance='N' and c.locked is null and c.call_scn is null
                then
                    -- ���� ������ ������� ������ �� ����������, ����� ��� �� ������
                    l_found := true;
                    l_startdate := c.caldt_date;
                else
                    -- ��� ����� ���������� ������:
                    -- ������� scn ��������� ������� �������� �� �������� saldoa, saldob
                    l_saldoa_snap_scn := get_snap_scn(TAB_SALDOA,           c.caldt_date);
if g_algorithm <> ALGORITHM_MIK then
                    l_saldob_snap_scn := get_snap_scn(TAB_SALDOB,           c.caldt_date);
end if;
                    l_delrow_snap_scn := get_snap_scn(TAB_SALDOA_DEL_ROWS,  c.caldt_date);
                    -- � �������� ���������������� �� �������� �� ��������� ���� � ����� �������
                    if ( is_partition_modified(TAB_SALDOA,          c.caldt_date, l_saldoa_snap_scn) = 1
                     or  g_algorithm <> ALGORITHM_MIK and
                         is_partition_modified(TAB_SALDOB,          c.caldt_date, l_saldob_snap_scn) = 1
                     or  is_partition_modified(TAB_SALDOA_DEL_ROWS, c.caldt_date, l_delrow_snap_scn) = 1
                       )
                    then
                        l_found := true;
                        l_startdate := c.caldt_date;
                    end if;            
                    -- 
                end if;
                --
                if l_found
                then
                    exit;
                end if;
                --
            end loop;
            --
            if not l_found
            then
                l_startdate := l_finishdate + 1; 
            end if;
            --
        end if;
        logger.info('������������� ���� ������ ������� '||to_char(l_startdate, FMT_DATE)||
                    case when l_startdate > l_finishdate 
                         then ' ������ ���� ��������� ������� '||to_char(l_finishdate, FMT_DATE)
                              ||' - ���������� �� �����������'
                         else '' 
                    end
                   );              
        --
        -- ��������� scn, ����+����� ��������� � ������� ������� � ���� REUSED, 
        -- ������� ����� �������� ������������ ��� ������������ 
        --
        l_callscn  := dbms_flashback.get_system_change_number(); 
        l_calldate := sysdate;
        for c in (select c.caldt_id 
                    from accm_state_snap s, accm_calendar c
                   where s.caldt_id = c.caldt_id
                     and c.caldt_date = c.bankdt_date -- ������ �� ���������� ����
                     and c.caldt_date between p_startdate and l_startdate-1
                   order by c.caldt_date
                 )
        loop            
            set_day_call(c.caldt_id, l_callscn, l_calldate, 'REUSED');
        end loop;
        --
        -- ��������� ����������� ������� ��� ������������ ������� �������         
        for c in (select caldt_id, caldt_date 
                    from accm_calendar c
                   where caldt_date between l_startdate and l_finishdate
                     and c.caldt_date = c.bankdt_date -- ������ �� ���������� ����
                   order by caldt_date
                 )
        loop            
            snap_balance_in_job(                 
                p_snapdate      => c.caldt_date,
                p_snapmode      => bars_accm_sync.SNAPMODE_FULL, 
                p_requestscn    => l_callscn,
                p_jobname       => l_jobname
            );            
            l_joblist(to_char(c.caldt_date, 'YYYYMMDD')) := l_jobname;                        
        end loop;        
        --
        -- ������� ���������� ���� ������� ��� ������������ ������� �������
        --
        wait_for_snap_jobs(l_joblist);
        --
        logger.info('��������� ��������� ���������� ������� �������� �� ������ � '
                   ||to_char(p_startdate, FMT_DATE)||' �� '||to_char(p_finishdate, FMT_DATE)
                   ||' � ������ '||case when p_snapmode=0 then '�������' else '����������' end||' ����������.'
                   );  
    end snap_balance_period;

    -----------------------------------------------------------------
    --                                                             --
    --  ������ ������������� ������                                --
    --                                                             --
    -----------------------------------------------------------------

    -----------------------------------------------------------------
    -- HEADER_VERSION()
    --
    --     ������� ��������� ������ ��������� ������
    --
    --
    --
    function header_version return varchar2
    is
    begin
        return 'package header BARS_ACCM_SNAP ' || VERSION_HEADER || chr(10) ||
               'package header definition(s):' || chr(10) || VERSION_HEADER_DEFS;
    end header_version;


    -----------------------------------------------------------------
    -- BODY_VERSION()
    --
    --     ������� ��������� ������ ���� ������
    --
    --
    --
    function body_version return varchar2
    is
    begin
        return 'package body BARS_ACCM_SNAP ' || VERSION_BODY || chr(10) ||
               'package body definition(s):' || chr(10) || VERSION_BODY_DEFS;
    end body_version;

begin
  load_algorithm();
end BARS_ACCM_SNAP; 
/

show error
