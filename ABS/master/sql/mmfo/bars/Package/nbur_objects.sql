create or replace package NBUR_OBJECTS 
is

  --
  -- constants
  --
  g_header_version  constant varchar2(64)  := 'version 17.5  2018.03.15';

  --
  -- types
  --
  subtype tbl_nm_subtype is varchar2(30) Not Null;

  -- header_version - возвращает версию заголовка пакета
  function header_version return varchar2;

  -- body_version - возвращает версию тела пакета
  function body_version return varchar2;

  --
  --  получение идентификатора объекта по его имени
  --
  function f_get_object_id_by_name
  ( p_object_name  in     nbur_ref_objects.object_name%type
  ) return number
    result_cache;

  --
  --  получение имени объекта по его идентификатору
  --
  function f_get_object_name_by_id
  ( p_object_id    in     number
  ) return varchar2
    result_cache;

  --
  --  получение VERSION_ID загруженного объекта
  --
  function f_get_version_object
  ( p_object_id    in number
  , p_report_date  in date
  , p_kf           in varchar2
  ) return number;

  --
  -- ADD NEW or UPDATE EXISTING OBJECT
  --
  procedure SET_OBJECT
  ( p_obj_nm       in     nbur_ref_objects.object_name%type
  , p_scm_nm       in     nbur_ref_objects.scheme%type      default 'BARS'
  , p_obj_tp       in     nbur_ref_objects.object_type%type default 'TABLE'
  , p_pcd_ins      in     nbur_ref_objects.proc_insert%type
  , p_pcd_upd      in     nbur_ref_objects.proc_update%type default null
  , p_pcd_del      in     nbur_ref_objects.proc_delete%type default null
  , p_obj_code     in     nbur_ref_objects.name_id_var%type
  , p_obj_id       out    nbur_ref_objects.id%type
  );

  --
  -- SET_OBJECT_DEPENDENCIES
  --
  procedure SET_OBJECT_DEPENDENCIES
  ( p_obj_id       in     nbur_lnk_object_object.object_id%type
  , p_obj_pid      in     nbur_lnk_object_object.object_pid%type
  );

  --
  --  вставка инфо о начале процесса загрузки объекта в таблицу загруженных объектов
  --
  procedure P_START_LOAD_OBJECT
  ( p_object_id    in     nbur_lst_objects.object_id%type
  , p_object_name  in     nbur_ref_objects.object_name%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_start_time   in     nbur_lst_objects.start_time%type  default systimestamp
  );

  --
  --
  --
  procedure p_load_customers
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  --
  --
  procedure p_load_accounts
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  --
  --
  procedure p_load_dailybal
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  --
  --
  procedure p_load_monthbal
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- LOAD_BAL_YEARLY
  --
  procedure LOAD_BAL_YEARLY
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- зміна статусу версії об`єкту
  --

  procedure P_UPDATE_ONE_OBJ_STATUS
  ( p_object_id    in     nbur_lst_objects.object_id%type
  , p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_status       in     nbur_lst_objects.object_status%type
  );

  --
  -- Наповнення даними вітрини фінансових транзакцій (opldok)
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure P_LOAD_TRANSACTIONS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  --
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure P_LOAD_BALANCES_R013
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини додаткових реквізитів фінансових документів
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure P_LOAD_ADL_DOC_RPT_DTL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини SWIFT реквізитів фін. документів
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_ADL_DOC_SWT_DTL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини зв`язків рахунків та договорів
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure P_LOAD_AGRM_ACCOUNTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини процентних карток рахунків
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure P_LOAD_ACNT_RATES
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини процентних ставок договорів
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure P_LOAD_AGRM_RATES
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  --
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_AGREEMENTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини касових (і не тільки) символів документів
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_TXN_SYMBOLS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );


  --
  -- Наповнення даними вітрини сум забезпечення в розрізі рахунків
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_BALANCES_CLT
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини резервів по активах
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_PROVISIONS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення даними вітрини графіків платежів (зниження ліміту кредитування)
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_PAYMENT_SHD
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення вітрини Середньо-хронологічних залишків
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_CHRON_AVG_BALS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення консолідованиї вітрини даних фінансових транзакцій за місяць, в т.ч. коригуючими
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_TRANSACTIONS_CNSL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  -- Наповнення вітрини даних нарахованих доходів та витрат за місяць
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure LOAD_PROFIT_AND_LOSS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  );

  --
  --
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --
  procedure SAVE_VERSION
  ( p_report_date  in     nbur_lst_versions.report_date%type
  , p_kf           in     nbur_lst_versions.kf%type
  , p_vrsn_id      in     nbur_lst_versions.version_id%type default null
  );

  --
  -- Збереження протоколів формування файлів в архіві версій
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_vrsn_id     - Iдентифiкатор версії
  --  p_file_id     - Iдентифiкатор файлу
  --
  procedure SAVE_FILE_VERSION
  ( p_report_dt    in     nbur_lst_files.report_date%type
  , p_kf           in     nbur_lst_files.kf%type
  , p_vrsn_id      in     nbur_lst_files.version_id%type
  , p_file_id      in     nbur_lst_files.file_id%type
  );

  --
  --
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_object_id   - Iдентифiкатор об`єкту
  --  p_version_id  - Iдентифiкатор версії
  --
  procedure BLOCK_VERSION
  ( p_report_date  in     nbur_lst_blc_objects.report_date%type
  , p_kf           in     nbur_lst_blc_objects.kf%type
  , p_object_id    in     nbur_lst_blc_objects.object_id%type
  , p_version_id   in     nbur_lst_blc_objects.version_id%type default null
  );

  --
  -- RETRIEVE_VERSION
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --  p_object_nm   - Назва об`єкту
  --
  procedure RETRIEVE_VERSION
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_object_nm    in     nbur_ref_objects.object_name%type
  );

  --
  -- REMOVE_INVALID_DM_VERSIONS
  --
  procedure REMOVE_INVALID_DM_VERSIONS
  ( p_start_id     in     number
  , p_end_id       in     number
  , p_lmt_dt       in     date
  , p_kf           in     varchar2
  );

  --
  -- Видалення інвалідних версій вітрин
  --
  procedure REMOVE_INVALID_VERSIONS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  );

  --
  -- Видалення застарілих версій вітрин
  --
  procedure REMOVE_OBSOLETE_VERSIONS;

  --
  -- GATHER_DM_STATS
  --
  procedure GATHER_DM_STATS
  ( p_start_id     in     number
  , p_end_id       in     number
  );

  --
  -- LOAD_ALL_OBJECTS
  --
  --  p_report_date - Звітна дата
  --  p_kf          - Код фiлiалу (МФО)
  --  p_version_id  - Iдентифiкатор версії
  --  p_auto_stat   - Автоматичний збір статистики по завантаженим вітринам даних
  --
  procedure LOAD_ALL_OBJECTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_auto_stat    in     boolean default true
  );



END NBUR_OBJECTS;
/

show errors;

create or replace package body NBUR_OBJECTS
is

  --
  -- constants
  --
  g_body_version  constant varchar2(64) := 'version 19.7  2018.03.27';
  fmt_dt          constant varchar2(10) := 'dd.mm.yyyy';
  fmt_tm          constant varchar2(21) := 'dd.mm.yyyy hh24:mi:ss';

  MODULE_PREFIX   constant varchar2(4)  := 'NBUR';

  --
  -- types
  --
  subtype kf_subtype     is char(6);
  type    t_tbl_lst_type is table of tbl_nm_subtype;

  --
  -- variables
  --
  l_usr_mfo            varchar2(6);
  l_rowcount           pls_integer;
  l_object_id          pls_integer;
  l_dop                pls_integer;
  t_tbl_lst            t_tbl_lst_type;
  l_err_tag            varchar2(30);
  l_err_rec_id         pls_integer;
  l_frst_yr_dt         date;
  l_attempt_num        number(1);
  l_dm_tblsps          boolean;

  --
  -- exceptions
  --
  e_ptsn_not_exsts      exception; -- Specified partition does not exist
  pragma exception_init( e_ptsn_not_exsts, -02149 );

  --
  -- повертає версію заголовка пакета
  --
  function header_version return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' header ' || g_header_version || '.';
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version return varchar2
  is
  begin
    return 'Package '||$$PLSQL_UNIT||' body ' || g_body_version || '.';
  end body_version;

  --
  --
  --
  function CHK_OBJ_POLICY_STE
  ( p_obj_nm       in     nbur_ref_objects.object_name%type
  ) return boolean
  is
    l_ste                 boolean;
    l_sel                 all_policies.sel%type;
  begin

    begin
      select SEL
    --     , INS, UPD, DEL, POLICY_NAME
        into l_sel
        from ALL_POLICIES
       where OBJECT_OWNER = 'BARS'
         and OBJECT_NAME  = p_obj_nm
         and POLICY_GROUP = 'FILIAL'
         and ENABLE       = 'YES';

      if ( l_sel = 'YES' )
      then
        l_ste := true;
      else
        l_ste := false;
      end if;

    exception
      when NO_DATA_FOUND then
        l_ste := false;
    end;

    return l_ste;

  end CHK_OBJ_POLICY_STE;

  --
  --
  --
  function CHK_DM_TBLSPS return boolean
  is
    l_qty  pls_integer;
  begin
    select count(1)
      into l_qty
      from DBA_TABLESPACES 
     where TABLESPACE_NAME like 'BRS_DM%';
    return case l_qty when 0 then FALSE else TRUE end;
  end CHK_DM_TBLSPS;
  
  --
  --
  --
  function REQUIRED_GATHER_STATS
  ( p_obj_nm       in     nbur_ref_objects.object_name%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_row_cnt      in     nbur_lst_objects.row_count%type
  ) return boolean
  is
    l_required            boolean := false;
    l_obj_nm              nbur_ref_objects.object_name%type;
    l_num_rows            all_tab_statistics.num_rows%type;
    l_last_anlyzed        all_tab_statistics.last_analyzed%type;
    l_locked              number(1);
  begin

    if ( p_obj_nm Is Not Null )
    then

      l_obj_nm := upper(p_obj_nm);

      if ( p_kf Is Null )
      then

        begin
--             , GLOBAL_STATS, USER_STATS, STALE_STATS -- ( YES / NO )
          select ts.NUM_ROWS, ts.LAST_ANALYZED, nvl2(ts.STATTYPE_LOCKED,1,0)
            into l_num_rows, l_last_anlyzed, l_locked
            from ALL_TAB_STATISTICS ts
           where ts.OWNER = 'BARS'
             and ts.TABLE_NAME = l_obj_nm
             and ts.OBJECT_TYPE = 'TABLE';
        exception
          when NO_DATA_FOUND
          then null;
        end;

      else

        begin
          select ts.NUM_ROWS, ts.LAST_ANALYZED
            into l_num_rows, l_last_anlyzed
            from ALL_TAB_STATISTICS ts
           where ts.OWNER = 'BARS'
             and ts.TABLE_NAME = l_obj_nm
             and ts.OBJECT_TYPE = 'PARTITION'
             and ts.PARTITION_NAME = 'P_'||p_kf;
        exception
          when NO_DATA_FOUND
          then
            begin
              select ts.NUM_ROWS, ts.LAST_ANALYZED
                into l_num_rows, l_last_anlyzed
                from ALL_TAB_STATISTICS ts
               where ts.OWNER = 'BARS'
                 and ts.TABLE_NAME = l_obj_nm
                 and ts.OBJECT_TYPE = 'SUBPARTITION'
                 and ts.SUBPARTITION_NAME = 'P_'||p_kf;
            exception
              when NO_DATA_FOUND
              then null;
            end;
        end;

        case
          when ( l_last_anlyzed Is Null )
          then -- статистика не збиралася взагалі
            l_required := true;
          when ( round(abs(l_num_rows-p_row_cnt),-2) > round(l_num_rows*0.10,-2) )
          then -- к-ть записів у табл. відрізнається більше ніж на 5% ( з округленням )
            l_required := true;
          else
            null;
        end case;

      end if;

    end if;

    return l_required;

  end REQUIRED_GATHER_STATS;

  --
  --
  --
  procedure GATHER_TABLE_STATS
  ( p_tbl_nm       in     nbur_ref_objects.object_name%type
  , p_kf           in     nbur_lst_objects.kf%type
  ) is
    l_ptsn_nm             varchar2(30);
  begin

    if ( p_kf Is Null )
    then

      dbms_application_info.set_client_info( 'Gather stats on "'||p_tbl_nm||'".' );

      DBMS_STATS.UNLOCK_TABLE_STATS
      ( ownname    => 'BARS'
      , tabname    => p_tbl_nm );

      DM.DM_UTL.GATHER_TBL_STATS
      ( p_own_name => 'BARS'
      , p_tab_name => p_tbl_nm
      , p_dop      => l_dop );

      DBMS_STATS.LOCK_TABLE_STATS
      ( ownname    => 'BARS'
      , tabname    => p_tbl_nm );

    else

      l_ptsn_nm := 'P_'||p_kf;

      dbms_application_info.set_client_info( 'Gather stats on "'||p_tbl_nm||'" partition "'||l_ptsn_nm||'".' );

      DBMS_STATS.UNLOCK_PARTITION_STATS
      ( ownname     => 'BARS'
      , tabname     => p_tbl_nm
      , partname    => l_ptsn_nm );

      /*
      DM.DM_UTL.GATHER_TBL_STATS
      ( p_own_name  => 'BARS'
      , p_tab_name  => p_tbl_nm
      , p_ptsn_name => l_ptsn_nm
      , p_mth_opt   => GET_MTH_OPT( p_tbl_nm ) -- на основы аналізу полів які викор. в запитах
      , p_dop       => l_dop
      , p_grnlr     => 'AUTO'
      , p_cascade   => TRUE
      );

      -- or
      DBMS_STATS.COPY_TABLE_STATS
      ( OWNNAME     => 'BARS'
      , TABNAME     => p_tbl_nm
      , SRCPARTNAME =>
      , DSTPARTNAME =>
      , FORCE       => TRUE
      );

      -- or export import table stats

      —- 1. create a table to hold stats
      dbms_stats.create_stat_table(‘SYSADM’,’TABLESTATS’,’D_SYSADM_M’);
      -— 2. partition stats export
      dbms_stats.export_table_stats(‘SYSADM’,’ORDERHDR_ALL’,’ORDERHDR_ALL_P88?,’TABLESTATS’);
      -— 3. manual copy step :)
      update TABLESTATS set c2=replace(c2,’88’,’90’);
      commit;
      -- 4. partition stats import
      dbms_stats.import_table_stats(‘SYSADM’,’ORDERHDR_ALL’,’ORDERHDR_ALL_P90?,’TABLESTATS’);
      */

      DBMS_STATS.LOCK_PARTITION_STATS
      ( ownname     => 'BARS'
      , tabname     => p_tbl_nm
      , partname    => l_ptsn_nm );

    end if;

    dbms_application_info.set_client_info( null );

  end GATHER_TABLE_STATS;

  --
  --
  --
  procedure COPY_TABLE_STATS
  ( p_tbl_nm       in     nbur_ref_objects.object_name%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_rpt_dt       in     nbur_lst_objects.report_date%type
  , p_numrows      in     number default null
  ) is
    title     constant    varchar2(32) := $$PLSQL_UNIT||'.COPY_TABLE_STATS';
    l_ptsn_nm             varchar2(30);
    srec                  dbms_stats.statrec;
    datevals              dbms_stats.datearray;
    l_numrows             number;
    l_numblks             number;
    l_avgrlen             number;
    l_density             number;
    l_distcnt             number;
    l_nullcnt             number;
    l_avgclen             number;
    l_min_dt              date;
    l_max_dt              date;
  begin

    if ( p_kf Is Null )
    then
      null;
    else

