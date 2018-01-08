
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_util.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NBUR_UTIL 
is

  --
  -- Constants
  --
  g_header_version   constant varchar2(64) := 'version 1.4  2017.10.06';

    --
  -- HEADER_VERSION
  --
  function header_version return varchar2;

  --
  -- BODY_VERSION
  --
  function body_version return varchar2;

  --
  --
  --
  procedure SET_COL
  ( p_tab_nm        in     varchar2
  , p_col_nm        in     varchar2
  , p_data_tp       in     varchar2
  , p_dflt_val      in     varchar2 default null -- column default value
  , p_col_cmnt      in     varchar2 default null -- column comment
  );

  --
  -- NORMALIZATION_SEQUENCE
  --
  procedure NORMALIZATION_SEQUENCE
  ( p_seq_name      in     all_sequences.sequence_name%type -- назва таблиці
  , p_last_val      in     pls_integer                      -- значення сіквенса (якщо треба поставити своє)
  );

  --
  -- NORMALIZATION_SEQUENCE
  --
  procedure NORMALIZATION_SEQUENCE
  ( p_seq_name     in     all_sequences.sequence_name%type -- назва сіквенса
  , p_tab_name     in     all_tab_cols.table_name%type     -- назва таблиці
  , p_col_name     in     all_tab_cols.column_name%type    -- назва поля
  );

  --
  -- EXPORT_FILE
  --
  procedure EXPORT_FILE
  ( p_file_id      in     nbur_lnk_files_objects.file_id%type
  , p_sql_stmt        out clob
  );

  --
  -- CRT_JOBS
  --
  procedure CRT_JOBS
  ( p_recreate      in     signtype default 0
  );

end NBUR_UTIL;
/
CREATE OR REPLACE PACKAGE BODY BARS.NBUR_UTIL 
is
  --
  -- constants
  --
  g_body_version  constant varchar2(64)  := 'version 1.5  2017.08.08';

  --
  -- types
  --

  --
  -- variables
  --

  --
  -- повертає версію заголовка пакета
  --
  function header_version return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' header ' || g_header_version;
  end header_version;

  --
  -- повертає версію тіла пакета
  --
  function body_version return varchar2
  is
  begin
    return 'Package ' || $$PLSQL_UNIT || ' body '   || g_body_version;
  end body_version;

  --
  --
  --
  procedure SET_COL
  ( p_tab_nm        in     varchar2
  , p_col_nm        in     varchar2
  , p_data_tp       in     varchar2
  , p_dflt_val      in     varchar2 default null -- column default value
  , p_col_cmnt      in     varchar2 default null -- column comment
  ) is
    -- Column being added already exists in table
    e_col_exsts            exception;
    pragma exception_init( e_col_exsts,          -01430 );
    -- Column to be modified must be empty to decrease precision or scale
    e_col_not_empty        exception;
    pragma exception_init( e_col_not_empty,      -01440 );
    --
    e_tab_not_exists       exception;
    pragma exception_init( e_tab_not_exists,     -00942 );
    --
    e_missing_exprn        exception;
    pragma exception_init( e_missing_exprn,      -00936 );
    -- Either functional or bitmap join index is defined on the column to be modified
    e_idx_is_dfnd_on_col   exception;
    pragma exception_init( e_idx_is_dfnd_on_col, -30556 );
    -- Data type or length of a table partitioning column may not be changed
    e_   exception;
    pragma exception_init( e_, -14060 );
    -----------------
    -- local variable
    l_scss                 signtype := 1;
    l_dflt_val             varchar2(64);
    l_ddl_stmt             varchar2(512);
    l_idx_nm               varchar2(30);
    l_obj_ddl              clob;
    ---
  begin

    if ( p_dflt_val Is Null )
    then
      l_dflt_val := '';
    else
      l_dflt_val := ' default '|| p_dflt_val;
    end if;

    begin
      l_ddl_stmt := 'alter table BARS.'||p_tab_nm||' add '||p_col_nm||' '||p_data_tp||l_dflt_val;
      execute immediate l_ddl_stmt;
      dbms_output.put_line('Table '||p_tab_nm||' altered.');
    exception
      when E_COL_EXSTS then
        dbms_output.put_line( 'Column '||p_col_nm||' already exists in table BARS.'||p_tab_nm );
        begin
          l_ddl_stmt := 'alter table BARS.'||p_tab_nm||' modify '||p_col_nm||' '||p_data_tp||l_dflt_val;
          execute immediate l_ddl_stmt;
          dbms_output.put_line( 'Column '||p_col_nm||' modified.');
        exception
          when E_COL_NOT_EMPTY then
            null;
          when E_IDX_IS_DFND_ON_COL then
            begin

              DBMS_METADATA.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );

              -- 1) serch index name and ddl
              select INDEX_NAME, DBMS_METADATA.GET_DDL('INDEX',INDEX_NAME,OWNER) as DDL_STMT
                into l_idx_nm, l_obj_ddl
                from ALL_INDEXES
               where TABLE_OWNER = 'BARS'
                 and TABLE_NAME  = p_tab_nm
                 and INDEX_TYPE  = ANY('BITMAP','FUNCTION-BASED NORMAL','FUNCTION-BASED BITMAP');
