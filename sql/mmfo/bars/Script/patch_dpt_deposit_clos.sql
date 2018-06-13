-- ================================================================================
-- Module : DPT
-- Author : BAA
-- Date   : 13.06.2018
-- ================================== <Comments> ==================================
-- recreate table DPT_DEPOSIT_CLOS
-- ================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TIMING       ON
SET TRIMSPOOL    ON
SET VERIFY       OFF

prompt -- ======================================================
prompt -- recreate table DPT_DEPOSIT_CLOS
prompt -- ======================================================

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index I3_DPTDEPOSITCLOS';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS
  then null;
end;
/

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index I4_DPTDEPOSITCLOS';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS
  then null;
end;
/

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index I5_DPTDEPOSITCLOS';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS
  then null;
end;
/

declare
  e_cnstrn_not_exists    exception;
  pragma exception_init( E_CNSTRN_NOT_EXISTS, -02443 );
begin
  execute immediate 'alter table DPT_DEPOSIT_CLOS drop constraint UK2_DPTDEPOSITCLOS cascade drop index';
  dbms_output.put_line( 'Table altered.' );
exception
  when e_cnstrn_not_exists
  then null;
end;
/

declare
  E_IDX_NOT_EXISTS        exception;
  pragma exception_init( E_IDX_NOT_EXISTS, -01418 );
begin
  execute immediate 'drop index I_KF_IDUPD_DPTID_DPTDEPCLOS';
  dbms_output.put_line( 'Index dropped.' );
exception
  when E_IDX_NOT_EXISTS
  then null;
end;
/

declare
  l_tab_nm            varchar2(30);
  l_ptsn_f            number(1);
  l_col_lst           varchar2(2048);
  l_tab_stmt          varchar2(8000);
  type r_stmt_type is record ( obj_tp    varchar2(30)
                             , obj_nm    varchar2(30)
                             , ddl_txt   varchar2(16384)
                             );
  type t_stmt_type is table of r_stmt_type;
  t_stmt              t_stmt_type := t_stmt_type();
  ---
  e_tab_not_exists       exception;
  pragma exception_init( e_tab_not_exists, -00942 );
  e_tab_rd_only          exception;
  pragma exception_init( e_tab_rd_only, -14139 );
  e_col_already_nn       exception;
  pragma exception_init( e_col_already_nn, -01442 );
begin

  l_tab_nm := 'DPT_DEPOSIT_CLOS';

  -- перевірка наяності SUBPARTITIONS
  select case
         when EXISTS( select 1
                        from ALL_TAB_SUBPARTITIONS
                       where TABLE_OWNER = 'BARS'
                         and TABLE_NAME  = l_tab_nm )
         then 1
         else 0
         end
    into l_ptsn_f
    from dual;

  if ( l_ptsn_f = 0 )
  then -- якщо SUBPARTITIONS відсутні

    begin
      execute immediate 'drop table TEST_'||l_tab_nm||' cascade constraints';
      dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" dropped.' );
    exception
      when e_tab_not_exists
      then null;
    end;

    execute immediate 'ALTER SESSION ENABLE PARALLEL DDL';
    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    -- KF + all other columns
    select LISTAGG(t.COLUMN_NAME,', ') WITHIN GROUP ( order by case t.COLUMN_NAME when 'KF' then -1 else t.COLUMN_ID end )
      into l_col_lst
      from ALL_TAB_COLS t
     where t.OWNER = 'BARS' 
       and t.TABLE_NAME = l_tab_nm
       and t.COLUMN_ID > 0
