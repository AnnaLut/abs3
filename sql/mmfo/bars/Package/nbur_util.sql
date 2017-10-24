
 
 PROMPT ===================================================================================== 
 PROMPT *** Run *** ========== Scripts /Sql/BARS/package/nbur_util.sql =========*** Run *** =
 PROMPT ===================================================================================== 
 
  CREATE OR REPLACE PACKAGE BARS.NBUR_UTIL 
is
  
  --
  -- Constants
  --
  g_header_version   constant varchar2(64) := 'version 1.2  2017.04.11';
  
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
  ( p_seq_name  in  all_tab_cols.table_name%type   -- назва таблиці
  , p_last_val  in  pls_integer                    -- значення сіквенса (якщо треба поставити своє)
  );
  
end NBUR_UTIL;
/
CREATE OR REPLACE PACKAGE BODY BARS.NBUR_UTIL 
is
  --
  -- constants
  --
  g_body_version  constant varchar2(64)  := 'version 1.2  2017.04.11';
  
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
      l_ddl_stmt := 'alter table BARS.'||p_tab_nm||' add ( '||p_col_nm||' '||p_data_tp||l_dflt_val||' )';
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
  ( p_seq_name  in  all_tab_cols.table_name%type  -- назва таблиці
  , p_last_val  in  pls_integer                    -- значення сіквенса (якщо треба поставити своє)
  ) is
    l_seq_id        pls_integer;
    l_tab_id        pls_integer;
  begin
    
    begin
      execute immediate 'select '||p_seq_name||'.nextval from dual'
         into l_seq_id;
    exception
     when OTHERS then null; -- obj not found
    end;
    
    if ( p_last_val is null ) 
    then
      null;
    else
      
      l_tab_id := p_last_val;
      
      if ( l_tab_id != l_seq_id ) 
      then
         
        execute immediate 'alter sequence ' || p_seq_name || ' increment by ' || to_char(l_tab_id - l_seq_id);

        execute immediate 'select '         || p_seq_name || '.nextval from dual'
           into l_seq_id;
          
        execute immediate 'alter sequence ' || p_seq_name || ' increment by 1';
        
        bars_audit.trace( $$PLSQL_UNIT||'.NORMALIZATION_SEQUENCE: SEQUENCE NEW VALUE = %s', to_char(l_seq_id) );
        
      end if;
      
    end if;
    
  end;
  
  --
  --
  --
  procedure NORMALIZATION_SEQUENCE
  ( p_seg_name  in  all_sequences.sequence_name%type -- назва таблиці
  , p_tab_name  in  all_tab_cols.table_name%type     -- назва таблиці
  , p_col_name  in  all_tab_cols.column_name%type    -- назва таблиці
  ) is
  begin
    null;
    -- bars_audit.trace('NORMALIZATION_SEQUENCE: SEQUENCE LAST VALUE = %s, MAX COLUMN VALUE = %s', to_char(l_seq_id), to_char(l_tab_id) );
  end;




begin
  null;
end NBUR_UTIL;
/
 show err;
 
 
 
 PROMPT ===================================================================================== 
 PROMPT *** End *** ========== Scripts /Sql/BARS/package/nbur_util.sql =========*** End *** =
 PROMPT ===================================================================================== 
 