/*
      копіювання статистики
      з субпартиції архівної    таблиці NBUR_DM_%_ARCH
      в партицію    оперативної таблиці NBUR_DM_%
      1) 
*/
      l_ptsn_nm := 'P_'||p_kf;

      dbms_application_info.set_client_info( 'Copy stats to "'||p_tbl_nm||'" partition "'||l_ptsn_nm||'".' );

      DBMS_STATS.GET_TABLE_STATS
      ( ownname  => 'BARS'
      , tabname  => p_tbl_nm
      , partname => l_ptsn_nm
      , numrows  => l_numrows
      , numblks  => l_numblks
      , avgrlen  => l_avgrlen
      );

      DBMS_STATS.SET_TABLE_STATS
      ( ownname  => 'BARS'
      , tabname  => p_tbl_nm
      , partname => l_ptsn_nm
      , numrows  => nvl(p_numrows,l_numrows)
      , numblks  => l_numblks
      , avgrlen  => l_avgrlen
      , force    => TRUE
      );

      DBMS_STATS.GET_COLUMN_STATS
      ( ownname  => 'BARS'
      , tabname  => p_tbl_nm
      , colname  => 'REPORT_DATE'
      , partname => l_ptsn_nm
      , distcnt  => l_distcnt
      , density  => l_density
      , nullcnt  => l_nullcnt
      , srec     => srec
      , avgclen  => l_avgclen
      );

      DBMS_STATS.CONVERT_RAW_VALUE( srec.minval, l_min_dt );
      DBMS_STATS.CONVERT_RAW_VALUE( srec.maxval, l_max_dt );

      bars_audit.info( title||': OLD min_dt='||to_char(l_min_dt,fmt_tm)||', max_dt='||to_char(l_max_dt,fmt_tm) );

      -- for number
      -- srec.minval := utl_raw.cast_from_number(5000);
      -- srec.maxval := utl_raw.cast_from_number(5999);

      -- for date
      datevals := DBMS_STATS.DATEARRAY( p_rpt_dt, p_rpt_dt );

      DBMS_STATS.PREPARE_COLUMN_VALUES
      ( srec     => srec
      , datevals => datevals
      );

      DBMS_STATS.CONVERT_RAW_VALUE( srec.minval, l_min_dt );
      DBMS_STATS.CONVERT_RAW_VALUE( srec.maxval, l_max_dt );

      bars_audit.info( title||': NEW min_dt='||to_char(l_min_dt,fmt_tm)||', max_dt='||to_char(l_max_dt,fmt_tm) );

      DBMS_STATS.SET_COLUMN_STATS
      ( ownname  => 'BARS'
      , tabname  => p_tbl_nm
      , partname => l_ptsn_nm
      , colname  => 'REPORT_DATE'
      , distcnt  => l_distcnt
      , density  => l_density
      , nullcnt  => l_nullcnt
      , avgclen  => l_avgclen
      , srec     => srec
      , force    => TRUE
      );

    end if;

  end COPY_TABLE_STATS;

  --
  --
  --
  procedure LOG_ERRORS
  ( p_err_msg      in     varchar2 default null
  , p_err_rec_id   out    number
  ) is
    l_recid               number(38);
  begin
    bars_audit.error( $$PLSQL_UNIT||': '|| p_err_msg || CHR(10) || dbms_utility.format_error_stack()
                                                     || CHR(10) || dbms_utility.format_error_backtrace()
                    , null, null, l_recid );
    p_err_rec_id := l_recid;
  end LOG_ERRORS;

  --
  --
  --
  procedure SET_OBJECT
  ( p_obj_nm       in     nbur_ref_objects.object_name%type
  , p_scm_nm       in     nbur_ref_objects.scheme%type      default 'BARS'
  , p_obj_tp       in     nbur_ref_objects.object_type%type default 'TABLE'
  , p_pcd_ins      in     nbur_ref_objects.proc_insert%type
  , p_pcd_upd      in     nbur_ref_objects.proc_update%type default null
  , p_pcd_del      in     nbur_ref_objects.proc_delete%type default null
  , p_obj_code     in     nbur_ref_objects.name_id_var%type
  , p_obj_id       out    nbur_ref_objects.id%type
  ) is
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.ADD_OBJECT';
  begin

    bars_audit.trace( '%s: Entry with ( obj_nm=%s, scm_nm=%s, obj_tp=%s, pcd_ins=%s ).'
                    , title, p_obj_nm, p_scm_nm, p_obj_tp, p_pcd_ins );

    select nvl(max(ID),0) + 1
      into p_obj_id
      from NBUR_REF_OBJECTS;

    begin

      Insert
        into NBUR_REF_OBJECTS
        ( ID, OBJECT_NAME, SCHEME, OBJECT_TYPE, PROC_INSERT, PROC_UPDATE, PROC_DELETE, NAME_ID_VAR )
      Values
        ( p_obj_id, p_obj_nm, p_scm_nm, p_obj_tp, p_pcd_ins, p_pcd_upd, p_pcd_del, p_obj_code );

      bars_audit.info( title || ': created new object #' || to_char(p_obj_id) );

    exception
      when DUP_VAL_ON_INDEX then

        update NBUR_REF_OBJECTS
           set SCHEME      = p_scm_nm
             , OBJECT_TYPE = p_obj_tp
             , PROC_INSERT = p_pcd_ins
             , PROC_UPDATE = p_pcd_upd
             , PROC_DELETE = p_pcd_del
             , NAME_ID_VAR = p_obj_code
         where OBJECT_NAME = p_obj_nm
     returning ID
          into p_obj_id;

        bars_audit.info( title || ': updated object #' || to_char(p_obj_id) );

    end;

    bars_audit.trace( '%s: Exit.', title );

  end SET_OBJECT;

  --
  --
  --
  procedure SET_OBJECT_DEPENDENCIES
  ( p_obj_id       in     nbur_lnk_object_object.object_id%type
  , p_obj_pid      in     nbur_lnk_object_object.object_pid%type
  ) is
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.SET_OBJ_DPND';
  begin

    bars_audit.trace( '%s: Entry with ( obj_id=%s, obj_pid=%s ).'
                    , title, to_char(p_obj_id), to_char(p_obj_pid) );

    if ( p_obj_pid Is Null )
    then -- видадення усіх залежностей для об`єкту

      delete NBUR_LNK_OBJECT_OBJECT
       where OBJECT_ID = p_obj_id;

      bars_audit.info( title || ': deleted new dependency for object #' || to_char(p_obj_id) );

    else -- внесення нової залежності для об`єкту

      begin

        insert
          into NBUR_LNK_OBJECT_OBJECT
             ( OBJECT_ID, OBJECT_PID )
        values
             ( p_obj_id, p_obj_pid );

        bars_audit.info( title || ': added new dependency for object #' || to_char(p_obj_id) );

      exception
        when DUP_VAL_ON_INDEX
        then null;
      end;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end SET_OBJECT_DEPENDENCIES;

  --
  --
  --
  procedure CHECK_OBJECT_DEPENDENCIES
  ( p_rpt_dt       in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_vrsn_id      in     nbur_lst_objects.version_id%type
  , p_obj_id       in     nbur_lst_objects.object_id%type
  ) is
  /**
  <b>CHECK_OBJECT_DEPENDENCIES</b> - Перевіка залежностей об'єктів
  %param p_rpt_dt      - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_vrsn_id     - Iдентифiкатор версії
  %param p_obj_id      - Iдентифiкатор об`єкту

  %version 1.0
  %usage   Перевіка наявності сформованих DM, що необхідні для формування
           згідно довідника залежностей об'єктів
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.CHK_OBJ_DPND';
    l_errmsg              varchar2(1000);
  begin

    bars_audit.trace( '%s: Entry with ( rpt_dt=%s, kf=%s, vrsn_id =%s, obj_id=%s ).'
                    , title, to_char(p_rpt_dt,fmt_dt), p_kf, to_char(p_vrsn_id), to_char(p_obj_id) );

    select LISTAGG( o.OBJECT_NAME, ', ' ) WITHIN GROUP ( order by o.ID )
      into l_errmsg
      from NBUR_LNK_OBJECT_OBJECT d
      join NBUR_REF_OBJECTS o
        on ( o.Id = d.OBJECT_PID )
      left
      join ( select OBJECT_ID
               from NBUR_LST_OBJECTS
              where REPORT_DATE = p_rpt_dt
                and ( p_kf = KF or p_kf Is Null )
                and VERSION_ID = p_vrsn_id
                and OBJECT_STATUS = 'FINISHED'
           ) l
        on ( l.OBJECT_ID = d.OBJECT_PID )
     where d.OBJECT_ID = p_obj_id
       and l.OBJECT_ID Is Null;

    if ( l_errmsg Is Not Null )
    then
      raise_application_error( -20666, 'Відсутні необхідні для формування DM: ' || l_errmsg );
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end CHECK_OBJECT_DEPENDENCIES;

  --
  --
  --
  procedure CHECK_OBJECT_DEPENDENCIES
  ( p_rpt_dt       in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_obj_id       in     nbur_lst_objects.object_id%type
  , p_prd_tp       in     nbur_ref_periods.period_type%type
  ) is
  /**
  <b>CHECK_OBJECT_DEPENDENCIES</b> - Перевіка залежностей об'єктів
  %param p_rpt_dt      - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_obj_id      - Iдентифiкатор об`єкту
  %param p_prd_tp      - Тип періоду

  %version 1.0
  %usage   Перевіка наявності сформованих DM, що необхідні для формування
           згідно довідника залежностей об'єктів
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.CHK_OBJ_DPND';
    l_errmsg              varchar2(1000);
  begin

    bars_audit.trace( '%s: Entry with ( rpt_dt=%s, kf=%s, obj_id=%s, prd_tp=%s ).'
                    , title, to_char(p_rpt_dt,fmt_dt), p_kf, to_char(p_obj_id), p_prd_tp );

    if ( l_errmsg Is Not Null )
    then
      raise_application_error( -20666, 'Відсутні необхідні для формування DM: ' || l_errmsg );
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end CHECK_OBJECT_DEPENDENCIES;

  ---------------------------------------------------------------------
  -- F_GET_OBJECT_ID_BY_NAME
  --
  --  Получение идентификатора объекта по его имени
  --
  function f_get_object_id_by_name
  ( p_object_name  in     nbur_ref_objects.object_name%type
  ) return number
    result_cache
  is
  begin

    begin

      select ID
        into l_object_id
        from NBUR_REF_OBJECTS
       where OBJECT_NAME = p_object_name;

    exception
      when NO_DATA_FOUND then
        LOG_ERRORS( 'not found ID for '||p_object_name, l_err_rec_id );
        l_object_id := null;
    end;

    return l_object_id;

  end f_get_object_id_by_name;

  ---------------------------------------------------------------------
  -- F_GET_OBJECT_NAME_BY_ID
  --
  --  Получение имени объекта по его идентификатору
  --
  ---------------------------------------------------------------------
  function f_get_object_name_by_id
  ( p_object_id      in     number
  ) return varchar2
    result_cache
  is
    l_object_name        nbur_ref_objects.object_name%type;
  begin
    begin
      select object_name
        into l_object_name
        from nbur_ref_objects
       where id = p_object_id;
    exception
      when no_data_found  then
        LOG_ERRORS( 'not found NAME for obj='||p_object_id, l_err_rec_id );
        l_object_name := null;
    end;

    return l_object_name;

  end f_get_object_name_by_id;

  ---------------------------------------------------------------------
  -- F_GET_LOADED_OBJECT_ID
  --
  --  Получение ID загруженного объекта по дате
  --
  ---------------------------------------------------------------------
  function f_get_version_object (p_object_id    in number,
                                 p_report_date  in date,
                                 p_kf           in varchar2
  )  return number
  is
    l_version_id       number;
  begin
      begin
          select version_id
          into l_version_id
          from nbur_lst_objects
          where object_id = p_object_id and
                report_date = p_report_date and
                (nvl(kf, p_kf) = p_kf or p_kf is null) and
                object_status in ('FINISHED', 'VALID');
      exception
          when no_data_found  then
              select max(version_id)
              into l_version_id
              from nbur_lst_objects
              where object_id = p_object_id and
                    report_date = p_report_date and
                    (nvl(kf, p_kf) = p_kf or p_kf is null);
      end;

      return l_version_id;
  exception
      when no_data_found  then
           LOG_ERRORS('not found VERSION for obj='||p_object_id||' for DAT='||to_char(p_report_date, fmt_dt), l_err_rec_id );
           return -1;
  end f_get_version_object;

  procedure P_UPDATE_ONE_OBJ_STATUS
  ( p_object_id    in     nbur_lst_objects.object_id%type
  , p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_status       in     nbur_lst_objects.object_status%type
  ) is
  begin

    if ( p_kf Is null )
    then

      update NBUR_LST_OBJECTS
         set FINISH_TIME   = nvl(FINISH_TIME,systimestamp)
           , OBJECT_STATUS = p_status
       where REPORT_DATE = p_report_date
         and OBJECT_ID   = p_object_id
         and VERSION_ID  = p_version_id;

    else

      update NBUR_LST_OBJECTS
         set FINISH_TIME   = nvl(FINISH_TIME,systimestamp)
           , OBJECT_STATUS = p_status
       where REPORT_DATE = p_report_date
         and KF          = p_kf
         and OBJECT_ID   = p_object_id
         and VERSION_ID  = p_version_id;

    end if;

  end P_UPDATE_ONE_OBJ_STATUS;

  ---
  -- FIXATION
  ---
  procedure FIXATION
  ( p_tbl_nm   in   tbl_nm_subtype
  ) is
  begin

    t_tbl_lst.EXTEND;
    t_tbl_lst(t_tbl_lst.last) := p_tbl_nm;

    bars_audit.trace( $$PLSQL_UNIT||'.FIXATION: table %s.', p_tbl_nm );

  end FIXATION;

  ---------------------------------------------------------------------
  -- P_START_LOAD_OBJECT
  --
  --  вставка инфо о начале процесса загрузки объекта
  --   в таблицу загруженных объектов
  --
  procedure P_START_LOAD_OBJECT
  ( p_object_id    in     nbur_lst_objects.object_id%type
  , p_object_name  in     nbur_ref_objects.object_name%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_start_time   in     nbur_lst_objects.start_time%type  default systimestamp
  )
  is
    title    constant     varchar2(100) := $$PLSQL_UNIT||'.START_LOAD_OBJECT('||p_object_name||')';
    --
    procedure SET_RCRD
    ( p_kf           in     nbur_lst_objects.kf%type
    ) is
    pragma autonomous_transaction;
    begin

      begin
        insert
          into NBUR_LST_OBJECTS
             ( REPORT_DATE, KF, OBJECT_ID, VERSION_ID, START_TIME, OBJECT_STATUS )
        values
             ( p_report_date, p_kf, p_object_id, p_version_id, p_start_time, 'RUNNING' );
      exception
        when DUP_VAL_ON_INDEX then
          if ( p_object_name in ('NBUR_DM_BALANCES_DAILY','NBUR_DM_BALANCES_MONTHLY') )
          then -- через рекурсивний виклик проц. наповнення перелічених вітрин після накопичення знімків балансу
            update NBUR_LST_OBJECTS
               set START_TIME  = p_start_time
             where REPORT_DATE = p_report_date
               and KF          = p_kf
               and VERSION_ID  = p_version_id
               and OBJECT_ID   = p_object_id;
          else
            bars_audit.error( title || dbms_utility.format_error_stack() );
          end if;
--      when OTHERS then
--        bars_audit.error( title || dbms_utility.format_error_stack() );
      end;

      commit;

    end SET_RCRD;
    ---
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    dbms_application_info.set_client_info( title );

    execute immediate 'alter session ENABLE PARALLEL DDL';
    execute immediate 'alter session SET DDL_LOCK_TIMEOUT=300';

    l_err_tag := to_char(p_report_date,'yyyymmdd') || '_' || p_kf || '_' || to_char(p_version_id,'FM00');

    --
    FIXATION( p_object_name );

    if ( p_kf Is Null )
    then -- for all KF

      execute immediate 'truncate table '||p_object_name;

      for i in ( select KF from MV_KF )
      loop

        SET_RCRD( i.KF );

      end loop;

    else -- for one KF

      SET_RCRD( p_kf );

      execute immediate 'alter table '||p_object_name||' truncate partition P_'||p_kf;

    end if;

    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    bars_audit.trace( '%s: Exit.', title );

  end P_START_LOAD_OBJECT;

  ----------------------------------------------------------------------
  -- P_FINISH_LOAD_OBJECT
  --
  --  запись инф. об окончании процесса загрузки объекта
  --  в таблицу загруженных объектов
  --
  procedure P_FINISH_LOAD_OBJECT
  ( p_object_id    in     number
  , p_version_id   in     number
  , p_report_date  in     date
  , p_kf           in     varchar2
  , p_rowcount     in     number
  , p_err_rec_id   in     number default null
  ) is
    title    constant     varchar2(64) := $$PLSQL_UNIT||'.FINISH_LOAD_OBJECT';
  begin

    bars_audit.trace( '%s: Entry with ( rpt_dt=%s, kf=%s, vrsn_id=%s, obj_id=%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf
                    , to_char(p_version_id), to_char(p_object_id) );

    if ( p_kf Is Null )
    then -- for all KF (in future)

      update NBUR_LST_OBJECTS
         set OBJECT_STATUS = 'INVALID'
       where REPORT_DATE = p_report_date
         and OBJECT_ID   = p_object_id
         and VERSION_ID  < p_version_id
         and OBJECT_STATUS <> 'BLOCKED';

      update NBUR_LST_OBJECTS
         set FINISH_TIME   = systimestamp
           , OBJECT_STATUS = case when p_err_rec_id > 0 then 'ERROR' else 'FINISHED' end
           , ROW_COUNT     = p_rowcount
           , ERR_REC_ID    = p_err_rec_id
       where REPORT_DATE = p_report_date
         and OBJECT_ID   = p_object_id
         and version_id  = p_version_id;

    else

      update NBUR_LST_OBJECTS
         set OBJECT_STATUS = 'INVALID'
       where REPORT_DATE = p_report_date
         and KF          = p_kf
         and OBJECT_ID   = p_object_id
         and VERSION_ID  < p_version_id
         and OBJECT_STATUS <> 'BLOCKED';

      update NBUR_LST_OBJECTS
         set FINISH_TIME   = systimestamp
           , OBJECT_STATUS = case when p_err_rec_id > 0 then 'ERROR' else 'FINISHED' end
           , ROW_COUNT     = p_rowcount
           , ERR_REC_ID    = p_err_rec_id
       where REPORT_DATE = p_report_date
         and KF          = p_kf
         and OBJECT_ID   = p_object_id
         and version_id  = p_version_id;

    end if;

    commit;

    dbms_application_info.set_client_info( null );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when others then
      LOG_ERRORS('for obj='||p_object_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
  end P_FINISH_LOAD_OBJECT;

  ---------------------------------------------------------------------
  -- P_LOAD_CUSTOMERS
  --
  --  заполнение таблицы параметров клиентов
  --  nbur_dm_customers, идентификатор объекта =1
  ---------------------------------------------------------------------
  procedure P_LOAD_CUSTOMERS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
    l_object_name       varchar2(100) := 'NBUR_DM_CUSTOMERS';
  begin

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object (l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    l_frst_yr_dt := add_months(trunc(p_report_date,'YYYY'), -12);

    if ( p_kf is null )
    then

       insert /*+ append */
        into NBUR_DM_CUSTOMERS
           ( REPORT_DATE, KF, CUST_ID, CUST_TYPE, CUST_CODE, CUST_NAME, CUST_ADR, OPEN_DATE,
             CLOSE_DATE, BRANCH, TAX_REG_ID, TAX_DST_ID, CRISK, CUST_PID, K030, K040, K041,
             K051, K060, K070, K072, K073, K074, K080, K081, K110, K111, K112 )
      select /*+ PARALLEL( 8 ) */
             p_report_date, c.KF
           , c.rnk, nvl(c.custtype, 0), c.okpo, coalesce(c.NMKK, subStr(c.NMK,1,38)), c.ADR
           , c.DATE_ON
           , case when ( c.DATE_OFF > p_report_date ) then null else c.DATE_OFF end as DATE_OFF
           , c.branch, c.c_reg, c.c_dst, nvl(c.crisk, '0'), RNKP,
             NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1') k030,
             lpad(NVL(to_char(c.country),'804'), 3, '0') k040,
             nvl(k2.k041, '0') k041, nvl(trim(c.sed),'00'),
             lpad(nvl(c.prinsider,'99'), 2, '0'),
             nvl(c.ise,'00000'), nvl(k7.k072,'0'), nvl(k7.k073,'0'), nvl(k7.k074,'0'),
             nvl(c.fs,'00'), nvl(k8.k081,'0'),
             nvl(c.ved,'00000'), nvl(k1.k111,'00'), nvl(k1.k112,'0')
        from CUSTOMER c
        left
        join ( select *
                from KL_K070
               where nvl(d_open, p_report_date) <= p_report_date
                 and ( d_close is null or d_close > p_report_date )
             ) k7
          on ( k7.k070 = c.ise )
        left
        join ( select *
                from KL_K080
               where nvl(d_open, p_report_date) <= p_report_date
                 and ( d_close is null or d_close > p_report_date )
             ) k8
          on ( k8.k080 = c.fs )
        left
        join ( select *
                from KL_K110
               where nvl(d_open, p_report_date) <= p_report_date
                 and ( d_close is null or d_close > p_report_date )
             ) k1
          on ( k1.k110 = c.ved )
        left
        join ( select *
                 from kl_k040
                where nvl(d_open, p_report_date) <= p_report_date
                  and ( d_close is null or d_close > p_report_date )
             ) k2
          on ( k2.k040 = nvl(lpad(to_char(c.country), 3,'0'),'804') )
       where lnnvl( c.DATE_OFF < l_frst_yr_dt ) -- без клієнтів закритих в попередньому році
      ;

    else

      insert /* append */
        into NBUR_DM_CUSTOMERS
           ( REPORT_DATE, KF, CUST_ID, CUST_TYPE, CUST_CODE, CUST_NAME, CUST_ADR, OPEN_DATE,
             CLOSE_DATE, BRANCH, TAX_REG_ID, TAX_DST_ID, CRISK, CUST_PID, K030, K040, K041,
             K051, K060, K070, K072, K073, K074, K080, K081, K110, K111, K112 )
      select /*+ PARALLEL( 4 ) */
             p_report_date, c.KF
           , c.rnk, nvl(c.custtype, 0), c.okpo, coalesce(c.NMKK, subStr(c.NMK,1,38)), c.ADR
           , c.DATE_ON
           , case when ( c.DATE_OFF > p_report_date ) then null else c.DATE_OFF end as DATE_OFF
           , c.branch, c.c_reg, c.c_dst, nvl(c.crisk, '0'), RNKP,
             NVL(to_char(2 - MOD(c.CODCAGENT, 2)), '1')     K030,
             lpad(NVL(to_char(c.country),'804'), 3,'0')     K040,
             nvl(k2.k041, '0')                              K041
           , nvl(trim(c.sed),'00')                          K051
           , lpad(nvl(c.prinsider,'99'), 2, '0')            K060
           , nvl(c.ise,'00000') K070
           , nvl(k7.k072,'0')   K072
           , nvl(k7.k073,'0')   K073
           , nvl(k7.k074,'0')   K074
           , nvl(c.FS,'00')     K080
           , nvl(k8.k081,'0')   K081
           , nvl(c.VED,'00000') K110
           , nvl(k1.k111,'00')  K111
           , nvl(k1.k112,'0')   K112
        from CUSTOMER c
        left
        join ( select *
                from KL_K070
               where nvl(d_open, p_report_date) <= p_report_date
                 and ( d_close is null or d_close > p_report_date )
             ) k7
          on ( k7.k070 = c.ise )
        left
        join ( select *
                from KL_K080
               where nvl(d_open, p_report_date) <= p_report_date
                 and ( d_close is null or d_close > p_report_date )
             ) k8
          on ( k8.k080 = c.fs )
        left
        join ( select *
                from KL_K110
               where nvl(d_open, p_report_date) <= p_report_date
                 and ( d_close is null or d_close > p_report_date )
             ) k1
          on ( k1.k110 = c.ved )
        left
        join ( select *
                 from kl_k040
                where nvl(d_open, p_report_date) <= p_report_date
                  and ( d_close is null or d_close > p_report_date )
             ) k2
          on ( k2.k040 = nvl(lpad(to_char(c.country), 3,'0'),'804') )
       where c.KF  = p_kf
         and lnnvl( c.DATE_OFF < l_frst_yr_dt ) -- без клієнтів закритих в попередньому році
      ;

    end if;

    l_rowcount := sql%rowcount;

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    ---
    -- till procedure PARSING_QUEUE_OBJECTS is not finished
    ---
    if ( REQUIRED_GATHER_STATS( l_object_name, p_kf, l_rowcount ) )
    then

      GATHER_TABLE_STATS
      ( p_tbl_nm   => l_object_name
      , p_kf       => p_kf );

    end if;

  exception
    when OTHERS then
      LOG_ERRORS( l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end p_load_customers;

  ---------------------------------------------------------------------
      -- P_LOAD_ACCOUNTS
      --
      --  заполнение таблицы параметров счетов
      --  nbur_showcase_accounts, идентификатор объекта =2
  ---------------------------------------------------------------------
  procedure P_LOAD_ACCOUNTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
    l_nbuc                varchar2(100);
    l_object_name         varchar2(100) := 'NBUR_DM_ACCOUNTS';
  begin

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    l_frst_yr_dt := trunc(p_report_date,'YYYY');

    if ( p_kf is null )
    then

      insert /*+ APPEND */
        into NBUR_DM_ACCOUNTS
           ( REPORT_DATE, KF, ACC_ID, ACC_NUM, ACC_NUM_ALT, ACC_TYPE, BRANCH, KV,
             OPEN_DATE, CLOSE_DATE, MATURITY_DATE, CUST_ID, ACC_PID, LIMIT, PAP, VID, BLC_CODE_DB, BLC_CODE_CR, NBS,
             OB22, R011, R012, R013, R016, R030, R031, R032, R033, R034, S180, S181, S183, S240, S580, NBUC, B040 )
      select p_report_date, c.kf, c.acc, c.nls, c.nlsalt, c.TIP
           , c.branch, c.kv, c.daos, c.dazs, c.mdate, c.rnk, c.ACCC, c.lim, c.PAP, c.VID, c.BLKD, c.BLKK, c.NBS
           , c.ob22, c.r011, c.r012, c.r013, c.R016, c.R030, r.R031, r.R032, r.R033, r.R034, c.S180
           , NVL(K.S181, '1') S181, NVL(K.S183, '1') S183
           , c.S240, c.S580, c.NBUC, c.B040
        from ( select /*+ PARALLEL( 8 ) LEADING( a ) USE_HASH( a s ) */
                      a.KF,
                      a.ACC,
                      a.NLS,
                      a.NLSALT,
                      nvl(a.TIP, 'ODB') tip,
                      a.branch,
                      a.KV,
                      a.DAOS,
                      case when ( a.DAZS > p_report_date ) then null else a.DAZS end as DAZS,
                      a.MDATE,
                      a.RNK,
                      a.ACCC,
                      a.lim,
                      nvl(a.PAP, '3') pap,
                      a.VID,
                      a.BLKD,
                      a.BLKK,
                      a.NBS,
                      nvl(a.OB22, '00') ob22,
                      NVL (s.R011, '0') R011,
                      case
                        when a.nbs like '1__6' or
                             a.nbs like '2__6' and a.nbs not in ('2526', '2546', '2606', '2806', '2906') or
                             a.nbs like '3__6' and a.nbs not in ('3006', '3106', '3906')
                        then 'C'
                        when a.tip = 'SNA'
                        then '4'
                        when a.nbs = '2620' and nvl(a.pap, '3') = '2' and nvl (s.r013, '0') = '1'
                        then '2'
                        when a.nbs = '2620' and nvl(a.pap, '3') = '2' and nvl (s.r013, '0') = '2'
                        then '6'
                        when a.nbs in ('2630', '2635') and nvl(a.pap, '3') = '2'
                        then '2'
                        when a.nbs in ('1890', '2890', '3590', '3599') and nvl(a.pap, '3') = '2'
                        then 'A'
                        else nvl(s.R012, '0')
                      end R012,
                      NVL(s.R013, '0' ) R013,
                      NVL(s.R016, '00') R016,
                      to_char(a.KV,'FM000') R030,
                      nvl(trim(S.S180), '0') S180,
                      nvl(trim(S.S240), '0') S240,
                      NVL(s.s580, '9') S580,
                      b.OBL as NBUC,
                      lpad(nvl(trim(b.b040), '0'), 20, '0') b040
                 FROM ACCOUNTS a
                 JOIN NBUR_QUEUE_OBJECTS q
                   ON ( q.KF = a.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
                 LEFT OUTER
                 JOIN SPECPARAM s
                   ON ( s.KF = a.KF and s.ACC = a.ACC )
                 JOIN BRANCH b
                   ON ( b.BRANCH = a.BRANCH )
                WHERE a.NBS IS NOT NULL
                  and regexp_like(a.NLS,'^(([1-7,9])|(86([1][0,5,8]|[5][1,2,8]))|(899(8|9)))')
                  and lnnvl( a.DAZS < l_frst_yr_dt ) -- без рахунків закритих в попередньому році
             ) c
        left outer
        join ( select S180, S181, S183
                 from KL_S180
                where nvl(DATA_O, p_report_date) <= p_report_date
                  and ( DATA_C is null or
                        DATA_C >= p_report_date + 1 )
             ) k
          on ( k.S180 = c.S180)
        left outer
        join KL_R030 r
          on ( r.R030 = c.R030 );

    else

      insert /* APPEND */
        into NBUR_DM_ACCOUNTS
           ( REPORT_DATE, KF, ACC_ID, ACC_TYPE, KV, BRANCH
           , ACC_NUM, ACC_NUM_ALT, NBS, OB22, OB22_ALT, ACC_ALT_DT
           , OPEN_DATE, CLOSE_DATE, MATURITY_DATE, CUST_ID, ACC_PID, LIMIT, PAP, VID, BLC_CODE_DB, BLC_CODE_CR
           , R011, R012, R013, R016, R030, R031, R032, R033, R034, S180, S181, S183, S240, S580, NBUC, B040 )
      select p_report_date, c.KF, c.ACC, c.TIP, c.KV, c.BRANCH
           , case when p_report_date < c.DAT_ALT then c.NLSALT             else c.NLS      end as ACC_NUM
           , case when p_report_date < c.DAT_ALT then null                 else c.NLSALT   end as ACC_NUM_ALT
           , case when p_report_date < c.DAT_ALT then SubStr(c.NLSALT,1,4) else c.NBS      end as NBS
           , case when p_report_date < c.DAT_ALT then nvl(c.OB22_ALT, '00')  else c.OB22     end as OB22
           , case when p_report_date < c.DAT_ALT then null                 else c.OB22_ALT end as OB22_ALT
           , case when p_report_date < c.DAT_ALT then null                 else c.DAT_ALT  end as ACC_ALT_DT
           , c.daos, c.dazs, c.mdate, c.rnk, c.ACCC, c.lim, c.PAP, c.VID, c.BLKD, c.BLKK
           , c.R011, c.r012, c.r013, c.R016, c.R030, r.R031, r.R032, r.R033, r.R034, c.S180
           , NVL(K.S181, '1') S181, NVL(K.S183, '1') S183
           , c.S240, c.S580, c.NBUC, c.B040
        from ( select /*+ PARALLEL( 4 ) LEADING( a ) USE_HASH( a s ) */
                      a.KF,
                      a.ACC,
                      a.NLS,
                      a.NLSALT,
                      a.DAT_ALT,
                      nvl(a.TIP, 'ODB') tip,
                      a.branch,
                      a.KV,
                      a.DAOS,
                      case when ( a.DAZS > p_report_date ) then null else a.DAZS end as DAZS,
                      a.MDATE,
                      a.RNK,
                      a.ACCC,
                      a.lim,
                      nvl(a.PAP, '3') pap,
                      a.VID,
                      a.BLKD,
                      a.BLKK,
                      a.NBS,
                      nvl(a.OB22, '00') ob22,
                      NVL(s.R011, '0' ) R011,
                      case
                        when a.nbs like '1__6' or
                             a.nbs like '2__6' and a.nbs not in ('2526', '2546', '2606', '2806', '2906') or
                             a.nbs like '3__6' and a.nbs not in ('3006', '3106', '3906')
                        then 'C'
                        when a.tip = 'SNA'
                        then '4'
                        when a.nbs = '2620' and nvl(a.pap, '3') = '2' and nvl (s.r013, '0') = '1'
                        then '2'
                        when a.nbs = '2620' and nvl(a.pap, '3') = '2' and nvl (s.r013, '0') = '2'
                        then '6'
                        when a.nbs in ('2630', '2635') and nvl(a.pap, '3') = '2'
                        then '2'
                        when a.nbs in ('1890', '2890', '3590', '3599') and nvl(a.pap, '3') = '2'
                        then 'A'
                        else nvl(s.R012, '0')
                      end R012,
                      NVL(s.R013, '0' ) R013,
                      NVL(s.R016, '00') R016,
                      to_char(a.KV,'FM000') R030,
                      nvl(trim(S.S180), '0') S180,
                      nvl(trim(S.S240), '0') S240,
                      NVL(s.s580, '9') S580,
                      s.OB22_ALT,
                      b.OBL as NBUC,
                      lpad(nvl(trim(b.b040), '0'), 20, '0') b040
                 from ACCOUNTS a
                 left outer
                 join SPECPARAM s
                   on ( s.KF = a.KF and s.ACC = a.ACC )
                 join BRANCH   b
                   on ( a.BRANCH = b.BRANCH )
                where a.KF = p_kf
                  and a.NBS IS NOT NULL
                  and regexp_like(a.NLS,'^(([1-7,9])|(86([1][0,5,8]|[5][1,2,8]))|(899(8|9)))')
                  and lnnvl( a.DAZS < l_frst_yr_dt ) -- без рахунків закритих в попередньому році
             ) c
        left outer
        join ( select S180, S181, S183
                 from KL_S180
                where nvl(DATA_O, p_report_date) <= p_report_date
                  and ( DATA_C is null or
                        DATA_C >= p_report_date + 1 )
             ) k
          on ( k.S180 = c.S180)
        left outer
        join KL_R030 r
          on ( r.R030 = c.R030 );

    end if;

    l_rowcount := sql%rowcount;

    p_finish_load_object(l_object_id, p_version_id, p_report_date, p_kf, l_rowcount);

    ---
    -- till procedure PARSING_QUEUE_OBJECTS is not finished
    ---
    if ( REQUIRED_GATHER_STATS( l_object_name, p_kf, l_rowcount ) )
    then

      GATHER_TABLE_STATS
      ( p_tbl_nm   => l_object_name
      , p_kf       => p_kf );

    end if;

  exception
    when others then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end p_load_accounts;

  --
  -- check report date on the bank day
  --
  function CHK_RPT_DT_ON_BANK_DAY
  ( p_rpt_dt       in     fdat.fdat%type
  ) return boolean
  result_cache
  is
    l_is_bday             number(1);
  begin

    -- перевірка наявності дати в списку банківських днів
    begin
      select 1
        into l_is_bday
        from FDAT
       where FDAT = p_rpt_dt;
    exception
      when NO_DATA_FOUND then
        l_is_bday := 0;
    end;

    -- перевірка на відсутність дати в списку календарних днів
    if ( l_is_bday = 1 )
    then
      begin
        select 0
          into l_is_bday
          from HOLIDAY
         where HOLIDAY = p_rpt_dt
           and KV      = 980;
      exception
        when NO_DATA_FOUND then
          l_is_bday := 1;
      end;
    else
      null;
    end if;

    return case when ( l_is_bday = 1 ) then True else False end;

  end CHK_RPT_DT_ON_BANK_DAY;

  --
  -- Формування щоденного знімку балансу
  --
  procedure CRT_DLY_SNPST
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  ) is
    title     constant    varchar2(64)  := $$PLSQL_UNIT||'.CRT_DLY_SNPST';
    l_errmsg              varchar2(512);
    l_wait_tm             number(3) := 600;
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf );

    if ( p_kf is null )
    then -- запуск формування щоденного знімку балансу для всіх KF

      for s in ( select q.KF
                   from NBUR_QUEUE_OBJECTS q
                  where q.REPORT_DATE = p_report_date
                    and q.ID          = l_object_id
               )
      loop

        CRT_DLY_SNPST
        ( p_report_date => p_report_date
        , p_kf          => s.KF );

      end loop;

    else

      -- Перевірка звітної дати на БАНКІВСЬКИЙ ДЕНЬ
      if ( CHK_RPT_DT_ON_BANK_DAY( p_report_date ) )
      then

        BC.SUBST_MFO( p_kf );

        bars_audit.trace( '%s: run SYNC_DLY_SNAP ( %s ).', title, to_char(p_report_date,fmt_dt) );

        BARS_UTL_SNAPSHOT.SYNC_SNAP( p_report_date );

        BC.HOME;

      else
        bars_audit.error( title||': дата '||to_char(p_report_date,fmt_dt)||' не є банківським днем!' );
        raise_application_error( -20666, 'Звітна дата '||to_char(p_report_date,fmt_dt)||' не є банківським днем.' );
      end if;

    end if;

  end CRT_DLY_SNPST;

  ---------------------------------------------------------------------
      -- P_LOAD_DAILYBAL
      --
      --  заполнение таблицы дневных остатков/оборотов
      --  nbur_dm_daily_balances, идентификатор объекта =3
  ---------------------------------------------------------------------
  procedure P_LOAD_DAILYBAL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_DAILYBAL';
    l_object_name         varchar2(100) := 'NBUR_DM_BALANCES_DAILY';
  begin

    l_object_id := f_get_object_id_by_name(l_object_name);

    if ( p_report_date = DAT_NEXT_U( GL.GBD(), -1 ) )
    then -- за попередный банківський день знімки переформовуємо безумовно перед перенесенням їх у вітрину
      CRT_DLY_SNPST
      ( p_report_date => p_report_date
      , p_kf          => p_kf );
    else
      null;
    end if;

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    if ( p_kf is null )
    then

      insert /*+ APPEND */
        into NBUR_DM_BALANCES_DAILY
           ( REPORT_DATE, KF, ACC_ID, CUST_ID, VOST, DOS, KOS, OST, VOSTQ, DOSQ, KOSQ, OSTQ )
      select /*+ PARALLEL( 8 ) */ p_report_date, b.KF, b.ACC, b.RNK,
             b.OST + b.DOS - b.KOS,  b.DOS,  b.KOS,  b.OST,
             b.OSTQ+ b.DOSQ- b.KOSQ, b.DOSQ, b.KOSQ, b.OSTQ
        from SNAP_BALANCES b
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = b.KF and q.REPORT_DATE = b.FDAT and q.ID = l_object_id )
       where b.FDAT = p_report_date;

    else

      insert /* APPEND */
        into NBUR_DM_BALANCES_DAILY
           ( REPORT_DATE, KF, ACC_ID, CUST_ID, VOST, DOS, KOS, OST, VOSTQ, DOSQ, KOSQ, OSTQ )
      select /*+ PARALLEL( 4 ) */ p_report_date, kf, acc, rnk,
             ost +dos -kos,  dos,  kos,  ost,
             ostq+dosq-kosq, dosq, kosq, ostq
        from SNAP_BALANCES
       where FDAT = p_report_date
         and KF = p_kf;

    end if;

    l_rowcount := sql%rowcount;

    if ( l_rowcount = 0 and p_report_date < DAT_NEXT_U( GL.GBD(), -1 ) )
    then -- відсутній знімок балансу

      if ( l_attempt_num = 1 )
      then

        l_attempt_num := l_attempt_num + 1;

        --
        CRT_DLY_SNPST
        ( p_report_date => p_report_date
        , p_kf          => p_kf );

        --
        P_LOAD_DAILYBAL
        ( p_report_date => p_report_date
        , p_kf          => p_kf
        , p_version_id  => p_version_id );

      else

        LOG_ERRORS( 'retrying create snapshot for p_report_date='||to_char(p_report_date, fmt_dt)||' and p_kf='||p_kf, l_err_rec_id );

      end if;

    else

      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

      ---
      -- till procedure PARSING_QUEUE_OBJECTS is not finished
      ---
      if ( REQUIRED_GATHER_STATS( l_object_name, p_kf, l_rowcount ) )
      then

        GATHER_TABLE_STATS
        ( p_tbl_nm   => l_object_name
        , p_kf       => p_kf );

      end if;

    end if;

  exception
    when others then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end p_load_dailybal;

  --
  -- Формування щомісячного знімку балансу
  --
  procedure CRT_MO_SNPST
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  ) is
    title     constant    varchar2(64)  := $$PLSQL_UNIT||'.CRT_MO_SNPST';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf );

    if ( p_kf is null )
    then -- запуск формування щоденного знімку балансу для всіх KF

      -- temporarry (until BARS_SNAPSHOT.CREATE_MONTHLY_SNAPSHOT can`t run by all KF in parallel)
      for s in ( select q.KF
                   from NBUR_QUEUE_OBJECTS q
                  where q.REPORT_DATE = p_report_date
                    and q.ID          = l_object_id
               )
      loop

        CRT_MO_SNPST
        ( p_report_date => p_report_date
        , p_kf          => s.KF );

      end loop;

    else

        BC.SUBST_MFO( p_kf );

        bars_audit.trace( '%s: run SYNC_MO_SNAP ( %s ).', title, to_char(p_report_date,fmt_dt) );

        BARS_SNAPSHOT.CREATE_MONTHLY_SNAPSHOT
        ( p_snapshot_dt => trunc(p_report_date,'MM')
        , p_auto_daily  => true );

        BC.HOME;

    end if;

  end CRT_MO_SNPST;

  ---------------------------------------------------------------------
  -- P_LOAD_MONTHBAL
  --
  --  заполнение таблицы остатков и месячных оборотов
  --  nbur_dm_monthly_balances, идентификатор объекта =4
  ---------------------------------------------------------------------
  procedure P_LOAD_MONTHBAL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
    l_object_name         varchar2(100) := 'NBUR_DM_BALANCES_MONTHLY';
  begin

    l_object_id := f_get_object_id_by_name(l_object_name);

    if ( trunc(sysdate) <= dat_next_u(trunc(sysdate,'MM'),6) )
    then -- в період формування коригуючих проводок (по 6-й роб. день міс.) знімки переформовуємо безумовно
      CRT_MO_SNPST
      ( p_report_date => p_report_date
      , p_kf          => p_kf );
    end if;

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    if ( p_kf is null )
    then

      insert /*+ APPEND */
        into NBUR_DM_BALANCES_MONTHLY
           ( REPORT_DATE, KF, ACC_ID, CUST_ID, DOS,
             KOS, OST, DOSQ, KOSQ, OSTQ, CRDOS, CRKOS, CRDOSQ, CRKOSQ, CUDOS, CUKOS,
             CUDOSQ, CUKOSQ, ADJ_BAL, ADJ_BAL_UAH )
      select /*+ PARALLEL( 8 ) */ p_report_date, b.KF,
             b.ACC, b.RNK, b.DOS, b.KOS, b.OST, b.DOSQ, b.KOSQ, b.OSTQ,
             b.CRDOS, b.CRKOS, b.CRDOSQ, b.CRKOSQ, b.CUDOS, b.CUKOS, b.CUDOSQ, b.CUKOSQ,
             b.OST - b.CRDOS + b.CRKOS, b.OSTQ - b.CRDOSQ + b.CRKOSQ
        from AGG_MONBALS b
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = b.KF and q.REPORT_DATE = b.FDAT and q.ID = l_object_id )
       where b.FDAT = trunc(p_report_date,'mm');

    else

      insert /* APPEND */
        into NBUR_DM_BALANCES_MONTHLY
           ( report_date, kf, acc_id, cust_id, dos,
             kos, ost, dosq, kosq, ostq, crdos, crkos, crdosq, crkosq, cudos, cukos,
             cudosq, cukosq, adj_bal, adj_bal_uah)
      select /*+ PARALLEL( 4 )*/ p_report_date, kf,
             acc, rnk, dos, kos, ost, dosq, kosq, ostq,
             crdos, crkos, crdosq, crkosq, cudos, cukos, cudosq, cukosq,
             ost - crdos + crkos, ostq - crdosq + crkosq
        from AGG_MONBALS
       where FDAT = trunc(p_report_date,'mm')
         and kf = p_kf;

    end if;

    l_rowcount := sql%rowcount;

    if ( l_rowcount = 0 and trunc(sysdate) > dat_next_u(trunc(sysdate,'MM'),6) )
    then -- відсутній знімок балансу

      --
      CRT_MO_SNPST
      ( p_report_date => p_report_date
      , p_kf          => p_kf );

      --
      P_LOAD_MONTHBAL
      ( p_report_date => p_report_date
      , p_kf          => p_kf
      , p_version_id  => p_version_id );

    else

      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

      ---
      -- till procedure PARSING_QUEUE_OBJECTS is not finished
      ---
      if ( REQUIRED_GATHER_STATS( l_object_name, p_kf, l_rowcount ) )
      then

        GATHER_TABLE_STATS
        ( p_tbl_nm   => l_object_name
        , p_kf       => p_kf );

      end if;

    end if;

  exception
    when others then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end p_load_monthbal;

  --------------------------------------------------------------------------------
  --
  -- LOAD_BAL_YEARLY
  --
  procedure LOAD_BAL_YEARLY
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_BAL_YEARLY</b> - наповнення даними вітрини річних залишків та оборотів по рахунка АБС
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини річних залишків та оборотів
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_ADL_DOC_RPT_DTL';
    l_object_name         varchar2(100) := 'NBUR_DM_BALANCES_YEARLY';
  begin

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf );

    if ( p_kf is null )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_BALANCES_YEARLY
           ( REPORT_DATE, KF, ACC_ID, CUST_ID, BAL, BAL_UAH
           , DOS, DOSQ, KOS, KOSQ
           , CRDOS, CRDOSQ, CRKOS, CRKOSQ, CUDOS, CUDOSQ, CUKOS, CUKOSQ, ADJ_BAL, ADJ_BAL_UAH )
      select /*+ PARALLEL( 8 ) */ p_report_date, b.KF
           , b.ACC,   b.RNK,    b.OST,   b.OSTQ
           , b.DOS,   b.DOSQ,   b.KOS,   b.KOSQ
           , b.CRDOS, b.CRDOSQ, b.CRKOS, b.CRKOSQ
           , b.CUDOS, b.CUDOSQ, b.CUKOS, b.CUKOSQ
           , ( b.OST  - b.CRDOS  + b.CRKOS  ) as ADJ_BAL
           , ( b.OSTQ - b.CRDOSQ + b.CRKOSQ ) as ADJ_BAL_UAH
        from AGG_YEARBALS b
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = b.KF and q.REPORT_DATE = b.FDAT and q.ID = l_object_id )
       where b.FDAT = trunc(p_report_date,'YY');

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_BALANCES_YEARLY
           ( REPORT_DATE, KF, ACC_ID, CUST_ID, BAL, BAL_UAH
           , DOS,   DOSQ,   KOS,   KOSQ
           , CRDOS, CRDOSQ, CRKOS, CRKOSQ
           , CUDOS, CUDOSQ, CUKOS, CUKOSQ
           , ADJ_BAL, ADJ_BAL_UAH )
      select /*+ PARALLEL( 4 ) */ p_report_date, KF
           , ACC,   RNK,    OST,   OSTQ
           , DOS,   DOSQ,   KOS,   KOSQ
           , CRDOS, CRDOSQ, CRKOS, CRKOSQ
           , CUDOS, CUDOSQ, CUKOS, CUKOSQ
           , ( OST  - CRDOS  + CRKOS  ) as ADJ_BAL
           , ( OSTQ - CRDOSQ + CRKOSQ ) as ADJ_BAL_UAH
        from AGG_YEARBALS
       where FDAT = trunc(p_report_date,'YY')
         and KF   = p_kf;

    end if;

    l_rowcount := sql%rowcount;

    if ( l_rowcount = 0 )
    then -- відсутній знімок балансу
      null;
    else
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );
    end if;

  exception
    when others then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_BAL_YEARLY;

  --
  --
  --
  procedure P_LOAD_TRANSACTIONS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>P_LOAD_TRANSACTIONS</b> - наповнення даними вітрини фінансових транзакцій (opldok)
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини даних фін. транзакцій
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_TRANSACTIONS';
    l_object_name         varchar2(100) := 'NBUR_DM_TRANSACTIONS';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_TRANSACTIONS
           ( REPORT_DATE, KF, REF, SOS, STMT, TT, TXT, KV, BAL, BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR )
      select /*+ PARALLEL( 16 ) */ d.FDAT, d.KF, d.REF, d.SOS, d.STMT, d.TT, d.TXT, d.KV, d.S, d.SQ
           , d.CUST_ID as CUST_ID_DB, d.ACC as ACC_ID_DB, d.ACC_NUM as ACC_NUM_DB, d.ACC_TYPE as ACC_TYPE_DB, d.nbs as R020_DB, d.ob22 as OB22_DB, d.NBUC as NBUC_DB
           , k.CUST_ID as CUST_ID_CR, k.ACC as ACC_ID_CR, k.ACC_NUM as ACC_NUM_CR, k.ACC_TYPE as ACC_TYPE_CR, k.nbs as R020_CR, k.OB22 as OB22_CR, k.NBUC as NBUC_CR
        from ( select p.REF, p.TT, p.DK, p.ACC, p.FDAT, p.S, p.SQ, p.TXT, p.STMT, p.SOS, p.KF
                    , a.ACC_NUM, a.KV, a.NBS, a.OB22, a.ACC_TYPE, a.CUST_ID, a.NBUC
                 from OPLDOK p
                 join NBUR_QUEUE_OBJECTS q
                   on ( q.KF = p.KF and q.REPORT_DATE = p.FDAT and q.ID = l_object_id )
                 join NBUR_DM_ACCOUNTS a
                   on ( a.KF = p.KF AND a.ACC_ID = p.ACC )
                where p.FDAT = p_report_date
                  and p.DK = 0
             ) d
        join ( select p.REF, p.TT, p.DK, p.ACC, p.FDAT, p.S, p.SQ, p.TXT, p.STMT, p.SOS, p.KF
                    , a.ACC_NUM, a.KV, a.NBS, a.OB22, a.ACC_TYPE, a.CUST_ID, a.NBUC
                 from OPLDOK p
                 join NBUR_QUEUE_OBJECTS q
                   on ( q.KF = p.KF and q.REPORT_DATE = p.FDAT and q.ID = l_object_id )
                 join NBUR_DM_ACCOUNTS a
                   on ( a.KF = p.KF AND a.ACC_ID = p.ACC )
                where p.fdat = p_report_date
                  and p.DK = 1
             ) k
          on ( k.KF = d.KF AND k.REF = d.REF AND k.STMT = d.STMT );

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_TRANSACTIONS
           ( REPORT_DATE, KF, REF, STMT, SOS, TT, TXT, KV, BAL, BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR )
      select /*+ ORDERED USE_HASH( d k ) */ p_report_date, p_kf, d.REF, d.STMT, d.SOS, d.TT, d.TXT, d.KV, d.S, d.SQ
           , d.CUST_ID as CUST_ID_DB, d.ACC as ACC_ID_DB, d.ACC_NUM as ACC_NUM_DB, d.ACC_TYPE as ACC_TYPE_DB, d.nbs as R020_DB, d.ob22 as OB22_DB, d.NBUC as NBUC_DB
           , k.CUST_ID as CUST_ID_CR, k.ACC as ACC_ID_CR, k.ACC_NUM as ACC_NUM_CR, k.ACC_TYPE as ACC_TYPE_CR, k.nbs as R020_CR, k.OB22 as OB22_CR, k.NBUC as NBUC_CR
        from ( select/*+ FULL( a ) USE_HASH( a p ) */ p.REF, p.STMT, p.ACC
                    , p.SOS, p.TT, p.TXT, p.S, p.SQ
                    , a.ACC_NUM, a.KV, a.NBS, a.OB22, a.ACC_TYPE, a.CUST_ID, a.NBUC
                 from OPLDOK p
                 join NBUR_DM_ACCOUNTS a
                   on ( a.KF = p.KF AND a.ACC_ID = p.ACC )
                where p.fdat = p_report_date
                  and p.KF = p_kf
                  and p.SOS = 5
                  and p.DK = 0
             ) d
        join ( select /*+ FULL( a ) USE_HASH( a p ) */ p.REF, p.STMT, p.ACC
                    , a.ACC_NUM, a.KV, a.NBS, a.OB22, a.ACC_TYPE, a.CUST_ID, a.NBUC
                 from OPLDOK p
                 join NBUR_DM_ACCOUNTS a
                   on ( a.KF = p.KF AND a.ACC_ID = p.ACC )
                where p.fdat = p_report_date
                  and p.KF = p_kf
                  and p.SOS = 5
                  and p.DK = 1
             ) k
          on ( k.REF = d.REF AND k.STMT = d.STMT );

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    ---
    -- till procedure PARSING_QUEUE_OBJECTS is not finished
    ---
    if ( REQUIRED_GATHER_STATS( l_object_name, p_kf, l_rowcount ) )
    then

      GATHER_TABLE_STATS
      ( p_tbl_nm   => l_object_name
      , p_kf       => p_kf );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end P_LOAD_TRANSACTIONS;

  --
  --
  --
  procedure P_LOAD_BALANCES_R013
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>P_LOAD_BALANCES_R013</b> - наповнення даними вітрини
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини даних
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_BALANCES_R013';
    l_object_name         varchar2(100) := 'NBUR_DM_BALANCES_DLY_R013';
    l_datz                date          := p_report_date + 1;

    l_start_time        timestamp;
  begin
    l_start_time := systimestamp;

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object (l_object_id, l_object_name, p_version_id, p_report_date, p_kf, l_start_time );

    delete from NBUR_TMP_LST_R020;

    insert into NBUR_TMP_LST_R020
    SELECT r020
      FROM kl_r020
     WHERE trim(prem) = 'КБ'
       AND LOWER(txt) LIKE '%нарах%доход%'
       AND d_open between TO_DATE ('01011997', 'ddmmyyyy') and l_datz
       and ( d_close is null or
             d_close >= l_datz )
       and r020 in ( select r020
                       from kod_r020
                      where a010 in ('C5','A7')
                        and d_open between TO_DATE('01011997', 'ddmmyyyy') and l_datz
                        and ( d_close is null or
                              d_close >= l_datz )
                   )
       and r020 in ( select r020
                       from kl_r013
                      where d_open between TO_DATE('01011997', 'ddmmyyyy') and l_datz
                        and ( d_close is null or
                              d_close >= l_datz )
                   );

    if p_kf Is Null
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_BALANCES_DLY_R013
           ( REPORT_DATE, KF, ACC_ID, ACC_TYPE, R013, R020, OB22, R030, BAL, BAL_UAH, R013_CLC )
        select dat, kf, acc_id, tip, r013_old, r020, ob22, r030, bal, bal_uah, r013
        from (
        select dat, kf, acc_id, ob22, tip, r013 r013_old,
            f_nbur_ret_r013 (dat, r020, r030, r013, decode(colname, 'OSTQ_BEFORE_30', 1, 2)) r013,
            r020, r030, decode(colname, 'OSTQ_BEFORE_30', ost_before_30, ost_after_30) bal,
            value bal_uah
        from (
            select z.*,
                (case when z.dos = 0 then 0
                      when abs (z.ost) >= abs (z.dos) then z.dos
                      else z.ost
                 end) ost_before_30,
                (case when z.dosq = 0 then 0
                      when abs (z.ostq) >= abs (z.dosq) then z.dosq
                      else z.ostq
                 end) ostq_before_30,
                (case when z.dos = 0 then z.ost
                      when abs (z.ost) < abs (z.dos) then z.ost - z.dos
                      else 0
                 end) ost_after_30,
                (case when z.dosq = 0 then z.ostq
                      when abs (z.ostq) < abs (z.dosq) then z.ostq - z.dosq
                      else 0
                 end) ostq_after_30
            from (
               select p_report_date dat, b.kf, b.acc acc_id,
                      nvl(c.r013, '0') r013,
                      nvl(a.nbs, substr(a.nls,1,4)) r020, a.tip,
                      nvl(a.ob22, '00') ob22,
                      lpad(a.kv, 3, '0') r030, sum(b.dos) dos,
                      -1 * gl.p_icurval(a.kv, sum(b.dos), p_report_date) dosq,
                      sum(decode(b.fdat, p_report_date, b.ost, 0)) ost,
                      sum(decode(b.fdat, p_report_date, b.ostq, 0)) ostq
                from snap_balances b, accounts a, specparam c
                where b.fdat between p_report_date - 29 and p_report_date and
                    b.acc = a.acc and
                    nvl(a.nbs, substr(a.nls,1,4)) in (select r020 from NBUR_TMP_LST_R020) and
                    a.tip not in ('SNO', 'SNA') and
                    not (nvl(a.nbs, substr(a.nls,1,4)) in ('1408', '1418', '1428') and nvl(c.r013, '0') = '1') and
                    not (b.kf = 300465 and b.rnk = 907973 and nvl(a.nbs, substr(a.nls,1,4)) in ('1418', '3118')) and
                    a.acc = c.acc(+)
                group by b.kf, b.acc,
                      nvl(c.r013, '0'), nvl(a.nbs, substr(a.nls,1,4)),
                      a.tip, a.ob22, a.kv
                having sum(decode(b.fdat, p_report_date, b.ost, 0))<0) z)  UNPIVOT (value
                                                                            FOR colname
                                                                            IN  (ostq_before_30,
                                                                                 ostq_after_30))
                where value <> 0 );
    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_BALANCES_DLY_R013
           ( REPORT_DATE, KF, ACC_ID, ACC_TYPE, R013, R020, OB22, R030, BAL, BAL_UAH, R013_CLC )
      select DAT, KF, ACC_ID, TIP, R013_OLD, R020, OB22, R030, BAL, BAL_UAH, R013
        from ( select dat, kf, acc_id, ob22, tip, r013 r013_old,
                      f_nbur_ret_r013 (dat, r020, r030, r013, decode(colname, 'OSTQ_BEFORE_30', 1, 2)) r013,
                      r020, r030, decode(colname, 'OSTQ_BEFORE_30', ost_before_30, ost_after_30) bal,
                      value bal_uah
                from (
            select z.*,
                (case when z.dos = 0 then 0
                      when abs (z.ost) >= abs (z.dos) then z.dos
                      else z.ost
                 end) ost_before_30,
                (case when z.dosq = 0 then 0
                      when abs (z.ostq) >= abs (z.dosq) then z.dosq
                      else z.ostq
                 end) ostq_before_30,
                (case when z.dos = 0 then z.ost
                      when abs (z.ost) < abs (z.dos) then z.ost - z.dos
                      else 0
                 end) ost_after_30,
                (case when z.dosq = 0 then z.ostq
                      when abs (z.ostq) < abs (z.dosq) then z.ostq - z.dosq
                      else 0
                 end) ostq_after_30
            from (
               select /*+ PARALLEL( 4 ) */
                      p_report_date as dat, a.kf, a.acc as acc_id,
                      nvl(c.r013, '0') r013,
                      nvl(a.nbs, substr(a.nls,1,4)) r020, a.tip,
                      nvl(a.ob22, '00') ob22,
                      lpad(a.kv, 3, '0') r030,
                      sum(b.dos) dos,
                      -1 * gl.p_icurval(a.kv, sum(b.dos), p_report_date) dosq,
                      sum(decode(b.fdat, p_report_date, b.ost, 0)) ost,
                      sum(decode(b.fdat, p_report_date, b.ostq, 0)) ostq
                 from accounts a
                 join snap_balances b
                   on ( b.kf = a.kf and b.acc = a.acc )
                 left
                 join specparam c
                   on ( c.kf = a.kf and c.acc = a.acc )
                where a.KF = p_kf
                  and b.fdat between p_report_date - 29 and p_report_date
                  and nvl(a.nbs, substr(a.nls,1,4)) in (select r020 from NBUR_TMP_LST_R020)
                  and a.tip not in ('SNO', 'SNA')
                  and not (nvl(a.nbs, substr(a.nls,1,4)) in ('1408', '1418', '1428') and nvl(c.r013, '0') = '1')
--                and not (b.kf = 300465 and b.rnk = 907973 and nvl(a.nbs, substr(a.nls,1,4)) in ('1418', '3118'))
                group by a.kf, a.acc,
                      nvl(c.r013, '0'),
                      nvl(a.nbs, substr(a.nls,1,4)),
                      a.tip, a.ob22, a.kv
                having sum(decode(b.fdat, p_report_date, b.ost, 0))<0) z)  UNPIVOT (value
                                                                            FOR colname
                                                                            IN  (ostq_before_30,
                                                                                 ostq_after_30))
                where value <> 0 );
    end if;

    l_rowcount := sql%rowcount;

    commit;

    delete from NBUR_TMP_LST_R020;
    insert into NBUR_TMP_LST_R020
    select unique r020
    from kod_r020
    where a010 in ('C5', 'A7') and
          d_open between TO_DATE ('01011997', 'ddmmyyyy') and l_datz and
         (d_close is null or
          d_close >= l_datz);

    if p_kf Is Null
    then -- for all KF
        merge into NBUR_DM_BALANCES_DLY_R013 r
        using (
            select b.fdat dat, b.kf, b.acc acc_id, a.tip, nvl(c.r013, '0') r013_old,
                nvl(a.nbs, substr(a.nls,1,4)) r020, nvl(a.ob22, '00') ob22, a.kv r030,
                b.ost bal, b.ostq bal_uah,
                (case when a.nbs = '9500' and nvl(c.r013, '0') = '0'
                        then '9'
                      when a.nbs in ('2610','2611','2615','2616','2617','2630','2635',
                                     '2636','2637','2651','2652','2653','2656') and
                             (nvl(c.r013, '0') = '0' OR
                              nvl(c.r013, '0') not in ('1','9') or
                              a.mdate is not null) and
                              (a.mdate is null OR a.mdate > p_report_date)
                        then '9'
                      when a.nbs in ('2610','2611','2615','2616','2617','2630','2635',
                                     '2636','2637','2651','2652','2653','2656') and
                             (nvl(c.r013, '0') = '0' OR
                              nvl(c.r013, '0') not in ('1','9') or
                              a.mdate is not null) and
                              (a.mdate is not null AND a.mdate <= p_report_date)
                        then '1'
                      else
                        nvl(c.r013, '0')
                end) r013_clc
            from snap_balances b, accounts a, specparam c
            where b.fdat = p_report_date and
                b.ost<>0 and
                b.acc = a.acc and
                nvl(a.nbs, substr(a.nls,1,4)) in (select r020
                                                  from NBUR_TMP_LST_R020
                                                  where r020 not in ('1490','1491','1492','1493',
                                                        '1590','1592','1890','2400','2401','2890','3190','3290',
                                                        '3590','3599','3690')) and
                b.acc = c.acc(+)) s
        ON (r.acc_id = s.acc_id)
        WHEN NOT MATCHED THEN
            INSERT (r.REPORT_DATE, r.KF, r.ACC_ID, r.ACC_TYPE, r.R013, r.R020, r.OB22, r.R030, r.BAL, r.BAL_UAH, r.r013_CLC)
            values (s.dat, s.KF, s.ACC_ID, s.tip, s.R013_old, s.R020, s.OB22, s.R030, s.BAL, s.BAL_UAH, s.r013_CLC);
    else
        merge into NBUR_DM_BALANCES_DLY_R013 r
        using (
            select b.fdat dat, b.kf, b.acc acc_id, a.tip, nvl(c.r013, '0') r013_old,
                nvl(a.nbs, substr(a.nls,1,4)) r020, nvl(a.ob22, '00') ob22, a.kv r030,
                b.ost bal, b.ostq bal_uah,
                (case when a.nbs = '9500' and nvl(c.r013, '0') = '0'
                        then '9'
                      when a.nbs in ('2610','2611','2615','2616','2617','2630','2635',
                                     '2636','2637','2651','2652','2653','2656') and
                             (nvl(c.r013, '0') = '0' OR
                              nvl(c.r013, '0') not in ('1','9') or
                              a.mdate is not null) and
                              (a.mdate is null OR a.mdate > p_report_date)
                        then '9'
                      when a.nbs in ('2610','2611','2615','2616','2617','2630','2635',
                                     '2636','2637','2651','2652','2653','2656') and
                             (nvl(c.r013, '0') = '0' OR
                              nvl(c.r013, '0') not in ('1','9') or
                              a.mdate is not null) and
                              (a.mdate is not null AND a.mdate <= p_report_date)
                        then '1'
                      else
                        nvl(c.r013, '0')
                end) r013_clc
            from snap_balances b, accounts a, specparam c
            where b.fdat = p_report_date and
                b.kf = p_kf and
                b.ost<>0 and
                b.acc = a.acc and
                nvl(a.nbs, substr(a.nls,1,4)) in (select r020
                                                  from NBUR_TMP_LST_R020
                                                  where r020 not in ('1490','1491','1492','1493',
                                                        '1590','1592','1890','2400','2401','2890','3190','3290',
                                                        '3590','3599','3690')) and
                b.acc = c.acc(+)) s
        ON (r.acc_id = s.acc_id)
        WHEN NOT MATCHED THEN
            INSERT (r.REPORT_DATE, r.KF, r.ACC_ID, r.ACC_TYPE, r.R013, r.R020, r.OB22, r.R030, r.BAL, r.BAL_UAH, r.r013_CLC)
            values (s.dat, s.KF, s.ACC_ID, s.tip, s.R013_old, s.R020, s.OB22, s.R030, s.BAL, s.BAL_UAH, s.r013_CLC);
    end if;

    l_rowcount := l_rowcount + sql%rowcount;

    p_finish_load_object(l_object_id, p_version_id, p_report_date, p_kf, l_rowcount);

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end P_LOAD_BALANCES_R013;

  --
  --
  --
  procedure P_LOAD_ADL_DOC_RPT_DTL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>P_LOAD_ADL_DOC_RPT_DTL</b> - наповнення даними вітрини додаткових реквізитів фінансових документів (operw)
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини додаткових реквізитів фін. документів
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_ADL_DOC_RPT_DTL';
    l_object_name         varchar2(100) := 'NBUR_DM_ADL_DOC_RPT_DTL';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_ADL_DOC_RPT_DTL
           ( REPORT_DATE, KF, REF
           , D1#70, D2#70, D3#70, D4#70, D5#70, D6#70, D7#70, D8#70, D9#70
           , DA#70, DB#70, DD#70, D1#E2, D6#E2, D7#E2, D8#E2, D1#E9, D1#C9, D6#C9
           , DE#C9, D1#D3, D1#F1, D1#27, D1#39, D1#44, D1#73, D2#73
           , D020,  BM__C, KURS,  D1#2D, KOD_B, KOD_G, KOD_N, TRF_R, TRF_D
           , DOC_T, DOC_A, DOC_S, DOC_N, DOC_D, REZID, NATIO, OKPO,  POKPO, OOKPO )
      select /*+ PARALLEL( 16 ) */ unique p_report_date, KF, REF
           , D1#70, D2#70, D3#70, D4#70, D5#70, D6#70, D7#70, D8#70, D9#70
           , DA#70, DB#70, DD#70, D1#E2, D6#E2, D7#E2, D8#E2, D1#E9, D1#C9, D6#C9
           , DE#C9, D1#D3, D1#F1, D1#27, D1#39, D1#44, D1#73
           , coalesce( case TT
                         when '046' then D2#73_046
                         when '115' then D2#73_115
                         when '116' then D2#73_116
                         when '117' then D2#73_117
                         when '120' then D2#73_120
                         when '137' then D2#73_137
                         when '138' then D2#73_138
                         when '151' then D2#73_151
                         when '153' then D2#73_153
                         when '156' then D2#73_156
                         when 'A06' then D2#73_A06
                         when 'A07' then D2#73_A07
                         when 'A16' then D2#73_A16
                         when 'CCD' then D2#73_CCD
                         when 'CCM' then D2#73_CCM
                         when 'F08' then D2#73_F08
                         when 'K06' then D2#73_K06
                         when 'K07' then D2#73_K07
                         when 'K91' then D2#73_K91
                         when 'MUQ' then D2#73_MUQ
                         when 'MVQ' then D2#73_MVQ
                         when 'VPF' then D2#73_VPF
                         else null
                       end
                     , D2#73_046,D2#73_115,D2#73_116,D2#73_117,D2#73_120,D2#73_137,D2#73_138,D2#73_151,D2#73_153,D2#73_156,D2#73_A06
                     , D2#73_A07,D2#73_A16,D2#73_CCD,D2#73_CCM,D2#73_F08,D2#73_K06,D2#73_K07,D2#73_K91,D2#73_MUQ,D2#73_MVQ,D2#73_VPF
             ) as D2#73
           , D020,  BM__C, KURS
           , D1#2D, KOD_B
           , nvl(KOD_G,CODEG) as KOD_G
           , nvl(KOD_N,CODEN) as KOD_N
           , nvl(D_REF,REFT ) as TRF_R
           , nvl(D_1PB,DATT ) as TRF_D
           , nvl(PASP ,PASPV) as DOC_T
           , nvl(PASP1,ATRT ) as DOC_A
           , DOC_S, DOC_N, DOC_D
           , REZID, NATIO
           , OKPO , POKPO, OOKPO
        from ( select w.KF
                    , w.REF
                    , w.TAG
                    , SubStr(trim(w.VALUE),1,64) as VALUE
                    , t.TT
                 from OPERW w
                 join NBUR_QUEUE_OBJECTS q
                   on ( q.KF = w.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
                 join NBUR_DM_TRANSACTIONS t
                   on ( t.KF = w.KF AND t.REF = w.REF )
                where w.TAG in ( 'D1#70', 'D2#70', 'D3#70', 'D4#70', 'D5#70', 'D6#70'
                               , 'D7#70', 'D8#70', 'D9#70', 'DA#70', 'DB#70', 'DD#70'
                               , 'D1#E2', 'D6#E2', 'D7#E2', 'D8#E2', 'D1#E9'
                               , 'D1#C9', 'D6#C9', 'DE#C9', 'D1#D3'
                               , 'D#27 ', 'D#39 ', 'D#44 ', 'D#73 '
                               , 'D020 ', 'BM__C', 'KURS '
                               , '73046', '73115', '73116', '73117', '73120', '73137'
                               , '73138', '73151', '73153', '73156', '73A06', '73A07'
                               , '73A16', '73CCD', '73CCM', '73F08', '73K06', '73K07'
                               , '73K91', '73MUQ', '73MVQ', '73VPF'
                               , 'KOD_G', 'n    ', 'KOD_N', 'N    ', 'D1#2D', 'KOD_B'
                               , 'F1   ', 'D_REF', 'REFT ', 'D_1PB', 'DATT ', 'REZID'
                               , 'NATIO', 'OKPO ', 'POKPO', 'OOKPO', 'PASP ', 'PASPV'
                               , 'PASPS', 'PASPN', 'PASP1', 'PASP2', 'ATRT '
                               )
             ) pivot ( max(VALUE) for TAG in ( 'D1#70' as D1#70, 'D2#70' as D2#70, 'D3#70' as D3#70
                                             , 'D4#70' as D4#70, 'D5#70' as D5#70, 'D6#70' as D6#70
                                             , 'D7#70' as D7#70, 'D8#70' as D8#70, 'D9#70' as D9#70
                                             , 'DA#70' as DA#70, 'DB#70' as DB#70, 'DD#70' as DD#70
                                             , 'D1#E2' as D1#E2, 'D6#E2' as D6#E2, 'D7#E2' as D7#E2
                                             , 'D8#E2' as D8#E2, 'D1#E9' as D1#E9
                                             , 'D1#C9' as D1#C9, 'D6#C9' as D6#C9, 'DE#C9' as DE#C9
                                             , 'D1#D3' as D1#D3
                                             , 'D#27 ' as D1#27, 'D#39 ' as D1#39, 'D#44 ' as D1#44
                                             , 'D#73 ' as D1#73
                                             , 'D020 ' as D020,  'BM__C' as BM__C, 'KURS ' as KURS
                                             , 'KOD_G' as KOD_G, 'n    ' as CODEG
                                             , 'KOD_N' as KOD_N, 'N    ' as CODEN
                                             , 'D1#2D' as D1#2D, 'KOD_B' as KOD_B, 'F1   ' as D1#F1
                                             , 'D_REF' as D_REF, 'REFT ' as REFT  -- TFR_REF
                                             , 'D_1PB' as D_1PB, 'DATT ' as DATT  -- TRF_DT
                                             , 'REZID' as REZID, 'NATIO' as NATIO
                                             , 'OKPO ' as OKPO , 'POKPO' as POKPO, 'OOKPO' as OOKPO
                                             , 'PASP ' as PASP , 'PASPV' as PASPV -- DOC_TP
                                             , 'PASP1' as PASP1, 'ATRT ' as ATRT  -- DOC_AHR (issuing authority)
                                             , 'PASPS' as DOC_S, 'PASPN' as DOC_N, 'PASP2' as DOC_D
                                             , '73046' as D2#73_046, '73115' as D2#73_115, '73116' as D2#73_116
                                             , '73117' as D2#73_117, '73120' as D2#73_120, '73137' as D2#73_137
                                             , '73138' as D2#73_138, '73151' as D2#73_151, '73153' as D2#73_153
                                             , '73156' as D2#73_156, '73A06' as D2#73_A06, '73A07' as D2#73_A07
                                             , '73A16' as D2#73_A16, '73CCD' as D2#73_CCD, '73CCM' as D2#73_CCM
                                             , '73F08' as D2#73_F08, '73K06' as D2#73_K06, '73K07' as D2#73_K07
                                             , '73K91' as D2#73_K91, '73MUQ' as D2#73_MUQ, '73MVQ' as D2#73_MVQ
                                             , '73VPF' as D2#73_VPF
                                             )
                     );

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_ADL_DOC_RPT_DTL
           ( REPORT_DATE, KF, REF
           , D1#70, D2#70, D3#70, D4#70, D5#70, D6#70, D7#70, D8#70, D9#70
           , DA#70, DB#70, DD#70, D1#E2, D6#E2, D7#E2, D8#E2, D1#E9, D1#C9, D6#C9
           , DE#C9, D1#D3, D1#F1, D1#27, D1#39, D1#44, D1#73, D2#73
           , D020,  BM__C, KURS,  D1#2D, KOD_B, KOD_G, KOD_N, TRF_R, TRF_D
           , DOC_T, DOC_A, DOC_S, DOC_N, DOC_D, REZID, NATIO, OKPO,  POKPO, OOKPO )
      select unique p_report_date, KF, REF
           , D1#70, D2#70, D3#70, D4#70, D5#70, D6#70, D7#70, D8#70, D9#70
           , DA#70, DB#70, DD#70, D1#E2, D6#E2, D7#E2, D8#E2, D1#E9, D1#C9, D6#C9
           , DE#C9, D1#D3, D1#F1, D1#27, D1#39, D1#44, D1#73
           , coalesce( case TT
                         when '046' then D2#73_046
                         when '115' then D2#73_115
                         when '116' then D2#73_116
                         when '117' then D2#73_117
                         when '120' then D2#73_120
                         when '137' then D2#73_137
                         when '138' then D2#73_138
                         when '151' then D2#73_151
                         when '153' then D2#73_153
                         when '156' then D2#73_156
                         when 'A06' then D2#73_A06
                         when 'A07' then D2#73_A07
                         when 'A16' then D2#73_A16
                         when 'CCD' then D2#73_CCD
                         when 'CCM' then D2#73_CCM
                         when 'F08' then D2#73_F08
                         when 'K06' then D2#73_K06
                         when 'K07' then D2#73_K07
                         when 'K91' then D2#73_K91
                         when 'MUQ' then D2#73_MUQ
                         when 'MVQ' then D2#73_MVQ
                         when 'VPF' then D2#73_VPF
                         else null
                       end
                     , D2#73_046,D2#73_115,D2#73_116,D2#73_117,D2#73_120,D2#73_137,D2#73_138,D2#73_151,D2#73_153,D2#73_156,D2#73_A06
                     , D2#73_A07,D2#73_A16,D2#73_CCD,D2#73_CCM,D2#73_F08,D2#73_K06,D2#73_K07,D2#73_K91,D2#73_MUQ,D2#73_MVQ,D2#73_VPF
             ) as D2#73
           , D020,  BM__C, KURS
           , D1#2D, KOD_B
           , nvl(KOD_G,CODEG) as KOD_G
           , nvl(KOD_N,CODEN) as KOD_N
           , nvl(D_REF,REFT ) as TRF_R
           , nvl(D_1PB,DATT ) as TRF_D
           , nvl(PASP ,PASPV) as DOC_T
           , nvl(PASP1,ATRT ) as DOC_A
           , DOC_S, DOC_N, DOC_D
           , REZID, NATIO
           , OKPO , POKPO, OOKPO
        from ( select w.KF
                    , w.REF
                    , w.TAG
                    , SubStr(trim(w.VALUE),1,64) as VALUE
                    , t.TT
                 from OPERW w
                 join ( select KF, REF, TT
                          from NBUR_DM_TRANSACTIONS
                         where KF          = p_kf
                        -- and REPORT_DATE = p_report_date
                      ) t
                   on ( t.KF = w.KF AND t.REF = w.REF )
                where w.TAG in ( 'D1#70', 'D2#70', 'D3#70', 'D4#70', 'D5#70', 'D6#70'
                               , 'D7#70', 'D8#70', 'D9#70', 'DA#70', 'DB#70', 'DD#70'
                               , 'D1#E2', 'D6#E2', 'D7#E2', 'D8#E2', 'D1#E9'
                               , 'D1#C9', 'D6#C9', 'DE#C9', 'D1#D3'
                               , 'D#27 ', 'D#39 ', 'D#44 ', 'D#73 '
                               , 'D020 ', 'BM__C', 'KURS '
                               , '73046', '73115', '73116', '73117', '73120', '73137'
                               , '73138', '73151', '73153', '73156', '73A06', '73A07'
                               , '73A16', '73CCD', '73CCM', '73F08', '73K06', '73K07'
                               , '73K91', '73MUQ', '73MVQ', '73VPF'
                               , 'KOD_G', 'n    ', 'KOD_N', 'N    ', 'D1#2D', 'KOD_B'
                               , 'F1   ', 'D_REF', 'REFT ', 'D_1PB', 'DATT ', 'REZID'
                               , 'NATIO', 'OKPO ', 'POKPO', 'OOKPO', 'PASP ', 'PASPV'
                               , 'PASPS', 'PASPN', 'PASP1', 'PASP2', 'ATRT '
                               )
             ) pivot ( max(VALUE) for TAG in ( 'D1#70' as D1#70, 'D2#70' as D2#70, 'D3#70' as D3#70
                                             , 'D4#70' as D4#70, 'D5#70' as D5#70, 'D6#70' as D6#70
                                             , 'D7#70' as D7#70, 'D8#70' as D8#70, 'D9#70' as D9#70
                                             , 'DA#70' as DA#70, 'DB#70' as DB#70, 'DD#70' as DD#70
                                             , 'D1#E2' as D1#E2, 'D6#E2' as D6#E2, 'D7#E2' as D7#E2
                                             , 'D8#E2' as D8#E2, 'D1#E9' as D1#E9
                                             , 'D1#C9' as D1#C9, 'D6#C9' as D6#C9, 'DE#C9' as DE#C9
                                             , 'D1#D3' as D1#D3
                                             , 'D#27 ' as D1#27, 'D#39 ' as D1#39, 'D#44 ' as D1#44
                                             , 'D#73 ' as D1#73
                                             , 'D020 ' as D020,  'BM__C' as BM__C, 'KURS ' as KURS
                                             , 'KOD_G' as KOD_G, 'n    ' as CODEG
                                             , 'KOD_N' as KOD_N, 'N    ' as CODEN
                                             , 'D1#2D' as D1#2D, 'KOD_B' as KOD_B, 'F1   ' as D1#F1
                                             , 'D_REF' as D_REF, 'REFT ' as REFT  -- TFR_REF
                                             , 'D_1PB' as D_1PB, 'DATT ' as DATT  -- TRF_DT
                                             , 'REZID' as REZID, 'NATIO' as NATIO
                                             , 'OKPO ' as OKPO , 'POKPO' as POKPO, 'OOKPO' as OOKPO
                                             , 'PASP ' as PASP , 'PASPV' as PASPV -- DOC_TP
                                             , 'PASP1' as PASP1, 'ATRT ' as ATRT  -- DOC_AHR (issuing authority)
                                             , 'PASPS' as DOC_S, 'PASPN' as DOC_N, 'PASP2' as DOC_D
                                             , '73046' as D2#73_046, '73115' as D2#73_115, '73116' as D2#73_116
                                             , '73117' as D2#73_117, '73120' as D2#73_120, '73137' as D2#73_137
                                             , '73138' as D2#73_138, '73151' as D2#73_151, '73153' as D2#73_153
                                             , '73156' as D2#73_156, '73A06' as D2#73_A06, '73A07' as D2#73_A07
                                             , '73A16' as D2#73_A16, '73CCD' as D2#73_CCD, '73CCM' as D2#73_CCM
                                             , '73F08' as D2#73_F08, '73K06' as D2#73_K06, '73K07' as D2#73_K07
                                             , '73K91' as D2#73_K91, '73MUQ' as D2#73_MUQ, '73MVQ' as D2#73_MVQ
                                             , '73VPF' as D2#73_VPF
                                             )
                     );

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end P_LOAD_ADL_DOC_RPT_DTL;

  --
  --
  --
  procedure LOAD_ADL_DOC_SWT_DTL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
    /**
  <b>LOAD_ADL_DOC_SWT_DTL</b> - наповнення даними вітрини SWIFT реквізитів фінансових документів (operw)
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини SWIFT реквізитів фін. документів
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_ADL_DOC_SWT_DTL';
    l_object_name         varchar2(100) := 'NBUR_DM_ADL_DOC_SWT_DTL';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_ADL_DOC_SWT_DTL
           ( REPORT_DATE, KF, REF
           , SW11R, SW11S, SW13C, SW20,  SW21,  SW23B, SW23E, SW25,  SW26T, SW30,  SW32A, SW32B
           , SW32C, SW32D, SW33B, SW36,  SW50,  SW50A, SW50F, SW50K, SW51A, SW52A, SW52B, SW52D, SW53A
           , SW53B, SW53D, SW54,  SW54A, SW54B, SW54D, SW55A, SW55B, SW55D, SW56,  SW56A, SW56C, SW56D
           , SW57,  SW57A, SW57B, SW57C, SW57D, SW58,  SW58A, SW58D, SW59,  SW59A, SW61,  SW70,  SW71A
           , SW71B, SW71F, SW71G, SW72,  SW76,  SW77A, SW77B, SW77T, SW79,  SWRCV, NOS_A, NOS_B, NOS_R )
      select p_report_date, KF, REF
           , SW11R, SW11S, SW13C, SW20,  SW21,  SW23B, SW23E, SW25,  SW26T, SW30,  SW32A, SW32B
           , SW32C, SW32D, SW33B, SW36,  SW50,  SW50A, SW50F, SW50K, SW51A, SW52A, SW52B, SW52D, SW53A
           , SW53B, SW53D, SW54,  SW54A, SW54B, SW54D, SW55A, SW55B, SW55D, SW56,  SW56A, SW56C, SW56D
           , SW57,  SW57A, SW57B, SW57C, SW57D, SW58,  SW58A, SW58D, SW59,  SW59A, SW61,  SW70,  SW71A
           , SW71B, SW71F, SW71G, SW72,  SW76,  SW77A, SW77B, SW77T, SW79,  SWRCV, NOS_A, NOS_B, NOS_R
        from ( select w.KF
                    , w.REF
                    , w.TAG
                    , w.VALUE
                 from OPERW w
                 join ( select unique KF, REF
                          from NBUR_DM_TRANSACTIONS
                      -- where REPORT_DATE = p_report_date
                      ) t
                   on ( t.KF = w.KF AND t.REF = w.REF )
                where w.TAG in ('11R  ','11S  ','13C  ','13С  ','20   ','21   '
                               ,'23B  ','23E  ','25   ','26T  ','30   ','32A  '
                               ,'32B  ','32C  ','32D  ','33B  ','36   ','50   '
                               ,'50A  ','50F  ','50K  ','51A  ','52A  ','52B  '
                               ,'52D  ','53A  ','53B  ','53D  ','54   ','54A  '
                               ,'54B  ','54D  ','55A  ','55B  ','55D  ','56   '
                               ,'56A  ','56C  ','56D  ','57   ','57A  ','57B  '
                               ,'57C  ','57D  ','58   ','58A  ','58D  ','59   '
                               ,'59A  ','61   ','70   ','71A  ','71B  ','71F  '
                               ,'71G  ','72   ','76   ','77A  ','77B  ','77T  '
                               ,'79   ','NOS_A','NOS_B','NOS_R','SWRCV')
             ) pivot ( max(VALUE) for TAG in ('11R  ' as SW11R, '11S  ' as SW11S, '13C  ' as SW13C
                                             ,'13С  ' as SW13С, '20   ' as SW20,  '21   ' as SW21
                                             ,'23B  ' as SW23B, '23E  ' as SW23E, '25   ' as SW25
                                             ,'26T  ' as SW26T, '30   ' as SW30,  '32A  ' as SW32A
                                             ,'32B  ' as SW32B, '32C  ' as SW32C, '32D  ' as SW32D
                                             ,'33B  ' as SW33B, '36   ' as SW36 , '50   ' as SW50
                                             ,'50A  ' as SW50A, '50F  ' as SW50F, '50K  ' as SW50K
                                             ,'51A  ' as SW51A, '52A  ' as SW52A, '52B  ' as SW52B
                                             ,'52D  ' as SW52D, '53A  ' as SW53A, '53B  ' as SW53B
                                             ,'53D  ' as SW53D, '54   ' as SW54,  '54A  ' as SW54A
                                             ,'54B  ' as SW54B, '54D  ' as SW54D, '55A  ' as SW55A
                                             ,'55B  ' as SW55B, '55D  ' as SW55D, '56   ' as SW56
                                             ,'56A  ' as SW56A, '56C  ' as SW56C, '56D  ' as SW56D
                                             ,'57   ' as SW57,  '57A  ' as SW57A, '57B  ' as SW57B
                                             ,'57C  ' as SW57C, '57D  ' as SW57D, '58   ' as SW58
                                             ,'58A  ' as SW58A, '58D  ' as SW58D, '59   ' as SW59
                                             ,'59A  ' as SW59A, '61   ' as SW61,  '70   ' as SW70
                                             ,'71A  ' as SW71A, '71B  ' as SW71B, '71F  ' as SW71F
                                             ,'71G  ' as SW71G, '72   ' as SW72,  '76   ' as SW76
                                             ,'77A  ' as SW77A, '77B  ' as SW77B, '77T  ' as SW77T
                                             ,'79   ' as SW79,  'SWRCV' as SWRCV
                                             ,'NOS_A' as NOS_A, 'NOS_B' as NOS_B, 'NOS_R' as NOS_R)
                     );

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_ADL_DOC_SWT_DTL
           ( REPORT_DATE, KF, REF
           , SW11R, SW11S, SW13C, SW20,  SW21,  SW23B, SW23E, SW25,  SW26T, SW30,  SW32A, SW32B
           , SW32C, SW32D, SW33B, SW36,  SW50,  SW50A, SW50F, SW50K, SW51A, SW52A, SW52B, SW52D, SW53A
           , SW53B, SW53D, SW54,  SW54A, SW54B, SW54D, SW55A, SW55B, SW55D, SW56,  SW56A, SW56C, SW56D
           , SW57,  SW57A, SW57B, SW57C, SW57D, SW58,  SW58A, SW58D, SW59,  SW59A, SW61,  SW70,  SW71A
           , SW71B, SW71F, SW71G, SW72,  SW76,  SW77A, SW77B, SW77T, SW79,  SWRCV, NOS_A, NOS_B, NOS_R )
      select /*+ PARALLEL( 8 ) */ p_report_date, KF, REF
           , SW11R, SW11S, SW13C, SW20,  SW21,  SW23B, SW23E, SW25,  SW26T, SW30,  SW32A, SW32B
           , SW32C, SW32D, SW33B, SW36,  SW50,  SW50A, SW50F, SW50K, SW51A, SW52A, SW52B, SW52D, SW53A
           , SW53B, SW53D, SW54,  SW54A, SW54B, SW54D, SW55A, SW55B, SW55D, SW56,  SW56A, SW56C, SW56D
           , SW57,  SW57A, SW57B, SW57C, SW57D, SW58,  SW58A, SW58D, SW59,  SW59A, SW61,  SW70,  SW71A
           , SW71B, SW71F, SW71G, SW72,  SW76,  SW77A, SW77B, SW77T, SW79,  SWRCV, NOS_A, NOS_B, NOS_R
        from ( select w.KF
                    , w.REF
                    , w.TAG
                    , case
                        when ( w.TAG = '50   ' )
                        then SubStr(trim(w.VALUE),1,140)
                        else SubStr(trim(w.VALUE),1,35 )
                      end as VALUE
                 from OPERW w
                 join ( select unique KF, REF
                          from NBUR_DM_TRANSACTIONS
                         where KF = p_kf
                        -- and REPORT_DATE = p_report_date
                      ) t
                   on ( t.KF = w.KF AND t.REF = w.REF )
                where w.TAG in ('11R  ','11S  ','13C  ','13С  ','20   ','21   '
                               ,'23B  ','23E  ','25   ','26T  ','30   ','32A  '
                               ,'32B  ','32C  ','32D  ','33B  ','36   ','50   '
                               ,'50A  ','50F  ','50K  ','51A  ','52A  ','52B  '
                               ,'52D  ','53A  ','53B  ','53D  ','54   ','54A  '
                               ,'54B  ','54D  ','55A  ','55B  ','55D  ','56   '
                               ,'56A  ','56C  ','56D  ','57   ','57A  ','57B  '
                               ,'57C  ','57D  ','58   ','58A  ','58D  ','59   '
                               ,'59A  ','61   ','70   ','71A  ','71B  ','71F  '
                               ,'71G  ','72   ','76   ','77A  ','77B  ','77T  '
                               ,'79   ','NOS_A','NOS_B','NOS_R','SWRCV')
             ) pivot ( max(VALUE) for TAG in ('11R  ' as SW11R, '11S  ' as SW11S, '13C  ' as SW13C
                                             ,'13С  ' as SW13С, '20   ' as SW20,  '21   ' as SW21
                                             ,'23B  ' as SW23B, '23E  ' as SW23E, '25   ' as SW25
                                             ,'26T  ' as SW26T, '30   ' as SW30,  '32A  ' as SW32A
                                             ,'32B  ' as SW32B, '32C  ' as SW32C, '32D  ' as SW32D
                                             ,'33B  ' as SW33B, '36   ' as SW36 , '50   ' as SW50
                                             ,'50A  ' as SW50A, '50F  ' as SW50F, '50K  ' as SW50K
                                             ,'51A  ' as SW51A, '52A  ' as SW52A, '52B  ' as SW52B
                                             ,'52D  ' as SW52D, '53A  ' as SW53A, '53B  ' as SW53B
                                             ,'53D  ' as SW53D, '54   ' as SW54,  '54A  ' as SW54A
                                             ,'54B  ' as SW54B, '54D  ' as SW54D, '55A  ' as SW55A
                                             ,'55B  ' as SW55B, '55D  ' as SW55D, '56   ' as SW56
                                             ,'56A  ' as SW56A, '56C  ' as SW56C, '56D  ' as SW56D
                                             ,'57   ' as SW57,  '57A  ' as SW57A, '57B  ' as SW57B
                                             ,'57C  ' as SW57C, '57D  ' as SW57D, '58   ' as SW58
                                             ,'58A  ' as SW58A, '58D  ' as SW58D, '59   ' as SW59
                                             ,'59A  ' as SW59A, '61   ' as SW61,  '70   ' as SW70
                                             ,'71A  ' as SW71A, '71B  ' as SW71B, '71F  ' as SW71F
                                             ,'71G  ' as SW71G, '72   ' as SW72,  '76   ' as SW76
                                             ,'77A  ' as SW77A, '77B  ' as SW77B, '77T  ' as SW77T
                                             ,'79   ' as SW79,  'SWRCV' as SWRCV
                                             ,'NOS_A' as NOS_A, 'NOS_B' as NOS_B, 'NOS_R' as NOS_R)
                     );

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_ADL_DOC_SWT_DTL;

  --
  --
  --
  procedure P_LOAD_AGRM_ACCOUNTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>P_LOAD_AGRM_ACCOUNTS</b> - наповнення даними вітрини зв`язків рахунків та договорів
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини зв`язків рахунків з договорорами
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_AGRM_ACCOUNTS';
    l_object_name         varchar2(100) := 'NBUR_DM_AGRM_ACCOUNTS';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_AGRM_ACCOUNTS
           ( REPORT_DATE, KF, ACC_ID, AGRM_ID, PRTFL_TP, CCY_ID
           , BEG_DT, END_DT, AGRM_NUM, AGRM_TP, AGRM_STE )
      select /*+ PARALLEL( 8 ) */ p_report_date
           , c.KF, c.ACC_ID, c.AGRM_ID, c.PRTFL_TP, a.KV
           , nvl(c.BEG_DT, a.OPEN_DATE)
           , nvl(c.END_DT, a.MATURITY_DATE)
           , c.AGRM_NUM, c.AGRM_TP, c.AGRM_STE
        from ( select 'CCK'   as PRTFL_TP -- портфель кредитів ФО/ЮО + Овердрафти + МБДК + НОСТРО + Форекс
                    , n.ND    as AGRM_ID
                    , n.ACC   as ACC_ID
                    , d.KF
                    , d.SDATE as BEG_DT
                    , d.WDATE as END_DT
                    , d.CC_ID as AGRM_NUM
                    , d.VIDD  as AGRM_TP
                    , d.SOS   as AGRM_STE
                 from ND_ACC  n
                 join CC_DEAL d
                   on ( d.ND = n.ND )
                union all
               select 'DPT' -- портфель депозитів ФО
                    , fa.DPTID, fa.ACCID
                    , fd.KF
                    , fd.DATZ
                    , fd.DAT_END
                    , fd.ND
                    , fd.VIDD
                    , 10
                 from DPT_ACCOUNTS fa
                 join DPT_DEPOSIT  fd
                   on ( fd.DEPOSIT_ID = fa.DPTID )
                union all
               select 'DPU' -- портфель депозитів ЮО
                    , ua.DPUID, ua.ACCID
                    , ud.KF
                    , ud.DATZ
                    , ud.DAT_END
                    , ud.ND
                    , ud.VIDD
                    , case when CLOSED = 0 then 10 else 15 end
                 from DPU_ACCOUNTS ua
                 join DPU_DEAL     ud
                   on ( ud.DPU_ID = ua.DPUID )
                union all
               select 'SCR' -- портфель цінних паперів
                    , sa.CP_REF, sa.CP_ACC
                    , sd.KF
                    , sd.DAT_UG
                    , null as END_DT
                    , null as AGRM_NUM
                    , null as AGRM_TP
                    , case when ACTIVE = 1 then 10 else 15 end
                 from CP_ACCOUNTS sa
                 join CP_DEAL     sd
                   on ( sd.REF = sa.CP_REF )
                union all
               select unique 'OW4' -- портфель БПК ( новий OW4 )
                    , ND, ACC_ID
                    , KF, DAT_BEGIN, DAT_END, AGRM_NUM, AGRM_TP, AGRM_STE
                 from ( select KF, ND, DAT_BEGIN, DAT_END
                             , null as AGRM_NUM
                             , null as AGRM_TP
                             , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                             , ACC_PK    -- 2625
                             , ACC_2625X -- 2625
                             , ACC_2625D -- 2625
                             , ACC_2627X -- 2625
                             , ACC_2627
                             , ACC_2628
                             , ACC_OVR   -- 2202/2203
                             , ACC_2207
                             , ACC_2208
                             , ACC_2209
                             , ACC_3570
                             , ACC_3579
                             , ACC_9129
                          from W4_ACC
                      )
                unpivot ( ACC_ID for ACC_TYPE in ( ACC_PK   as '2625', ACC_2625X as '2625X', ACC_2625D as '2625D'
                                                 , ACC_2627 as '2627', ACC_2627X as '2627X', ACC_2628  as '2628'
                                                 , ACC_OVR  as '2203', ACC_2207  as '2207' , ACC_2208  as '2208', ACC_2209 as '2209'
                                                 , ACC_3570 as '3570', ACC_3579  as '3579' , ACC_9129  as '9129' )
                        )
                union all
               select unique 'BPK' -- портфель БПК ( старий BPK )
                    , ND, ACC_ID
                    , KF, DAT_BEGIN, DAT_END, AGRM_NUM, AGRM_TP, AGRM_STE
                 from ( select KF, ND
                             , null as DAT_BEGIN
                             , null as DAT_END
                             , null as AGRM_NUM
                             , null as AGRM_TP
                             , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                             , ACC_PK    -- 2625
                             , ACC_OVR   -- 2202/2203
                             , ACC_2207
                             , ACC_2208
                             , ACC_2209
                             , ACC_3570
                             , ACC_3579
                             , ACC_9129
                          from BPK_ACC
                      )
                unpivot ( ACC_ID for ACC_TYPE in ( ACC_PK   as '2625', ACC_3570 as '3570', ACC_3579 as '3579', ACC_9129 as '9129'
                                                 , ACC_OVR  as '2203', ACC_2207 as '2207', ACC_2208 as '2208', ACC_2209 as '2209' )
                        )
             ) c
        join NBUR_DM_ACCOUNTS a
          on ( c.ACC_ID = a.ACC_ID )
       where a.OPEN_DATE <= p_report_date
         and a.CLOSE_DATE Is Null
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_AGRM_ACCOUNTS
           ( REPORT_DATE, KF, ACC_ID, AGRM_ID, PRTFL_TP, CCY_ID
           , BEG_DT, END_DT, AGRM_NUM, AGRM_TP, AGRM_STE )
      select /*+ PARALLEL( 4 ) */ p_report_date
           , a.KF, c.ACC_ID, c.AGRM_ID, c.PRTFL_TP, a.KV
           , nvl(c.BEG_DT, a.OPEN_DATE)
           , nvl(c.END_DT, a.MATURITY_DATE)
           , c.AGRM_NUM, c.AGRM_TP, c.AGRM_STE
        from ( select 'CCK'   as PRTFL_TP -- портфель кредитів ФО/ЮО + Овердрафти + МБДК + НОСТРО + Форекс
                    , n.ND    as AGRM_ID
                    , n.ACC   as ACC_ID
                    , d.KF
                    , d.SDATE as BEG_DT
                    , d.WDATE as END_DT
                    , d.CC_ID as AGRM_NUM
                    , d.VIDD  as AGRM_TP
                    , d.SOS   as AGRM_STE
                 from ND_ACC  n
                 join CC_DEAL d
                   on ( d.KF = n.KF and d.ND = n.ND )
                where d.KF = p_kf
                union all
               select 'DPT' -- портфель депозитів ФО
                    , fa.DPTID, fa.ACCID
                    , fd.KF
                    , fd.DATZ
                    , fd.DAT_END
                    , fd.ND
                    , fd.VIDD
                    , 10
                 from DPT_ACCOUNTS fa
                 join DPT_DEPOSIT  fd
                   on ( fd.KF = fa.KF and fd.DEPOSIT_ID = fa.DPTID )
                where fd.KF = p_kf
                union all
               select 'DPU' -- портфель депозитів ЮО
                    , ua.DPUID, ua.ACCID
                    , ud.KF
                    , ud.DATZ
                    , ud.DAT_END
                    , ud.ND
                    , ud.VIDD
                    , case when CLOSED = 0 then 10 else 15 end
                 from DPU_ACCOUNTS ua
                 join DPU_DEAL     ud
                   on ( ud.KF = ua.KF and ud.DPU_ID = ua.DPUID )
                where ud.KF = p_kf
                union all
               select 'SCR' -- портфель цінних паперів
                    , sa.CP_REF, sa.CP_ACC
                    , sd.KF
                    , sd.DAT_UG
                    , null as END_DT
                    , null as AGRM_NUM
                    , null as AGRM_TP
                    , case when ACTIVE = 1 then 10 else 15 end
                 from CP_ACCOUNTS sa
                 join CP_DEAL     sd
                   on ( sd.REF = sa.CP_REF )
                where sd.KF = p_kf
                union all
               select unique 'OW4' -- портфель БПК ( новий OW4 )
                    , ND, ACC_ID
                    , KF, DAT_BEGIN, DAT_END, AGRM_NUM, AGRM_TP, AGRM_STE
                 from ( select KF, ND, DAT_BEGIN, DAT_END
                             , null as AGRM_NUM
                             , null as AGRM_TP
                             , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                             , ACC_PK    -- 2625
                             , ACC_2625X -- 2625
                             , ACC_2625D -- 2625
                             , ACC_2627X -- 2625
                             , ACC_2627
                             , ACC_2628
                             , ACC_OVR   -- 2202/2203
                             , ACC_2207
                             , ACC_2208
                             , ACC_2209
                             , ACC_3570
                             , ACC_3579
                             , ACC_9129
                          from W4_ACC
                         where KF = p_kf
                      )
                unpivot ( ACC_ID for ACC_TYPE in ( ACC_PK   as '2625', ACC_2625X as '2625X', ACC_2625D as '2625D'
                                                 , ACC_2627 as '2627', ACC_2627X as '2627X', ACC_2628  as '2628'
                                                 , ACC_OVR  as '2203', ACC_2207  as '2207' , ACC_2208  as '2208' , ACC_2209 as '2209'
                                                 , ACC_3570 as '3570', ACC_3579  as '3579' , ACC_9129  as '9129' )
                        )
                union all
               select unique 'BPK' -- портфель БПК ( старий BPK )
                    , ND, ACC_ID
                    , KF, DAT_BEGIN, DAT_END, AGRM_NUM, AGRM_TP, AGRM_STE
                 from ( select KF, ND
                             , null as DAT_BEGIN
                             , null as DAT_END
                             , null as AGRM_NUM
                             , null as AGRM_TP
                             , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                             , ACC_PK    -- 2625
                             , ACC_OVR   -- 2202/2203
                             , ACC_2207
                             , ACC_2208
                             , ACC_2209
                             , ACC_3570
                             , ACC_3579
                             , ACC_9129
                          from BPK_ACC
                         where KF = p_kf
                      )
                unpivot ( ACC_ID for ACC_TYPE in ( ACC_PK   as '2625', ACC_3570 as '3570', ACC_3579 as '3579', ACC_9129 as '9129'
                                                 , ACC_OVR  as '2203', ACC_2207 as '2207', ACC_2208 as '2208', ACC_2209 as '2209' )
                        )
             ) c
        join NBUR_DM_ACCOUNTS a
          on ( c.KF = a.KF and c.ACC_ID = a.ACC_ID )
       where a.KF         = p_kf
         and a.OPEN_DATE <= p_report_date
         and a.CLOSE_DATE Is Null;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end P_LOAD_AGRM_ACCOUNTS;

  --
  -- P_LOAD_ACNT_RATES
  --
  procedure P_LOAD_ACNT_RATES
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
    /**
  <b>P_LOAD_ACNT_RATES</b> - наповнення даними вітрини процентних карток рахунків
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини процентних карток рахунків
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_ACNT_RATES';
    l_object_name         varchar2(100) := 'NBUR_DM_ACNT_RATES';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( p_kf Is Null )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_ACNT_RATES
           ( REPORT_DATE, KF, ACC_ID, RATE_TP
           , FRQ_TP, ACR_ACC_ID, PNL_ACC_ID, RATE_DT, RATE_VAL )
      select /*+ PARALLEL( 4 ) */ p_report_date
           , a.KF, a.ACC_ID
           , i.ID, i.FREQ, i.ACRA, i.ACRB, r.BDAT
           , least( round( case
              when r.BR Is Null
              then r.IR
              when r.IR Is Null
              then s.RATE
              else -- ( r.IR Is Null AND r.BR Is Null ) or ( r.IR Is Not Null AND r.BR Is Not Null )
                case
                  when r.OP = 1
                  then r.IR + s.RATE
                  when r.OP = 2
                  then r.IR - s.RATE
                  when r.OP = 3
                  then r.IR * s.RATE
                  when r.OP = 4
                  then r.IR / s.RATE
                  else Null -- r.OP = 0 OR r.OP Is Null
                end
           end, 4 ), 999.9999 ) as CLC_RATE
        from NBUR_DM_ACCOUNTS a
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = a.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
        left
        join NBUR_DM_BALANCES_DAILY b
         on ( b.KF = a.KF and b.ACC_ID = a.ACC_ID )
        left
        join INT_ACCN i
          on ( i.KF = a.KF and i.ACC = a.ACC_ID )
        left
        join ( select KF, ACC, ID, BDAT, IR, BR, OP
                 from INT_RATN
                where ( ACC, ID, BDAT ) in ( select ACC, ID, max(BDAT)
                                               from INT_RATN
                                              where BDAT <= p_report_date
                                              group by ACC, ID )
             ) r
          on ( r.KF = i.KF and r.ACC = i.ACC and r.ID = i.ID )
        left
        join ( select KF
                    , BR_ID
                    , KV
                    , 0 as LWR_LMT
                    , 999999999999999999999999 as UPR_LMT
                    , RATE
                    , 'N' as BR_TP
                 from BR_NORMAL_EDIT
                where ( KF, BR_ID, KV, BDATE ) in ( select rv.KF, rv.BR_ID, rv.KV, max(rv.BDATE)
                                                      from BR_NORMAL_EDIT rv
                                                      join BRATES rc
                                                        on ( rv.BR_ID = rc.BR_ID )
                                                     where rc.BR_TYPE = 1
                                                       and rv.BDATE <= p_report_date
                                                     group by rv.KF, rv.BR_ID, rv.KV )
                union all
               select KF
                    , BR_ID
                    , KV
                    , lag( S, 1, -1 ) over ( partition by BR_ID, KV order by s) + 1 as LWR_LMT
                    , S as UPR_LMT
                    , RATE
                    , 'T' as BR_TP
                 from BR_TIER_EDIT
                where ( KF, BR_ID, KV, S, BDATE ) in ( select rv.KF, rv.BR_ID, rv.KV, rv.S, max(rv.BDATE)
                                                         from BR_TIER_EDIT rv
                                                         join BRATES rc
                                                           on ( rv.BR_ID = rc.BR_ID )
                                                        where rc.BR_TYPE > 1
                                                          and rv.BDATE <= p_report_date
                                                        group by rv.KF, rv.BR_ID, rv.KV, rv.S )
             ) s
          on ( r.KF = s.KF and r.BR = s.BR_ID and a.KV = s.KV and nvl(b.OST,0) between s.LWR_LMT and s.UPR_LMT )
       where a.OPEN_DATE <= p_report_date
         and a.CLOSE_DATE Is Null
         and i.ID Is Not Null
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_ACNT_RATES
           ( REPORT_DATE, KF, ACC_ID, RATE_TP
           , FRQ_TP, ACR_ACC_ID, PNL_ACC_ID, RATE_DT, RATE_VAL )
      select /*+ PARALLEL( 4 ) */ p_report_date
           , a.KF, a.ACC_ID
           , i.ID, i.FREQ, i.ACRA, i.ACRB, r.BDAT
           , least( round( case
              when r.BR Is Null
              then r.IR
              when r.IR Is Null
              then s.RATE
              else -- ( r.IR Is Null AND r.BR Is Null ) or ( r.IR Is Not Null AND r.BR Is Not Null )
                case
                  when r.OP = 1
                  then r.IR + s.RATE
                  when r.OP = 2
                  then r.IR - s.RATE
                  when r.OP = 3
                  then r.IR * s.RATE
                  when r.OP = 4
                  then r.IR / s.RATE
                  else Null -- r.OP = 0 OR r.OP Is Null
                end
           end, 4 ), 999.9999 ) as CLC_RATE
        from NBUR_DM_ACCOUNTS a
        left
        join NBUR_DM_BALANCES_DAILY b
         on ( b.KF = a.KF and b.ACC_ID = a.ACC_ID )
        left
        join INT_ACCN i
          on ( i.KF = a.KF and i.ACC = a.ACC_ID )
        left
        join ( select KF, ACC, ID, BDAT, IR, BR, OP
                 from INT_RATN
                where ( ACC, ID, BDAT ) in ( select ACC, ID, max(BDAT)
                                               from INT_RATN
                                              where KF = p_kf
                                                and BDAT <= p_report_date
                                              group by ACC, ID )
             ) r
          on ( r.KF = i.KF and r.ACC = i.ACC and r.ID = i.ID )
        left
        join ( select BR_ID
                    , KV
                    , 0 as LWR_LMT
                    , 999999999999999999999999 as UPR_LMT
                    , RATE
                    , 'N' as BR_TP
                 from BR_NORMAL_EDIT
                where ( KF, BR_ID, KV, BDATE ) in ( select rv.KF, rv.BR_ID, rv.KV, max(rv.BDATE)
                                                      from BR_NORMAL_EDIT rv
                                                      join BRATES rc
                                                        on ( rv.BR_ID = rc.BR_ID )
                                                     where rv.KF = p_kf
                                                       and rc.BR_TYPE = 1
                                                       and rv.BDATE <= p_report_date
                                                     group by rv.KF, rv.BR_ID, rv.KV )
                union all
               select BR_ID
                    , KV
                    , lag( S, 1, -1 ) over ( partition by BR_ID, KV order by S ) + 1 as LWR_LMT
                    , S as UPR_LMT
                    , RATE
                    , 'T' as BR_TP
                 from BR_TIER_EDIT
                where ( KF, BR_ID, KV, S, BDATE ) in ( select rv.KF, rv.BR_ID, rv.KV, rv.S, max(rv.BDATE)
                                                         from BR_TIER_EDIT rv
                                                         join BRATES rc
                                                           on ( rv.BR_ID = rc.BR_ID )
                                                        where rv.KF = p_kf
                                                          and rc.BR_TYPE > 1
                                                          and rv.BDATE <= p_report_date
                                                        group by rv.KF, rv.BR_ID, rv.KV, rv.S )
             ) s
          on ( r.BR = s.BR_ID and a.KV = s.KV and nvl(b.OST,0) between s.LWR_LMT and s.UPR_LMT )
       where a.KF = p_kf
         and a.OPEN_DATE <= p_report_date
         and a.CLOSE_DATE Is Null
         and i.ID Is Not Null
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end P_LOAD_ACNT_RATES;


  --
  --
  --
  procedure P_LOAD_AGRM_RATES
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>P_LOAD_AGRM_RATES</b> - наповнення даними вітрини процентних карток рахунків
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини процентних карток рахунків
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_AGRM_RATES';
    l_object_name         varchar2(100) := 'NBUR_DM_AGRM_RATES';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_AGRM_RATES
           ( REPORT_DATE, KF, AGRM_ID, ACC_ID
           , RATE_TP, FRQ_TP, ACR_ACC_ID, PNL_ACC_ID, RATE_DT, RATE_VAL )
      select /*+ PARALLEL( 8 ) */ p_report_date
           , ac.KF, ac.AGRM_ID, ac.ACC_ID
           , ag.RATE_TP, ag.FRQ_TP, ag.ACR_ACC_ID, ag.PNL_ACC_ID, ag.RATE_DT, ag.RATE_VAL
        from NBUR_DM_AGRM_ACCOUNTS ac
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = ac.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
        join NBUR_DM_ACNT_RATES ag
          on ( ag.KF = ac.KF and ag.ACC_ID = ac.ACC_ID )
       where ac.KF = p_kf
--      select /*+ PARALLEL( 8 ) */ p_report_date
--           , a.KF, a.AGRM_ID, r.ACC, r.ID, r.FREQ, r.ACRA, r.ACRB, r.BDAT
--           , least( round( case
--              when r.BR Is Null
--              then r.IR
--              when r.IR Is Null
--              then s.RATE
--              else -- ( r.IR Is Null AND r.BR Is Null ) or ( r.IR Is Not Null AND r.BR Is Not Null )
--                case
--                  when r.OP = 1
--                  then r.IR + s.RATE
--                  when r.OP = 2
--                  then r.IR - s.RATE
--                  when r.OP = 3
--                  then r.IR * s.RATE
--                  when r.OP = 4
--                  then r.IR / s.RATE
--                  else Null -- r.OP = 0 OR r.OP Is Null
--                end
--           end, 4 ), 999.9999 ) as CLC_RATE
--        from ( select /*+ NO_PARALLEL */
--                      er.KF, er.ACC, er.ID, er.BDAT, er.IR, er.BR, er.OP
--                    , i.FREQ, i.ACRA, i.ACRB
--                 from INT_RATN er
--                 join INT_ACCN i
--                   on ( i.KF = er.KF and i.ACC    = er.ACC and i.ID = er.ID )
--                 join NBUR_DM_ACCOUNTS a -- обмеження вибірки по діючих рахунках на звітну дату
--                   on ( a.KF = er.KF and a.ACC_ID = er.ACC )
--                where er.KF = p_kf
--                  and ( er.ACC, er.ID, er.BDAT ) = ( select ir.ACC, ir.ID, max(ir.BDAT)
--                                                       from INT_RATN ir
--                                                      where ir.BDAT <= p_report_date
--                                                        and ir.KF    = er.KF
--                                                        and ir.ACC   = er.ACC
--                                                        and ir.ID    = er.ID
--                                                      group by ir.ACC, ir.ID )
--                  and nvl(er.IR,er.BR) Is NOT Null
--             ) r
--        left
--        join NBUR_DM_AGRM_ACCOUNTS a
--          on ()
--        left
--        join NBUR_DM_BALANCES_DAILY b
--         on ( b.KF = a.KF and b.ACC_ID = a.ACC_ID )
--        left
--
--        left
----         join ( select KF, ACC, ID, BDAT, IR, BR, OP
----                  from INT_RATN
----                 where ( ACC, ID, BDAT ) in ( select ACC, ID, max(BDAT)
----                                                from INT_RATN
----                                               where BDAT <= p_report_date
----                                               group by ACC, ID )
----              ) r
----           on ( r.KF = i.KF and r.ACC = i.ACC and r.ID = i.ID )
--        left
--        join ( select BR_ID
--                    , KV
--                    , 0 as LWR_LMT
--                    , 999999999999999999999999 as UPR_LMT
--                    , RATE
--                    , 'N' as BR_TP
--                 from BR_NORMAL_EDIT
--                where ( BR_ID, KV, BDATE ) in ( select rv.BR_ID, rv.KV, max(rv.BDATE)
--                                                  from BR_NORMAL_EDIT rv
--                                                  join BRATES rc
--                                                    on ( rv.BR_ID = rc.BR_ID )
--                                                 where rc.BR_TYPE = 1
--                                                   and rv.BDATE <= p_report_date
--                                                 group by rv.BR_ID, rv.KV )
--                union all
--               select BR_ID
--                    , KV
--                    , lag( S, 1, -1 ) over ( partition by BR_ID, KV order by s) + 1 as LWR_LMT
--                    , S as UPR_LMT
--                    , RATE
--                    , 'T' as BR_TP
--                 from BR_TIER_EDIT
--                where ( BR_ID, KV, S, BDATE ) in ( select BR_ID, KV, S, max(BDATE)
--                                                     from BR_TIER_EDIT
--                                                    where BDATE <= p_report_date
--                                                    group by BR_ID, KV, S )
--             ) s
--          on ( r.BR = s.BR_ID and a.CCY_ID = s.KV and nvl(b.OST,0) between s.LWR_LMT and s.UPR_LMT )
--       where i.ID Is Not Null
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_AGRM_RATES
           ( REPORT_DATE, KF, AGRM_ID, ACC_ID
           , RATE_TP, FRQ_TP, ACR_ACC_ID, PNL_ACC_ID, RATE_DT, RATE_VAL )
      select /*+ PARALLEL( 4 ) */ p_report_date
           , ac.KF, ac.AGRM_ID, ac.ACC_ID
           , ag.RATE_TP, ag.FRQ_TP, ag.ACR_ACC_ID, ag.PNL_ACC_ID, ag.RATE_DT, ag.RATE_VAL
        from NBUR_DM_AGRM_ACCOUNTS ac
        join NBUR_DM_ACNT_RATES ag
          on ( ag.KF = ac.KF and ag.ACC_ID = ac.ACC_ID )
       where ac.KF = p_kf
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end P_LOAD_AGRM_RATES;

  --
  --
  --
  procedure LOAD_AGREEMENTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>P_LOAD_AGRM_RATES</b> - ...
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_AGREEMENTS';
    l_object_name         varchar2(100) := 'NBUR_DM_AGREEMENTS';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_AGREEMENTS
           ( REPORT_DATE, KF, AGRM_ID, AGRM_NUM, AGRM_TP, AGRM_STE, BEG_DT, END_DT
           , INL_AMNT, CRN_AMNT, DBT_FRQ_TP, DBT_INL_DT, DBT_MAT_DAY
           , INT_FRQ_TP, INT_INL_DT, INT_MAT_DAY, PRTFL_TP, CCY_ID, CUST_ID )
      select p_report_date, KF, AGRM_ID, AGRM_NUM, AGRM_TP, AGRM_STE, BEG_DT, END_DT
           , INL_AMNT, CRN_AMNT, DBT_FRQ_TP, DBT_INL_DT, DBT_MAT_DAY
           , INT_FRQ_TP, INT_INL_DT, INT_MAT_DAY, PRTFL_TP, CCY_ID, CUST_ID
        from ( select /*+ PARALLEL( 8 ) */ d.KF
                    , d.ND    as AGRM_ID
                    , d.CC_ID as AGRM_NUM
                    , d.VIDD  as AGRM_TP
                    , d.SOS   as AGRM_STE
                    , d.SDATE as BEG_DT
                    , d.wdate as END_DT
                    , d.SDOG  as INL_AMNT
                    , d.LIMIT as CRN_AMNT
                    , c.FREQ  as DBT_FRQ_TP  -- (nFREQ)  Періодичність погашення основного боргу
                    , null    as DBT_INL_DT  --
                    , i.S     as DBT_MAT_DAY -- (dfDen)  День погашення основного боргу
                    , i.FREQ  as INT_FRQ_TP  -- (nFREQP) Періодичність погашення процентного боргу
                    , null    as INT_INL_DT  --
                    , null    as INT_MAT_DAY --
                    , 'CCK'   as PRTFL_TP
                    , a.KV    as CCY_ID
                    , a.CUST_ID
                 from NBUR_DM_ACCOUNTS a
                 join INT_ACCN i
                   on ( i.KF = a.KF and i.ACC = a.ACC_ID and i.ID = 0 )
                 join ND_ACC   n
                   on ( n.KF = a.KF and n.ACC = a.ACC_ID )
                 join CC_ADD   c
                   on ( c.KF = n.KF and c.ND = n.ND and c.ADDS = 0 )
                 join CC_DEAL d
                   on ( d.KF = n.KF and d.ND = n.ND )
                 join ( select KF, ND, TAG, TXT
                          from ND_TXT
                         where TAG in ( 'I_CR9', 'PR_TR'
                                      , 'FREQ' , 'FREQP'
                                      , 'DATSN', 'DAYSN' )
                      ) w
                   on ( w.KF = a.KF and w.ND = n.ND )
                where a.ACC_NUM like '8999%'
                  and a.OPEN_DATE <= p_report_date
                  and a.CLOSE_DATE is null
             )
        union all
       select p_report_date
            , d.KF
            , d.DPU_ID  as AGRM_ID
            , d.ND      as AGRM_NUM
            , d.VIDD    as AGRM_TP
            , case
                when ( d.CLOSED = 0 )
                then 10
                else 15
              end       as AGRM_STE
            , d.DAT_BEGIN
            , d.DAT_END
            , d.SUM     as INL_AMNT
            , d.SUM
            , 400                        as DBT_FRQ_TP  -- в кінці строку
            , d.DATV                     as DBT_INL_DT  --
            , extract( day from d.DATV ) as DBT_MAT_DAY --
            , d.FREQV                    as INT_FRQ_TP  --
            , case d.FREQV
                when   5 then add_months( d.DAT_BEGIN, 1 )                -- Щомісячно
                when   7 then add_months( d.DAT_BEGIN, 3 )                -- Щоквартально
                when  12 then add_months( trunc(d.DAT_BEGIN,'YYYY'), 12 ) -- Раз на рік (в кінці року)
                when  30 then ( d.DAT_BEGIN + 30 )                        -- Раз на 30 днів
                when 180 then add_months( d.DAT_BEGIN, 6 )                -- 1 раз на пів року
                when 360 then add_months( d.DAT_BEGIN,12 )                -- Щорічно
                when 400 then d.DATV                                      -- В кінці терміну
                else Null
              end as INT_INL_DT
            , extract( day from d.DAT_BEGIN ) as INT_MAT_DAY
            , 'DPU'   as PRTFL_TP
            , a.KV    as CCY_ID
            , d.RNK   as CUST_ID
         from DPU_DEAL d
         join NBUR_DM_ACCOUNTS a
           on ( a.KF = d.KF and a.ACC_ID = d.ACC )
        union all
       select p_report_date
            , d.KF
            , d.DEPOSIT_ID
            , d.ND
            , d.VIDD
            , 10 as AGRM_STE
            , d.DAT_BEGIN
            , d.DAT_END
            , d.LIMIT
            , d.LIMIT
            , 400                           as DBT_FRQ_TP  -- в кінці строку
            , d.DAT_END                     as DBT_INL_DT  --
            , extract( day from d.DAT_END ) as DBT_MAT_DAY --
            , d.FREQ                        as INT_FRQ_TP  --
            , case d.FREQ
                when   5 then add_months( d.DAT_BEGIN, 1 )                -- Щомісячно
                when   7 then add_months( d.DAT_BEGIN, 3 )                -- Щоквартально
                when  12 then add_months( trunc(d.DAT_BEGIN,'YYYY'), 12 ) -- Раз на рік (в кінці року)
                when  30 then ( d.DAT_BEGIN + 30 )                        -- Раз на 30 днів
                when 180 then add_months( d.DAT_BEGIN, 6 )                -- 1 раз на пів року
                when 360 then add_months( d.DAT_BEGIN,12 )                -- Щорічно
                when 400 then d.DAT_END                                   -- В кінці терміну
                else Null
              end as INT_INL_DT
            , extract( day from d.DAT_BEGIN ) as INT_MAT_DAY
            , 'DPT'   as PRTFL_TP
            , d.KV    as CCY_ID
            , d.RNK   as CUST_ID
         from DPT_DEPOSIT d
        union all
       select p_report_date -- портфель цінних паперів
            , sd.KF
            , sd.REF           as AGRM_ID
            , o.ND             as AGRM_NUM
            , to_number(a.NBS) as AGRM_TP
            , case
                when ACTIVE = 1
                then 10
                else 15
              end             as AGRM_STE
            , sd.DAT_UG       as BEG_DT
            , a.MATURITY_DATE as END_DT
            , o.S             as INL_AMNT
            , o.S             as CRN_AMNT
            , null            as DBT_FRQ_TP
            , null            as DBT_INL_DT
            , null            as DBT_MAT_DAY
            , null            as INT_FRQ_TP
            , null            as INT_INL_DT
            , null            as INT_MAT_DAY
            , 'SCR'           as PRTFL_TP
            , a.KV            as CCY_ID
            , a.CUST_ID       as CUST_ID
         from CP_DEAL     sd
         join NBUR_DM_ACCOUNTS a
           on ( a.KF = sd.KF and a.ACC_ID = sd.ACC )
         join OPER o
           on ( o.KF = sd.KF and o.REF = sd.REF )
        union all
       select p_report_date
            , b.KF
            , b.AGRM_ID
            , null                         as AGRM_NUM
            , 2625                         as AGRM_TP
            , b.AGRM_STE
            , nvl(BEG_DT,a.OPEN_DATE     ) as BEG_DT
            , nvl(END_DT,a.MATURITY_DATE ) as END_DT
            , 0                            as INL_AMNT
            , 0                            as CRN_AMNT
            , 2                            as DBT_FRQ_TP
            , null                         as DBT_INL_DT
            , null                         as DBT_MAT_DAY
            , 5                            as INT_FRQ_TP
            , null                         as INT_INL_DT
            , null                         as INT_MAT_DAY
            , PRTFL_TP
            , a.KV                         as CCY_ID
            , a.CUST_ID                    as CUST_ID
         from ( select KF -- портфель БПК ( новий OW4 )
                     , ND                      as AGRM_ID
                     , DAT_BEGIN               as BEG_DT
                     , DAT_END                 as END_DT
                     , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                     , 'OW4'                   as PRTFL_TP
                     , ACC_PK
                  from W4_ACC
                 union all
                select KF  -- портфель БПК ( старий BPK )
                     , ND                      as AGRM_ID
                     , null                    as DAT_BEGIN
                     , null                    as DAT_END
                     , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                     , 'OW4'                   as PRTFL_TP
                     , ACC_PK
                  from BPK_ACC
              ) b
         join NBUR_DM_ACCOUNTS a
           on ( a.KF = b.KF and a.ACC_ID = b.ACC_PK )
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_AGREEMENTS
           ( REPORT_DATE, KF, AGRM_ID, AGRM_NUM, AGRM_TP, AGRM_STE, BEG_DT, END_DT
           , INL_AMNT, CRN_AMNT, DBT_FRQ_TP, DBT_INL_DT, DBT_MAT_DAY
           , INT_FRQ_TP, INT_INL_DT, INT_MAT_DAY, PRTFL_TP, CCY_ID, CUST_ID )
      select /*+ PARALLEL( 4 ) */
             p_report_date, KF, AGRM_ID, AGRM_NUM, AGRM_TP, AGRM_STE, BEG_DT, END_DT
           , INL_AMNT, CRN_AMNT, DBT_FRQ_TP, DBT_INL_DT, DBT_MAT_DAY
           , INT_FRQ_TP, INT_INL_DT, INT_MAT_DAY, PRTFL_TP, CCY_ID, CUST_ID
        from ( select d.KF
                    , d.ND         as AGRM_ID
                    , d.CC_ID      as AGRM_NUM
                    , d.VIDD       as AGRM_TP
                    , d.SOS        as AGRM_STE
                    , d.SDATE      as BEG_DT
                    , d.WDATE      as END_DT
                    , d.SDOG       as INL_AMNT
                    , d.LIMIT      as CRN_AMNT
                    , c.FREQ       as DBT_FRQ_TP  -- Періодичність погашення основного боргу
                    , i.APL_DAT    as DBT_INL_DT  -- Перша платіжна дата (дата першого погашення боргу)
                    , i.S          as DBT_MAT_DAY -- День погашення основного боргу
                    , i.FREQ       as INT_FRQ_TP  -- Періодичність погашення процентного боргу
                    , w.INT_INL_DT as INT_INL_DT  -- Дата початку погашення відсотків
                    , coalesce(w.INT_MAT_DAY, extract( day from d.SDATE )) as INT_MAT_DAY -- День погашення відсотків
                    , 'CCK'   as PRTFL_TP
                    , a.KV    as CCY_ID
                    , a.CUST_ID
                 from NBUR_DM_ACCOUNTS a
                 join INT_ACCN i
                   on ( i.KF = a.KF and i.ACC = a.ACC_ID and i.ID = 0 )
                 join ND_ACC   n
                   on ( n.KF = a.KF and n.ACC = a.ACC_ID )
                 join CC_ADD   c
                   on ( c.KF = n.KF and c.ND = n.ND and c.ADDS = 0 )
                 join CC_DEAL d
                   on ( d.KF = n.KF and d.ND = n.ND )
                 join ( select KF, ND
                             , case
                                 when I_CR9 = '1'
                                 then 0
                                 else 1
                               end          as RESTORE_F  -- Відновлювальна Кред.Дінія (1-Так/0-Ні)
                             , case
                                 when PR_TR = '1'
                                 then 1
                                 else 0
                               end          as TRANCHE_F   -- Ознака траншів (1-Так/0-Ні)
--                           , FREQ         as DBT_FRQ_TP  -- Періодичність погашення боргу
--                           , FREQP        as INT_FRQ_TP  -- Періодичність погашення відсотків
                             , case
                                 when regexp_like(DATSN,'^(\d{2}.\d{2}.\d{4})$')
                                 then to_date(DATSN,'dd-mm-yyyy')
                                 else null
                               end          as INT_INL_DT  -- Дата першого погашення відсотків
                             , case
                                 when regexp_like(DAYSN,'^(\d{1,2})$')
                                 then to_number(DAYSN)
                                 else null
                               end          as INT_MAT_DAY -- День погашення відсотків
                          from ( select KF, ND, TAG, TXT
                                   from ND_TXT
                                  where TAG in ( 'I_CR9', 'PR_TR'
--                                             , 'FREQ' , 'FREQP'
                                               , 'DATSN', 'DAYSN' )
                               ) pivot ( max(TXT) for TAG in ( 'I_CR9' as I_CR9, 'PR_TR' as PR_TR
--                                                           , 'FREQ'  as FREQ , 'FREQP' as FREQP
                                                             , 'DATSN' as DATSN, 'DAYSN' as DAYSN )
                                       )
                      ) w
                   on ( w.KF = n.KF and w.ND = n.ND )
                where a.KF = p_kf
                  and a.ACC_NUM like '8999%'
                  and a.OPEN_DATE <= p_report_date
                  and a.CLOSE_DATE is null
             )
       union all
      select p_report_date
           , d.KF
           , d.DPU_ID  as AGRM_ID
           , d.ND      as AGRM_NUM
           , d.VIDD    as AGRM_TP
           , case
               when ( d.CLOSED = 0 )
               then 10
               else 15
             end       as AGRM_STE
           , d.DAT_BEGIN
           , d.DAT_END
           , d.SUM     as INL_AMNT
           , d.SUM
           , 400                        as DBT_FRQ_TP  -- в кінці строку
           , d.DATV                     as DBT_INL_DT  --
           , extract( day from d.DATV ) as DBT_MAT_DAY --
           , d.FREQV                    as INT_FRQ_TP  --
           , case d.FREQV
               when   5 then add_months( d.DAT_BEGIN, 1 )                -- Щомісячно
               when   7 then add_months( d.DAT_BEGIN, 3 )                -- Щоквартально
               when  12 then add_months( trunc(d.DAT_BEGIN,'YYYY'), 12 ) -- Раз на рік (в кінці року)
               when  30 then ( d.DAT_BEGIN + 30 )                        -- Раз на 30 днів
               when 180 then add_months( d.DAT_BEGIN, 6 )                -- 1 раз на пів року
               when 360 then add_months( d.DAT_BEGIN,12 )                -- Щорічно
               when 400 then d.DATV                                      -- В кінці терміну
               else Null
             end as INT_INL_DT
           , extract( day from d.DAT_BEGIN ) as INT_MAT_DAY
           , 'DPU'   as PRTFL_TP
           , a.KV    as CCY_ID
           , d.RNK   as CUST_ID
        from DPU_DEAL d
        join NBUR_DM_ACCOUNTS a
          on ( a.KF = d.KF and a.ACC_ID = d.ACC )
       where d.KF = p_kf
       union all
      select p_report_date
           , d.KF
           , d.DEPOSIT_ID
           , d.ND
           , d.VIDD
           , 10 as AGRM_STE
           , d.DAT_BEGIN
           , d.DAT_END
           , d.LIMIT
           , d.LIMIT
           , 400                           as DBT_FRQ_TP  -- в кінці строку
           , d.DAT_END                     as DBT_INL_DT  --
           , extract( day from d.DAT_END ) as DBT_MAT_DAY --
           , d.FREQ                        as INT_FRQ_TP  --
           , case d.FREQ
               when   5 then add_months( d.DAT_BEGIN, 1 )                -- Щомісячно
               when   7 then add_months( d.DAT_BEGIN, 3 )                -- Щоквартально
               when  12 then add_months( trunc(d.DAT_BEGIN,'YYYY'), 12 ) -- Раз на рік (в кінці року)
               when  30 then ( d.DAT_BEGIN + 30 )                        -- Раз на 30 днів
               when 180 then add_months( d.DAT_BEGIN, 6 )                -- 1 раз на пів року
               when 360 then add_months( d.DAT_BEGIN,12 )                -- Щорічно
               when 400 then d.DAT_END                                   -- В кінці терміну
               else Null
             end as INT_INL_DT
           , extract( day from d.DAT_BEGIN ) as INT_MAT_DAY
           , 'DPT'   as PRTFL_TP
           , d.KV    as CCY_ID
           , d.RNK   as CUST_ID
        from DPT_DEPOSIT d
       where d.KF = p_kf
       union all
      select p_report_date -- портфель цінних паперів
           , sd.KF
           , sd.REF           as AGRM_ID
           , o.ND             as AGRM_NUM
           , to_number(a.NBS) as AGRM_TP
           , case
               when ACTIVE = 1
               then 10
               else 15
             end             as AGRM_STE
           , sd.DAT_UG       as BEG_DT
           , a.MATURITY_DATE as END_DT
           , o.S             as INL_AMNT
           , o.S             as CRN_AMNT
           , null            as DBT_FRQ_TP
           , null            as DBT_INL_DT
           , null            as DBT_MAT_DAY
           , null            as INT_FRQ_TP
           , null            as INT_INL_DT
           , null            as INT_MAT_DAY
           , 'SCR'           as PRTFL_TP
           , a.KV            as CCY_ID
           , a.CUST_ID       as CUST_ID
        from CP_DEAL     sd
        join NBUR_DM_ACCOUNTS a
          on ( a.KF = sd.KF and a.ACC_ID = sd.ACC )
        join OPER o
          on ( o.KF = sd.KF and o.REF = sd.REF )
       where sd.KF = p_kf
       union all
      select p_report_date
           , b.KF
           , b.AGRM_ID
           , null                         as AGRM_NUM
           , 2625                         as AGRM_TP
           , b.AGRM_STE
           , nvl(BEG_DT,a.OPEN_DATE     ) as BEG_DT
           , nvl(END_DT,a.MATURITY_DATE ) as END_DT
           , 0                            as INL_AMNT
           , 0                            as CRN_AMNT
           , 2                            as DBT_FRQ_TP
           , null                         as DBT_INL_DT
           , null                         as DBT_MAT_DAY
           , 5                            as INT_FRQ_TP
           , null                         as INT_INL_DT
           , null                         as INT_MAT_DAY
           , PRTFL_TP
           , a.KV                         as CCY_ID
           , a.CUST_ID                    as CUST_ID
        from ( select KF -- портфель БПК ( новий OW4 )
                    , ND                      as AGRM_ID
                    , DAT_BEGIN               as BEG_DT
                    , DAT_END                 as END_DT
                    , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                    , 'OW4'                   as PRTFL_TP
                    , ACC_PK
                 from W4_ACC
                where KF = p_kf
                union all
               select KF  -- портфель БПК ( старий BPK )
                    , ND                      as AGRM_ID
                    , null                    as DAT_BEGIN
                    , null                    as DAT_END
                    , nvl2(DAT_CLOSE, 15, 10) as AGRM_STE
                    , 'OW4'                   as PRTFL_TP
                    , ACC_PK
                 from BPK_ACC
                where KF = p_kf
             ) b
        join NBUR_DM_ACCOUNTS a
          on ( a.KF = b.KF and a.ACC_ID = b.ACC_PK )
         LOG ERRORS
        INTO NBUR_DM_AGREEMENTS_ERRLOG ( l_err_tag )
      REJECT LIMIT UNLIMITED
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS( l_object_name||' for vrsn_id='||p_version_id||' rpt_dt='||to_char(p_report_date,fmt_dt)||' kf='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_AGREEMENTS;

  --
  --
  --
  procedure LOAD_TXN_SYMBOLS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_TXN_SYMBOLS</b> - наповнення даними вітрини касових (і не тільки) символів документів
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини касових (і не тільки) символів
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_TXN_SYMBOLS';
    l_object_name         varchar2(100) := 'NBUR_DM_TXN_SYMBOLS';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_TXN_SYMBOLS
           ( REPORT_DATE, KF, REF, STMT, SYMB_TP, SYMB_VAL )
      select /*+ PARALLEL( 8 ) */ txn.REPORT_DATE, txn.KF, txn.REF, txn.STMT
           , 1 as SYMB_TP
           , case
               when ( txn.TT = doc.TT )
               then lpad(nvl(doc.SK,tts.SK),2,'0')
               else lpad(nvl(tts.SK,dtl.SK),2,'0')
             end as SYMB_VAL
        from NBUR_DM_TRANSACTIONS txn
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = txn.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
        left
        join OPER doc
          on ( doc.KF = txn.KF and doc.ref = txn.REF )
        left
        join ( select TT, SK
                 from TTS
                where SK IS Not Null
             ) tts
          on ( tts.TT = txn.TT )
        left
        join ( select KF, REF
                    , case
                        when regexp_like(VALUE,'^(\d{1,2})$')
                        then VALUE
                        else Null
                      end as SK
                 from OPERW
                where TAG = 'SK'
             ) dtl
          on ( dtl.REF = txn.REF )
       where txn.KV = 980
         and ( regexp_like( txn.ACC_NUM_CR, '^(100[1-4])' )
               or
               regexp_like( txn.ACC_NUM_DB, '^(100[1-4])' )
             )
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_TXN_SYMBOLS
           ( REPORT_DATE, KF, REF, STMT, SYMB_TP, SYMB_VAL )
      select /*+ PARALLEL( 4 ) */
             txn.REPORT_DATE, txn.KF, txn.REF, txn.STMT
           , 1 as SYMB_TP
           , case
               when ( txn.TT = doc.TT )
               then lpad(nvl(doc.SK,tts.SK),2,'0')
               else lpad(nvl(tts.SK,dtl.SK),2,'0')
             end as SYMB_VAL
        from NBUR_DM_TRANSACTIONS txn
        left
        join OPER doc
          on ( doc.KF = txn.KF and doc.ref = txn.REF )
        left
        join ( select TT, SK
                 from TTS
                where SK IS Not Null
             ) tts
          on ( tts.TT = txn.TT )
        left
        join ( select KF, REF
                    , case
                        when regexp_like(VALUE,'^(\d{1,2})$')
                        then VALUE
                        else Null
                      end as SK
                 from OPERW
                where TAG = 'SK'
             ) dtl
          on ( dtl.REF = txn.REF )
       where txn.KF = p_kf
         and txn.KV = 980
         and ( regexp_like( txn.ACC_NUM_CR, '^(100[1-4])' )
               or
               regexp_like( txn.ACC_NUM_DB, '^(100[1-4])' )
             )
         LOG ERRORS
        INTO NBUR_DM_TXN_SYMBOLS_ERRLOG ( l_err_tag )
      REJECT LIMIT UNLIMITED
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_TXN_SYMBOLS;

  --
  --
  --
  procedure LOAD_BALANCES_CLT
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_BALANCES_CLT</b> - наповнення даними вітрини сум забезпечення в розрізі рахунків
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини ...
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_BALANCES_CLT';
    l_object_name         varchar2(100) := 'NBUR_DM_BALANCES_CLT';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_BALANCES_CLT
           ( REPORT_DATE, KF
           , CLT_ACC_ID, CLT_BAL, CLT_BAL_UAH, CLT_CUST_ID
           , AST_ACC_ID, AST_BAL, AST_BAL_UAH, AST_CUST_ID
           , TOT_AST_BAL_UAH,     TOT_CLT_BAL_UAH
           , CLT_AMNT, CLT_AMNT_UAH
           , AST_AMNT, AST_AMNT_UAH )
      select /*+ PARALLEL( 8 ) */ p_report_date
           , clt.KF
           , clt.ACC    as CLT_ACC_ID
           , bc.OST     as CLT_BAL
           , bc.OSTQ    as CLT_BAL_UAH
           , bc.CUST_ID as CLT_CUST_ID
           , clt.ACCS   as AST_ACC_ID
           , ba.OST     as AST_BAL
           , ba.OSTQ    as AST_BAL_UAH
           , ba.CUST_ID as AST_CUST_ID
           , sum(abs(ba.OSTQ)) over (partition by clt.ACC ) as TOT_AST_BAL_UAH_BY_CLT
           , sum(abs(bc.OSTQ)) over (partition by clt.ACCS) as TOT_CLT_BAL_UAH_BY_AST
           , round(abs(bc.OST ) * ratio_to_report(abs(ba.OSTQ)) over (partition by clt.ACC )) as CLT_AMNT
           , round(abs(bc.OSTQ) * ratio_to_report(abs(ba.OSTQ)) over (partition by clt.ACC )) as CLT_AMNT_UAH
           , round(abs(ba.OST ) * ratio_to_report(abs(bc.OSTQ)) over (partition by clt.ACCS)) as AST_AMNT
           , round(abs(ba.OSTQ) * ratio_to_report(abs(bc.OSTQ)) over (partition by clt.ACCS)) as AST_AMNT_UAH
        from CC_ACCP clt               -- relation            ( зв'язок рах. забезпечення з рах. активу )
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = clt.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
        join NBUR_DM_BALANCES_DAILY bc -- collateral balances ( залишки забезпечення )
          on ( bc.KF = clt.KF and bc.ACC_ID = clt.ACC )
        join NBUR_DM_BALANCES_DAILY ba -- assets balances     ( залишки активів )
          on ( ba.KF = clt.KF and ba.ACC_ID = clt.ACCS )
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_BALANCES_CLT
           ( REPORT_DATE, KF
           , CLT_ACC_ID, CLT_BAL, CLT_BAL_UAH, CLT_CUST_ID
           , AST_ACC_ID, AST_BAL, AST_BAL_UAH, AST_CUST_ID
           , TOT_AST_BAL_UAH,     TOT_CLT_BAL_UAH
           , CLT_AMNT, CLT_AMNT_UAH
           , AST_AMNT, AST_AMNT_UAH )
      select /*+ PARALLEL( 4 ) */ p_report_date
           , clt.KF
           , clt.ACC    as CLT_ACC_ID
           , bc.OST     as CLT_BAL
           , bc.OSTQ    as CLT_BAL_UAH
           , bc.CUST_ID as CLT_CUST_ID
           , clt.ACCS   as AST_ACC_ID
           , ba.OST     as AST_BAL
           , ba.OSTQ    as AST_BAL_UAH
           , ba.CUST_ID as AST_CUST_ID
           , sum(abs(ba.OSTQ)) over (partition by clt.ACC ) as TOT_AST_BAL_UAH_BY_CLT
           , sum(abs(bc.OSTQ)) over (partition by clt.ACCS) as TOT_CLT_BAL_UAH_BY_AST
           , round(abs(bc.OST ) * ratio_to_report(abs(ba.OSTQ)) over (partition by clt.ACC )) as CLT_AMNT
           , round(abs(bc.OSTQ) * ratio_to_report(abs(ba.OSTQ)) over (partition by clt.ACC )) as CLT_AMNT_UAH
           , round(abs(ba.OST ) * ratio_to_report(abs(bc.OSTQ)) over (partition by clt.ACCS)) as AST_AMNT
           , round(abs(ba.OSTQ) * ratio_to_report(abs(bc.OSTQ)) over (partition by clt.ACCS)) as AST_AMNT_UAH
        from CC_ACCP clt               -- relation            ( зв'язок рах. забезпечення з рах. активу )
        join NBUR_DM_BALANCES_DAILY bc -- collateral balances ( залишки забезпечення )
          on ( bc.KF = clt.KF and bc.ACC_ID = clt.ACC )
        join NBUR_DM_BALANCES_DAILY ba -- assets balances     ( залишки активів )
          on ( ba.KF = clt.KF and ba.ACC_ID = clt.ACCS )
       where clt.KF = p_kf
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_BALANCES_CLT;

  --
  --
  --
  procedure LOAD_PROVISIONS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_PROVISIONS</b> - наповнення даними вітрини резервів по активах
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини ...
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_PROVISIONS';
    l_object_name         varchar2(100) := 'NBUR_DM_PROVISIONS';
    l_prvn_dt             rez_protocol.dat%type;
    l_pymt_dt             rez_protocol.dat_bank%type;
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    select last_day(max(DAT)) + 1
         , max(dat_bank) keep (DENSE_RANK LAST ORDER BY dat_bank)
      into l_prvn_dt, l_pymt_dt
      from REZ_PROTOCOL
     where DAT_BANK <= p_report_date;

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_PROVISIONS
           ( REPORT_DATE, KF
           , ID, CCY_ID, CUST_ID, AGRM_ID, AST_ACC_ID, AST_ACC_NUM, AST_CGY
           , PRVN_AMNT, PRVN_AMNT_UAH, PRVN_NIT_AMNT, PRVN_NIT_AMNT_UAH, PRVN_30D_AMNT, PRVN_30D_AMNT_UAH
           , K030, R013, S250, DCN_AMNT, BV, BV_UAH, PV, PV_UAH, CLT_AMNT, CLT_AMNT_UAH
           , PRVN_ACC_ID, PRVN_NIT_ACC_ID, PRVN_30D_ACC_ID, MGTN_DT, REPYMT_AMNT, REPYMT_AMNT_UAH )
      select /*+ PARALLEL( 8 ) */ r.FDAT, r.KF, r.ID
           , r.KV             as CCY_ID
           , r.RNK            as CUST_ID
           , r.ND             as AGRM_ID
           , r.ACC            as AST_ACC_ID
           , r.NLS            as AST_ACC_NUM
           , r.KAT            as AST_CGY
           , r.REZ  * 100     as CLT_AMNT
           , r.REZQ * 100     as CLT_AMNT_UAH
           , r.REZN  * 100    as CLT_NIT_AMNT
           , r.REZNQ * 100    as CLT_NIT_AMNT_UAH
           , r.REZ_30  * 100  as CLT_30D_AMNT
           , r.REZQ_30 * 100  as CLT_30D_AMNT_UAH
           , r.RZ             as K030
           , r.R013
           , r.S250
           , r.DISKONT * 100  as DCN_AMNT
           , r.BV  * 100      as BV
           , r.BVQ * 100      as BV_UAH
           , r.PV  * 100      as PV
           , r.PVQ * 100      as PV_UAH
           , r.ZAL  * 100     as CLT_BAL
           , r.ZALQ * 100     as CLT_BAL_UAH
           , r.ACC_REZ        as CLT_ACC_ID
           , r.ACC_REZN       as CLT_ACC_ID
           , r.ACC_REZ_30     as CLT_30D_ACC_ID
           , r.DAT_MI         as MGTN_DT
           , nvl(p.BAL,    0) as REPYMT_AMNT
           , nvl(p.BAL_UAH,0) as REPYMT_AMNT_UAH
        from NBU23_REZ r
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF = r.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
        left -- Сума списань забогованості за рахунок резерву
        join ( select /*+ PARALLEL( txn, 4 ) */ KF
                    , case when MPLR = 1 then ACC_ID_CR else ACC_ID_DB end as ACC_ID
                    , sum(MPLR*BAL    ) as BAL
                    , sum(MPLR*BAL_UAH) as BAL_UAH
                 from NBUR_DM_TRANSACTIONS_ARCH txn
                 join ( select NBS_REZ as R020_CLT
                             , NBS     as R020_AST
                             , 1       as MPLR
                          from SREZERV_OB22
                         union
                        select NBS, NBS_REZ, -1
                          from SREZERV_OB22
                      ) clt
                   on ( clt.R020_CLT = txn.R020_DB and clt.R020_AST = txn.R020_CR )
                where ( REPORT_DATE, KF, VERSION_ID ) in ( select REPORT_DATE, KF, max(VERSION_ID) as VERSION_ID
                                                             from NBUR_LST_OBJECTS
                                                            where REPORT_DATE between l_pymt_dt and p_report_date
                                                              and OBJECT_ID = l_object_id
                                                              and OBJECT_STATUS in ('FINISHED','BLOCKED')
                                                              and ROW_COUNT > 0
                                                            group by REPORT_DATE, KF )
                group by KF, case when MPLR = 1 then ACC_ID_CR else ACC_ID_DB end
               having sum(MPLR*BAL) > 0

             ) p
          on ( p.KF = r.KF and p.ACC_ID = r.ACC )
       where FDAT = l_prvn_dt
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_PROVISIONS
           ( REPORT_DATE, KF
           , ID, CCY_ID, CUST_ID, AGRM_ID, AST_ACC_ID, AST_ACC_NUM, AST_CGY
           , PRVN_AMNT, PRVN_AMNT_UAH, PRVN_NIT_AMNT, PRVN_NIT_AMNT_UAH, PRVN_30D_AMNT, PRVN_30D_AMNT_UAH
           , K030, R013, S250, DCN_AMNT, BV, BV_UAH, PV, PV_UAH, CLT_AMNT, CLT_AMNT_UAH
           , PRVN_ACC_ID, PRVN_NIT_ACC_ID, PRVN_30D_ACC_ID, MGTN_DT, REPYMT_AMNT, REPYMT_AMNT_UAH )
      select r.FDAT, r.KF, r.ID
           , r.KV            as CCY_ID
           , r.RNK           as CUST_ID
           , r.ND            as AGRM_ID
           , r.ACC           as AST_ACC_ID
           , r.NLS           as AST_ACC_NUM
           , r.KAT           as AST_CGY
           , r.REZ  * 100    as CLT_AMNT
           , r.REZQ * 100    as CLT_AMNT_UAH
           , r.REZN  * 100   as CLT_NIT_AMNT
           , r.REZNQ * 100   as CLT_NIT_AMNT_UAH
           , r.REZ_30  * 100 as CLT_30D_AMNT
           , r.REZQ_30 * 100 as CLT_30D_AMNT_UAH
           , r.RZ            as K030
           , r.R013
           , r.S250
           , r.DISKONT * 100  as DCN_AMNT
           , r.BV  * 100      as BV
           , r.BVQ * 100      as BV_UAH
           , r.PV  * 100      as PV
           , r.PVQ * 100      as PV_UAH
           , r.ZAL  * 100     as CLT_BAL
           , r.ZALQ * 100     as CLT_BAL_UAH
           , r.ACC_REZ        as CLT_ACC_ID
           , r.ACC_REZN       as CLT_ACC_ID
           , r.ACC_REZ_30     as CLT_30D_ACC_ID
           , r.DAT_MI         as MGTN_DT
           , nvl(p.BAL    ,0) as REPYMT_AMNT
           , nvl(p.BAL_UAH,0) as REPYMT_AMNT_UAH
        from NBU23_REZ r
        left -- Сума списань забогованості за рахунок резерву
        join ( select /*+ PARALLEL( txn, 4 ) */
                      case when MPLR = 1 then ACC_ID_CR else ACC_ID_DB end as ACC_ID
                    , sum(MPLR*BAL    ) as BAL
                    , sum(MPLR*BAL_UAH) as BAL_UAH
                 from NBUR_DM_TRANSACTIONS_ARCH txn
                 join ( select NBS_REZ as R020_CLT
                             , NBS     as R020_AST
                             , 1       as MPLR
                          from SREZERV_OB22
                         union
                        select NBS, NBS_REZ, -1
                          from SREZERV_OB22
                      ) clt
                   on ( clt.R020_CLT = txn.R020_DB and clt.R020_AST = txn.R020_CR )
                where ( REPORT_DATE, KF, VERSION_ID ) in ( select REPORT_DATE, KF, max(VERSION_ID) as VERSION_ID
                                                             from NBUR_LST_OBJECTS
                                                            where REPORT_DATE between l_pymt_dt and p_report_date
                                                              and KF = p_kf
                                                              and OBJECT_ID = l_object_id
                                                              and OBJECT_STATUS in ('FINISHED','BLOCKED')
                                                              and ROW_COUNT > 0
                                                            group by REPORT_DATE, KF )
                group by case when MPLR = 1 then ACC_ID_CR else ACC_ID_DB end
               having sum(MPLR*BAL) > 0

             ) p
          on ( p.ACC_ID = r.ACC )
       where FDAT = l_prvn_dt
         and KF   = p_kf
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_PROVISIONS;

  --
  --
  --
  procedure LOAD_PAYMENT_SHD
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_PAYMENT_SHD</b> - наповнення даними вітрини графіків платежів (зниження ліміту кредитування)
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини ...
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_PAYMENT_SHD';
    l_object_name         varchar2(100) := 'NBUR_DM_PAYMENT_SHD';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      null;

    --
    --   insert /*+ APPEND */
    --     into NBUR_DM_PAYMENT_SHD
    --        ( REPORT_DATE, KF
    --        )
    --   select /*+ PARALLEL( 8 ) */ p_report_date, a.KF
    --    from
    --    join NBUR_QUEUE_OBJECTS q
    --      on ( q.KF = .KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
    --   ;
    --
    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_PAYMENT_SHD
           ( REPORT_DATE, KF
           , AGRM_ID, ACC_ID, PYMT_DT, PYMT_AMNT, PYMT_AMNT_UAH, LMT_AMNT, LMT_AMNT_UAH, S240 )
      select p_report_date, lim.KF
           , lim.AGRM_ID
           , acc.ACC_ID
           , lim.PYMT_DT
           , case
               when ( PYMT_DT = MAX_PYMT_DT ) -- прострочка
               then PYMT_AMNT + ( LMT_BAL - CMLV_TOT )
               when ( CMLV_TOT > LMT_BAL )    -- переплата
               then PYMT_AMNT - ( CMLV_TOT - LMT_BAL )
               else PYMT_AMNT                 -- точно по графіку
             end as PYMT_AMNT
           , case
               when ( acc.CCY_ID = 980 )
               then lim.PYMT_AMNT
               else round( lim.PYMT_AMNT * rts.RATE )
             end as PYMT_AMNT_UAH
           , lim.LMT_AMNT
           ,  case
               when ( acc.CCY_ID = 980 )
               then lim.LMT_AMNT
               else round( lim.LMT_AMNT * rts.RATE )
             end as LMT_AMNT_UAH
           , case
               when ( DYS_QTY  =    1 ) then '2' -- Овернайт (на 1 день)
               when ( DYS_QTY <=    7 ) then '3' -- Вiд   2 до 7 днiв
               when ( DYS_QTY <=   21 ) then '4' -- Вiд   8 до 21 дня
               when ( DYS_QTY <=   31 ) then '5' -- Вiд  22 до 31 дня
               when ( DYS_QTY <=   92 ) then '6' -- Вiд  32 до 92 днiв
               when ( DYS_QTY <=  183 ) then '7' -- Вiд  93 до 183 днiв
               when ( DYS_QTY <=  274 ) then 'A' -- Вiд 184 до 274 днiв
               when ( DYS_QTY <=  365 ) then 'B' -- Вiд 275 до 365(366) днiв
               when ( DYS_QTY <=  548 ) then 'C' -- Від 366(367) до 548(549) днiв
               when ( DYS_QTY <=  730 ) then 'D' -- Від 549(550) днів до 2 років
               when ( DYS_QTY <= 1095 ) then 'E' -- Більше 2 до 3 років
               when ( DYS_QTY <= 1825 ) then 'F' -- Більше 3 до 5 років
               when ( DYS_QTY <= 3650 ) then 'G' -- Більше 5 до 10 років
               when ( DYS_QTY  > 3650 ) then 'H' -- Понад 10 років
               else '1' -- На вимогу
             end as S240
        from ( select l.KF
                    , l.ND   as AGRM_ID
                    , l.FDAT as PYMT_DT
                    , ( l.FDAT - p_report_date ) as DYS_QTY
                    , l.LIM2 as LMT_AMNT
                    , l.SUMG as PYMT_AMNT
                    , abs(lb.OST ) as LMT_BAL
                    , abs(lb.OSTQ) as LMT_BAL_UAH
                    , max( case when l.fdat >= p_report_date then l.FDAT else null end ) over ( partition by l.ND ) as MAX_PYMT_DT
                    , min( case when l.fdat >= p_report_date then l.FDAT else null end ) over ( partition by l.ND order by l.fdat ) as MIN_PYMT_DT
                    , sum( case when l.fdat >= p_report_date then l.SUMG else null end ) over ( partition by l.ND order by l.fdat ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) as CMLV_TOT  -- cumulative total
                 from CC_LIM l
                 join NBUR_DM_BALANCES_DAILY lb -- 8999
                   on ( lb.KF = l.KF and lb.ACC_ID = l.ACC )
                where lb.KF = p_kf
                  and lb.OST < 0 -- ??? як себе поведе при відновлювальній Кред. Лінії
                ) lim
           join ( select aa.KF, aa.AGRM_ID, aa.ACC_ID, aa.CCY_ID
                       , a.ACC_NUM, a.OPEN_DATE, a.MATURITY_DATE
                       , b.OST, b.OSTQ
                    from NBUR_DM_AGRM_ACCOUNTS aa
                    join NBUR_DM_ACCOUNTS a
                      on ( a.KF = aa.KF and a.ACC_ID = aa.ACC_ID )
                    join NBUR_DM_BALANCES_DAILY b
                      on ( b.KF = aa.KF and b.ACC_ID = aa.ACC_ID )
                   where a.ACC_TYPE = 'SS'
                ) acc
             on ( acc.KF = lim.KF and acc.AGRM_ID = lim.AGRM_ID )
           join ( select KV          as CCY_ID
                       , RATE_O/BSUM as RATE
                    from CUR_RATES$BASE
                   where ( BRANCH, VDATE, KV ) in ( select BRANCH, max(VDATE), KV
                                                      from CUR_RATES$BASE
                                                     where VDATE <= p_report_date
                                                       and BRANCH = '/'||p_kf||'/'
                                                     group by BRANCH, KV )
                ) rts
             on ( rts.CCY_ID = acc.CCY_ID )
          where PYMT_DT >= MIN_PYMT_DT
            and CMLV_TOT <= (LMT_BAL + PYMT_AMNT)
         ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_PAYMENT_SHD;

  --
  --
  --
  procedure LOAD_CHRON_AVG_BALS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_CHRON_AVG_BALS</b> - наповнення даними вітрини Середньо-хронологічних залишків
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення оперативної (проміжної/non versioned) вітрини Середньо-хронологічних залишків
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_CHRON_AVG_BALS';
    l_object_name         varchar2(100) := 'NBUR_DM_CHRON_AVG_BALS';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_CHRON_AVG_BALS
           ( REPORT_DATE, VERSION_ID, KF
           , ACC_ID, R020, R030, AVG_BAL, AVG_BAL_UAH
           , SUM_CR, SUM_CR_UAH, SUM_DB, SUM_DB_UAH )
      select p_report_date, p_version_id, KF
           , ACC_ID
           , NBS as R020
           , KV  as R030
           , round(sum( case when ( DAY_MUN = 1 ) then BAL_INPT/2     else BAL_INPT     end )/DYS_QTY) as AVG_BAL
           , round(sum( case when ( DAY_MUN = 1 ) then BAL_INPT_UAH/2 else BAL_INPT_UAH end )/DYS_QTY) as AVG_BAL_UAH
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else KOS  end ) as SUM_CR
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else KOSQ end ) as SUM_CR_UAH
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else DOS  end ) as SUM_DB
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else DOSQ end ) as SUM_DB_UAH
        from ( with CDR_DYS as ( select ( add_months(trunc(p_report_date,'MM'),-1) + level - 1 ) as CDR_DT
                                   from dual
                                connect
                                     by ( add_months(trunc(p_report_date,'MM'),-1) + level - 1 ) <= trunc(p_report_date,'MM') ),
                   CALENDAR as ( select cdr.CDR_DT
                                      , extract( DAY from cdr.CDR_DT) as DAY_MUN
                                      , min( cdr.CDR_DT ) over () as MIN_DT
                                      , max( cdr.CDR_DT ) over () as MAX_DT
                                      , ( select min(f.FDAT) from FDAT f where f.FDAT >= cdr.CDR_DT ) BNK_DT
                                   from CDR_DYS cdr )
               select /*+ PARALLEL( 8 ) */ ac.CDR_DT, ac.BNK_DT, ac.DAY_MUN, ac.MIN_DT, ac.MAX_DT, ac.DYS_QTY
                    , ac.KF, ac.ACC_ID, ac.NBS, ac.KV
                    , nvl(( b.OST  - b.KOS  + b.DOS  ),0) as BAL_INPT
                    , nvl(( b.OSTQ - b.KOSQ + b.DOSQ ),0) as BAL_INPT_UAH
                    , nvl(b.KOS,0) as KOS, nvl(b.KOSQ,0)  as KOSQ
                    , nvl(b.DOS,0) as DOS, nvl(b.DOSQ,0)  as DOSQ
                 from ( select c.CDR_DT, c.BNK_DT, c.DAY_MUN, c.MIN_DT, c.MAX_DT
                             , ( c.MAX_DT - c.MIN_DT ) as DYS_QTY
                             , a.KF, a.ACC_ID, a.NBS, a.KV
                          from CALENDAR c
                         cross
                          join ( select t.KF, t.ACC_ID, t.NBS, t.KV
                                   from NBUR_DM_ACCOUNTS t
                                   join NBUR_QUEUE_OBJECTS q
                                      on ( q.KF = t.KF and q.REPORT_DATE = p_report_date and q.ID = l_object_id )
                               ) a
                      ) ac
                 left
--               join SNAP_BALANCES b
--                 on ( b.FDAT = ac.BNK_DT and b.KF = ac.KF and b.ACC = ac.ACC_ID )
                 join NBUR_DM_BALANCES_DAILY_ARCH b
                   on ( b.REPORT_DATE = ac.BNK_DT AND b.KF = ac.KF AND b.ACC_ID = ac.ACC_ID )
                 join NBUR_LST_OBJECTS v
                   on ( v.REPORT_DATE = b.REPORT_DATE AND v.KF = b.KF AND v.VERSION_ID = b.VERSION_ID )
                where v.OBJECT_ID = l_object_id
                  and v.VLD = 0
             )
       group by MIN_DT, KF, ACC_ID, NBS, KV, DYS_QTY
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_CHRON_AVG_BALS
           ( REPORT_DATE, VERSION_ID, KF
           , ACC_ID, R020, R030, AVG_BAL, AVG_BAL_UAH
           , SUM_CR, SUM_CR_UAH, SUM_DB, SUM_DB_UAH )
      select p_report_date, p_version_id, KF
           , ACC_ID
           , NBS as R020
           , KV  as R030
           , round(sum( case when ( DAY_MUN = 1 ) then BAL_INPT/2     else BAL_INPT     end )/DYS_QTY) as AVG_BAL
           , round(sum( case when ( DAY_MUN = 1 ) then BAL_INPT_UAH/2 else BAL_INPT_UAH end )/DYS_QTY) as AVG_BAL_UAH
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else KOS  end ) as SUM_CR
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else KOSQ end ) as SUM_CR_UAH
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else DOS  end ) as SUM_DB
           , sum( case when ( CDR_DT = MAX_DT or CDR_DT <> BNK_DT ) then 0 else DOSQ end ) as SUM_DB_UAH
        from ( with CDR_DYS as ( select ( add_months(trunc(p_report_date,'MM'),-1) + level - 1 ) as CDR_DT
                                   from dual
                                connect
                                     by ( add_months(trunc(p_report_date,'MM'),-1) + level - 1 ) <= trunc(p_report_date,'MM') ),
                   CALENDAR as ( select cdr.CDR_DT
                                      , extract( DAY from cdr.CDR_DT) as DAY_MUN
                                      , min( cdr.CDR_DT ) over () as MIN_DT
                                      , max( cdr.CDR_DT ) over () as MAX_DT
                                      , ( select min(f.FDAT) from FDAT f where f.FDAT >= cdr.CDR_DT ) BNK_DT
                                   from CDR_DYS cdr )
               select /*+ PARALLEL( 8 ) */ ac.CDR_DT, ac.BNK_DT, ac.DAY_MUN, ac.MIN_DT, ac.MAX_DT, ac.DYS_QTY
                    , ac.KF, ac.ACC_ID, ac.NBS, ac.KV
                    , nvl(( b.OST  - b.KOS  + b.DOS  ),0) as BAL_INPT
                    , nvl(( b.OSTQ - b.KOSQ + b.DOSQ ),0) as BAL_INPT_UAH
                    , nvl(b.KOS,0) as KOS, nvl(b.KOSQ,0)  as KOSQ
                    , nvl(b.DOS,0) as DOS, nvl(b.DOSQ,0)  as DOSQ
                 from ( select c.CDR_DT, c.BNK_DT, c.DAY_MUN, c.MIN_DT, c.MAX_DT
                             , ( c.MAX_DT - c.MIN_DT ) as DYS_QTY
                             , a.KF, a.ACC_ID, a.NBS, a.KV
                          from CALENDAR c
                         cross
                          join NBUR_DM_ACCOUNTS a
                         where a.KF = p_kf
                      ) ac
                 left
                 join SNAP_BALANCES b -- NBUR_DM_BALANCES_DAILY_ARCH
                   on ( b.FDAT = ac.BNK_DT and b.KF = ac.KF and b.ACC = ac.ACC_ID )
             )
       group by MIN_DT, KF, ACC_ID, NBS, KV, DYS_QTY
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_CHRON_AVG_BALS;

  --
  --
  --
  procedure LOAD_TRANSACTIONS_CNSL
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_TRANSACTIONS_CNSL</b> - наповнення даними вітрини фінансових транзакцій за місяць, в т.ч. коригуючими
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення консолідованиї вітрини даних фінансових транзакцій за місяць, в т.ч. коригуючими
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_TRANSACTIONS_CNSL';
    l_object_name         varchar2(100) := 'NBUR_DM_TRANSACTIONS_CNSL';
    l_txn_dm_id           pls_integer   := f_get_object_id_by_name('NBUR_DM_TRANSACTIONS');

    l_rpt_mo_frst_bnk_dt  date;
    l_rpt_mo_last_bnk_dt  date;
    l_nxt_mo_frst_bnk_dt  date;
    l_nxt_mo_last_bnk_dt  date;
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

--  -- останній робочий день попереднього міс.
--  l_prv_mo_last_bnk_dt := DAT_NEXT_U( trunc(p_report_date,'MM'), -1 );

    -- перший робочий день звітного міс.
    if ( trunc(p_report_date,'MM') = trunc(p_report_date,'YYYY') )
    then -- без проводок перекриття року (завжди виконуються датою 01 січня)
      l_rpt_mo_frst_bnk_dt := DAT_NEXT_U( trunc(p_report_date,'MM'), 1 );
    else
      l_rpt_mo_frst_bnk_dt := DAT_NEXT_U( trunc(p_report_date,'MM'), 0 );
    end if;

    -- останній робочий день звітного міс.
    l_rpt_mo_last_bnk_dt := DAT_NEXT_U( add_months( trunc(p_report_date,'MM'), 1 ), -1 );

    -- перший робочий день наступного міс.
    l_nxt_mo_frst_bnk_dt := DAT_NEXT_U( add_months( trunc(p_report_date,'MM'), 1 ),  0 );

    -- останній робочий день наступного міс.
    l_nxt_mo_last_bnk_dt := DAT_NEXT_U( add_months( trunc(p_report_date,'MM'), 2 ), -1 );

    bars_audit.trace( '%s: ( rpt_mo_frst_bnk_dt=%s, rpt_mo_last_bnk_dt=%s, nxt_mo_frst_bnk_dt=%s, nxt_mo_last_bnk_dt=%s ).'
                    , title, to_char(l_rpt_mo_frst_bnk_dt,fmt_dt), to_char(l_rpt_mo_last_bnk_dt,fmt_dt)
                           , to_char(l_nxt_mo_frst_bnk_dt,fmt_dt), to_char(l_nxt_mo_last_bnk_dt,fmt_dt) );

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    -- CHECK_OBJECT_DEPENDENCIES
    -- ( p_rpt_dt  => p_report_date
    -- , p_kf      => p_kf
    -- , p_vrsn_id => p_version_id
    -- , p_obj_id  => l_object_id
    -- );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_TRANSACTIONS_CNSL
           ( REPORT_DATE, KF, REF, TT, CCY_ID, BAL, BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR )
      select /*+ PARALLEL( 16 ) */
             txn.REPORT_DATE, txn.KF, txn.REF, txn.TT, txn.KV, txn.BAL, txn.BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR
        from NBUR_DM_TRANSACTIONS_ARCH txn
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF   = txn.KF AND q.REPORT_DATE = p_report_date AND q.ID = l_object_id )
        join OPER doc
          on ( doc.KF = txn.KF AND doc.REF = txn.REF )
       where ( txn.REPORT_DATE, txn.KF, txn.VERSION_ID ) in ( select report_date, kf, max(version_id)
                                                                from NBUR_LST_OBJECTS
                                                               where REPORT_DATE between l_rpt_mo_frst_bnk_dt
                                                                                     and l_rpt_mo_last_bnk_dt
                                                                 and OBJECT_ID = l_txn_dm_id
                                                                 and VLD = 0
                                                               group by report_date, kf )
         and doc.VDAT between l_rpt_mo_frst_bnk_dt
                          and l_rpt_mo_last_bnk_dt
         and doc.VOB not in ( 96, 99 )
         and doc.SOS = 5
       union all
      select /*+ PARALLEL( 16 ) */
             txn.REPORT_DATE, txn.KF, txn.REF, txn.TT, txn.KV, txn.BAL, txn.BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR
        from NBUR_DM_TRANSACTIONS_ARCH txn
        join NBUR_QUEUE_OBJECTS q
          on ( q.KF   = txn.KF AND q.REPORT_DATE = p_report_date AND q.ID = l_object_id )
        join OPER doc
          on ( doc.KF = txn.KF AND doc.REF = txn.REF )
       where ( txn.REPORT_DATE, txn.KF, txn.VERSION_ID ) in ( select REPORT_DATE, KF, max(VERSION_ID)
                                                                from NBUR_LST_OBJECTS
                                                               where REPORT_DATE between l_nxt_mo_frst_bnk_dt
                                                                                     and l_nxt_mo_last_bnk_dt
                                                                 and OBJECT_ID = l_txn_dm_id
                                                                 and VLD = 0
                                                               group by report_date, kf )
         and doc.VDAT = l_rpt_mo_last_bnk_dt
         and doc.VOB in ( 96, 99 )
         and doc.SOS = 5
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_TRANSACTIONS_CNSL
           ( REPORT_DATE, KF, REF, TT, CCY_ID, BAL, BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR )
      select /*+ PARALLEL( 8 ) */
             txn.REPORT_DATE, txn.KF, txn.REF, txn.TT, txn.KV, txn.BAL, txn.BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR
        from NBUR_DM_TRANSACTIONS_ARCH txn
        join OPER doc
          on ( doc.KF = txn.KF AND doc.REF = txn.REF )
       where ( txn.REPORT_DATE, txn.KF, txn.VERSION_ID ) in ( select REPORT_DATE, KF, max(version_id)
                                                                from NBUR_LST_OBJECTS
                                                               where report_date between l_rpt_mo_frst_bnk_dt
                                                                                     and l_rpt_mo_last_bnk_dt
                                                                 and kf        = p_kf
                                                                 and object_id = l_txn_dm_id
                                                                 and OBJECT_STATUS in ('FINISHED','BLOCKED')
                                                               group by report_date, kf )
         and doc.VDAT >= l_rpt_mo_frst_bnk_dt
         and doc.VOB not in ( 96, 99 )
         and doc.SOS = 5
       union all
      select /*+ PARALLEL( 8 ) */
             txn.REPORT_DATE, txn.KF, txn.REF, txn.TT, txn.KV, txn.BAL, txn.BAL_UAH
           , CUST_ID_DB, ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB, NBUC_DB
           , CUST_ID_CR, ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR, NBUC_CR
        from NBUR_DM_TRANSACTIONS_ARCH txn
        join OPER doc
          on ( doc.KF = txn.KF AND doc.REF = txn.REF )
       where ( txn.REPORT_DATE, txn.KF, txn.VERSION_ID ) in ( select report_date, kf, max(version_id)
                                                                from NBUR_LST_OBJECTS
                                                               where report_date between l_nxt_mo_frst_bnk_dt
                                                                                     and l_nxt_mo_last_bnk_dt
                                                                 and kf        = p_kf
                                                                 and object_id = l_txn_dm_id
                                                                 and OBJECT_STATUS in ('FINISHED','BLOCKED')
                                                               group by report_date, kf )
         and doc.VDAT = l_rpt_mo_last_bnk_dt
         and doc.VOB in ( 96, 99 )
         and doc.SOS = 5
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    ---
    -- till procedure PARSING_QUEUE_OBJECTS is not finished
    ---
    if ( REQUIRED_GATHER_STATS( l_object_name, p_kf, l_rowcount ) )
    then

      GATHER_TABLE_STATS
      ( p_tbl_nm   => l_object_name
      , p_kf       => p_kf );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_TRANSACTIONS_CNSL;

  --
  --
  --
  procedure LOAD_PROFIT_AND_LOSS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>LOAD_PROFIT_AND_LOSS</b> - наповнення даними вітрини нарахованих доходів та витрат за місяць
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   Наповнення вітрини даних нарахованих доходів та витрат за місяць
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_PROFIT_AND_LOSS';
    l_object_name         varchar2(100) := 'NBUR_DM_PROFIT_AND_LOSS';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );

    l_object_id := f_get_object_id_by_name(l_object_name);

    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );

    CHECK_OBJECT_DEPENDENCIES
    ( p_rpt_dt  => p_report_date
    , p_kf      => p_kf
    , p_vrsn_id => p_version_id
    , p_obj_id  => l_object_id
    );

    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
    then -- for all KF

      insert /*+ APPEND */
        into NBUR_DM_PROFIT_AND_LOSS
           ( REPORT_DATE, KF
           , ACC_ID, PRFT_AMNT, PRFT_AMNT_UAH, LOSS_AMNT, LOSS_AMNT_UAH )
      select p_report_date, pnl.KF
           , case
               when regexp_like( ACC_NUM_DB, '^70' )
               then ACC_ID_CR -- LOSS
               when regexp_like( ACC_NUM_CR, '^60' )
               then ACC_ID_DB -- PROFIT
               else null      -- OTHER
             end as ACC_ID
           , sum( case when regexp_like( ACC_NUM_DB, '^70' ) then AMNT_CR else 0 end ) as LOSS_AMNT
           , sum( case when regexp_like( ACC_NUM_DB, '^70' ) then AMNT_DB else 0 end ) as LOSS_AMNT_UAH
           , sum( case when regexp_like( ACC_NUM_CR, '^60' ) then AMNT_DB else 0 end ) as PRFT_AMNT
           , sum( case when regexp_like( ACC_NUM_CR, '^60' ) then AMNT_CR else 0 end ) as PRFT_AMNT_UAH
        from ( select txn.KF
                    , nvl(cpd.ACC_ID_DB,   txn.ACC_ID_DB  ) as ACC_ID_DB
                    , nvl(cpd.ACC_NUM_DB,  txn.ACC_NUM_DB ) as ACC_NUM_DB
                    , nvl(cpd.BAL_DB,      txn.BAL        ) as AMNT_DB
                    , nvl(cpc.ACC_ID_CR,   txn.ACC_ID_CR  ) as ACC_ID_CR
                    , nvl(cpc.ACC_NUM_CR,  txn.ACC_NUM_CR ) as ACC_NUM_CR
                    , nvl(cpc.BAL_CR,      txn.BAL        ) as AMNT_CR
                 from NBUR_DM_TRANSACTIONS_CNSL txn
                 join NBUR_QUEUE_OBJECTS q
                   on ( q.KF = txn.KF AND q.REPORT_DATE = p_report_date AND q.ID = l_object_id )
                 left
                 join ( select t.REF
                             , t.TT
                             , l.ACC3801
                             , t.ACC_ID_DB
                             , t.ACC_NUM_DB
                             , t.CCY_ID as CCY_ID_DB
                             , t.BAL    as BAL_DB
                          from NBUR_DM_TRANSACTIONS_CNSL t
                          join VP_LIST l
                            on ( l.ACC3800 = t.ACC_ID_CR )
                         where t.ACC_NUM_CR like '3800%'
                           and t.CCY_ID <> 980
                      ) cpd
                   on ( cpd.REF = txn.REF and cpd.TT = txn.TT and cpd.ACC3801 = txn.ACC_ID_DB )
                 left
                 join ( select t.REF
                             , t.TT
                             , l.ACC3801
                             , t.ACC_ID_CR
                             , t.ACC_NUM_CR
                             , t.CCY_ID as CCY_ID_CR
                             , t.BAL    as BAL_CR
                          from NBUR_DM_TRANSACTIONS_CNSL t
                          join VP_LIST l
                            on ( l.ACC3800 = t.ACC_ID_DB )
                         where t.ACC_NUM_DB like '3800%'
                           and t.CCY_ID <> 980
                      ) cpc
                   on ( cpc.REF = txn.REF and cpc.TT = txn.TT and cpc.ACC3801 = txn.ACC_ID_CR )
                where txn.CCY_ID = 980
                  and ( regexp_like( txn.ACC_NUM_DB, '^70' ) and regexp_like( txn.ACC_NUM_CR, '[^(6|7)]' )
                        or
                        regexp_like( txn.ACC_NUM_CR, '^60' ) and regexp_like( txn.ACC_NUM_DB, '[^(6|7)]' )
                      )
            ) pnl
        group by KF, case
                       when regexp_like( ACC_NUM_DB, '^70' )
                       then ACC_ID_CR
                       when regexp_like( ACC_NUM_CR, '^60' )
                       then ACC_ID_DB
                       else null
                     end
      ;

    else -- for one KF

      insert /* APPEND */
        into NBUR_DM_PROFIT_AND_LOSS
           ( REPORT_DATE, KF
           , ACC_ID, PRFT_AMNT, PRFT_AMNT_UAH, LOSS_AMNT, LOSS_AMNT_UAH )
            select p_report_date, pnl.KF
           , case
               when regexp_like( ACC_NUM_DB, '^70' )
               then ACC_ID_CR -- LOSS
               when regexp_like( ACC_NUM_CR, '^60' )
               then ACC_ID_DB -- PROFIT
               else null      -- OTHER
             end as ACC_ID
           , sum( case when regexp_like( ACC_NUM_DB, '^70' ) then AMNT_CR else 0 end ) as LOSS_AMNT
           , sum( case when regexp_like( ACC_NUM_DB, '^70' ) then AMNT_DB else 0 end ) as LOSS_AMNT_UAH
           , sum( case when regexp_like( ACC_NUM_CR, '^60' ) then AMNT_DB else 0 end ) as PRFT_AMNT
           , sum( case when regexp_like( ACC_NUM_CR, '^60' ) then AMNT_CR else 0 end ) as PRFT_AMNT_UAH
        from ( select txn.KF
                    , nvl(cpd.ACC_ID_DB,   txn.ACC_ID_DB  ) as ACC_ID_DB
                    , nvl(cpd.ACC_NUM_DB,  txn.ACC_NUM_DB ) as ACC_NUM_DB
                    , nvl(cpd.BAL_DB,      txn.BAL        ) as AMNT_DB
      /*            --
                    , nvl(cpd.CCY_ID_DB,   txn.CCY_ID     ) as CCY_ID_DB
                    , nvl(cpd.ACC_TYPE_DB, txn.ACC_TYPE_DB) as ACC_TYPE_DB
                    , nvl(cpd.R020_DB,     txn.R020_DB    ) as R020_DB
                    , nvl(cpd.OB22_DB,     txn.OB22_DB    ) as OB22_DB
                    --
                    , txn.ACC_ID_DB
                    , txn.ACC_NUM_DB
                    , txn.ACC_TYPE_DB
                    , txn.R020_DB
                    , txn.OB22_DB
                    , txn.ACC_ID_CR
                    , txn.ACC_NUM_CR
                    , txn.ACC_TYPE_CR
                    , txn.R020_CR
                    , txn.OB22_CR
                    --
                    , nvl(cpc.CCY_ID_CR,   txn.CCY_ID     ) as CCY_ID_CR
                    , nvl(cpc.ACC_TYPE_CR, txn.ACC_TYPE_CR) as ACC_TYPE_CR
                    , nvl(cpc.R020_CR,     txn.R020_CR    ) as R020_CR
                    , nvl(cpc.OB22_CR,     txn.OB22_CR    ) as OB22_CR
                    , txn.REF, txn.TT, txn.TXT, txn.CCY_ID, txn.BAL, txn.BAL_UAH
      */
                    , nvl(cpc.ACC_ID_CR,   txn.ACC_ID_CR  ) as ACC_ID_CR
                    , nvl(cpc.ACC_NUM_CR,  txn.ACC_NUM_CR ) as ACC_NUM_CR
                    , nvl(cpc.BAL_CR,      txn.BAL        ) as AMNT_CR
                 from NBUR_DM_TRANSACTIONS_CNSL txn
                 left
                 join ( select t.REF, t.TT, l.ACC3801
                             , t.ACC_ID_DB
                             , t.ACC_NUM_DB
                          -- , ACC_TYPE_DB, R020_DB, OB22_DB
                          -- , t.ACC_ID_CR, ACC_NUM_CR, ACC_TYPE_CR, R020_CR, OB22_CR
                             , t.CCY_ID as CCY_ID_DB
                             , t.BAL   as BAL_DB
                          from NBUR_DM_TRANSACTIONS_CNSL t
                          join VP_LIST l
                            on ( l.ACC3800 = t.ACC_ID_CR )
                         where t.KF = p_kf
                           and t.ACC_NUM_CR like '3800%'
                           and t.CCY_ID <> 980
                      ) cpd
                   on ( cpd.REF = txn.REF and cpd.TT = txn.TT and cpd.ACC3801 = txn.ACC_ID_DB )
                 left
                 join ( select t.REF, t.TT, l.ACC3801
                          -- , ACC_ID_DB, ACC_NUM_DB, ACC_TYPE_DB, R020_DB, OB22_DB
                             , t.ACC_ID_CR
                             , t.ACC_NUM_CR
                          -- , ACC_TYPE_CR, R020_CR, OB22_CR
                             , t.CCY_ID as CCY_ID_CR
                             , t.BAL    as BAL_CR
                          from NBUR_DM_TRANSACTIONS_CNSL t
                          join VP_LIST l
                            on ( l.ACC3800 = t.ACC_ID_DB )
                         where t.KF = p_kf
                           and t.ACC_NUM_DB like '3800%'
                           and t.CCY_ID <> 980
                      ) cpc
                   on ( cpc.REF = txn.REF and cpc.TT = txn.TT and cpc.ACC3801 = txn.ACC_ID_CR )
                where txn.KF = p_kf
                  and txn.CCY_ID = 980
                  and ( regexp_like( txn.ACC_NUM_DB, '^70' ) and regexp_like( txn.ACC_NUM_CR, '[^(6|7)]' )
                        or
                        regexp_like( txn.ACC_NUM_CR, '^60' ) and regexp_like( txn.ACC_NUM_DB, '[^(6|7)]' )
                      )
            ) pnl
        group by KF, case
                       when regexp_like( ACC_NUM_DB, '^70' )
                       then ACC_ID_CR
                       when regexp_like( ACC_NUM_CR, '^60' )
                       then ACC_ID_DB
                       else null
                     end
      ;

    end if;

    l_rowcount := sql%rowcount;

    commit;

    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );

    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );

    bars_audit.trace( '%s: Exit.', title );

  exception
    when OTHERS then
      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
  end LOAD_PROFIT_AND_LOSS;

    --
    --
    --
--  procedure LOAD_***
--  ( p_report_date  in     nbur_lst_objects.report_date%type
--  , p_kf           in     nbur_lst_objects.kf%type default null
--  , p_version_id   in     nbur_lst_objects.version_id%type
--  ) is
--  /**
--  <b>LOAD_***</b> - наповнення даними вітрини ...
--  %param p_report_date - Звітна дата
--  %param p_kf          - Код фiлiалу (МФО)
--  %param p_version_id  - Iдентифiкатор версії
--
--  %version 1.0
--  %usage   Наповнення оперативної (проміжної/non versioned) вітрини ...
--  */
--    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.LOAD_***';
--    l_object_name         varchar2(100) := 'NBUR_DM_***';
--  begin
--
--    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id =%s ).'
--                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id) );
--
--    l_object_id := f_get_object_id_by_name(l_object_name);
--
--    p_start_load_object( l_object_id, l_object_name, p_version_id, p_report_date, p_kf, systimestamp );
--
--    CHECK_OBJECT_DEPENDENCIES
--    ( p_rpt_dt  => p_report_date
--    , p_kf      => p_kf
--    , p_vrsn_id => p_version_id
--    , p_obj_id  => l_object_id
--    );
--
--    if ( ( p_kf Is Null ) AND ( l_usr_mfo Is Null ) )
--    then -- for all KF
--
--      insert /*+ APPEND */
--        into NBUR_DM_***
--           ( REPORT_DATE, KF
--           )
--      select /*+ PARALLEL( 8 ) */ p_report_date, a.KF
--      ;
--
--    else -- for one KF
--
--      insert /*+ APPEND */
--        into NBUR_DM_AGRM_RATES
--           ( REPORT_DATE, KF
--           )
--      select p_report_date, a.KF
--       where a.KF = p_kf
--      ;
--
--    end if;
--
--    l_rowcount := sql%rowcount;
--
--    commit;
--
--    bars_audit.trace( '%s: Inserted %s records.', title, to_char(l_rowcount) );
--
--    p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, l_rowcount );
--
--    bars_audit.trace( '%s: Exit.', title );
--
--  exception
--    when OTHERS then
--      LOG_ERRORS(l_object_name||' for vrsn_id='||p_version_id||' DAT='||to_char(p_report_date, fmt_dt)||' KF='||p_kf, l_err_rec_id );
--      p_finish_load_object( l_object_id, p_version_id, p_report_date, p_kf, null, l_err_rec_id );
--  end LOAD_***;

  --
  --
  --
  function GET_TAB_COL_LIST
  ( p_tab_nm       in     nbur_ref_objects.object_name%type
  ) return varchar
  DETERMINISTIC
  RESULT_CACHE
  is
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.GET_TAB_COL_LIST';
    l_col_lst             varchar2(3072);
    l_tab_nm              varchar2(30);
  begin

    l_tab_nm := upper(p_tab_nm);

    begin
      select listagg( COLUMN_NAME, ', ' ) WITHIN GROUP ( ORDER BY COLUMN_ID )
        into l_col_lst
        from ALL_TAB_COLS
       where TABLE_NAME = l_tab_nm
         and OWNER = 'BARS'
         and VIRTUAL_COLUMN = 'NO';
    exception
      when NO_DATA_FOUND then
        l_col_lst := null;
    end;

--  bars_audit.trace( '%s: Exit with ( %s ).', title, l_col_lst );

    return l_col_lst;

  end GET_TAB_COL_LIST;

  --
  --
  --
  procedure MOVE_DATA_TO_ARCH
  ( p_obj_nm       in     nbur_ref_objects.object_name%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_vrsn_id      in     nbur_lst_objects.version_id%type
  ) is
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.MOVE_DATA_TO_ARCH';
    l_arc_tab_nm          varchar2(30);
    l_arc_col_lst         varchar2(3072);
    l_obj_col_lst         varchar2(3072);
  begin

    bars_audit.trace( '%s: Entry with ( obj_nm=%s, kf=%s, vrsn_id=%s ).'
                    , title, p_obj_nm, p_kf, to_char(p_vrsn_id) );

    l_arc_tab_nm  := p_obj_nm||'_ARCH';

    l_arc_col_lst := GET_TAB_COL_LIST( l_arc_tab_nm );

    l_obj_col_lst := replace( l_arc_col_lst, 'VERSION_ID', ':p_vrsn_id' );

    dbms_application_info.set_client_info( 'Moving data into table '||l_arc_tab_nm );

    begin
      if ( p_kf Is Null )
      then
        -- '/*+ PARALLEL( '||l_dop||' ) */'
        execute immediate 'insert /*+ APPEND */'                       ||chr(10)||
                          '  into '||l_arc_tab_nm                      ||chr(10)||
                          '     ( '||l_arc_col_lst||' )'               ||chr(10)||
                          'select /*+ PARALLEL( 8 ) */ '||l_obj_col_lst||chr(10)||
                          '  from '||p_obj_nm
        using p_vrsn_id;
      else
        execute immediate 'insert /* APPEND */'                        ||chr(10)||
                          '  into '||l_arc_tab_nm                      ||chr(10)||
                          '     ( '||l_arc_col_lst||' )'               ||chr(10)||
                          'select /*+ PARALLEL( 8 ) */ '||l_obj_col_lst||chr(10)||
                          '  from '||p_obj_nm                          ||chr(10)||
                          ' where KF          = :p_kf'
        using p_vrsn_id, p_kf;
      end if;
    exception
      when OTHERS then
        bars_audit.error( title||': ( obj_nm='||p_obj_nm||')'
                               ||chr(10)||dbms_utility.format_error_stack()
                               ||chr(10)||dbms_utility.format_error_backtrace() );
    end;

    dbms_application_info.set_client_info( null );

    bars_audit.trace( '%s: Exit.', title );

  end MOVE_DATA_TO_ARCH;

  --
  --
  --
  procedure CREATE_RANGE_PARTITION
  ( p_dm_tab_nm    in     tbl_nm_subtype
  , p_rpt_dt       in     nbur_dm_agrm_accounts_arch.report_date%type
  , p_kf           in     nbur_dm_agrm_accounts_arch.kf%type
  , p_vrsn_id      in     nbur_dm_agrm_accounts_arch.version_id%type default null
  ) is
  /**
  <b>CREATE_RANGE_PARTITION</b> - створення сегменту таблиці
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)

  %version 1.7 (03/08/2016)
  %usage   Перенесення даних з оперативних (проміжних) таблиць в архів версій вітрин даних
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.crt_rng_partition';

    l_add_stmt            varchar(1000);
    l_spl_stmt            varchar(1000);
    l_crt_stmt            varchar(1000);
    l_rnm_stmt            varchar(1000);

    e_ptsn_split          exception; -- Partition cannot be split along the specified high bound
    pragma exception_init( e_ptsn_split, -14080 );

    e_ptsn_nm_exsts       exception; -- New partition name must differ from the old partition name
    pragma exception_init( e_ptsn_nm_exsts, -14081 );

    e_ptsn_bound          exception; -- partition bound must collate higher than that of the last partition
    pragma exception_init( e_ptsn_bound, -14074 );

  begin

    bars_audit.trace( '%s: Start running with ( dm_tab_nm=%s, rpt_dt=%s, kf=%s, vrsn_id=%s).'
                    , title, p_dm_tab_nm, to_char(p_rpt_dt,fmt_dt), p_kf, to_char(p_vrsn_id) );

    case
      when ( p_vrsn_id > 0 )
      then -- for multicolumn partition (by VERSION)

        l_add_stmt := q'[ALTER TABLE BARS.%tabnm ADD PARTITION P_%rptdt_SP_%vrsnid VALUES LESS THAN (to_date('%rptdt','YYYYMMDD'),%vrsnid)]';

        l_spl_stmt := q'[ALTER TABLE BARS.%tabnm SPLIT PARTITION FOR (to_date('%rptdt','YYYYMMDD'),%vrsnid) AT (to_date('%rptdt+1','YYYYMMDD'),%vrsnid)]';

        l_rnm_stmt := q'[ALTER TABLE BARS.%tabnm RENAME PARTITION FOR (to_date('%rptdt','YYYYMMDD'),%vrsnid) TO P_%rptdt_SP_%vrsnid]';

--      l_crt_stmt := q'[LOCK TABLE BARS.%tabnm PARTITION FOR (to_date('%rptdt','YYYYMMDD'),%vrsnid) IN SHARE MODE]';

        l_add_stmt := replace( l_add_stmt, '%vrsnid', to_char(p_vrsn_id,'FM00') );

        l_spl_stmt := replace( l_spl_stmt, '%vrsnid', to_char(p_vrsn_id,'FM00') );

        l_rnm_stmt := replace( l_rnm_stmt, '%vrsnid', to_char(p_vrsn_id,'FM00') );

--      l_crt_stmt := replace( l_crt_stmt, '%vrsnid', to_char(p_vrsn_id,'FM00') );

      when ( p_kf is Not Null )
      then -- for multicolumn partition (by KF)

        l_add_stmt := q'[ALTER TABLE BARS.%tabnm ADD PARTITION P_%rptdt_SP_%kf VALUES LESS THAN (to_date('%rptdt+1','YYYYMMDD'),'%kf')]';

        l_spl_stmt := q'[ALTER TABLE BARS.%tabnm SPLIT PARTITION FOR (to_date('%rptdt','YYYYMMDD'),'%kf') AT (to_date('%rptdt+1','YYYYMMDD'),'%kf')]';

        l_rnm_stmt := q'[ALTER TABLE BARS.%tabnm RENAME PARTITION FOR (to_date('%rptdt','YYYYMMDD'),'%kf') TO P_%rptdt_SP_%kf]';

        l_add_stmt := replace( l_add_stmt, '%kf', p_kf );

        l_spl_stmt := replace( l_spl_stmt, '%kf', p_kf );

        l_rnm_stmt := replace( l_rnm_stmt, '%kf', p_kf );

      else -- for singlecolumn partition

        l_add_stmt := q'[ALTER TABLE BARS.%tabnm ADD PARTITION P_%rptdt VALUES LESS THAN (to_date('%rptdt','YYYYMMDD'))]';

        l_rnm_stmt := q'[ALTER TABLE BARS.%tabnm RENAME PARTITION FOR (to_date('%rptdt','YYYYMMDD')) TO P_%rptdt]';

    end case;

    l_add_stmt := replace( l_add_stmt, '%tabnm', p_dm_tab_nm );
    l_spl_stmt := replace( l_spl_stmt, '%tabnm', p_dm_tab_nm );
    l_rnm_stmt := replace( l_rnm_stmt, '%tabnm', p_dm_tab_nm );

    l_add_stmt := replace( l_add_stmt, '%rptdt+1', to_char(p_rpt_dt+1,'YYYYMMDD') );
    l_spl_stmt := replace( l_spl_stmt, '%rptdt+1', to_char(p_rpt_dt+1,'YYYYMMDD') );

    l_add_stmt := replace( l_add_stmt, '%rptdt', to_char(p_rpt_dt,'YYYYMMDD') );
    l_spl_stmt := replace( l_spl_stmt, '%rptdt', to_char(p_rpt_dt,'YYYYMMDD') );
    l_rnm_stmt := replace( l_rnm_stmt, '%rptdt', to_char(p_rpt_dt,'YYYYMMDD') );

    bars_audit.trace( title || ': add_stmt = ' || l_add_stmt );
    bars_audit.trace( title || ': spl_stmt = ' || l_spl_stmt );
    bars_audit.trace( title || ': rnm_stmt = ' || l_rnm_stmt );

    begin
      execute immediate l_add_stmt;
    exception
      when e_ptsn_bound then
        -- split partition
        begin
          execute immediate l_spl_stmt;
          -- rename partition
          begin
            execute immediate l_rnm_stmt;
          exception
            when e_ptsn_nm_exsts then
              null;
          end;
        exception
          when e_ptsn_split then
            null;
        end;
    end;

    bars_audit.trace( '%s: Exit.', title );

  end CREATE_RANGE_PARTITION;

  --
  --
  --
  procedure SAVE_VERSION
  ( p_report_date  in     nbur_lst_versions.report_date%type
  , p_kf           in     nbur_lst_versions.kf%type
  , p_vrsn_id      in     nbur_lst_versions.version_id%type default null
  ) is
  /**
  <b>SAVE_VERSION</b>  - збереження даних ВІТРИН в архіві версій
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)

  %version 1.8 (07/11/2016)
  %usage   Перенесення даних з оперативних (проміжних) таблиць в архів версій вітрин даних
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.SAVE_VERSION';


    l_vrsn_id   nbur_lst_versions.version_id%type;
    l_iot       all_tables.iot_type%type;
    ---
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf );

    -- check and lock
    if ( p_vrsn_id Is Null )
    then
      begin
        if ( p_kf is null )
        then
          select max(VERSION_ID)
            into l_vrsn_id
            from NBUR_LST_VERSIONS
           where REPORT_DATE = p_report_date
             and STATUS = 'FINISHED';
        else
          select VERSION_ID
            into l_vrsn_id
            from NBUR_LST_VERSIONS
           where REPORT_DATE = p_report_date
             and STATUS = 'FINISHED'
             and KF = p_kf
             for update of STATUS nowait;
        end if;
      exception
        when NO_DATA_FOUND then
          bars_audit.error( title || ': Not found appropriate DM version!' );
          raise_application_error( -20666, 'Not found appropriate DM version!', true );
        when TOO_MANY_ROWS then
          bars_audit.error( title || 'Found many appropriate DM version!' );
          raise_application_error( -20666, 'Found many appropriate DM version!', true );
        when OTHERS        then
          bars_audit.error( title || sqlerrm || dbms_utility.format_error_backtrace() );
          raise;
      end;
    else
      l_vrsn_id := p_vrsn_id;
    end if;

    dbms_application_info.set_action( 'SAVE_VERSION' );

    if ( t_tbl_lst.count > 0 )
    then -- Data archiving

      for i in t_tbl_lst.first .. t_tbl_lst.last
      loop

        case t_tbl_lst(i)
          when ( 'NBUR_DM_AGRM_ACCOUNTS' )
          then
            -- check table type
            select count(1)
              into l_iot
              from ALL_TABLES
             where OWNER = 'BARS'
               and TABLE_NAME like 'NBUR_DM_AGRM_ACCOUNTS_ARCH'
               and IOT_TYPE Is Not Null;
            if ( l_iot > 0 )
            then -- for index-organized table create partition manually
              if ( p_kf Is Null )
              then
                for b in ( select KF
                             from MV_KF
                            order by KF )
                loop
                  CREATE_RANGE_PARTITION
                  ( p_dm_tab_nm => 'NBUR_DM_AGRM_ACCOUNTS_ARCH'
                  , p_rpt_dt    => p_report_date
                  , p_kf        => b.KF
                  , p_vrsn_id   => Null
                  );
                end loop;
              else
                CREATE_RANGE_PARTITION
                ( p_dm_tab_nm => 'NBUR_DM_AGRM_ACCOUNTS_ARCH'
                , p_rpt_dt    => p_report_date
                , p_kf        => p_kf
                , p_vrsn_id   => Null
                );
              end if;
            end if;

          when ( 'NBUR_DM_CHRON_AVG_BALS' )
          then

            CREATE_RANGE_PARTITION
            ( p_dm_tab_nm => 'NBUR_DM_CHRON_AVG_BALS_ARCH'
            , p_rpt_dt    => p_report_date
            , p_kf        => null
            , p_vrsn_id   => l_vrsn_id
            );

            if ( p_kf Is Null )
            then -- for all KF

              DM_UTL.EXCHANGE_PARTITION( p_source_table_nm => 'NBUR_DM_CHRON_AVG_BALS_ARCH'
                                       , p_target_table_nm => 'NBUR_DM_CHRON_AVG_BALS'
                                       , p_partition_nm    => 'P_'||to_char(p_report_date,'YYYYMMDD')||'_'|| to_char(l_vrsn_id,'FM000') );

            else

              insert /*+ APPEND */
                into NBUR_DM_CHRON_AVG_BALS_ARCH
                   ( REPORT_DATE, KF, VERSION_ID
                   , ACC_ID, R020, R030, AVG_BAL, AVG_BAL_UAH
                   , SUM_CR, SUM_CR_UAH, SUM_DB, SUM_DB_UAH )
              select /*+ PARALLEL( 8 ) */ REPORT_DATE, KF, VERSION_ID
                   , ACC_ID, R020, R030, AVG_BAL, AVG_BAL_UAH
                   , SUM_CR, SUM_CR_UAH, SUM_DB, SUM_DB_UAH
                from NBUR_DM_CHRON_AVG_BALS
               where p_kf = KF;

              commit;

            end if;

          else
            null;

        end case;

        -- костиль (замінити на ознаку з поля в табл. NBUR_REF_OBJECTS коли таке появиться)
        if ( t_tbl_lst(i) like '%CNSL' )
        then -- for DM that contains consolidated data from another DM
          null;
        else
          MOVE_DATA_TO_ARCH( p_obj_nm  => t_tbl_lst(i)
                           , p_kf      => p_kf
                           , p_vrsn_id => l_vrsn_id
                           );
        end if;

      end loop;

    end if;

    --------------------------------------------------------------------------------
    --
    -- change version status
    --

    dbms_application_info.set_client_info( 'Change version status.' );

    if ( p_kf is null )
    then
      update NBUR_LST_VERSIONS
         set STATUS = 'VALID'
       where REPORT_DATE = p_report_date
         and VERSION_ID  = l_vrsn_id;
    else
      update NBUR_LST_VERSIONS
         set STATUS = 'VALID'
       where REPORT_DATE = p_report_date
         and KF          = p_kf
         and VERSION_ID  = l_vrsn_id;
    end if;

    commit;

    dbms_application_info.set_client_info( 'Clear tables.' );

    FIXATION('NBUR_AGG_PROTOCOLS');

    -- clear tables
    for r in t_tbl_lst.first .. t_tbl_lst.last
    loop
      begin
        if ( p_kf Is Null )
        then
          execute immediate 'truncate table ' || t_tbl_lst(r);
        else
          execute immediate 'alter table ' || t_tbl_lst(r) || ' truncate partition P_' || p_kf;
        end if;
      exception
        when E_PTSN_NOT_EXSTS
        then null;
        when OTHERS
        then bars_audit.error( title || ': table_name=' || t_tbl_lst(r) || chr(10) || sqlerrm );
      end;
    end loop;

    t_tbl_lst.delete();

    dbms_application_info.set_client_info( null );
    dbms_application_info.set_action( null );

    bars_audit.trace( '%s: Exit.', title );

  end SAVE_VERSION;

  --
  --
  --
  procedure SAVE_FILE_VERSION
  ( p_report_dt    in     nbur_lst_files.report_date%type
  , p_kf           in     nbur_lst_files.kf%type
  , p_vrsn_id      in     nbur_lst_files.version_id%type
  , p_file_id      in     nbur_lst_files.file_id%type
  ) is
  /**
  <b>SAVE_VERSION</b>  - збереження протоколів формування файлів в архіві версій
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)

  %version 1.0 (26/10/2016)
  %usage   Перенесення даних з оперативних (проміжних) таблиць в архів версій вітрин даних
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.SAVE_FILE_VERSION';
    l_rpt_code            varchar2(5);
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, vrsn_id=%s, file_id=%s ).', title
                    , to_char(p_report_dt,fmt_dt), p_kf, to_char(p_vrsn_id), to_char(p_file_id) );

    begin

      select rf.FILE_CODE
        into l_rpt_code
        from NBUR_LST_FILES lf
        join NBUR_REF_FILES rf
          on ( rf.ID = lf.FILE_ID )
       where lf.REPORT_DATE = p_report_dt
         and lf.KF          = p_kf
         and lf.VERSION_ID  = p_vrsn_id
         and lf.FILE_ID     = p_file_id
         and lf.FILE_STATUS = 'FINISHED'
      ;

      dbms_application_info.set_client_info( 'Moving data into table "NBUR_DETAIL_PROTOCOLS_ARCH".' );

      insert
        into NBUR_DETAIL_PROTOCOLS_ARCH
           ( REPORT_DATE, KF, VERSION_ID
           , REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, DESCRIPTION
           , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH )
      select REPORT_DATE, KF, p_vrsn_id
           , REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, DESCRIPTION
           , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH
        from NBUR_DETAIL_PROTOCOLS
       where REPORT_CODE = l_rpt_code
         and ( p_kf = KF or p_kf Is Null );

      dbms_application_info.set_client_info( 'Moving data into table "NBUR_AGG_PROTOCOLS_ARCH".' );

      insert
        into NBUR_AGG_PROTOCOLS_ARCH
           ( REPORT_DATE, KF, VERSION_ID
           , REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND )
      select REPORT_DATE, KF, p_vrsn_id
           , REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND
        from NBUR_AGG_PROTOCOLS
       where REPORT_CODE = l_rpt_code
         and ( p_kf = KF or p_kf Is Null );

      dbms_application_info.set_client_info( 'Clear data from tables.' );

      -- NBUR_AGG_PROTOCOLS is a temporary table
      execute immediate 'truncate table NBUR_DETAIL_PROTOCOLS';

      delete
        from NBUR_AGG_PROTOCOLS
       where REPORT_CODE = l_rpt_code
         and ( p_kf = KF or p_kf Is Null );

      dbms_application_info.set_client_info( null );

    exception
      when NO_DATA_FOUND then
        bars_audit.trace( '%s: Doesn`t exist appropriate data for moving.', title );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end SAVE_FILE_VERSION;

  --
  --
  --
  function GET_CRN_VRSN
  ( p_rpt_dt       in     nbur_lst_blc_objects.report_date%type
  , p_kf           in     nbur_lst_blc_objects.kf%type
  , p_obj_id       in     nbur_lst_blc_objects.object_id%type
  ) return nbur_lst_blc_objects.version_id%type
  is
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.BLOCK_VERSION';
    l_vrsn                nbur_lst_blc_objects.version_id%type;
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, object_id=%s ).', title
                    , to_char(p_rpt_dt,fmt_dt), p_kf, to_char(p_obj_id) );

    if ( p_kf is Null )
    then
      l_vrsn := 1; --- temporarry
    else
      l_vrsn := 1; --- temporarry
    end if;

    return l_vrsn;

  end GET_CRN_VRSN;

  --
  --
  --
  procedure BLOCK_VERSION
  ( p_report_date  in     nbur_lst_blc_objects.report_date%type
  , p_kf           in     nbur_lst_blc_objects.kf%type
  , p_object_id    in     nbur_lst_blc_objects.object_id%type
  , p_version_id   in     nbur_lst_blc_objects.version_id%type default null
  ) is
  /**
  <b>BLOCK_VERSION</b> - ...
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_object_id   - Iдентифiкатор об`єкту
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage   ...
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.BLOCK_VERSION';
    l_version_id          nbur_lst_blc_objects.version_id%type;
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, object_id=%s, version_id=%s ).', title
                    , to_char(p_report_date,fmt_dt), p_kf, to_char(p_object_id), to_char(p_version_id) );

    if ( p_version_id > 0 )
    then
      l_version_id := p_version_id;
    else
      l_version_id := GET_CRN_VRSN( p_report_date, p_kf, p_object_id );
      bars_audit.trace( '%s: version_id=%s.', title, to_char(l_version_id) );
    end if;

    begin
      insert
        into NBUR_LST_BLC_OBJECTS
           ( REPORT_DATE, KF, VERSION_ID, OBJECT_ID, BLOCKED_TIME, USER_NAME )
      values
           ( p_report_date, p_kf, l_version_id, p_object_id, systimestamp, USER_NAME );
    exception
      when DUP_VAL_ON_INDEX then
        null;
    end;

    P_UPDATE_ONE_OBJ_STATUS( p_object_id   => p_object_id
                           , p_report_date => p_report_date
                           , p_kf          => p_kf
                           , p_version_id  => p_version_id
                           , p_status      => 'BLOCKED' );

    bars_audit.trace( '%s: Exit.', title );

  end BLOCK_VERSION;

  --
  --
  --
  procedure RETRIEVE_VERSION
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_object_nm    in     nbur_ref_objects.object_name%type
  ) is
  /**
  <b>RETRIEVE_VERSION</b>  - ...
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_object_id   - Iдентифiкатор об`єкту
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0 (03/08/2016)
  %usage   Копіювання даних з архіву версій вітрини даних в оперативну (проміжну) таблицю
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.RETRIEVE_VERSION_BY_NM';
    l_col_lst             varchar2(1000);
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id=%s, object_nm=%s ).', title
                    , to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id), p_object_nm );

    /*
    begin
    select 1
      into l_is_exists
      from NBUR_LST_OBJECTS
     where REPORT_DATE   = p_report_date
       and KF            = p_kf
       and VERSION_ID    = p_version_id
       and OBJECT_ID     = p_object_id
       and OBJECT_STATUS = 'FINISHED'

       and ROW_COUNT > 0
*/
    select listagg(t1.COLUMN_NAME, ', ') WITHIN GROUP (ORDER BY t1.COLUMN_ID)
      into l_col_lst
      from ( select COLUMN_NAME, COLUMN_ID
               from ALL_TAB_COLS
              where TABLE_NAME = p_object_nm
                and OWNER = 'BARS'
                and VIRTUAL_COLUMN = 'NO'
           ) t1
      join ( select COLUMN_NAME
               from ALL_TAB_COLS
              where TABLE_NAME = p_object_nm||'_ARCH'
                and OWNER = 'BARS'
                and VIRTUAL_COLUMN = 'NO'
           ) t2
        on ( t2.COLUMN_NAME = t1.COLUMN_NAME )
    ;

    if ( p_kf Is Null )
    then
      execute immediate 'insert /*+ APPEND */'                ||chr(10)||
                        '  into '||p_object_nm                ||chr(10)||
                        '     ( '||l_col_lst||' )'            ||chr(10)||
                        'select /*+ PARALLEL( '||to_char(l_dop)||' ) */ '||l_col_lst||chr(10)||
                        '  from '||p_object_nm||'_ARCH'       ||chr(10)||
                        ' where REPORT_DATE = :p_report_date' ||chr(10)||
                        '   and VERSION_ID  = :p_version_id'
      using p_report_date, p_version_id;
    else
      execute immediate 'insert /*+ APPEND */'                ||chr(10)||
                        '  into '||p_object_nm                ||chr(10)||
                        '     ( '||l_col_lst||' )'            ||chr(10)||
                        'select /*+ PARALLEL( '||to_char(l_dop)||' ) */ '||l_col_lst||chr(10)||
                        '  from '||p_object_nm||'_ARCH'       ||chr(10)||
                        ' where REPORT_DATE = :p_report_date' ||chr(10)||
                        '   and KF          = :p_kf'          ||chr(10)||
                        '   and VERSION_ID  = :p_version_id'
      using p_report_date, p_kf, p_version_id;
    end if;

    bars_audit.trace( '%s: Exit.', title );

  end RETRIEVE_VERSION;

  --
  --
  --
  procedure RETRIEVE_VERSION
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  , p_object_id    in     nbur_lst_objects.object_id%type
  , p_version_id   in     nbur_lst_objects.version_id%type
  ) is
  /**
  <b>RETRIEVE_VERSION</b>  - ...
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_object_id   - Iдентифiкатор об`єкту
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0 (03/08/2016)
  %usage   Копіювання даних з архіву версій вітрини даних в оперативну (проміжну) таблицю
  */
    title     constant    varchar2(60)  := $$PLSQL_UNIT||'.RETRIEVE_VERSION_BY_ID';
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, object_id=%s, version_id=%s ).', title
                    , to_char(p_report_date,fmt_dt), p_kf, to_char(p_object_id), to_char(p_version_id) );

    RETRIEVE_VERSION
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id
    , p_object_nm   => F_GET_OBJECT_NAME_BY_ID( p_object_id )
    );

    bars_audit.trace( '%s: Exit.', title );

  end RETRIEVE_VERSION;

  --
  -- REMOVE_INVALID_DM_VERSIONS
  --
  procedure REMOVE_INVALID_DM_VERSIONS
  ( p_start_id     in     number
  , p_end_id       in     number
  , p_lmt_dt       in     date
  , p_kf           in     varchar2
  ) is
    title     constant    varchar2(64) := $$PLSQL_UNIT||'.REMOVE_INVALID_DM_VERSIONS';
  begin

    bars_audit.trace( '%s: Entry with ( p_start_id=%s, p_end_id=%s, p_lmt_dt=%s, p_kf=%s ).'
                    , title, to_char(p_start_id), to_char(p_end_id), to_char(p_lmt_dt,fmt_dt), p_kf );

    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    << LST_OBJ >>
    for o in ( select o.ID          as OBJ_ID
                    , t.TABLE_NAME  as TBL_NM
                    , t.IOT_TYPE
                    , p.PARTITIONING_TYPE
                    , p.PARTITIONING_KEY_COUNT
                    , p.SUBPARTITIONING_TYPE
                    , p.SUBPARTITIONING_KEY_COUNT
                    , p.PARTITIONING_KEY_COUNT + p.SUBPARTITIONING_KEY_COUNT as KEY_CNT
                    , nvl2(p.INTERVAL,1,0) as ITRV
                 from NBUR_REF_OBJECTS o
                 join ALL_TABLES t
                   on ( t.OWNER = 'BARS'  and t.TABLE_NAME = o.OBJECT_NAME||'_ARCH' )
                 join ALL_PART_TABLES p
                   on ( p.OWNER = t.OWNER and p.TABLE_NAME = t.TABLE_NAME )
                where ID between p_start_id and p_end_id
             )
    loop

      bars_audit.trace( '%s: obj_id=%s, tbl_nm=%s, key_cnt=%s.'
                      , title, to_char(o.OBJ_ID), o.TBL_NM, to_char(o.KEY_CNT)  );

      << LST_VRSN >>
      for v in ( select v.ROWID       as ROW_ID
                      , v.REPORT_DATE as RPT_DT
                      , v.KF
                      , v.VERSION_ID  as VRSN_ID
                   from NBUR_LST_OBJECTS v
                  where v.REPORT_DATE   < p_lmt_dt
                    and v.KF            = p_kf
                    and v.OBJECT_ID     = o.OBJ_ID
                    and v.OBJECT_STATUS = 'INVALID'
                  order by v.REPORT_DATE
--                  for update of OBJECT_STATUS nowait
               )
      loop

        bars_audit.trace( '%s: tbl_nm=%s, rpt_dt=%s, vrsn_id=%s.', title
                        , o.TBL_NM, to_char(v.RPT_DT,fmt_dt), to_char(v.VRSN_ID) );

        begin

          if ( o.KEY_CNT = 3 )
          then
            begin
              execute immediate 'alter table '||o.TBL_NM||' drop partition for ( to_date('''||
                                to_char(v.RPT_DT,'YYYYMMDD')||''',''YYYYMMDD''),'''||v.KF||''','||to_char(v.VRSN_ID)||' )';
              bars_audit.trace( '%s: partition dropped for (%s,%s).', title, to_char(v.RPT_DT,fmt_dt), v.KF );
            exception
              when e_ptsn_not_exsts then
                null;
            end;
          else
            execute immediate 'delete /*+ PARALLEL( '||to_char(l_dop)||' ) */ '||o.TBL_NM
                  ||chr(10)|| ' where REPORT_DATE = :v_rpt_dt'
                  ||chr(10)|| '   and KF          = :v_kf'
                  ||chr(10)|| '   and VERSION_ID  = :v_vrsn_id'
            using v.RPT_DT, v.KF, v.VRSN_ID;
          end if;

          update NBUR_LST_OBJECTS
             set OBJECT_STATUS = 'DELETED'
           where ROWID = v.ROW_ID;

          commit;

        exception
          when others then
            bars_audit.error( title || ': ' || dbms_utility.format_error_stack()
                                            || dbms_utility.format_error_backtrace() );
        end;

      end loop LST_VRSN;

    end loop LST_OBJ;

    bars_audit.trace( '%s: Exit.', title );

  end REMOVE_INVALID_DM_VERSIONS;

  --
  -- REMOVE_INVALID_RPT_VERSIONS
  --
  procedure REMOVE_INVALID_RPT_VERSIONS
  ( p_start_id     in     number
  , p_end_id       in     number
  , p_lmt_dt       in     date
  , p_kf           in     varchar2
  ) is
    title     constant    varchar2(64) := $$PLSQL_UNIT||'.REMOVE_INVALID_DM_VERSIONS';
  begin

    bars_audit.trace( '%s: Entry with ( p_start_id=%s, p_end_id=%s, p_lmt_dt=%s, p_kf=%s ).'
                    , title, to_char(p_start_id), to_char(p_end_id), to_char(p_lmt_dt,fmt_dt), p_kf );

    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    << RMV_RPT >>
    for f in ( select f.ROWID       as ROW_ID
                    , f.REPORT_DATE as RPT_DT
                    , f.KF
                    , f.VERSION_ID  as VRSN_ID
                    , SubStr(f.FILE_NAME,1,3) as RPT_CODE
                 from NBUR_LST_FILES f
                where f.REPORT_DATE < p_lmt_dt
                  and f.KF          = p_kf
                  and f.FILE_ID between p_start_id and p_end_id
                  and f.FILE_STATUS = 'INVALID'
                order by f.REPORT_DATE
--                for update of FILE_STATUS nowait
             )
    loop

      bars_audit.trace( '%s: rpt_dt=%s, vrsn_id=%s, rpt_code=%s.', title
                      , to_char(f.RPT_DT,fmt_dt), to_char(f.VRSN_ID), f.RPT_CODE );

      begin

        delete NBUR_DETAIL_PROTOCOLS_ARCH
         where REPORT_DATE = f.RPT_DT
           and KF          = f.KF
           and VERSION_ID  = f.VRSN_ID
           and REPORT_CODE = f.RPT_CODE;

        delete NBUR_AGG_PROTOCOLS_ARCH
         where REPORT_DATE = f.RPT_DT
           and KF          = f.KF
           and VERSION_ID  = f.VRSN_ID
           and REPORT_CODE = f.RPT_CODE;

        update NBUR_LST_FILES
           set FILE_STATUS = 'DELETED'
         where ROWID = f.ROW_ID;

        commit;

      exception
        when others then
          bars_audit.error( title || ': ' || dbms_utility.format_error_stack()
                                          || dbms_utility.format_error_backtrace() );
      end;

    end loop RMV_RPT;

    bars_audit.trace( '%s: Exit.', title );

  end REMOVE_INVALID_RPT_VERSIONS;

  --
  --
  --
  procedure REMOVE_INVALID_VERSIONS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type
  ) is
  /**
  <b>REMOVE_INVALID_VERSIONS</b> - Видалення інвалідних версій з вітрин
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)

  %version 1.2 (07/02/2018)
  %usage   Видалення інвалідних версій даних з архівних вітрин даних
  */
    title        constant  varchar2(64) := $$PLSQL_UNIT||'.REMOVE_INVALID_VERSIONS';

    l_lmt_dt               date;
    l_kf                   varchar2(6);
    l_task_nm              varchar2(30);
    l_sql_stmt             varchar2(4000);

    e_task_not_found       exception;
    pragma exception_init( e_task_not_found, -29498 );

    function GET_DM_QTY return pls_integer
    is
      l_dm_qty   pls_integer;
    begin
      select count(ID)
        into l_dm_qty
        from NBUR_REF_OBJECTS;
      return l_dm_qty;
    end GET_DM_QTY;

  begin

    bars_audit.trace( '%s: Entry with ( p_report_date=%s, p_kf=%s ).', title, to_char(p_report_date,fmt_dt), p_kf );

    l_kf := nvl(p_kf,l_usr_mfo);

    if ( l_kf Is Null )
    then -- for all KF

      for i in ( select KF from MV_KF )
      loop

        REMOVE_INVALID_VERSIONS
        ( p_report_date => p_report_date
        , p_kf          => i.KF
        );

      end loop;

    else -- for one KF

      if ( p_report_date Is Null )
      then -- залишаємо усі версії вітрин за поточний і попередній місяць
        l_lmt_dt := add_months( trunc(GL.GBD(),'MM'), -1 );
      else -- залишаємо усі версії вітрин за поточний місяць та останній банківський день попереднього місяця
        l_lmt_dt := DAT_NEXT_U( trunc(p_report_date,'MM'), -1 );
      end if;

      bars_audit.trace( '%s: l_lmt_dt=%s.', title, to_char(l_lmt_dt,fmt_dt) );

      begin

        l_task_nm := 'REMOVE_INVALID_DM_VERSIONS';

        begin
          DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
        exception
          when e_task_not_found 
          then null;
        end;

        DBMS_PARALLEL_EXECUTE.create_task( task_name => l_task_nm );

        l_sql_stmt := 'select ID, ID from NBUR_REF_OBJECTS';

        DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name => l_task_nm
                                                  , sql_stmt  => l_sql_stmt
                                                  , by_rowid  => FALSE );

        l_sql_stmt := 'begin NBUR_OBJECTS.REMOVE_INVALID_DM_VERSIONS( :start_id, :end_id, to_date('''
                    || to_char(l_lmt_dt,'YYYYMMDD') || ''',''YYYYMMDD''), '''||l_kf||''' ); end;';

        DBMS_PARALLEL_EXECUTE.run_task( task_name      => l_task_nm
                                      , sql_stmt       => l_sql_stmt
                                      , language_flag  => DBMS_SQL.NATIVE
                                      , parallel_level => GET_DM_QTY() );

        DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );

      end;

      begin

        l_task_nm := 'REMOVE_INVALID_RPT_VERSIONS';

        begin
          DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );
        exception
          when e_task_not_found 
          then null;
        end;

        DBMS_PARALLEL_EXECUTE.create_task( task_name => l_task_nm );

        l_sql_stmt := 'select min(ID), max(ID) from ( select id, ntile(16) over (order by ID) as GRP_ID  from NBUR_REF_FILES ) group by GRP_ID';

        DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name => l_task_nm
                                                  , sql_stmt  => l_sql_stmt
                                                  , by_rowid  => FALSE );

        l_sql_stmt := 'begin NBUR_OBJECTS.REMOVE_INVALID_RPT_VERSIONS( :start_id, :end_id, to_date('''
                    || to_char(l_lmt_dt,'YYYYMMDD') || ''',''YYYYMMDD''), '''||l_kf||''' ); end;';

        DBMS_PARALLEL_EXECUTE.run_task( task_name      => l_task_nm
                                      , sql_stmt       => l_sql_stmt
                                      , language_flag  => DBMS_SQL.NATIVE
                                      , parallel_level => 15 );

        DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );

      end;

      execute immediate 'ALTER SESSION ENABLE PARALLEL DDL';

      -- move
      for f in ( select distinct
                        f.KF
                      , f.REPORT_DATE as RPT_DT
                   from NBUR_LST_FILES f
                  where f.REPORT_DATE < l_lmt_dt
                    and f.KF          = l_kf
                    and f.FILE_STATUS = any('FINISHED','BLOCKED')
               )
      loop

        begin
          execute immediate 'alter table NBUR_DETAIL_PROTOCOLS_ARCH move subpartition '
                         || 'for ( to_date('''||to_char(f.RPT_DT,'YYYYMMDD')||''',''YYYYMMDD''),'''||f.KF||''' ) '
                         || case when l_dm_tblsps then 'tablespace BRS_DM_' || f.KF else '' end
                         || ' COMPRESS UPDATE INDEXES INDEXES PARALLEL 24';
          bars_audit.trace( '%s: subpartition moved for (%s,%s).', title, to_char(f.RPT_DT,fmt_dt), f.KF );
        exception
          when e_ptsn_not_exsts then
            null;
          when others then
            bars_audit.error( title || ': ' || dbms_utility.format_error_stack()
                                            || dbms_utility.format_error_backtrace() );
        end;

        begin
          execute immediate 'alter table NBUR_AGG_PROTOCOLS_ARCH move subpartition '
                         || 'for ( to_date('''||to_char(f.RPT_DT,'YYYYMMDD')||''',''YYYYMMDD''),'''||f.KF||''' ) '
                         || case when l_dm_tblsps then 'tablespace BRS_DM_' || f.KF else '' end
                         || ' COMPRESS UPDATE INDEXES PARALLEL 24';
          bars_audit.trace( '%s: subpartition moved for (%s,%s).', title, to_char(f.RPT_DT,fmt_dt), f.KF );
        exception
          when e_ptsn_not_exsts then
            null;
          when others then
            bars_audit.error( title || ': ' || dbms_utility.format_error_stack()
                                            || dbms_utility.format_error_backtrace() );
        end;

      end loop;

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end REMOVE_INVALID_VERSIONS;

  --
  --
  --
  procedure REMOVE_OBSOLETE_VERSIONS
  is
  /**
  <b>REMOVE_OBSOLETE_VERSIONS</b> - Видалення застарілих версій з вітрин

  %version 1.1 (07/02/2018)
  %usage   Видалення застарілих версій даних з архівних вітрин даних
  */
    title        constant varchar2(64)  := $$PLSQL_UNIT||'.REMOVE_OBSOLETE_VERSIONS';
    l_lmt_dt              date;
  begin

    bars_audit.trace( '%s: Entry.', title );

    l_lmt_dt := add_months( trunc(GL.GBD(),'MM'), -6 );

    bars_audit.trace( '%s: l_lmt_dt=%s.', title, to_char(l_lmt_dt,fmt_dt) );

    for o in ( select distinct
                      v.REPORT_DATE as RPT_DT
                    , t.TABLE_NAME  as TBL_NM
                 from NBUR_REF_OBJECTS o
                 join NBUR_LST_OBJECTS v
                   on ( v.OBJECT_ID = o.ID )
                 join ALL_TABLES t
                   on ( t.OWNER = 'BARS' and t.TABLE_NAME = o.OBJECT_NAME||'_ARCH' )
                where v.REPORT_DATE < l_lmt_dt
                  and v.OBJECT_STATUS != 'DELETED'
                order by v.REPORT_DATE
             )
    loop

      bars_audit.trace( '%s: tbl_nm=%s, rpt_dt=%s.', title, o.TBL_NM, to_char(o.RPT_DT,fmt_dt) );

      begin

        begin
          execute immediate 'alter table '||o.TBL_NM||' drop partition for ( to_date('''||to_char(o.RPT_DT,'YYYYMMDD')||''',''YYYYMMDD'') )';
          bars_audit.trace( '%s: partition dropped for %s.', title, to_char(o.RPT_DT,fmt_dt) );
        exception
          when e_ptsn_not_exsts then
            null;
        end;

        update NBUR_LST_OBJECTS
           set OBJECT_STATUS = 'DELETED'
         where REPORT_DATE   = o.RPT_DT;

      exception
        when others then
          bars_audit.error( title || ': ' || dbms_utility.format_error_stack()
                                          || dbms_utility.format_error_backtrace() );
      end;

    end loop;

    for f in ( select distinct
                      f.REPORT_DATE as RPT_DT
                 from NBUR_LST_FILES f
                where f.REPORT_DATE < l_lmt_dt
                  and f.FILE_STATUS != 'DELETED'
             )
    loop

      begin

        bars_audit.trace( '%s: tbl_nm=NBUR_DETAIL_PROTOCOLS_ARCH, rpt_dt=%s.', title, to_char(f.RPT_DT,fmt_dt) );

        begin
          execute immediate 'alter table NBUR_DETAIL_PROTOCOLS_ARCH drop partition for ( to_date('''||to_char(f.RPT_DT,'YYYYMMDD')||''',''YYYYMMDD'') )';
          bars_audit.trace( '%s: partition dropped for %s.', title, to_char(f.RPT_DT,fmt_dt) );
        exception
          when e_ptsn_not_exsts then
            null;
        end;

        bars_audit.trace( '%s: tbl_nm=NBUR_AGG_PROTOCOLS_ARCH, rpt_dt=%s.', title, to_char(f.RPT_DT,fmt_dt) );

        begin
          execute immediate 'alter table NBUR_AGG_PROTOCOLS_ARCH drop partition for ( to_date('''||to_char(f.RPT_DT,'YYYYMMDD')||''',''YYYYMMDD'') )';
          bars_audit.trace( '%s: partition dropped for %s.', title, to_char(f.RPT_DT,fmt_dt) );
        exception
          when e_ptsn_not_exsts then
            null;
        end;

        update NBUR_LST_FILES
           set FILE_STATUS = 'DELETED'
--           , FILE_BODY   = null
--           , FILE_HASH   = null
         where REPORT_DATE = f.RPT_DT;

      exception
        when others then
          bars_audit.error( title || ': ' || dbms_utility.format_error_stack()
                                          || dbms_utility.format_error_backtrace() );
      end;

    end loop;

--  commit;

    bars_audit.trace( '%s: Exit.', title );

  end REMOVE_OBSOLETE_VERSIONS;

  --
  --
  --
  procedure GATHER_DM_STATS
  ( p_start_id     in     number
  , p_end_id       in     number
  ) is
  /**
  <b>GATHER_DM_STATS</b> - збір статистики після для всіх обєктів ( DM )
  %param p_start_id -
  %param p_end_id   -

  %version 1.0 (03/08/2016)
  %usage   збір статистики після завантаження всіх обєктів процедурою LOAD_ALL_OBJECTS
  */
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.GATHER_DM_STATS';
  begin

    bars_audit.trace( '%s: Entry with ( p_start_id=%s, p_end_id=%s ).'
                    , title, to_char( p_start_id ), to_char( p_end_id ) );

    for k in ( select SCHEME      as OWN_NM
                    , OBJECT_NAME as OBJ_NM
                 from NBUR_REF_OBJECTS
                where ID between p_start_id AND p_end_id )
    loop

      bars_audit.trace( '%s: Start GATHER_DM_STATS for %s.%s', title, k.OWN_NM, k.OBJ_NM );

      DM.DM_UTL.GATHER_TBL_STATS
      ( p_own_name => k.OWN_NM
      , p_tab_name => k.OBJ_NM
      , p_dop      => l_dop );

    end loop;

    bars_audit.trace( '%s: Exit.', title );

  end GATHER_DM_STATS;

  --
  --
  --
  procedure LOAD_ALL_OBJECTS
  ( p_report_date  in     nbur_lst_objects.report_date%type
  , p_kf           in     nbur_lst_objects.kf%type default null
  , p_version_id   in     nbur_lst_objects.version_id%type
  , p_auto_stat    in     boolean default true
  ) is
  /**
  <b>LOAD_ALL_OBJECTS</b> - Наповнення даними вітрин та збір статистики по них
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії
  %param p_auto_stat   - Автоматичний збір статистики по завантаженим вітринам даних

  %version 1.0
  %usage   Наповнення даними оперативних (проміжних/non versioned) вітрин та збір статистики по них
  */
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.LOAD_ALL_OBJECTS';
    l_task_nm             varchar2(30) := 'GATHER_DM_STATS';
    l_sql_stmt            varchar2(4000);
  begin

    bars_audit.trace( '%s: Entry with ( report_dt=%s, kf=%s, version_id=%s, auto_stat=%s ).'
                    , title, to_char(p_report_date,fmt_dt), p_kf, to_char(p_version_id)
                    , case when p_auto_stat then 'True' else 'False' end );

    P_LOAD_CUSTOMERS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_ACCOUNTS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_BALANCES_R013
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_DAILYBAL
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_MONTHBAL
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_BAL_YEARLY
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_AGRM_ACCOUNTS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_AGRM_RATES
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_AGREEMENTS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_TRANSACTIONS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    P_LOAD_ADL_DOC_RPT_DTL
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_TXN_SYMBOLS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_BALANCES_CLT
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_PROVISIONS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_PAYMENT_SHD
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    LOAD_CHRON_AVG_BALS
    ( p_report_date => p_report_date
    , p_kf          => p_kf
    , p_version_id  => p_version_id );

    if ( p_auto_stat )
    then -- Паралельне завдання на збір статистики

      DBMS_PARALLEL_EXECUTE.create_task(task_name => l_task_nm );

      l_sql_stmt  := 'select ID, ID from BARS.NBUR_REF_OBJECTS';

      DBMS_PARALLEL_EXECUTE.create_chunks_by_sql( task_name => l_task_nm
                                                , sql_stmt  => l_sql_stmt
                                                , by_rowid  => FALSE );

      l_sql_stmt := 'begin NBUR_OBJECTS.GATHER_DM_STATS( :start_id, :end_id ); end;';

      DBMS_PARALLEL_EXECUTE.run_task( task_name      => l_task_nm
                                    , sql_stmt       => l_sql_stmt
                                    , language_flag  => DBMS_SQL.NATIVE
                                    , parallel_level => 8 );

      -- -- If there is error, RESUME it for at most 2 times.
      -- l_try := 0;
      -- while( DBMS_PARALLEL_EXECUTE.task_status(l_task_nm) != DBMS_PARALLEL_EXECUTE.FINISHED and l_try < 2 )
      -- loop
      --   l_try := l_try + 1;
      --   DBMS_PARALLEL_EXECUTE.resume_task(l_task);
      -- end loop;

      DBMS_PARALLEL_EXECUTE.drop_task( task_name => l_task_nm );

    end if;

    bars_audit.trace( '%s: Exit.', title );

  end LOAD_ALL_OBJECTS;

  --
  --
  --
  procedure PARSING_QUEUE_OBJECTS
  is
  /**
  <b>PARSING_QUEUE_OBJECTS</b> -
  %param p_report_date - Звітна дата
  %param p_kf          - Код фiлiалу (МФО)
  %param p_version_id  - Iдентифiкатор версії

  %version 1.0
  %usage
  */
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.PARSING_QUEUE_OBJECTS';
  begin

    null;

--  if ( p_version_id = 1 )
--  then -- для першої версії формуємо всі DM
--
--    LOAD_ALL_OBJECTS
--    ( p_report_date =>
--    , p_kf          =>
--    , p_version_id  =>
--    );
--
--  else -- для другої і всіх наступних
--
--    -- аналіз черги файлів (зміна статусу на "в обробці")
--
--    update NBUR_QUEUE_FORMS
--       set STATUS = 0
--         , DATE_START = sysdate
--     where STATUS = 0
--    returning REPORT_DATE, KF, USER_ID, PROC_TYPE, ID /* file_id */
--      into;
--
--    -- пошук DM необхідних для формування фалів у черзі
--    -- пошук повязаних DM (DM 2-го рівня)
--    -- формування DM із врахуванням рівня DM (встівка із статусом RUNNING):
--    --   - перевірка блокування DM ( так - запуск процедури / ні - запуск процедури формування )
--    -- Інвалідація попередньої версії (про всякий випадок можна усіх у яких version_id об`єкта менший від поточної)
--    -- після завершення формування.
--    -- Виклик процедури формування ФАЙЛІВ у черзі
--
--    -- Перенесення DM в архів
--    SAVE_VERSION
--    ( p_report_date =>
--    , p_kf          =>
--    , p_vrsn_id     =>
--    );
--
--  end if;

    /*
    select o.ID, OBJECT_NAME, SCHEME||'.'||PROC_INSERT as PRC_NM
         , r.OBJECT_PID
      from NBUR_REF_OBJECTS o
      left
      join NBUR_LNK_OBJECT_OBJECT r
        on ( r.OBJECT_ID = o.ID )
     where in ( select ID
                 from NBUR_QUEUE_OBJECTS
                where REPORT_DATE = p_rpt_dt
                  and KF = p_kf
              )
    */
    bars_audit.trace( '%s: Exit.', title );

  end PARSING_QUEUE_OBJECTS;



BEGIN

  -- initialize collection
  t_tbl_lst := t_tbl_lst_type();

  -- Set user kf value
  l_usr_mfo := sys_context('bars_context','user_mfo');

  -- Set Degree of Parallelism
  select greatest( 8, count(1) )
    into l_dop
    from MV_KF;

  l_attempt_num := 1;

  l_dm_tblsps := CHK_DM_TBLSPS();

END NBUR_OBJECTS;
/

show errors;

grant EXECUTE on NBUR_OBJECTS to BARS_ACCESS_DEFROLE;
grant EXECUTE on NBUR_OBJECTS to RPBN002;
