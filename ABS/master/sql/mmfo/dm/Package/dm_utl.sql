CREATE OR REPLACE PACKAGE DM.DM_UTL 
is
  --
  -- constants
  --
  g_header_version        constant varchar2(64) := 'version 1.7 22.03.2018';

  --
  -- HEADER_VERSION
  --
  function header_version return varchar2;

  --
  -- EXCHANGE PARTITION BY NAME
  --
  procedure EXCHANGE_PARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type
  , p_novalidate        in     boolean default false
  );

  --
  -- EXCHANGE PARTITION BY CONDITION FOR
  --
  procedure EXCHANGE_PARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  , p_novalidate        in     boolean default false
  );

  --
  -- EXCHANGE SUBPARTITION BY NAME
  --
  procedure EXCHANGE_SUBPARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_subpartition_nm   in     all_tab_subpartitions.subpartition_name%type
  , p_novalidate        in     boolean default false
  );

  --
  -- EXCHANGE SUBPARTITION BY CONDITION FOR
  --
  procedure EXCHANGE_SUBPARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  , p_novalidate        in     boolean default false
  );

  --
  -- RENAME PARTITION BY CONDITION FOR
  --
  procedure RENAME_PARTITION_FOR
  ( p_table_nm          in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type
  , p_condition         in     varchar2
  , p_rename_sub        in     signtype default 0
  );

  procedure SPLIT_IDX_PARTITION
  ( p_idx_nm            in     varchar2
  , p_ptsn_nm           in     varchar2
  , p_spl_cd            in     varchar2
  , p_new1_nm           in     varchar2 default null
  , p_new2_nm           in     varchar2 default null
  );

  --
  -- GET_MOD_SCN
  --
  function GET_LAST_SCN
  ( p_table_nm          in     all_part_tables.table_name%type
  , p_table_own         in     all_part_tables.owner%type
  , p_date              in     date
  , p_kf                in     varchar2
  ) return number;

  --
  -- GATHER_TBL_STATS
  --
  procedure GATHER_TBL_STATS
  ( p_own_name          in     varchar2 default 'BARS'
  , p_tab_name          in     varchar2
  , p_dop               in     integer  default 1
  );

  --
  -- GATHER_TBL_STATS
  --
  procedure GATHER_TBL_STATS
  ( p_own_name          in     varchar2
  , p_tab_name          in     varchar2
  , p_ptsn_name         in     varchar2
  , p_mth_opt           in     varchar2
  , p_dop               in     integer
  , p_grnlr             in     varchar2
  , p_cascade           in     boolean
  , p_force             in     boolean  default FALSE
  );

  --
  -- GATHER_IDX_STATS
  --
  procedure GATHER_IDX_STATS
  ( p_own_name          in     varchar2 default 'BARS'
  , p_idx_name          in     varchar2
  , p_dop               in     integer  default 1
  , p_grnlr             in     varchar2 default 'AUTO'
  , p_force             in     boolean  default FALSE
  );

  --
  -- GATHER_DM_STATS
  --
  procedure GATHER_DM_STATS
  ( p_dm_nm             in     varchar2
  , p_force             in     boolean default FALSE
  );

END DM_UTL;
/

show errors;

