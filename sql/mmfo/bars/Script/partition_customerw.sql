-- ================================================================================
-- Module : CAC
-- Author : Lypskykh (orig: BAA)
-- Date   : 09.08.2018
-- ================================== <Comments> ==================================
-- recreate table CUSTOMERW
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
prompt -- recreate table CUSTOMERW
prompt -- ======================================================

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

  l_tab_nm := 'CUSTOMERW';

  -- перевірка наяності PARTITIONS
  select case
         when EXISTS( select 1
                        from ALL_TAB_PARTITIONS
                       where TABLE_OWNER = 'BARS'
                         and TABLE_NAME  = l_tab_nm )
         then 1
         else 0
         end
    into l_ptsn_f
    from dual;

  if ( 0 = 0 )
  then -- якщо PARTITIONS відсутні

    begin
      execute immediate 'drop table TEST_'||l_tab_nm||' cascade constraints';
      dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" dropped.' );
    exception
      when e_tab_not_exists
      then null;
    end;
    
    begin
        execute immediate 'alter table CUSTOMERW read write';
    exception
        when others then
            if sqlcode = -14140 then null; else raise; end if;
    end;

    execute immediate 'ALTER SESSION ENABLE PARALLEL DDL';
    execute immediate 'ALTER SESSION ENABLE PARALLEL DML';

    lock table CUSTOMERW in exclusive mode;
    

    -- KF + all other columns
    select LISTAGG(t.COLUMN_NAME,', ') WITHIN GROUP ( order by case t.COLUMN_NAME when 'KF' then -1 else t.COLUMN_ID end )
      into l_col_lst
      from ALL_TAB_COLS t
     where OWNER = 'BARS' 
       and TABLE_NAME = l_tab_nm
       and HIDDEN_COLUMN = 'NO';

    begin
      execute immediate 'alter table ' || l_tab_nm || ' read only';
    exception
      when e_tab_rd_only then
        dbms_output.put_line( 'Table "'|| l_tab_nm || '" is already in read-only mode.' );
    end;

    l_tab_stmt := 'create table TEST_' || l_tab_nm || chr(10) || '( ' ||
    replace( l_col_lst, 'KF,', q'[KF default sys_context('bars_context','user_mfo') not null,]' ) || q'[
) tablespace BRSBIGD
PARALLEL 24
STORAGE( INITIAL 32K NEXT 32K )
PARTITION BY LIST (KF) subpartition by list (TAG)
SUBPARTITION TEMPLATE
( 
  SUBPARTITION SP_GENERAL values ('MATER', 'SWS86', 'VISA', 'OSN', 'FO', 'EXCLN', 'DOV_A', 'FGIDX', 'BUSSL', 'BUSSS', 'NER_D', 'NER_C', 'NER_N', 'OBPR', 'URKLI', 'VLIC', 'VPD', 'IO', 'MAMA', 'N_RPP', 'DATVR', 'DLIC', 'DATK', 'N_SVD', 'N_RPD', 'DOV_F', 'TEL_D', 'KODID', 'KVPKK', 'K013', 'AGENT', 'RCOMM', 'N_REE', 'KURAK', 'KURAT', 'KURAR', 'DR', 'MPNO', 'FIRMA', 'NLIC', 'N_RPN', 'INSFO', 'OPERB', 'OPER', 'N_SVO', 'VIDY', 'PIDPR', 'DOV_P', 'VNCRP', 'KONTR', 'ZVYO', 'WORKU', 'VNCRR', 'ISP', 'N_SVI', 'SUPR', 'FIN23', 'AF3', 'AF5', 'ADRU'),
  SUBPARTITION SP_GENERAL_SUM values ('SUM1', 'SUM2', 'SUM3', 'SUM4'),
  SUBPARTITION SP_GENERAL_COUNT values ('COUN1', 'COUN2', 'COUN3', 'COUN4'),
  SUBPARTITION SP_GENERAL_NOTAR values ('NOTAT', 'NOTAN', 'NOTAS', 'NOTTA', 'NOTAR'),
  SUBPARTITION SP_GENERAL_SN values ('SN_GC', 'SN_FN', 'SN_4N', 'SN_MN', 'SN_LN'),
  SUBPARTITION SP_GENERAL_NSM values ('NSMCV', 'NSMCC', 'NSMCT'),
  SUBPARTITION SP_BPK_W4 values ('W4SKS', 'W4KKS', 'W4KKA', 'W4KKT', 'W4KKB', 'W4KKZ', 'W4KKW', 'W4KKR'),
  SUBPARTITION SP_BPK_PC values ('PC_MF', 'PC_Z4', 'PC_Z3', 'PC_Z5', 'PC_Z2', 'PC_Z1', 'PC_SS'),
  SUBPARTITION SP_CRV values ('RVDBC', 'RVIBA', 'RVIBR', 'RVIBB', 'RVIDT', 'RV_XA', 'RVRNK', 'RVPH1', 'RVPH2', 'RVPH3'),
  SUBPARTITION SP_FM_DJ values ('DJ_S1', 'DJ_S2', 'DJ_S3', 'DJ_S4', 'DJ_C1', 'DJ_C2', 'DJ_C3', 'DJ_C4', 'DJER1', 'DJER2', 'DJER3', 'DJER4', 'DJOTH', 'DJOWF', 'DJ_MA', 'DJ_LN', 'DJ_TC', 'DJAVI', 'DJCFI', 'DJ_FH', 'DJ_CP'),
  SUBPARTITION SP_FM_FS values ('FSIN', 'FSZAS', 'FSVLI', 'FSVLA', 'FSVLZ', 'FSVLN', 'FSVLO', 'FSCP', 'FSVLM', 'FSDVD', 'FSOBK', 'FSDPD', 'FSZP', 'FSZOP', 'FSVED', 'FSKPK', 'FSKPR', 'FSKRB', 'FSKRD', 'FSKRN', 'FSDIB', 'FSKRK', 'FSOVR', 'FSOMD', 'FSODI', 'FSODV', 'FSODP', 'FSODT', 'FSPOR', 'FSDEP', 'FSRSK', 'FSRKZ', 'FSSST', 'FSSOD', 'FSDRY', 'FSVSN', 'FSB'),
  SUBPARTITION SP_FM values ('IDPPD', 'IDPIB', 'RIZIK', 'AF4_B', 'AINAB', 'SPECB', 'USTF', 'TIPFO', 'BKOR', 'ABSRE', 'POSRB', 'DJER', 'SUTD', 'PEP', 'HKLI', 'LICO', 'WORK', 'PUBLP', 'NRDAT', 'NRORG', 'NRSVI', 'SNSDR', 'OUNAM', 'OUCMP', 'OVIFS', 'OVIDP', 'FSZPD', 'AF6', 'O_REP', 'INZAS', 'ID_YN', 'OSOBA', 'OBSLU', 'OIST', 'HIST', 'EMAIL', 'ADRW', 'FADR', 'FADRB', 'PODR', 'PODR2', 'UPFO', 'CCVED', 'TIPA', 'PHKLI', 'GR', 'NPDV', 'AF1_9', 'PLPPR', 'IDDPD', 'DAIDI', 'DATZ', 'IDDPL', 'IDDPR'),
  SUBPARTITION SP_NDBO values ('NDBO'),
  SUBPARTITION SP_DDBO values ('DDBO'),
  SUBPARTITION SP_OTHERS values ('SUBSD', 'SUBSN', 'RS6S5', 'RS6HI', 'ELT_N', 'ELT_D', 'RNKS6', 'RS6S6', 'RNKUN', 'RNKUF', 'STMT', 'SW_RN', 'OSNUL', 'RKO_N', 'Y_ELT', 'SAMZ', 'VIDKL', 'VYDPP', 'RKO_D', 'CRSRC', 'CHORN', 'SPMRK', 'LINKG', 'UADR', 'MOB01', 'MOB02', 'MOB03', 'INVCL', 'DEATH', 'SUBS', 'UUCG', 'ADRP', 'VIP_K', 'NOTAX', 'WORKB', 'BIC', 'CIGPO', 'TARIF', 'FZ', 'UUDV'),
  SUBPARTITION SP_OTHERS_MS values ('MS_FS', 'MS_KL', 'MS_VD', 'MS_GR'),
  SUBPARTITION SP_OTHERS_FG values ('FGADR', 'FGTWN', 'FGOBL', 'FGDST'),
  SUBPARTITION SP_SDBO values ('SDBO'),
  SUBPARTITION SP_DEFAULT values (DEFAULT)
)
( PARTITION P_300465 VALUES ('300465')
, PARTITION P_302076 VALUES ('302076')
, PARTITION P_303398 VALUES ('303398')
, PARTITION P_304665 VALUES ('304665')
, PARTITION P_305482 VALUES ('305482')
, PARTITION P_311647 VALUES ('311647')
, PARTITION P_312356 VALUES ('312356')
, PARTITION P_313957 VALUES ('313957')
, PARTITION P_315784 VALUES ('315784')
, PARTITION P_322669 VALUES ('322669')
, PARTITION P_323475 VALUES ('323475')
, PARTITION P_324805 VALUES ('324805')
, PARTITION P_325796 VALUES ('325796')
, PARTITION P_326461 VALUES ('326461')
, PARTITION P_328845 VALUES ('328845')
, PARTITION P_331467 VALUES ('331467')
, PARTITION P_333368 VALUES ('333368')
, PARTITION P_335106 VALUES ('335106')
, PARTITION P_336503 VALUES ('336503')
, PARTITION P_337568 VALUES ('337568')
, PARTITION P_338545 VALUES ('338545')
, PARTITION P_351823 VALUES ('351823')
, PARTITION P_352457 VALUES ('352457')
, PARTITION P_353553 VALUES ('353553')
, PARTITION P_354507 VALUES ('354507')
, PARTITION P_356334 VALUES ('356334')
)
as
select /*+ parallel( 24 ) */ ]' || ' (select bars_sqnc.get_kf(substr(to_char(rnk), -2, 2)) from dual) as KF, RNK, TAG, VALUE, ISP ' || q'[
  from ]'|| l_tab_nm;

    execute immediate l_tab_stmt;
    dbms_output.put_line( 'Table "TEST_'||l_tab_nm||'" created.' );

    -- ======================================================
    -- Default Values
    -- ======================================================
    begin
      dbms_output.put_line( 'Copying default column values from source table.' );
      for dv in ( select COLUMN_NAME, DATA_DEFAULT, DEFAULT_LENGTH
                    from ALL_TAB_COLS t
                   where OWNER = 'BARS'
                     and TABLE_NAME = l_tab_nm
                     and COLUMN_NAME != 'KF'
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
          t_stmt(t_stmt.last).ddl_txt := replace( t_stmt(t_stmt.last).ddl_txt, 'BRSDYNI', 'BRSBIGI' );
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
    --BPA.ALTER_POLICY_INFO(l_tab_nm, 'WHOLE', null, 'E', 'E', 'E');
    BPA.ALTER_POLICIES( l_tab_nm );
    commit;

  else -- якщо PARTITIONS наявні
    dbms_output.put_line( 'Table "'||l_tab_nm||'" already partitioned.' );
  end if;

end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index UK_CUSTOMERW on CUSTOMERW (KF, TAG, RNK) tablespace BRSBIGI local compress 1';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

declare
  e_idx_exists           exception;
  pragma exception_init( e_idx_exists,      -00955 );
  e_col_already_idx      exception;
  pragma exception_init( e_col_already_idx, -01408 );
  e_dup_keys_found       exception;
  pragma exception_init( e_dup_keys_found,  -01452 );
begin
  execute immediate 'create unique index PK_CUSTOMERW on customerw (tag, rnk) tablespace brsbigi';
  dbms_output.put_line( 'Index created.' );
exception
  when e_idx_exists
  then dbms_output.put_line( 'Name is already used by an existing object.' );
  when e_col_already_idx
  then dbms_output.put_line( 'Such column list already indexed.' );
  when e_dup_keys_found
  then dbms_output.put_line( 'Cannot create unique index: duplicate keys found' );
end;
/

begin
    BPA.ALTER_POLICY_INFO('CUSTOMERW', 'WHOLE', null, 'E', 'E', 'E');
    BPA.ALTER_POLICY_INFO('CUSTOMERW', 'FILIAL', 'M', 'M', 'M', 'M');
    BPA.ALTER_POLICIES('CUSTOMERW');
end;
/

begin
  DBMS_STATS.GATHER_TABLE_STATS
  ( OwnName          => 'BARS'
  , TabName          => 'CUSTOMERW'
  , Estimate_Percent => DBMS_STATS.AUTO_SAMPLE_SIZE
  , Granularity      => 'AUTO'
  , Cascade          => TRUE
  );
end;
/