/*
              select c.INDEX_NAME, DBMS_METADATA.GET_DDL('INDEX',INDEX_NAME,OWNER) as DDL_STMT
                into l_idx_nm, l_obj_ddl
                from ALL_IND_COLUMNS c
                join ALL_INDEXES     i
                  on ( i.TABLE_OWNER = c.TABLE_OWNER and
                       i.TABLE_NAME  = c.TABLE_NAME  )
               where c.TABLE_OWNER = 'BARS'
                 and c.TABLE_NAME  = upper(p_tab_nm)
                 and c.COLUMN_NAME = upper(p_col_nm)
                 and i.INDEX_TYPE  = ANY('BITMAP','FUNCTION-BASED NORMAL','FUNCTION-BASED BITMAP');
*/

              -- 2) drop index
              execute immediate 'drop index '||l_idx_nm;
              dbms_output.put_line( 'Index "'||l_idx_nm||'" dropped.' );

              -- 3) alter column
              SET_COL( p_tab_nm, p_col_nm, p_data_tp, p_dflt_val, p_col_cmnt );

              -- 4) recreate index
              execute immediate l_obj_ddl;
              dbms_output.put_line( 'Index "'||l_idx_nm||'" created.' );

              -- 5) Gather Statistics on that index

            exception
              when NO_DATA_FOUND then
                dbms_output.put_line( sqlerrm );
            end;
          when E_ then
            null;
            -- begin
            --   -- 1) check
            --   select case
            --          when exists ( select /*+ NO_PARALLEL( t ) */ 1
            --                         from NBUR_DM_CHRON_AVG_BALS_ARCH t
            --                        where rownum = 1 )
            --          then 1
            --          else 0
            --        end
            --   into l_
            --   from dual;
            --
            --   -- 2) get table ddl
            --   DBMS_METADATA.SET_TRANSFORM_PARAM( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );
            --   l_obj_ddl := DBMS_METADATA.GET_DDL( 'TABLE', p_tab_nm, 'BARS' );
            --
            --   -- 3) change
            --
            -- end;
          when OTHERS then
            dbms_output.put_line( 'Error' || chr(10) || sqlerrm || chr(10) || l_ddl_stmt );
        end;
      when E_TAB_NOT_EXISTS then
        l_scss := 0;
      when E_MISSING_EXPRN then
        dbms_output.put_line( 'Error: missing expression (' || l_ddl_stmt || ')' );
      when OTHERS then
        dbms_output.put_line( 'Error' || chr(10) || sqlerrm || chr(10) || l_ddl_stmt );
    end;

    if ( l_scss = 1 and p_col_cmnt Is Not Null )
    then
      begin
        execute immediate 'comment on column BARS.'||p_tab_nm||'.'||p_col_nm||' is '||DBMS_ASSERT.ENQUOTE_LITERAL( p_col_cmnt );
        dbms_output.put_line( 'Comment created.' );
      exception
        when OTHERS then
          dbms_output.put_line( sqlerrm );
      end;
    end if;

  end SET_COL;

  --
  --
  --
  procedure NORMALIZATION_SEQUENCE
  ( p_seq_name      in     all_sequences.sequence_name%type -- назва таблиці
  , p_last_val      in     pls_integer                      -- значення сіквенса (якщо треба поставити своє)
  ) is
    l_seq_id               pls_integer;
    l_tab_id               pls_integer;
    l_tab_nm               all_tab_cols.table_name%type;
    l_col_nm               all_tab_cols.column_name%type;
    e_seq_not_exists       exception;
    pragma exception_init( e_seq_not_exists, -02289 );
  begin

    bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: Entry with ( p_seq_name=%s, p_last_val=%s ).', p_seq_name, to_char(p_last_val) );

    begin

      execute immediate 'select '||p_seq_name||'.nextval from dual'
         into l_seq_id;

      if ( p_last_val is null )
      then

        begin

          select TABLE_NAME
            into l_tab_nm
            from ALL_TRIGGERS
           where BASE_OBJECT_TYPE = 'TABLE'
             and ( OWNER, TRIGGER_NAME ) in ( select OWNER, NAME
                                                from ALL_DEPENDENCIES
                                               where REFERENCED_OWNER = 'BARS'
                                                 and REFERENCED_TYPE  = 'SEQUENCE'
                                                 and REFERENCED_NAME  = upper(p_seq_name)
                                                 and OWNER            = 'BARS'
                                                 and TYPE             = 'TRIGGER' );

          begin

            select COLUMN_NAME
              into l_col_nm
              from ALL_CONS_COLUMNS
             where (OWNER,CONSTRAINT_NAME,TABLE_NAME) in ( select OWNER, CONSTRAINT_NAME, TABLE_NAME
                                                             from ALL_CONSTRAINTS
                                                            where OWNER           = 'BARS'
                                                              and TABLE_NAME      = l_tab_nm
                                                              and CONSTRAINT_TYPE = 'P' );
          exception
            when NO_DATA_FOUND then
              bars_audit.error( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: not found column for sequence '||p_seq_name );
          end;

        exception
          when NO_DATA_FOUND then
            bars_audit.error( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: not found table for sequence '||p_seq_name );
        end;

        if ( l_tab_nm Is Not Null and l_col_nm Is Not Null)
        then

          NBUR_UTIL.NORMALIZATION_SEQUENCE
          ( p_seq_name => p_seq_name
          , p_tab_name => l_tab_nm
          , p_col_name => l_col_nm
          );

        end if;

      else

        if ( p_last_val != l_seq_id )
        then

          execute immediate 'alter sequence ' || p_seq_name || ' increment by ' || to_char(p_last_val - l_seq_id);

          execute immediate 'select '         || p_seq_name || '.nextval from dual'
             into l_seq_id;

          execute immediate 'alter sequence ' || p_seq_name || ' increment by 1';

          bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: SEQUENCE NEW VALUE = %s', to_char(l_seq_id) );

        end if;

      end if;

    exception
      when E_SEQ_NOT_EXISTS then
        bars_audit.error( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: sequence '||p_seq_name||' does not exist.' );
    end;

    bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: Exit.' );

  end NORMALIZATION_SEQUENCE;

  --
  --
  --
  procedure NORMALIZATION_SEQUENCE
  ( p_seq_name  in     all_sequences.sequence_name%type -- назва сіквенса
  , p_tab_name  in     all_tab_cols.table_name%type     -- назва таблиці
  , p_col_name  in     all_tab_cols.column_name%type    -- назва поля
  ) is
    l_max_id           pls_integer;
  begin

    bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: Entry with ( p_seq_name=%s, p_tab_name=%s, p_col_name=%s ).', p_seq_name, p_tab_name, p_col_name );

    begin

      execute immediate 'select max('||p_col_name||') from '||p_tab_name
         into l_max_id;

      bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: column %s.%s max value=%s', p_tab_name, p_col_name, to_char(l_max_id) );

      NORMALIZATION_SEQUENCE
      ( p_seq_name => p_seq_name
      , p_last_val => l_max_id
      );

    exception
      when OTHERS then
        case sqlcode
        when -00904
        then bars_audit.error( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: "'||p_col_name||'" invalid identifier.' );
        when -00942
        then bars_audit.error( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: table '||p_tab_name||' does not exist.' );
        else bars_audit.error( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: '||sqlerrm );
        end case;
    end;

    bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: Exit.' );

  end NORMALIZATION_SEQUENCE;

  --
  --
  --
  procedure EXPORT_FILE
  ( p_file_id          in     nbur_lnk_files_objects.file_id%type
  , p_sql_stmt            out clob
  ) is
    title        constant     varchar2(64) := $$PLSQL_UNIT||'.EXPORT_FILE';
    l_sql                     clob;
  begin

    bars_audit.trace( '%s: Entry with ( file_id=%s ).', title, to_char(p_file_id) );

    dbms_lob.createtemporary( l_sql, TRUE );

    l_sql := '-- ======================================================================================' || chr(10)
          || '-- Author : BAA'                                                                           || chr(10)
          || '-- Date   : ' || to_char(sysdate,'dd/mm/yyyy')                                             || chr(10)
          || '-- ===================================== <Comments> =====================================' || chr(10)
          || '-- '                                                                                       || chr(10)
          || '-- ======================================================================================' || chr(10)
          || '-- '                                                                                       || chr(10)
          || '-- ======================================================================================' || chr(10)
          || chr(10)
          || 'SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED'                                         || chr(10)
          || chr(10)
          || 'declare'                                                                                   || chr(10)
          || '  l_file_id   nbur_ref_files.id%type;'                                                     || chr(10)
          || '  l_proc_id   nbur_ref_procs.id%type;'                                                     || chr(10)
          || 'begin'                                                                                     || chr(10)
          || chr(10)
          ;

    l_sql := l_sql || '  -- NBUR_REF_FORM_STRU' || chr(10);

    for k in ( select '  NBUR_FILES.SET_FILE_STC'              ||chr(10)||
                      '  ( p_file_id       => l_file_id'       ||chr(10)||
                      '  , p_seg_num       => '         ||SEGMENT_NUMBER||chr(10)||
                      '  , p_seg_code      => '||chr(39)||SEGMENT_CODE  ||chr(39)||chr(10)||
                      '  , p_seg_nm        => '||chr(39)||SEGMENT_NAME  ||chr(39)||chr(10)||
                      '  , p_seg_rule      => '||chr(39)||SEGMENT_RULE  ||chr(39)||chr(10)||
                      '  , p_key_attr      => '         ||KEY_ATTRIBUTE ||chr(10)||
                      '  , p_sort_attr     => '         ||SORT_ATTRIBUTE||chr(10)||
                      '  );'                   ||chr(10) as STMT
                 from NBUR_REF_FORM_STRU
                where file_id = 16555
                order by SEGMENT_NUMBER )
    loop
      l_sql := l_sql || k.STMT;
    end loop;

    l_sql := l_sql || 'end;' || chr(10) || '/' ||chr(10) || chr(10) || 'commit;' || chr(10) || chr(10);

    p_sql_stmt := l_sql;

    dbms_lob.freetemporary( l_sql );

    bars_audit.trace( '%s: Exit.', title );

  end EXPORT_FILE;

  --
  -- CRT_JOBS
  --
  procedure CRT_JOBS
  ( p_recreate      in     signtype default 0
  ) is
    title       constant   varchar2(64) := $$PLSQL_UNIT||'.CRT_JOBS';
    l_job_nm               varchar2(30);
    l_job_stmt             varchar2(2048);
    l_start_dt             timestamp;
    e_job_not_exists       exception;
    pragma exception_init( e_job_not_exists, -27475 );
    e_job_exists           exception;
    pragma exception_init( e_job_exists, -27477 );
    ---
    procedure DROP_JOB
    is
    begin
      DBMS_SCHEDULER.DROP_JOB( job_name  => l_job_nm );
      bars_audit.info( title || ': Job "' || l_job_nm || '" droped.' );
    exception
      when e_job_not_exists then
        null;
    end;
    ---
    procedure CREATE_JOB
    is
    begin
      DBMS_SCHEDULER.CREATE_JOB
      ( job_name        => l_job_nm
      , job_type        => 'PLSQL_BLOCK'
      , job_action      => l_job_stmt
      , start_date      => l_start_dt
      , repeat_interval => 'FREQ=MINUTELY; INTERVAL=15'
      , enabled         => TRUE
      , comments        => 'Перевірка черги файлів звітності'
      );
      bars_audit.info( title || ': Job "' || l_job_nm || '" created.' );
    exception
      when e_job_exists then
        bars_audit.info( title || ': Job "' || l_job_nm || '" already exists.' );
    end;
    ---
  begin

    bars_audit.trace( '%s: Entry with ( p_recreate=%s ).', title, to_char(p_recreate) );

    l_start_dt := trunc(SYSTIMESTAMP) + INTERVAL '5' MINUTE;

    for j in ( select KF from MV_KF )
    loop

      l_job_nm   := 'NBUR_CHECK_QUEUE_1_'||j.KF;

      if ( p_recreate = 1 )
      then
        DROP_JOB;
      end if;

      l_job_stmt :=  'declare'   || chr(10) || '  RetVal number;' || chr(10) ||
                     'begin'     || chr(10) || '  BARS.BC.HOME;'  || chr(10) ||
                     '  RetVal := BARS.NBUR_QUEUE.F_CHECK_QUEUE_OBJECTS('''||j.KF|| ''');' || chr(10) ||
                     '  commit;' || chr(10) ||
                     'end;';

      CREATE_JOB;

      l_job_nm   := 'NBUR_CHECK_QUEUE_2_'||j.KF;

      if ( p_recreate = 1 )
      then
        DROP_JOB;
      end if;

      l_job_stmt :=  'declare'   || chr(10) || '  RetVal number;' || chr(10) ||
                     'begin'     || chr(10) || '  BARS.BC.HOME;'  || chr(10) ||
                     '  RetVal := BARS.NBUR_QUEUE.F_CHECK_QUEUE_WITHOUT_OBJECTS('''||j.KF|| ''');' || chr(10) ||
                     '  commit;' || chr(10) ||
                     'end;';

      CREATE_JOB;

    end loop;

    bars_audit.trace( '%s: Exit.', title );

  end CRT_JOBS;



begin
  null;
end NBUR_UTIL;
/
 show err;
 
PROMPT *** Create  grants  NBUR_UTIL ***
grant EXECUTE                                                                on NBUR_UTIL       to BARS_ACCESS_DEFROLE;

 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_util.sql =========*** End *** =
 PROMPT ===================================================================================== 
 