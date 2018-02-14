-- ======================================================================================
-- Module : GL
-- Author : BAA
-- Date   : 19.10.2017
-- ===================================== <Comments> =====================================
-- recreate table SALDOA
-- ======================================================================================

SET SERVEROUTPUT ON SIZE UNLIMITED FORMAT WRAPPED
SET DEFINE       OFF
SET ECHO         OFF
SET FEEDBACK     OFF
SET LINES        300
SET PAGES        500
SET TERMOUT      ON
SET TRIMSPOOL    ON
SET VERIFY       OFF

prompt -- ======================================================
prompt -- recreate table SALDOA
prompt -- ======================================================

declare
  e_tab_not_exists exception;
  pragma exception_init( e_tab_not_exists, -00942 );
begin
  execute immediate 'drop table TEST_SALDOA cascade constraints';
  dbms_output.put_line( 'Table "TEST_SALDOA" dropped.' );
exception
  when e_tab_not_exists 
  then dbms_output.put_line( 'Table "TEST_SALDOA" does not exist.' );
end;
/

SET TIMING ON

declare
  l_tab_nm            varchar2(30);
  l_ptsn_f            number(1);
  l_tab_stmt          varchar2(8000);
  type r_stmt_type is record ( obj_tp    varchar2(30)
                             , ddl_txt   varchar2(8000)
                             );
  type t_stmt_type is table of r_stmt_type;
  t_stmt              t_stmt_type;
  --
  e_tab_rd_only          exception;
  pragma exception_init( e_tab_rd_only, -14139 );
  e_tab_rd_wrt           exception;
  pragma exception_init( e_tab_rd_wrt, -14140 );
begin
  
  l_tab_nm := 'SALDOA';
  
  execute immediate 'ALTER SESSION ENABLE PARALLEL DDL';
  execute immediate 'ALTER SESSION ENABLE PARALLEL DML';
  
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
      execute immediate 'alter table ' || l_tab_nm || ' read only';
      dbms_application_info.set_action( 'RECREATE_TABLE_'||l_tab_nm );
    exception
      when e_tab_rd_only then
        begin
          dbms_output.put_line( 'Table "'|| l_tab_nm || '" is already in read-only mode.' );
          begin
            select s.USERNAME
              into l_tab_stmt
              from V$SESSION s
             where s.TYPE   = 'USER'
               and s.STATUS = 'ACTIVE'
               and s.ACTION = 'RECREATE_TABLE_'||l_tab_nm;
            raise_application_error( -20666, 'Завдання вже запущено користувачем '||l_tab_stmt, true );
          exception
            when NO_DATA_FOUND then
              null;
          end;
        end;
    end;

--  lock table NBU23_REZ in exclusive mode;

    l_tab_stmt := q'[create table TEST_SALDOA