--     and t.HIDDEN_COLUMN = 'NO'
--     and t.VIRTUAL_COLUMN = 'NO'
    ;

    begin
      execute immediate 'alter table ' || l_tab_nm || ' read only';
    exception
      when e_tab_rd_only then
        dbms_output.put_line( 'Table "'|| l_tab_nm || '" is already in read-only mode.' );
    end;

    l_tab_stmt := 'create table TEST_' || l_tab_nm || chr(10) || '( ' ||
    replace( l_col_lst, 'KF,', q'[KF default sys_context('bars_context','user_mfo') not null,]' ) || q'[
) tablespace BRSBIGD
COMPRESS FOR OLTP
PARALLEL 24
STORAGE( INITIAL 256K NEXT 256K )
PARTITION BY RANGE ("WHEN") INTERVAL( NUMTOYMINTERVAL(3,'MONTH'))
SUBPARTITION BY LIST (KF)
SUBPARTITION TEMPLATE
( SUBPARTITION SP_300465 VALUES ('300465')
, SUBPARTITION SP_302076 VALUES ('302076')
, SUBPARTITION SP_303398 VALUES ('303398')
, SUBPARTITION SP_304665 VALUES ('304665')
, SUBPARTITION SP_305482 VALUES ('305482')
, SUBPARTITION SP_311647 VALUES ('311647')
, SUBPARTITION SP_312356 VALUES ('312356')
, SUBPARTITION SP_313957 VALUES ('313957')
, SUBPARTITION SP_315784 VALUES ('315784')
, SUBPARTITION SP_322669 VALUES ('322669')
, SUBPARTITION SP_323475 VALUES ('323475')
, SUBPARTITION SP_324805 VALUES ('324805')
, SUBPARTITION SP_325796 VALUES ('325796')
, SUBPARTITION SP_326461 VALUES ('326461')
, SUBPARTITION SP_328845 VALUES ('328845')
, SUBPARTITION SP_331467 VALUES ('331467')
, SUBPARTITION SP_333368 VALUES ('333368')
, SUBPARTITION SP_335106 VALUES ('335106')
, SUBPARTITION SP_336503 VALUES ('336503')
, SUBPARTITION SP_337568 VALUES ('337568')
, SUBPARTITION SP_338545 VALUES ('338545')
, SUBPARTITION SP_351823 VALUES ('351823')
, SUBPARTITION SP_352457 VALUES ('352457')
, SUBPARTITION SP_353553 VALUES ('353553')
, SUBPARTITION SP_354507 VALUES ('354507')
, SUBPARTITION SP_356334 VALUES ('356334')
)
( PARTITION DEPCLS_Y2009    VALUES LESS THAN (TO_DATE(' 2010-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2010    VALUES LESS THAN (TO_DATE(' 2011-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2011    VALUES LESS THAN (TO_DATE(' 2012-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2012    VALUES LESS THAN (TO_DATE(' 2013-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2013    VALUES LESS THAN (TO_DATE(' 2014-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2014    VALUES LESS THAN (TO_DATE(' 2015-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q1 VALUES LESS THAN (TO_DATE(' 2015-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q2 VALUES LESS THAN (TO_DATE(' 2015-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q3 VALUES LESS THAN (TO_DATE(' 2015-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2015_Q4 VALUES LESS THAN (TO_DATE(' 2016-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q1 VALUES LESS THAN (TO_DATE(' 2016-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q2 VALUES LESS THAN (TO_DATE(' 2016-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q3 VALUES LESS THAN (TO_DATE(' 2016-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2016_Q4 VALUES LESS THAN (TO_DATE(' 2017-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q1 VALUES LESS THAN (TO_DATE(' 2017-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q2 VALUES LESS THAN (TO_DATE(' 2017-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q3 VALUES LESS THAN (TO_DATE(' 2017-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION DEPCLS_Y2017_Q4 VALUES LESS THAN (TO_DATE(' 2018-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
)
as
select /*+ parallel( 24 ) */ ]' || l_col_lst || q'[
  from ]'|| l_tab_nm;

    execute immediate l_tab_stmt;
    dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" created.' );

    -- ======================================================
    -- Default Values
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying default column values from source table.' );
      for dv in ( select COLUMN_NAME, DATA_DEFAULT, DEFAULT_LENGTH
                    from ALL_TAB_COLS
                   where OWNER = 'BARS'
                     and TABLE_NAME = l_tab_nm
                     and COLUMN_NAME != 'KF'
                     and COLUMN_ID > 0
                     and DATA_DEFAULT IS NOT NULL
      ) loop
        begin
          l_tab_stmt := 'alter table TEST_' || l_tab_nm || ' modify ' || dv.COLUMN_NAME ||
                                ' default ' || SubStr( dv.DATA_DEFAULT, 1, dv.DEFAULT_LENGTH );
          execute immediate l_tab_stmt;
        exception
          when OTHERS then
            dbms_output.put_line( l_tab_stmt ||chr(10)|| sqlerrm );
        end;
      end loop;
    end;

    -- ======================================================
    -- Comments
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying comments from source table.' );
      for c in ( select 'comment on table '||OWNER||'.TEST_'||TABLE_NAME||' is '||DBMS_ASSERT.ENQUOTE_LITERAL(COMMENTS) as STMT
                  from ALL_TAB_COMMENTS
                 where OWNER = 'BARS'
                   and TABLE_NAME = l_tab_nm
                 union all
                select 'comment on column '||OWNER||'.TEST_'||TABLE_NAME||'.'||COLUMN_NAME||' is '||DBMS_ASSERT.ENQUOTE_LITERAL(COMMENTS)
                  from ALL_COL_COMMENTS
                 where OWNER = 'BARS'
                   and TABLE_NAME = l_tab_nm
                   and COMMENTS Is Not Null
      ) loop
        begin
          execute immediate c.STMT;
          dbms_output.put_line( 'Comment created.' );
        exception
          when OTHERS then
            dbms_output.put_line( 'Comment creation error: ' || sqlerrm || chr(10) || c.STMT );
        end;
      end loop;
    end;

    -- ======================================================
    -- Grants
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying privileges from source table.' );
      for c in ( select 'grant '||PRIVILEGE||' on TEST_'||TABLE_NAME||' to '||GRANTEE ||
                        case GRANTABLE when 'YES' then ' WITH GRANT OPTION' else '' end  as STMT
                   from ALL_TAB_PRIVS
                  where TABLE_SCHEMA = 'BARS'
                    and TABLE_NAME   = l_tab_nm
      ) loop
        begin
          execute immediate c.STMT;
          dbms_output.put_line( 'Grant complete.' );
        exception
          when OTHERS then
            dbms_output.put_line( 'Grant creation error: ' || sqlerrm || chr(10) || c.STMT );
        end;
      end loop;
    end;

    -- ======================================================
    -- Collect DDL for constraints, Indexes and Triggers
    -- ======================================================
    begin
      DBMS_METADATA.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );
      for k in ( select 'CONSTRAINT'    as OBJ_TP
                      , CONSTRAINT_NAME as OBJ_NM
                   from USER_CONSTRAINTS
                  where TABLE_NAME = l_tab_nm
                    and CONSTRAINT_TYPE = any ('P','U','C')
                    and CONSTRAINT_NAME not like 'CC%NN' -- Not Null
                  union all
                 select 'REF_CONSTRAINT' as OBJ_TP
                      , CONSTRAINT_NAME  as OBJ_NM
                   from USER_CONSTRAINTS
                  where TABLE_NAME = l_tab_nm
                    and CONSTRAINT_TYPE = 'R'
                  union all
                 select 'INDEX'      as OBJ_TP
                      , i.INDEX_NAME as OBJ_NM
                   from USER_INDEXES i
                   left
                   join ( select CONSTRAINT_NAME, INDEX_NAME
                            from USER_CONSTRAINTS
                           where TABLE_NAME = l_tab_nm
                             and CONSTRAINT_TYPE = any ('P','U')
                        ) c
                     on ( c.INDEX_NAME = i.INDEX_NAME )
                  where i.TABLE_OWNER = 'BARS'
                    and i.TABLE_NAME  = l_tab_nm
                    and c.INDEX_NAME Is Null
                  union all
                 select 'TRIGGER'    as OBJ_TP
                      , TRIGGER_NAME as OBJ_NM
                   from USER_TRIGGERS
                  where TABLE_NAME = l_tab_nm
             )
      loop
        t_stmt.EXTEND;
        t_stmt(t_stmt.last).OBJ_TP  := k.OBJ_TP;
        t_stmt(t_stmt.last).OBJ_NM  := k.OBJ_NM;
        t_stmt(t_stmt.last).DDL_TXT := DBMS_LOB.SUBSTR( DBMS_METADATA.GET_DDL( k.OBJ_TP, k.OBJ_NM ), 16000, 4 );
        case k.OBJ_TP
        when 'CONSTRAINT'
        then
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, ' DISABLE',  ' ENABLE'     );
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, ' VALIDATE', ' NOVALIDATE' );
          -- add replacement of constraints such as "CHECK (VIDD IS NOT NULL)" to "MODIFY VIDD NOT NULL"
        when 'TRIGGER'
        then
          t_stmt(t_stmt.last).ddl_txt := regexp_replace( t_stmt(t_stmt.last).ddl_txt, '(ALTER TRIGGER .+)' );
        when 'INDEX'
        then -- modify indexes that contains field "KF" (first in list) to local
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, 'BRSDYNI', 'BRSMDLI' );
          if ( regexp_like( t_stmt(t_stmt.last).ddl_txt, '\( *"?KF"? *,' ) )
          then
            t_stmt(t_stmt.last).ddl_txt := t_stmt(t_stmt.last).ddl_txt || ' LOCAL COMPRESS 1';
          end if;
        else
          null;
        end case;
      end loop;
    end;

    execute immediate 'drop table '||l_tab_nm||' cascade constraints';
    dbms_output.put_line( 'Table "'||l_tab_nm||'" dropped.' );

    execute immediate 'rename TEST_'||l_tab_nm||' to '||l_tab_nm;
    dbms_output.put_line( 'Rename complete.' );

    -- ======================================================
    -- Rename Not Null constraints
    -- ======================================================
    begin
      dbms_output.put_line( 'Rename Not Null constraints.' );
      for k in 
      ( select cc.CONSTRAINT_NAME, cc.COLUMN_NAME 
          from ALL_CONSTRAINTS  cs
          join ALL_CONS_COLUMNS cc
            on ( cc.CONSTRAINT_NAME = cs.CONSTRAINT_NAME ) 
         where cs.OWNER = 'BARS'
           and cs.TABLE_NAME = l_tab_nm
           and cs.CONSTRAINT_TYPE = 'C'
           and cc.CONSTRAINT_NAME like 'SYS%'
      ) loop
        begin
          execute immediate 'alter table '||l_tab_nm||' rename constraint ' || k.CONSTRAINT_NAME ||
                            ' to CC_'|| replace(l_tab_nm,'_') || '_' || replace(k.COLUMN_NAME,'_') || '_NN';
          dbms_output.put_line( 'Table altered.' );
        exception
          when OTHERS then 
            dbms_output.put_line( 'Constraint NOT renamed: '||sqlerrm );
        end;
      end loop;
    end;

    -- ======================================================
    -- Execute collected DDL
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying constraints, index and triggers from source table.' );
      for r in t_stmt.first .. t_stmt.last
      loop
        begin
          execute immediate t_stmt(r).ddl_txt;
        exception
          when E_COL_ALREADY_NN
          then null;
          when OTHERS
          then dbms_output.put_line( 'Create ' || t_stmt(r).obj_tp || ' error => ' || sqlerrm || chr(10) || 'on stmt => ' || t_stmt(r).ddl_txt );
        end;
      end loop;
      t_stmt.delete();
    end;

    begin
      execute immediate 'alter table '||l_tab_nm||' noparallel';
      dbms_output.put_line( 'Table altered.' );
    exception
      when others
      then dbms_output.put_line( sqlerrm );
    end;

    -- ======================================================
    -- Policies
    -- ======================================================
    BPA.ALTER_POLICIES( l_tab_nm );
    commit;

  else -- якщо SUBPARTITIONS наявні
    dbms_output.put_line( 'Table "'||l_tab_nm||'" already partitioned.' );
  end if;

  -- ======================================================
  -- set DBMS_STATS preference
  -- ======================================================
  DBMS_STATS.SET_TABLE_PREFS( OwnName => 'BARS'
                            , TabName => l_tab_nm
                            , pname   => 'INCREMENTAL'
                            , pvalue  => 'TRUE' );

end;
/

-- manual replacement of constraints such as "CHECK (... IS NOT NULL)" to "MODIFY ... NOT NULL"
declare
  e_col_already_nn  exception;
  pragma exception_init( e_col_already_nn, -01442 );
begin
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify ACC constraint CC_DPTDEPOSITCLOS_ACC_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "ACC" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify ACTION_ID constraint CC_DPTDEPOSITCLOS_ACTNID_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "ACTION_ID" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify ACTIION_AUTHOR constraint CC_DPTDEPOSITCLOS_ACTNAHR_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "ACTIION_AUTHOR" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify BRANCH constraint CC_DPTDEPOSITCLOS_BRANCH_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "BRANCH" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify DAT_BEGIN constraint CC_DPTDEPOSITCLOS_DATBEGIN_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "DAT_BEGIN" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify DATZ constraint CC_DPTDEPOSITCLOS_DATZ_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "DATZ" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify DEPOSIT_ID constraint CC_DPTDEPOSITCLOS_DEPOSITID_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "DEPOSIT_ID" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify KF constraint CC_DPTDEPOSITCLOS_KF_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "KF" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify KV constraint CC_DPTDEPOSITCLOS_KV_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "KV" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify RNK constraint CC_DPTDEPOSITCLOS_RNK_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "RNK" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify STOP_ID constraint CC_DPTDEPOSITCLOS_STOPID_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "STOP_ID" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify USERID constraint CC_DPTDEPOSITCLOS_USERID_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "USERID" is already NOT NULL.' );
  end;
  begin
    execute immediate 'alter table DPT_DEPOSIT_CLOS modify VIDD constraint CC_DPTDEPOSITCLOS_VIDD_NN Not Null enable novalidate';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_col_already_nn
    then dbms_output.put_line( 'Column "VIDD" is already NOT NULL.' );
  end;
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_ACTNID on DPT_DEPOSIT_CLOS ( ACTION_ID, DEPOSIT_ID, KF ) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx 
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
begin
  execute immediate 'create index IDX_DPTDEPOSITCLOS_BDATE on DPT_DEPOSIT_CLOS ( BDATE, KF, DEPOSIT_ID, IDUPD ) tablespace BRSBIGI compress 2';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
end;
/

begin
  DBMS_STATS.GATHER_TABLE_STATS
  ( OwnName          => 'BARS'
  , TabName          => 'DPT_DEPOSIT_CLOS'
  , Estimate_Percent => DBMS_STATS.AUTO_SAMPLE_SIZE
  , Degree           => 24
  , Granularity      => 'AUTO'
  , Cascade          => TRUE
  );
end;
/