CREATE OR REPLACE PACKAGE BODY DM.DM_UTL 
is
  --
  -- constants
  --
  G_BODY_VERSION          constant varchar2(64) := 'version 2.2  22.03.2018';
  G_MODCODE               constant varchar2(10) := 'BARS_DM';
  G_ERR_MODCODE           constant varchar2(3)  := 'ACM';

  -- Сolumn type or size mismatch in EXCHANGE SUBPARTITION
  ERR_COLUMN_MISMATCH     exception;
  PRAGMA EXCEPTION_INIT( ERR_COLUMN_MISMATCH, -14278 );

  -- Index mismatch for tables in EXCHANGE SUBPARTITION
  ERR_INDEX_MISMATCH      exception;
  PRAGMA EXCEPTION_INIT( ERR_COLUMN_MISMATCH, -14279 );

  --
  -- повертає версію заголовка пакета
  --
  function header_version
    return varchar2
  is
  /**
  <b>HEADER_VERSION</b> - ф-я повертає версію заголовка пакета
  %param

  %version 1.0   27.05.2016
  %usage   перевірка версії заголовка пакета
  */
  begin
    return 'Package DM_UTL header '||g_header_version;
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version
    return varchar2
  is
  /**
  <b>BODY_VERSION</b> - ф-я повертає версію тіла пакета
  %param

  %version 1.0   27.05.2016
  %usage   перевірка версії тіла пакета
  */
  begin
    return 'Package DM_UTL body '||g_body_version;
  end body_version;

  --
  -- EXCHANGE PARTITION BY NAME
  --
  procedure EXCHANGE_PARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type
  , p_novalidate        in     boolean default false
  ) is
  begin

    bars.bars_audit.trace( 'dm_utl.exchange_partition: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_part_nm=%s, p_novalidate=%s ).'
                         , p_source_table_nm, p_target_table_nm, p_partition_nm
                         , case when p_novalidate then 'TRUE' else 'FALSE' end );

    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!' );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!' );
      when ( p_partition_nm    Is Null )
      then raise_application_error( -20666, 'Parameter [p_partition_nm] must be specified!' );
      else null;
    end case;

    execute immediate 'ALTER TABLE BARS.'   ||p_target_table_nm||
                      ' EXCHANGE PARTITION '||p_partition_nm   ||
                      ' WITH TABLE BARS.'   ||p_source_table_nm||
                      ' INCLUDING INDEXES ' ||case when p_novalidate
                                              then ' WITHOUT VALIDATION'
                                              else '' end;

    bars.bars_audit.trace( 'dm_utl.exchange_partition: Exit.' );

  end EXCHANGE_PARTITION;

  --
  -- EXCHANGE PARTITION BY CONDITION FOR
  --
  PROCEDURE EXCHANGE_PARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  , p_novalidate        in     boolean default false
  ) is
  begin

    bars.bars_audit.trace( 'dm_utl.exchange_partition_for: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_condition=%s, p_novalidate=%s ).'
                         , p_source_table_nm, p_target_table_nm, p_condition
                         , case when p_novalidate then 'TRUE' else 'FALSE' end );

    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!' );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!' );
      when ( p_condition       Is Null )
      then raise_application_error( -20666, 'Parameter [p_condition] must be specified!' );
      else null;
    end case;

    -- partition is first locked to ensure that the partition is created
    execute immediate 'LOCK TABLE BARS.'||p_target_table_nm||
                      ' PARTITION FOR ' ||p_condition      ||
                      ' IN SHARE MODE';

    execute immediate 'ALTER TABLE BARS.'       ||p_target_table_nm||
                      ' EXCHANGE PARTITION FOR '||p_condition      ||
                      ' WITH TABLE BARS.'       ||p_source_table_nm||
                      ' INCLUDING INDEXES '     ||case when p_novalidate
                                                  then ' WITHOUT VALIDATION'
                                                  else '' end;

    bars.bars_audit.trace( 'dm_utl.exchange_partition_for: Exit.' );

  end EXCHANGE_PARTITION_FOR;

  --
  -- EXCHANGE SUBPARTITION BY NAME
  --
  PROCEDURE EXCHANGE_SUBPARTITION
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_subpartition_nm   in     all_tab_subpartitions.subpartition_name%type
  , p_novalidate        in     boolean default false
  ) is
  begin

    bars.bars_audit.trace( 'dm_utl.exchange_subpartition: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_subpart_nm=%s, p_novalidate=%s ).'
                         , p_source_table_nm, p_target_table_nm, p_subpartition_nm
                         , case when p_novalidate then 'TRUE' else 'FALSE' end );

    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!', true );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!', true );
      when ( p_subpartition_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_subpartition_nm] must be specified!', true );
      else null;
    end case;

    execute immediate 'ALTER TABLE BARS.'      ||p_target_table_nm||
                      ' EXCHANGE SUBPARTITION '||p_subpartition_nm||
                      ' WITH TABLE BARS.'      ||p_source_table_nm||
                      ' INCLUDING INDEXES '    ||case when p_novalidate
                                                 then ' WITHOUT VALIDATION'
                                                 else '' end;

    bars.bars_audit.trace( 'dm_utl.exchange_subpartition: Exit.' );

  end EXCHANGE_SUBPARTITION;

  --
  -- EXCHANGE SUBPARTITION BY CONDITION FOR
  --
  PROCEDURE EXCHANGE_SUBPARTITION_FOR
  ( p_source_table_nm   in     all_tab_subpartitions.table_name%type
  , p_target_table_nm   in     all_tab_subpartitions.table_name%type
  , p_condition         in     varchar2
  , p_novalidate        in     boolean default false
  ) is
  /**
  <b>EXCHANGE_SUBPARTITION_FOR</b> - EXCHANGE SUBPARTITION without specified SUBPARTITION NAME (by section key)
  %param p_source_table_nm - source table name
  %param p_target_table_nm - target table name
  %param p_condition       - section key for subpartition

  %version 1.0
  %usage   визначення наявності операції утримання штрафу з депозиту
  */
    title   constant  varchar2(60) := 'dm_utl.exchange_subpartition_for';
  begin

    bars.bars_audit.trace( '%s: Start with (p_src_tab_nm=%s, p_trg_tab_nm=%s, p_condition=%s, p_novalidate=%s ).'
                         , title, p_source_table_nm, p_target_table_nm, p_condition
                         , case when p_novalidate then 'TRUE' else 'FALSE' end );

    case
      when ( p_source_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_source_table_nm] must be specified!' );
        -- bars.bars_error.raise_nerror( G_ERR_MODCODE, 'GENERAL_ERROR_CODE', 'Parameter [p_source_table_nm] must be specified!' );
      when ( p_target_table_nm Is Null )
      then raise_application_error( -20666, 'Parameter [p_target_table_nm] must be specified!' );
      when ( p_condition       Is Null )
      then raise_application_error( -20666, 'Parameter [p_condition] must be specified!' );
      else null;
    end case;

    -- subpartition is first locked to ensure that the partition is created
    execute immediate 'LOCK TABLE BARS.'  ||p_target_table_nm||
                      ' SUBPARTITION FOR '||p_condition      ||
                      ' IN SHARE MODE';

    begin
      execute immediate 'ALTER TABLE BARS.'          ||p_target_table_nm||
                        ' EXCHANGE SUBPARTITION FOR '||p_condition      ||
                        ' WITH TABLE BARS.'          ||p_source_table_nm||
                        ' INCLUDING INDEXES '        ||case when p_novalidate
                                                       then ' WITHOUT VALIDATION'
                                                       else '' end;
    exception
      when ERR_COLUMN_MISMATCH then
        bars_audit.error( title || ': Невідповідність типу або розміру полів в таблиць ' || p_target_table_nm || ' та ' || p_source_table_nm
                                || chr(10) || dbms_utility.format_error_backtrace() );
        raise ERR_COLUMN_MISMATCH;
        /*
        -- compare table columns and write diff log in sec_audit
        select *
          from all_tab_columns
         where owner = 'BARS'
           and table_name = 'AGG_MONBALS'
        */
      when ERR_INDEX_MISMATCH then
        bars_audit.error( title || ': Невідповідність структури індексу таблиць ' || p_target_table_nm || ' та ' || p_source_table_nm
                                || chr(10) || dbms_utility.format_error_backtrace() );
        raise ERR_INDEX_MISMATCH;
    end;

    bars.bars_audit.trace( 'dm_utl.exchange_subpartition_for: Exit.'  );

  end EXCHANGE_SUBPARTITION_FOR;

  --
  -- RENAME PARTITION BY CONDITION FOR
  --
  PROCEDURE RENAME_PARTITION_FOR
  ( p_table_nm          in     all_tab_subpartitions.table_name%type
  , p_partition_nm      in     all_tab_subpartitions.partition_name%type
  , p_condition         in     varchar2
  , p_rename_sub        in     signtype default 0
  ) is
  /**
  <b>RENAME_PARTITION_FOR</b> - RENAME PARTITION (by specified section key)
  %param p_table_nm     - table name
  %param p_partition_nm - new partition name
  %param p_condition    - section key for partition

  %version 1.0
  %usage   Переіменування секції таблиці (по ключу для системно згенерованих імен)
  */
    title          constant    varchar2(60) := 'dm_utl.exchange_subpartition_for';
    l_condition                varchar2(300);
    l_pos                      pls_integer;
  begin

    bars.bars_audit.trace( '%s: Start with (p_tab_nm=%s, p_partition_nm=%s, p_condition=%s).'
                         , title, p_table_nm, p_partition_nm, p_condition );
    begin
      execute immediate 'ALTER TABLE BARS.'     ||p_table_nm ||
                        ' RENAME PARTITION FOR '||p_condition||' TO ' ||p_partition_nm;
    exception
      when OTHERS then
        if ( sqlcode = -14081 )
        then null; -- new partition name must differ from the old partition name
        else bars_audit.error( title   || dbms_utility.format_error_stack()  ||
                               chr(10) || dbms_utility.format_error_backtrace() );
        end if;
    end;

    if ( p_rename_sub = 1 )
    then -- rename subpartition

      l_pos := inStr( p_condition, ')', -1 ) - 1;

      l_condition := SubStr( p_condition, 1, l_pos )||',';

      for s in ( select kc.COLUMN_NAME
                    --, kc.COLUMN_POSITION
                      , t.SUBPARTITION_NAME
                      , t.HIGH_BOUND
                   from ALL_SUBPART_KEY_COLUMNS kc
                   join ALL_SUBPARTITION_TEMPLATES t
                     on ( t.USER_NAME = kc.OWNER and t.TABLE_NAME = kc.NAME )
                  where kc.OWNER = 'BARS'
                    and kc.OBJECT_TYPE = 'TABLE'
                    and kc.NAME = p_table_nm
                  order by SUBPARTITION_POSITION )
      loop
        begin
          execute immediate 'ALTER TABLE BARS.'||p_table_nm||
                            ' RENAME SUBPARTITION FOR '||l_condition||s.HIGH_BOUND||
                            ') TO '||p_partition_nm||'_'||s.SUBPARTITION_NAME;
        end;
      end loop;

    end if;

    bars.bars_audit.trace( '%s: Exit.', title );

  end RENAME_PARTITION_FOR;

  --
  -- SPLIT_IDX_PARTITION
  --
  procedure SPLIT_IDX_PARTITION
  ( p_idx_nm            in     varchar2
  , p_ptsn_nm           in     varchar2
  , p_spl_cd            in     varchar2
  , p_new1_nm           in     varchar2 default null
  , p_new2_nm           in     varchar2 default null
  ) is
    title         constant     varchar2(32) := 'dm_utl.split_idx_partition';
    l_spl_stmt                 varchar2(512);
  begin

    bars_audit.trace( '%s: Entry with ( p_idx_nm=>%s, p_ptsn_nm=>%s, p_spl_cd=%s, p_new1_nm=%s, p_new2_nm=%s ).'
                    , title, p_idx_nm, p_ptsn_nm, p_spl_cd, p_new1_nm, p_new2_nm );

    l_spl_stmt := 'alter index '||p_idx_nm||' split partition '||p_ptsn_nm||' at '||p_spl_cd;

    case
    when ( p_new1_nm Is Not Null and p_new2_nm Is Not Null )
    then
      l_spl_stmt := l_spl_stmt||' into ( partition '||p_new1_nm||', partition '||p_new2_nm||' )';
    when ( p_new1_nm Is Not Null and p_new2_nm Is Null )
    then
      l_spl_stmt := l_spl_stmt||' into ( partition '||p_new1_nm||', partition '||p_ptsn_nm||' )';
    else
     null;
    end case;

    bars_audit.trace( '%s: stmt=>%s.', title, l_spl_stmt );

    execute immediate l_spl_stmt;

    bars.bars_audit.trace( '%s: Exit.', title );

  end SPLIT_IDX_PARTITION;

  --
  -- GET_MOD_SCN
  --
  function GET_LAST_SCN
  ( p_table_nm          in     all_part_tables.table_name%type
  , p_table_own         in     all_part_tables.owner%type
  , p_date              in     date
  , p_kf                in     varchar2
  ) return number
  is
    /**
    <b>GET_LAST_SCN</b> - Повертає SCN останньої модифікації таблиці
    %param p_table_nm  - table name
    %param p_table_own - table owner
    %param p_date      - partition key value ( FDAT )
    %param p_kf        - subpartition key value ( KF )

    %version 1.2
    %usage   отримати SCN останных змін в таблиці
    */
    title         constant     varchar2(32) := 'dm_utl.get_last_scn';
    l_tbl_own                  all_part_tables.owner%type;
    l_scn                      number(38);
    l_ptsn                     number(1);
    l_sptsn                    number(1);
    l_stmt                     varchar(2048); -- additional conditions
    l_dt                       varchar2(8);   -- partition key value
  begin

    bars_audit.trace( '%s: Entry with ( p_table_nm=>%s, p_date=>%s, p_kf=>%s ).'
                    , title, p_table_nm, to_char(p_date,'dd.mm.yyyy'), p_kf );

    l_tbl_own := upper(nvl(p_table_own,'BARS'));
    l_dt := to_char(p_date,'yyyymmdd');

    begin
      select 1
           , case when SUBPARTITIONING_TYPE = 'NONE' then 0 else 1 end
        into l_ptsn
           , l_sptsn
        from ALL_PART_TABLES
       where TABLE_NAME = upper(p_table_nm)
         and OWNER      = l_tbl_own;
    exception
      when NO_DATA_FOUND then
        l_ptsn  := 0;
        l_sptsn := 0;
    end;

    l_stmt := case
              when upper(p_table_nm) = 'SALDOA'
              then q'[ s where not exists (select 1 from ]'||l_tbl_own||q'[.ACCOUNTS a where a.NLS like '80%' and a.ACC = s.ACC)]'
              else null
              end;

    l_stmt := case
              when ( l_sptsn = 1 )
              then --
                case
                when ( p_kf   Is Not Null and p_date Is Null )
                then 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm ||
                     ' partition for ( '''||p_kf||''' )' || l_stmt
                when ( p_date Is Not Null and p_kf   Is Null )
                then 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm ||
                     ' partition for ( to_date('''||l_dt||''',''yyyymmdd'') )' || l_stmt
                when ( p_date Is Not Null and p_kf Is Not Null )
                then 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm ||
                     ' subpartition for ( to_date('''||l_dt||''',''yyyymmdd''), '''||p_kf||''' )'|| l_stmt
                else 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm || l_stmt
                end
              when ( l_ptsn  = 1 )
              then -- 
                case
                when ( p_date Is Not Null )
                then 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm ||
                     ' partition for ( to_date('''||l_dt||''',''yyyymmdd'') )' || l_stmt
                when ( p_kf Is Not Null )
                then 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm ||
                     ' partition for ( '''||p_kf||''' )' || l_stmt
--              where ( p_date Is Null AND p_kf Is Null )
--              then 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm || l_stmt
                else 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm || l_stmt
                end
              else 'select nvl(max(ora_rowscn),0) from ' || l_tbl_own || '.' || p_table_nm ||
                   ' where FDAT = to_date('''||l_dt||''',''yyyymmdd'')'
              end;

    bars_audit.trace( '%s: stmt=>%s.', title,l_stmt );

    execute immediate l_stmt into l_scn;

    bars_audit.trace( '%s: Exit with SCN=%s', title, to_char(l_scn) );

    return l_scn;

  end GET_LAST_SCN;

  --
  --
  --
  procedure GATHER_TBL_STATS
  ( p_own_name     in     varchar2 default 'BARS'
  , p_tab_name     in     varchar2
  , p_dop          in     integer  default 1
  ) is
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.GATHER_TBL_STATS';
  begin

    bars_audit.trace( '%s: Entry with ( p_own_name=%s, p_tab_name=%s, p_dop=%s ).'
                    , title, p_own_name, p_tab_name, to_char( p_dop ) );

    begin
      DBMS_STATS.GATHER_TABLE_STATS
      ( ownname          => p_own_name
      , tabname          => p_tab_name
      , estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE
      , cascade          => TRUE
      , method_opt       => 'FOR ALL COLUMNS SIZE AUTO'
      , degree           => p_dop
      , granularity      => 'ALL' );
    exception
      when OTHERS then
        bars_audit.error( $$PLSQL_UNIT || ': ' ||chr(10)|| dbms_utility.format_error_stack()
                                               ||chr(10)|| dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end GATHER_TBL_STATS;

  --
  --
  --
  procedure GATHER_TBL_STATS
  ( p_own_name     in     varchar2
  , p_tab_name     in     varchar2
  , p_ptsn_name    in     varchar2
  , p_mth_opt      in     varchar2
  , p_dop          in     integer
  , p_grnlr        in     varchar2
  , p_cascade      in     boolean
  , p_force        in     boolean default FALSE
  ) is
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.GATHER_TBL_STATS';
  begin

    bars_audit.trace( '%s: Entry with ( p_own_name=%s, p_tab_name=%s, p_ptsn_name=%s, p_mth_opt=%s, p_dop=%s, p_grnlr=%s, p_cascade=%s, p_force=%s ).'
                    , title, p_own_name, p_tab_name, p_ptsn_name, p_mth_opt, to_char( p_dop ), p_grnlr
                    , case when p_cascade then 'TRUE' else 'FALSE' end
                    , case when p_force   then 'TRUE' else 'FALSE' end );

    begin
      DBMS_STATS.GATHER_TABLE_STATS
      ( ownname          => p_own_name
      , tabname          => p_tab_name
      , partname         => p_ptsn_name
      , estimate_percent => DBMS_STATS.AUTO_SAMPLE_SIZE
      , cascade          => p_cascade
      , method_opt       => p_mth_opt
      , degree           => p_dop
      , granularity      => p_grnlr
      , force            => p_force );
    exception
      when OTHERS then
        bars_audit.error( $$PLSQL_UNIT || ': ' ||chr(10)|| dbms_utility.format_error_stack()
                                               ||chr(10)|| dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end GATHER_TBL_STATS;

  --
  --
  --
  procedure GATHER_IDX_STATS
  ( p_own_name     in     varchar2 default 'BARS'
  , p_idx_name     in     varchar2
  , p_dop          in     integer  default 1
  , p_grnlr        in     varchar2 default 'AUTO'
  , p_force        in     boolean  default FALSE
  ) is
    title     constant    varchar2(60) := $$PLSQL_UNIT||'.GATHER_IDX_STATS';
  begin

    bars_audit.trace( '%s: Entry with ( p_own_name=%s, p_idx_name=%s, p_dop=%s, p_grnlr=%s, p_force=%s ).'
                    , title, p_own_name, p_idx_name, to_char( p_dop ), p_grnlr
                    , case when p_force then 'TRUE' else 'FALSE' end );

    begin
      DBMS_STATS.GATHER_INDEX_STATS
      ( ownname     => p_own_name
      , indname     => p_idx_name
      , degree      => p_dop
      , granularity => p_grnlr
      , force       => p_force );
    exception
      when OTHERS then
        bars_audit.error( $$PLSQL_UNIT || ': ' ||chr(10)|| dbms_utility.format_error_stack()
                                               ||chr(10)|| dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end GATHER_IDX_STATS;

  --
  --
  --
  procedure GATHER_DM_STATS
  ( p_dm_nm        in     varchar2
  , p_force        in     boolean default FALSE
  ) is
    title     constant    varchar2(64) := $$PLSQL_UNIT||'.GATHER_DM_STATS';
  begin

    bars_audit.trace( '%s: Entry with ( p_dm_nm=%s, p_force=%s ).'
                    , title, p_dm_nm, case when p_force then 'TRUE' else 'FALSE' end );

    begin
      DBMS_STATS.GATHER_TABLE_STATS
      ( ownname          => 'BARS'
      , tabname          => p_dm_nm );
    exception
      when OTHERS then
        bars_audit.error( $$PLSQL_UNIT || ': ' ||chr(10)|| dbms_utility.format_error_stack()
                                               ||chr(10)|| dbms_utility.format_error_backtrace() );
    end;

    bars_audit.trace( '%s: Exit.', title );

  end GATHER_DM_STATS;



BEGIN
  NULL;
END DM_UTL;
/

show err;

grant EXECUTE on DM.DM_UTL to BARS;