( FDAT                                                not null
, KF   default sys_context('bars_context','user_mfo') not null
, ACC                                                 not null
, OSTF                                                not null
, DOS                                                 not null
, KOS                                                 not null
, PDAT
, TRCN
, OSTQ default 0                                      not null
, DOSQ default 0                                      not null
, KOSQ default 0                                      not null
) tablespace BRSSALD
COMPRESS FOR OLTP
PARALLEL 24
STORAGE( INITIAL 32K NEXT 32K )
PARTITION BY RANGE (FDAT) INTERVAL( NUMTODSINTERVAL(1,'DAY'))
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
( PARTITION SALDOA_Y2008     VALUES LESS THAN (TO_DATE(' 2009-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0 
, PARTITION SALDOA_Y2009     VALUES LESS THAN (TO_DATE(' 2010-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2010     VALUES LESS THAN (TO_DATE(' 2011-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2011     VALUES LESS THAN (TO_DATE(' 2012-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2012     VALUES LESS THAN (TO_DATE(' 2013-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2013     VALUES LESS THAN (TO_DATE(' 2014-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2014_Q1  VALUES LESS THAN (TO_DATE(' 2014-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2014_Q2  VALUES LESS THAN (TO_DATE(' 2014-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2014_Q3  VALUES LESS THAN (TO_DATE(' 2014-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2014_Q4  VALUES LESS THAN (TO_DATE(' 2015-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2015_Q1  VALUES LESS THAN (TO_DATE(' 2015-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2015_Q2  VALUES LESS THAN (TO_DATE(' 2015-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2015_Q3  VALUES LESS THAN (TO_DATE(' 2015-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2015_Q4  VALUES LESS THAN (TO_DATE(' 2016-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2016_Q1  VALUES LESS THAN (TO_DATE(' 2016-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2016_Q2  VALUES LESS THAN (TO_DATE(' 2016-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2016_Q3  VALUES LESS THAN (TO_DATE(' 2016-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2016_Q4  VALUES LESS THAN (TO_DATE(' 2017-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2017_Q1  VALUES LESS THAN (TO_DATE(' 2017-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2017_Q2  VALUES LESS THAN (TO_DATE(' 2017-07-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2017_Q3  VALUES LESS THAN (TO_DATE(' 2017-10-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2017_M10 VALUES LESS THAN (TO_DATE(' 2017-11-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2017_M11 VALUES LESS THAN (TO_DATE(' 2017-12-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
, PARTITION SALDOA_Y2017_M12 VALUES LESS THAN (TO_DATE(' 2018-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) COMPRESS BASIC PCTFREE 0
) 
as 
select /*+ parallel( 24 ) */ FDAT, KF, ACC, OSTF, DOS, KOS, PDAT, TRCN, OSTQ, DOSQ, KOSQ
  from SALDOA
 order by ACC, FDAT ]'; -- for better Clustering Factor

    execute immediate l_tab_stmt;
    dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" created.' );

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
                    and TABLE_NAME   = l_tab_nm /*
                 select 'grant ' || LISTAGG( PRIVILEGE, ', ' ) 
                                    WITHIN GROUP ( order by case PRIVILEGE
                                                            when 'SELECT' then 0
                                                            when 'INSERT' then 1
                                                            when 'UPDATE' then 2
                                                            when 'DELETE' then 3 
                                                            else 4 end ) ||
                        ' on ' || TABLE_NAME || ' to ' || GRANTEE
                   from ALL_TAB_PRIVS
                  where TABLE_SCHEMA = 'BARS'
                    and TABLE_NAME   = l_tab_nm
                  group by TABLE_NAME, GRANTEE */
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
      dbms_output.put_line( 'Copying index and constraints from source table.' );
      DBMS_METADATA.set_transform_param( DBMS_METADATA.SESSION_TRANSFORM, 'STORAGE', false );
      select OBJ_TP, DDL_STMT
        bulk collect
        into t_stmt
        from ( select 'CONSTRAINT' as OBJ_TP
                    , DBMS_LOB.SUBSTR(DBMS_METADATA.GET_DDL( 'REF_CONSTRAINT', CONSTRAINT_NAME ),8000,4) as DDL_STMT
                 from USER_CONSTRAINTS
                where TABLE_NAME = l_tab_nm
                  and CONSTRAINT_TYPE = 'R'
                union all
               select 'CONSTRAINT', DBMS_LOB.SUBSTR(DBMS_METADATA.GET_DDL( 'CONSTRAINT', CONSTRAINT_NAME ),8000,4)
                 from USER_CONSTRAINTS
                where TABLE_NAME = l_tab_nm
                  and CONSTRAINT_TYPE = any ('P','U','C')
                  and CONSTRAINT_NAME not like 'CC%NN' -- Not Null
                union all
               select 'INDEX', DBMS_LOB.SUBSTR(DBMS_METADATA.GET_DDL( 'INDEX', i.INDEX_NAME ),8000,4)
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
               select 'TRIGGER', DBMS_LOB.SUBSTR(DBMS_METADATA.GET_DDL( 'TRIGGER', TRIGGER_NAME ),8000,4)
                 from USER_TRIGGERS
                where TABLE_NAME = l_tab_nm
             );
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
          -- execute immediate c.STMT;
          dbms_output.put_line( 'Table altered.' );
        exception
          when OTHERS then 
            dbms_output.put_line( 'Constraint NOT renamed: '||sqlerrm );
        end;
      end loop;
    end;

    -- ======================================================
    -- execute 
    -- ======================================================
    for r in t_stmt.first .. t_stmt.last
    loop
      begin
        case t_stmt(r).obj_tp
        when 'CONSTRAINT'
        then
          t_stmt(r).ddl_txt := replace( t_stmt(r).ddl_txt, ' DISABLE',  ' ENABLE'     );
          t_stmt(r).ddl_txt := replace( t_stmt(r).ddl_txt, ' VALIDATE', ' NOVALIDATE' );
        when 'TRIGGER'
        then
          t_stmt(r).ddl_txt := regexp_replace( t_stmt(r).ddl_txt, '(ALTER TRIGGER .+)' );
        else
          null;
        end case;
        execute immediate t_stmt(r).ddl_txt;
      exception
        when OTHERS
        then dbms_output.put_line( 'Create ' || t_stmt(r).obj_tp || ' error => ' || sqlerrm || chr(10) || 'on stmt => ' || t_stmt(r).ddl_txt );
      end;
    end loop;

    t_stmt.delete();

    begin
      execute immediate 'alter table '||l_tab_nm||' noparallel';
    exception
      when others
      then dbms_output.put_line( sqlerrm );
    end;

    -- ======================================================
    -- Policies
    -- ======================================================
    BPA.ALTER_POLICIES( l_tab_nm );
    commit;

  else -- якщо SUBPARTITIONS на€вн≥
    dbms_output.put_line( 'Table "'||l_tab_nm||'" already subpartitioned.' );
  end if;

  -- ======================================================
  -- set DBMS_STATS preference
  -- ======================================================
  DBMS_STATS.SET_TABLE_PREFS( OwnName => 'BARS'
                            , TabName => l_tab_nm
                            , pname   => 'INCREMENTAL'
                            , pvalue  => 'TRUE' );

  begin
    execute immediate 'alter table ' || l_tab_nm || ' read write';
    dbms_output.put_line( 'Table altered.' );
  exception
    when e_tab_rd_wrt
    then dbms_output.put_line( 'Table "'|| l_tab_nm || '" is already in read/write mode.' );
  end;

  dbms_application_info.set_action( null );

end;
/

create or replace trigger TAD_SALDOA
after delete on SALDOA
--
-- Удаленные из SALDOA записи переносим в SALDOA_DEL_ROWS
--
for each row
begin
  begin
    insert
      into SALDOA_DEL_ROWS ( ACC, FDAT )
    values ( :old.ACC, :old.FDAT );
  exception
    when DUP_VAL_ON_INDEX then
      null;
  end;
end TAD_SALDOA;
/

show errors;

begin
  DBMS_STATS.GATHER_TABLE_STATS
  ( OwnName          => 'BARS'
  , TabName          => 'SALDOA'
  , Estimate_Percent => DBMS_STATS.AUTO_SAMPLE_SIZE
  , Granularity      => 'AUTO'
  , Cascade          => TRUE
  );
end;
/
